object FTesteConsultaCNPJ: TFTesteConsultaCNPJ
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consulta CNPJ'
  ClientHeight = 536
  ClientWidth = 754
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 15
    Width = 754
    Height = 25
    Margins.Left = 0
    Margins.Top = 15
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Alignment = taCenter
    Caption = 'Consulta CNPJ Receita Federal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 308
  end
  object Label2: TLabel
    Left = 0
    Top = 40
    Width = 754
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'validando Google reCaptcha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 283
  end
  object Label3: TLabel
    Left = 0
    Top = 65
    Width = 754
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'by Suicide Coder'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 170
  end
  object Label4: TLabel
    Left = 0
    Top = 90
    Width = 754
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'codersuicide@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 247
  end
  object Label5: TLabel
    Left = 276
    Top = 144
    Width = 34
    Height = 13
    Caption = 'CNPJ:'
  end
  object btnConsultar: TButton
    Left = 276
    Top = 168
    Width = 209
    Height = 34
    Caption = 'Consultar'
    TabOrder = 0
    OnClick = btnConsultarClick
  end
  object memo: TMemo
    Left = 8
    Top = 211
    Width = 738
    Height = 317
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object edtCNPJ: TEdit
    Left = 312
    Top = 141
    Width = 173
    Height = 21
    Alignment = taCenter
    TabOrder = 2
    Text = '45997418000153'
  end
end
