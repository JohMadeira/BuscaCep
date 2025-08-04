unit uCepComponente.Component;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, REST.Client, REST.Types,
  XML.XMLIntf, XML.XMLDoc, uCepComponente.Intf, uCEPModel, JSON,
  FireDAC.Comp.Client, FireDAC.DApt, uCommon;

type
  TCepComponente = class(TComponent, ICepComponente)
  private
    FResponse: string;
    FOnAfterFetch: TNotifyEvent;
    procedure SetResponse(const Value: string);
    function RetornaBaseURL(pParams: TArray<string>; pConsulta: string): string;  
    procedure PreencherCEP(pQuery: TFDQuery; pCEP: TCep);
  published
    property Response: string read FResponse write SetResponse;
    property OnAfterFetch: TNotifyEvent read FOnAfterFetch write FOnAfterFetch;
    function ConsultaCEPBanco(const cParams: TArray<string>): TObjectList<TCep>; overload;
    function ConsultaCEPWS(const cParams: TArray<string>; cConsulta: string; cTipoPesquisa: TTipoPesquisa): TObjectList<TCep>; overload;
  end;

procedure Register;

implementation

uses REST.Json, uDAOCep;

{ TCepComponente }

procedure TCepComponente.SetResponse(const Value: string);
begin
  FResponse := Value;
end;

function TCepComponente.RetornaBaseURL(pParams: TArray<string>; pConsulta: string): string;
begin
  if pParams[0] <> '' then
    Result := Format('https://viacep.com.br/ws/%s/%s', [pParams[0], pConsulta])
  else
    Result := Format('https://viacep.com.br/ws/%s/%s/%s/%s', [pParams[1], pParams[2], pParams[3], pConsulta]);
end;

function TCepComponente.ConsultaCEPBanco(const cParams: TArray<string>): TObjectList<TCep>;
var
  vQuery: TFDQuery;
  daoCEP: TDAOCep;
  vCep: TCep;
  aux: integer;
begin
  Result := nil;
  try    
    daoCEP := TDAOCep.Create();
    if cParams[0] <> '' then
      vQuery := daoCEP.consultarCEP(cParams[0])
    else
      vQuery := daoCEP.ConsultarEndereco(cParams[1],'%'+cParams[2]+'%','%'+cParams[3]+'%');
    if vQuery <> nil then
      begin
        Result := TObjectList<TCep>.Create();
        while not vQuery.Eof do        
          begin            
            vCep := TCep.Create;
            PreencherCEP(vQuery, vCep);
            Result.Add(vCep);
            vQuery.Next
          end;
      end;
  finally
    FreeAndNil(daoCEP);
    FreeAndNil(vQuery);
  end;
end;

function TCepComponente.ConsultaCEPWS(const cParams: TArray<string>; cConsulta: string; cTipoPesquisa: TTipoPesquisa): TObjectList<TCep>;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JsonObj: TJSONObject;
  JsonArray: TJSONArray;
  XmlDoc: IXMLDocument;
  Root, EnderecosNode, CepNode: IXMLNode;
  aux: integer;
  vCep: TCep;
begin
  RESTClient   := TRESTClient.Create(RetornaBaseURL(cParams, cConsulta));
  RESTRequest  := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTRequest.Client   := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method   := rmGET;
    RESTRequest.Execute;
    SetResponse(RESTResponse.Content);

    if (Pos('erro', RESTResponse.Content) > 0) OR
       (Length(RESTResponse.Content) = 2) then
      begin
        Result := nil;
        Exit;
      end;

    try
      if RESTResponse.ContentType.Contains('application/json') then
        begin
          Result := TObjectList<TCep>.Create();
          if cTipoPesquisa = eCep then
            Result.Add(TJSON.JsonToObject<TCep>(RESTResponse.Content))
          else if cTipoPesquisa = eEndereco then
          begin
            JsonArray := TJSONValue.ParseJSONValue(RESTResponse.Content) as TJSONArray;
            for aux := 0 to JsonArray.Count -1 do
              begin
                Result.Add(TJSON.JsonToObject<TCep>(JsonArray.Items[aux].ToJSON));
              end;
          end;
        end
      else
      if RESTResponse.ContentType.Contains('xml') then
      begin
        XmlDoc := TXMLDocument.Create(nil);
        XmlDoc.LoadFromXML(RESTResponse.Content);
        XmlDoc.Active := True;
        Root := XmlDoc.DocumentElement;
        Result := TObjectList<TCep>.Create();
        if cTipoPesquisa = eCep then
          begin
            vCep := TCep.Create;
            vCep.Cep         := Root.ChildNodes['cep'].Text;
            vCep.Logradouro  := Root.ChildNodes['logradouro'].Text;
            vCep.Complemento := Root.ChildNodes['complemento'].Text;
            vCep.Unidade     := Root.ChildNodes['unidade'].Text;
            vCep.Bairro      := Root.ChildNodes['bairro'].Text;
            vCep.Localidade  := Root.ChildNodes['localidade'].Text;
            vCep.Uf          := Root.ChildNodes['uf'].Text;
            Result.Add(vCep)
          end
        else if cTipoPesquisa = eEndereco then
          begin
            EnderecosNode := Root.ChildNodes['enderecos'];
            for aux := 0 to EnderecosNode.ChildNodes.Count -1 do
            begin
              CepNode := EnderecosNode.ChildNodes[aux];
              if cepNode.NodeName = 'endereco' then
              begin
                vCep := TCep.Create;
                vCep.Cep         := cepNode.ChildNodes['cep'].Text;
                vCep.Logradouro  := cepNode.ChildNodes['logradouro'].Text;
                vCep.Complemento := cepNode.ChildNodes['complemento'].Text;
                vCep.Unidade     := cepNode.ChildNodes['unidade'].Text;
                vCep.Bairro      := cepNode.ChildNodes['bairro'].Text;
                vCep.Localidade  := cepNode.ChildNodes['localidade'].Text;
                vCep.Uf          := cepNode.ChildNodes['uf'].Text;
                Result.Add(vCep)
              end;
            end;
          end;
      end;

      if Assigned(FOnAfterFetch) then
        FOnAfterFetch(Self);
    except
      raise;
    end;
  except
    Result := nil;
  end;
  RESTClient.Free;
  RESTRequest.Free;
  RESTResponse.Free;
end;

procedure TCepComponente.PreencherCEP(pQuery: TFDQuery; pCEP: TCep);
begin
  with pQuery do
    begin
      pCEP.Cep := FieldByName('Cep').AsString;
      pCEP.Logradouro := FieldByName('Logradouro').AsString;
      pCEP.Complemento := FieldByName('Complemento').AsString;
      pCEP.Bairro := FieldByName('Bairro').AsString;
      pCEP.Localidade := FieldByName('Localidade').AsString;
      pCEP.Uf := FieldByName('Uf').AsString;
    end;
end;

procedure Register;
begin
  RegisterComponents('CepComponente', [TCepComponente]);
end;

end.
