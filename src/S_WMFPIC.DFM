object WMFPicker: TWMFPicker
  Left = 420
  Top = 187
  BorderStyle = bsDialog
  Caption = 'Hinzuf'#252'gen einer WMF-Bilddatei'
  ClientHeight = 295
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PreviewBevel: TBevel
    Left = 8
    Top = 8
    Width = 337
    Height = 249
  end
  object SpeedButton1: TSpeedButton
    Left = 400
    Top = 264
    Width = 113
    Height = 25
    Caption = '&OK'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 8
    Top = 264
    Width = 113
    Height = 25
    Caption = '&Abbrechen'
    OnClick = SpeedButton2Click
  end
  object DriveComboBox1: TDriveComboBox
    Left = 352
    Top = 8
    Width = 161
    Height = 22
    Ctl3D = True
    DirList = DirectoryListBox1
    ParentCtl3D = False
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 352
    Top = 32
    Width = 161
    Height = 105
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 352
    Top = 144
    Width = 161
    Height = 113
    ItemHeight = 16
    Mask = '*.wmf'
    TabOrder = 2
    OnChange = FileListBox1Change
  end
end
