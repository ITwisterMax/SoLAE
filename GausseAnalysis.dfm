object GausseAnalysis_: TGausseAnalysis_
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1040#1085#1072#1083#1080#1079' '#1052#1077#1090#1086#1076#1072' '#1043#1072#1091#1089#1089#1072' | Made by ITwisterMax'
  ClientHeight = 250
  ClientWidth = 610
  Color = clWhite
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnShow = Start
  PixelsPerInch = 96
  TextHeight = 13
  object Analysis_: TStringGrid
    Left = 0
    Top = 0
    Width = 610
    Height = 250
    Align = alClient
    Color = clWhite
    ColCount = 2
    DefaultColWidth = 300
    DefaultRowHeight = 27
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    RowCount = 7
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    GradientEndColor = clWhite
    ParentFont = False
    TabOrder = 0
    RowHeights = (
      27
      27
      27
      27
      27
      27
      27)
  end
  object Cancel_: TButton
    Left = 485
    Top = 208
    Width = 99
    Height = 34
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Impact'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
end
