unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  THelp_ = class(TForm)
    //���
    BackGround_: TImage;
    //���������
    Head_: TLabel;
    //�����
    Frame_: TPanel;
    //�������
    Reference_: TImage;
    //����� 0
    Start_: TLabel;
    //����� 1
    Point1_: TLabel;
    //����� 2
    Point2_: TLabel;
    //����� 3
    Point3_: TLabel;
    //����� 4
    Point4_: TLabel;
    //����� 5
    Point5_: TLabel;
    //����� 6
    Point6_: TLabel;
    //����� 7
    Point7_: TLabel;
    //����� 8
    Point8_: TLabel;
    //����� � ������� ����
    ExitToMainMenu_: TButton;



private
  { Private declarations }
public
  { Public declarations }
end;

var
  //�����
  Help_: THelp_;

implementation

{$R *.dfm}

end.
