unit uTestesCenarios;

interface

type
  TParams = record
    class function CepValido: TArray<string>; static;
    class function CepInvalido: TArray<string>; static;
    class function EnderecoValido: TArray<string>; static;
    class function EnderecoInvalido: TArray<string>; static;
  end;

implementation

class function TParams.CepValido: TArray<string>;
begin
  Result := ['94814090', '', '', ''];
end;

class function TParams.CepInvalido: TArray<string>;
begin
  Result := ['00000000', '', '', ''];
end;

class function TParams.EnderecoValido: TArray<string>;
begin
  Result := ['', 'RS', 'PORTO ALEGRE', 'ASSIS BRASIL'];
end;

class function TParams.EnderecoInvalido: TArray<string>;
begin
  Result := ['', 'TT', 'CIDADE TESTE', 'RUA TESTE'];
end;

end.
