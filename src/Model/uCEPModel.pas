unit uCEPModel;

interface

uses REST.JSON.Types;

type
  TCep = class
  private
    [JSONNameAttribute('cep')]
    FCep: string;
    [JSONNameAttribute('logradouro')]
    FLogradouro: string;
    [JSONNameAttribute('complemento')]
    FComplemento: string;
    [JSONNameAttribute('unidade')]
    FUnidade: string;
    [JSONNameAttribute('bairro')]
    FBairro: string;
    [JSONNameAttribute('localidade')]
    FLocalidade: string;
    [JSONNameAttribute('uf')]
    FUf: string;
    [JSONNameAttribute('estado')]
    FEstado: string;
    [JSONNameAttribute('regiao')]
    FRegiao: string;
    [JSONNameAttribute('ibge')]
    FIbge: string;
    [JSONNameAttribute('gia')]
    FGia: string;
    [JSONNameAttribute('ddd')]
    FDdd: string;
    [JSONNameAttribute('siafi')]
    FSiafi: string;
  public
    property Cep: string         read FCep         write FCep;
    property Logradouro: string  read FLogradouro  write FLogradouro;
    property Complemento: string read FComplemento write FComplemento;
    property Unidade: string     read FUnidade     write FUnidade;
    property Bairro: string      read FBairro      write FBairro;
    property Localidade: string  read FLocalidade  write FLocalidade;
    property Uf: string          read FUf          write FUf;
    property Estado: string      read FEstado      write FEstado;
    property Regiao: string      read FRegiao      write FRegiao;
    property Ibge: string        read FIbge        write FIbge;
    property Gia: string         read FGia         write FGia;
    property Ddd: string         read FDdd         write FDdd;
    property Siafi: string       read FSiafi       write FSiafi;
  end;

implementation

{ TCep }

end.
