object HilfeFenster: THilfeFenster
  Left = 574
  Top = 148
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Lernprogramm Bilderkartei  - Hilfe -'
  ClientHeight = 350
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 144
    Top = 312
    Width = 129
    Height = 25
    Caption = 'Hilfe &schlie'#223'en'
    OnClick = SpeedButton1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 16
    Width = 385
    Height = 281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Lernprogramm - Bilderkartei'
      '==========================='
      ''
      '  Mit diesem kleinen Programm k'#246'nnen Sie Ihre eigenen Bilder '
      'in '
      'die Bilderkartei des Lenrnprogramms einf'#252'gen. Sie k'#246'nnen auch '
      'Bilder l'#246'schen oder umbenennen.'
      ''
      '  Die Bilder, die Sie hinzuf'#252'gen k'#246'nnen m'#252'ssen im WMF-Format '
      
        'vorliegen. Dieses Bild-Format ist recht verbreitet. Es sollte in' +
        ' '
      'jedem Gesch'#228'ft Preiswerte "Clip-Arts"-CD-Roms geben, auf der '
      'hunderte von Bildern im WMF-Format gespeichert sind.'
      ''
      
        '  Um ein Bild in die Bildkartei hinzuzuf'#252'gen, klicken Sie einfac' +
        'h '
      'auf den Knopf "Bild hinzuf'#252'gen". In dem neu erschienenen '
      'Fenster k'#246'nnen Sie dann das Laufwerk (z.B. Ihr CD-ROM - '
      'Laufwerk), das Verzeichnis, und dann das konkrete Bild '
      'ausw'#228'hlen. Nach einem'
      ''
      '  Um die Namen von Bereits vorhandenen Bildern zu '#228'ndern, '
      'klicken Sie einfach auf den Namen in der Liste, und '#228'ndern Sie '
      'den namen unten links.'
      ''
      '  Das Lernprogramm ist so konzipiert, da'#223' es auch unter '
      'Windows 3.1 l'#228'uft. Aus technischen Gr'#252'nden werden daher nur '
      'Dateinamen mit 8 Zeichen akzeptiert. Sollte ein Dateiname '
      'mehr '
      'als 8 Buchstaben haben, werden die restlichen abgeschnitten, '
      'was im Normalfa'
      ''
      '  Falls Probleme auftreten sollten k'#246'nnen Sie mich per E-Mail '
      'unter der Adresse portale@fh-brandenburg.de erreichen.'
      ''
      ''
      'Viel Spass beim Lernen w'#252'nscht Ihnen Alessandro Portale.')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
