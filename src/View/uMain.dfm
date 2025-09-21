object fMain: TfMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Busca CEP'
  ClientHeight = 606
  ClientWidth = 1027
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1027
    Height = 81
    Align = alTop
    Caption = 'Consulta'
    TabOrder = 0
    object btnConsulta: TSpeedButton
      Left = 804
      Top = 43
      Width = 23
      Height = 22
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939ACACACFCFC
        FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000000000000212121909090F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000000000000000000000000E0E0E6E6E6EE3E3E3FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        00000606065D5D5DD2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
        000000000000000000000000000000000000003B3B3BB2B2B2FEFEFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000000000000000000000000000000000000000000000000000000000000000
        002E2E2E999999F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000
        0000000000000000000000000000001717177F7F7FECECECFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7171715B5B5B3E3E3E2828280B0B0B00
        00000000000000000000000000000000000000000000000000000000000B0B0B
        6C6C6CDCDCDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF6F6F6DDDDDDC3C3C3AAAAAA9090907777775D5D5D4444442A
        2A2A1111110000000000000202024C4C4CC4C4C4FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DDDDDDC3C3C3AAAAAA9090907777
        775D5D5D4444442A2A2A1111110000000000000202024C4C4CBBBBBBFFFFFFFF
        FFFFFFFFFFFFFFFF7171715B5B5B3E3E3E2828280B0B0B000000000000000000
        0000000000000000000000000000000000000000000B0B0B6C6C6CDCDCDCFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        00000000000000000000000000000000000000000000001717177F7F7FECECEC
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
        00000000000000000000000000000000000000000000000000262626909090F7
        F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000000000000000000000000000000000000000000000000000003B3B3BB2B2
        B2FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF000000000000000000000000000000000000060606555555
        CACACAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000E0E0E6E
        6E6EE3E3E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000002121
        21888888F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        333333A1A1A1FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = btnConsultaClick
    end
    object pgcBusca: TPageControl
      Left = 3
      Top = 21
      Width = 790
      Height = 57
      ActivePage = tabCEP
      TabOrder = 0
      OnChange = pgcBuscaChange
      object tabCEP: TTabSheet
        Caption = 'CEP'
        object edtCepConsulta: TEdit
          Left = 3
          Top = 1
          Width = 142
          Height = 23
          NumbersOnly = True
          TabOrder = 0
        end
      end
      object tabEndereco: TTabSheet
        Caption = 'Endere'#231'o'
        ImageIndex = 1
        object Label1: TLabel
          Left = 3
          Top = 3
          Width = 14
          Height = 15
          Caption = 'UF'
        end
        object Label2: TLabel
          Left = 106
          Top = 3
          Width = 57
          Height = 15
          Caption = 'Localidade'
        end
        object Label3: TLabel
          Left = 464
          Top = 3
          Width = 62
          Height = 15
          Caption = 'Logradouro'
        end
        object edtUfConsulta: TEdit
          Left = 23
          Top = 1
          Width = 50
          Height = 23
          TabOrder = 0
        end
        object edtLocalidadeConsulta: TEdit
          Left = 169
          Top = 1
          Width = 250
          Height = 23
          TabOrder = 1
        end
        object edtLogradouroConsulta: TEdit
          Left = 532
          Top = 3
          Width = 250
          Height = 23
          TabOrder = 2
        end
      end
    end
    object rdgRetorno: TRadioGroup
      Left = 833
      Top = 18
      Width = 185
      Height = 57
      Caption = 'Retorno'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'JSON'
        'XML')
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 81
    Width = 1027
    Height = 525
    Align = alClient
    Caption = 'Endere'#231'o'
    Color = clSilver
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    object Label4: TLabel
      Left = 14
      Top = 18
      Width = 21
      Height = 15
      Caption = 'CEP'
    end
    object Label5: TLabel
      Left = 108
      Top = 18
      Width = 62
      Height = 15
      Caption = 'Logradouro'
    end
    object Label6: TLabel
      Left = 14
      Top = 67
      Width = 77
      Height = 15
      Caption = 'Complemento'
    end
    object Label8: TLabel
      Left = 14
      Top = 117
      Width = 57
      Height = 15
      Caption = 'Localidade'
    end
    object Label9: TLabel
      Left = 560
      Top = 167
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object Label10: TLabel
      Left = 14
      Top = 167
      Width = 31
      Height = 15
      Caption = 'Bairro'
    end
    object GroupBox3: TGroupBox
      Left = 744
      Top = 17
      Width = 281
      Height = 259
      Align = alRight
      Caption = 'Retorno WS'
      TabOrder = 0
      object mmoJSON: TMemo
        Left = 2
        Top = 17
        Width = 277
        Height = 240
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 276
      Width = 1023
      Height = 247
      Align = alBottom
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 2
        Top = 17
        Width = 1019
        Height = 228
        Align = alClient
        DataSource = dsDataSource
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object edtCepRetorno: TDBEdit
      Left = 14
      Top = 39
      Width = 80
      Height = 23
      DataField = 'CEP'
      DataSource = dsDataSource
      TabOrder = 2
    end
    object edtLogradouroRetorno: TDBEdit
      Left = 108
      Top = 39
      Width = 557
      Height = 23
      DataField = 'LOGRADOURO'
      DataSource = dsDataSource
      TabOrder = 3
    end
    object edtComplemento: TDBEdit
      Left = 14
      Top = 88
      Width = 651
      Height = 23
      DataField = 'COMPLEMENTO'
      DataSource = dsDataSource
      TabOrder = 4
    end
    object edtLocalidadeRetorno: TDBEdit
      Left = 14
      Top = 138
      Width = 651
      Height = 23
      DataField = 'LOCALIDADE'
      DataSource = dsDataSource
      TabOrder = 5
    end
    object edtBairro: TDBEdit
      Left = 14
      Top = 188
      Width = 531
      Height = 23
      DataField = 'BAIRRO'
      DataSource = dsDataSource
      TabOrder = 6
    end
    object edtUFRetorno: TDBEdit
      Left = 560
      Top = 188
      Width = 29
      Height = 23
      DataField = 'UF'
      DataSource = dsDataSource
      TabOrder = 7
    end
  end
  object dsDataSource: TDataSource
    Left = 904
    Top = 232
  end
end
