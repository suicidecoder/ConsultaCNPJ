object FSCConsultaCNPJ: TFSCConsultaCNPJ
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consultar CNPJ'
  ClientHeight = 551
  ClientWidth = 754
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panelStatus: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 551
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Carregando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object panelWebBrowser: TPanel
    Left = 186
    Top = 88
    Width = 0
    Height = 0
    BevelOuter = bvNone
    Caption = 'panelWebBrowser'
    TabOrder = 1
    object WebBrowser: TWebBrowser
      Left = 0
      Top = 0
      Width = 0
      Height = 0
      Margins.Top = 60
      Align = alClient
      TabOrder = 0
      OnDocumentComplete = WebBrowserDocumentComplete
      ExplicitWidth = 617
      ExplicitHeight = 313
      ControlData = {
        4C00000000000000000000000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object TimerInicializar: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerInicializarTimer
    Left = 232
    Top = 208
  end
  object TimerExibirWebBrowser: TTimer
    Enabled = False
    OnTimer = TimerExibirWebBrowserTimer
    Left = 232
    Top = 264
  end
end
