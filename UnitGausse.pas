unit UnitGausse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.Grids,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TGausse_ = class(TForm)
    //���
    BackGround_: TImage;
    //��������
    Decor_: TImage;
    //���������
    Head_: TLabel;
    //�����
    TextAboutN_: TLabel;
    //�����������
    InfoAboutN_: TSpinEdit;
    //����� ���������� ��������
    Timer_: TEdit;
    //������� �������
    TableCreate_: TButton;
    //��������� �������
    Load_: TButton;
    //������ ����
    StartWork_: TButton;
    //��������� ����
    SaveInFile_: TButton;
    //������ ����
    GAnalysis_: TButton;
    //������� ��� ����� ����
    InputData_: TStringGrid;
    //������� ��� ������� ����
    OutputData_: TStringGrid;
    //����� � ������� ����
    ExitToMainMenu_: TButton;

//������ �����
procedure Start(Sender: TObject);
//������� �������
procedure TableCreate_Click(Sender: TObject);
//�������� �� �����
procedure Load_Click(Sender: TObject);
//������ ����
procedure StartWork_Click(Sender: TObject);
//��������� ����
procedure SaveInFile_Click(Sender: TObject);
//������ ����
procedure GAnalysis_Click(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //�����
  Gausse_: TGausse_;
  //����� ������� ������
  ClickOnTableFlag, ClickOnSearchFlag : Boolean;

implementation

{$R *.dfm}

//������� ������� � ����� ������� ������ ������
uses GausseDeterminant, GausseAnalysis;

procedure TGausse_.Start(Sender: TObject);
var
  //������� � ������� ������
  Col, Row : Integer;

begin
  //��������� ������
  InfoAboutN_.SetFocus;
  //��������� ������ ������� ������
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //��������� ������� � InfoAboutN_
  InfoAboutN_.Text := '10';

  //����������� ���������� ������� InputData_
  InputData_.ColCount := 12;
  InputData_.RowCount := 11;
    for Col := 0 to 11 do
      for Row := 0 to 10 do
        InputData_.Cells[Col,Row] := ' ';

  //����������� ���������� ������� OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := 11;
  for Col := 0 to 1 do
    for Row := 0 to 10 do
      OutputData_.Cells[Col,Row] := ' ';
end;

procedure TGausse_.TableCreate_Click(Sender: TObject);
var
  //����������� ����, ������� � ������ ������
  n, Col, Row : Integer;

begin
  //��������� ������ ������� ������
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //���������� �����������
  n := StrToInt(InfoAboutN_.Text);
  //���� ������� ������
  ClickOnTableFlag := True;

  //�������� ������� InputData_
  InputData_.ColCount := n + 2;
  InputData_.RowCount := n + 1;
  for Col := 1 to n + 1 do
    for Row := 1 to n do
      InputData_.Cells[Col,Row] := ' ';
  for Col := 1 to n do
    InputData_.Cells[Col,0] := 'K('+inttostr(Col)+')';
  InputData_.Cells[n+1,0] := '����.';
  for Row := 1 to n do
    InputData_.Cells[0,Row] := Char(Row+64);

  //�������� ������� OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := n + 1;
  for Row := 1 to n do
    OutputData_.Cells[1,Row] := ' ';
  OutputData_.Cells[1,0] := '����.';
  for Row := 1 to n do
    OutputData_.Cells[0,Row] := 'X('+inttostr(Row)+')';
end;

procedure TGausse_.Load_Click(Sender: TObject);
var
  //��������� ����
  F : TextFile;
  //�������������� ����������, ������ � �������
  n, i, j : Integer;
  Temp : String;
begin
  //��������� ������ ������� ������
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //���� ������� ������
  ClickOnTableFlag := True;
  //�������� � ���������� �� �����
  AssignFile(F, 'History.txt');
  ReSet(F);
  //���������� �����������
  ReadLn(F, n);
  //�������� ������� InputData_
  InputData_.ColCount := n + 2;
  InputData_.RowCount := n + 1;
  for j := 1 to n do
    InputData_.Cells[j,0] := 'K('+inttostr(j)+')';
  InputData_.Cells[n+1,0] := '����.';
  for i := 1 to n do
    InputData_.Cells[0,i] := Char(i+64);

  //�������� ������� OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := n + 1;
  for i := 1 to n do
    OutputData_.Cells[1,i] := ' ';
  OutputData_.Cells[1,0] := '����.';
  for i := 1 to n do
    OutputData_.Cells[0,i] := 'X('+inttostr(i)+')';
  for j := 1 to n do
    for i := 1 to n + 1 do
      begin
        ReadLn(f, Temp);
        Temp := Trim(Temp);
        InputData_.Cells[i, j] := Temp;
      end;
  //�������� �����
  CloseFile(f);

  //����� ���������
  ShowMessage('������ ���� ������� ���������.');
end;

procedure TGausse_.StartWork_Click(Sender: TObject);
var
  //����������� ����, ������� � ������� ������
  n, j, i : Integer;
  //������� �������������
  Matrix : TMatrix;
  //������� �������
  Decisions : TArray;
  //���������� ��� �������� ������� ���������� ��������
  iCounterPerSec : Int64;
  T1, T2 : Int64;
  GausseTime : Real;

begin
  //�������� ������� ������ TableCreate_
  if not ClickOnTableFlag then
    begin
      ShowMessage('������! ������� �������� �������...');
      Exit;
    end;
  //���������� �����������
  n := InputData_.ColCount - 2;
  //���� ������� ������
  ClickOnSearchFlag := True;

  //�������� ������� �������������
  SetLength(Matrix, n, n+1);
  //�������� ������� ������
  SetLength(Decisions, n+1);
  for i := 0 to n - 1 do
    for j := 0 to n do
      begin
        InputData_.Cells[j+1,i+1] := Trim(InputData_.Cells[j+1,i+1]);
        Matrix[i,j] := StrToFloat(InputData_.Cells[j+1,i+1]);
        Decisions[i] := 0;
      end;

  //������� ������� ���������� �������� (������)
  QueryPerformanceFrequency(iCounterPerSec);
  QueryPerformanceCounter(T1);

  //������� �������
  Decisions := SearchDec(Matrix, Decisions, n);
  //������������ ������
  Matrix := nil;

  //������� ������� ���������� �������� (�����������)
  QueryPerformanceCounter(T2);
  GausseTime := (T2 - T1) / iCounterPerSec;
  Timer_.Text := FloatToStr(GausseTime);

  //�������� �������
  if Decisions[n] = 1 then
    begin
      Showmessage('������� �� ����� �������!');
      Decisions := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;
  if Decisions[n] = 2 then
    begin
      Showmessage('������� �� ����������!');
      Decisions := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;

  //����� ������
  for i := 0 to n - 1 do
  OutputData_.Cells[1,i+1] := FloatToStrF(Decisions[i],ffFixed,6,2);
  //������������ ������
  Decisions := nil;
end;

procedure TGausse_.SaveInFile_Click(Sender: TObject);
var
  //��������� ����
  F : TextFile;
  //�����������, ������ � �������
  i, j, n : Integer;
  //����� ������ �����
  Flag1, Flag2 : Boolean;

begin
  //��������� ������ ������ �����
  Flag1 := False;
  Flag2 := False;
  //�������� ������� ������ TableCreate_
  if not ClickOnTableFlag then
  begin
    ShowMessage('������! ������� �������� �������...');
    Flag1 := True;
  end;
  //�������� ������� ������ StartWork_
  if (not ClickOnSearchFlag) and (not Flag1) then
    begin
      ShowMessage('������! ������� �������� �������...');
      Flag2 := True;
    end;
  if (not Flag1) and (not Flag2) then
    begin
      //�������� � ������ � ����
      AssignFile(F, 'History.txt');

      Rewrite(F);
      //���������� �����������
      n := InputData_.ColCount - 2;
      //������ InputData_ � ����
      WriteLn(f, n);
      for j := 1 to n do
       for i := 1 to n + 1 do
         WriteLn(F, InputData_.Cells[i,j]);

      //�������� �����
      CloseFile(F);

      //����� ���������
      ShowMessage('������ ���� ������� ���������.');
    end;
end;

procedure TGausse_.GAnalysis_Click(Sender: TObject);
var
  //����� ������ �����
  Flag1, Flag2 : Boolean;

begin
  //��������� ������ ������ �����
  Flag1 := False;
  Flag2 := False;
  //�������� ������� ������ TableCreate_
  if not ClickOnTableFlag then
  begin
    ShowMessage('������! ������� �������� �������...');
    Flag1 := True;
  end;
  //�������� ������� ������ StartWork_
  if (not ClickOnSearchFlag) and (not Flag1) then
    begin
      ShowMessage('������! ������� �������� �������...');
      Flag2 := True;
    end;

  //����� ������� ������ ������
  if (not Flag1) and (not Flag2) then GausseAnalysis_.ShowModal;
end;

end.
