unit uCepComponente.Intf;

interface

uses
  System.Classes, System.Generics.Collections, uCEPModel, uCommon;

type
  ICepComponente = interface
    function ConsultaCEPBanco(const cParams: TArray<string>): TObjectList<TCep>;
    function ConsultaCEPWS(const cParams: TArray<string>; cConsulta: string; cTipoPesquisa: TTipoPesquisa): TObjectList<TCep>;
  end;

implementation

end.

