unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.MPlayer;

type
  TMainMenu_ = class(TForm)
    //������
    Music_: TMediaPlayer;
    //���
    BackGround_: TImage;
    //��������
    Decor_: TImage;
    //���������
    Head_: TLabel;
    //��������� ������
    MatrixMethod_: TButton;
    //������� �������
    KramerMethod_: TButton;
    //����� ������
    GausseMethod_: TButton;
    //�������
    Reference_: TButton;
    //�����
    Exit_: TButton;

//������ �����
procedure Start(Sender: TObject);
//���������� �������
procedure OnNotify(Sender: TObject);
//��������� ������
procedure MatrixMethod_Click(Sender: TObject);
//������� �������
procedure KramerMethod_Click(Sender: TObject);
//����� ������
procedure GausseMethod_Click(Sender: TObject);
//�������
procedure Reference_Click(Sender: TObject);
//�����
procedure Exit_Click(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //�����
  MainMenu_: TMainMenu_;

implementation

{$R *.dfm}

//��������� ������, ������� �������, ����� ������ � �������
uses UnitMatrix, UnitKramer, Help, UnitGausse;

procedure TMainMenu_.Start(Sender: TObject);
begin
  //��������� ������
  Exit_.SetFocus;
  //��������������� �������
  Music_.Play;
end;

procedure TMainMenu_.OnNotify(Sender: TObject);
begin
  //���������� �������
  with Music_ do
  if NotifyValue = nvSuccessful then
    begin
      Notify := True;
      Play;
    end;
end;

procedure TMainMenu_.MatrixMethod_Click(Sender: TObject);
begin
  //����� ����� "��������� ������"
  Matrix_.ShowModal;
end;

procedure TMainMenu_.KramerMethod_Click(Sender: TObject);
begin
  //����� ����� "������� �������"
  Kramer_.ShowModal;
end;

procedure TMainMenu_.GausseMethod_Click(Sender: TObject);
begin
  //����� ����� "����� �������"
  Gausse_.ShowModal;
end;

procedure TMainMenu_.Reference_Click(Sender: TObject);
begin
  //����� ����� "�������"
  Help_.ShowModal;
end;

procedure TMainMenu_.Exit_Click(Sender: TObject);
begin
  //�������� ����� "������� ����"
  MainMenu_.Close;
end;

end.
