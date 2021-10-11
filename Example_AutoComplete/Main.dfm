object MainForm: TMainForm
  Left = 223
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Example AutoComplete'
  ClientHeight = 243
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object InfoLbl: TLabel
    Left = 8
    Top = 10
    Width = 29
    Height = 16
    Caption = 'Text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object CreditsLbl: TLabel
    Left = 10
    Top = 207
    Width = 287
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'Developpe par Bacterius (www.delphifr.com)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object EditControl: TEdit
    Left = 48
    Top = 6
    Width = 347
    Height = 24
    Hint = 
      'Par exemple, saisissez "C:\" si vous utilisez le systeme de fich' +
      'iers'
    TabOrder = 0
  end
  object OptionsBox: TGroupBox
    Left = 8
    Top = 39
    Width = 387
    Height = 162
    Caption = ' Options auto-complete '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object SepBevel: TBevel
      Left = 10
      Top = 118
      Width = 365
      Height = 3
    end
    object FileBox: TCheckBox
      Tag = 1
      Left = 10
      Top = 30
      Width = 215
      Height = 20
      Hint = 'Autorise l'#39'auto-completion avec le systeme de fichiers'
      Caption = 'Utiliser le systeme de fichiers'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = OptionChange
    end
    object HistoryBox: TCheckBox
      Tag = 2
      Left = 10
      Top = 59
      Width = 215
      Height = 21
      Hint = 'Autorise l'#39'auto-completion avec l'#39'historique internet'
      Caption = 'Utiliser l'#39'historique internet'
      TabOrder = 1
      OnClick = OptionChange
    end
    object RecentBox: TCheckBox
      Tag = 3
      Left = 10
      Top = 89
      Width = 223
      Height = 21
      Hint = 'Autorise l'#39'auto-completion avec les adresses recentes'
      Caption = 'Utiliser les adresses recentes'
      TabOrder = 2
      OnClick = OptionChange
    end
    object AppendBox: TCheckBox
      Tag = 4
      Left = 10
      Top = 128
      Width = 170
      Height = 21
      Hint = 'Autorise l'#39'ajout de l'#39'auto-completion'
      Caption = 'Auto-completion par ajout'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = OptionChange
    end
  end
  object QuitBtn: TButton
    Left = 303
    Top = 207
    Width = 92
    Height = 26
    Hint = 'Quitte l'#39'application'
    Caption = 'Exit'
    TabOrder = 2
    OnClick = QuitBtnClick
  end
end
