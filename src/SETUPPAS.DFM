object SetupForm: TSetupForm
  Left = 221
  Top = 233
  BorderStyle = bsDialog
  Caption = 'Lernprogramm - Bilderkartei'
  ClientHeight = 391
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PreviewBevel: TBevel
    Left = 16
    Top = 16
    Width = 281
    Height = 169
  end
  object ExitButton: TSpeedButton
    Left = 312
    Top = 352
    Width = 129
    Height = 25
    Caption = '&Beenden'
    OnClick = ExitButtonClick
  end
  object SortButton: TSpeedButton
    Left = 312
    Top = 280
    Width = 129
    Height = 25
    Caption = 'Liste &sortiern'
    OnClick = SortButtonClick
  end
  object SpeedButton1: TSpeedButton
    Left = 312
    Top = 240
    Width = 129
    Height = 25
    Caption = 'Bild &l'#246'schen'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 312
    Top = 200
    Width = 129
    Height = 25
    Caption = 'Bild Hinzu&f'#252'gen'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 312
    Top = 16
    Width = 129
    Height = 25
    Caption = '&Hilfe'
    OnClick = SpeedButton3Click
  end
  object BildNameEdit: TEdit
    Left = 16
    Top = 352
    Width = 281
    Height = 24
    TabOrder = 0
    OnExit = BildNameEditExit
    OnKeyUp = BildNameEditKeyUp
  end
  object BildNameListBox: TListBox
    Left = 16
    Top = 200
    Width = 281
    Height = 137
    ItemHeight = 16
    TabOrder = 1
    OnClick = BildNameListBoxClick
  end
end
