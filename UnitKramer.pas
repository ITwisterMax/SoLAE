unit UnitKramer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Samples.Spin;

type
  TKramer_ = class(TForm)
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
    KAnalysis_: TButton;
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
procedure KAnalysis_Click(Sender: TObject);


private
{ Private declarations }
public
{ Public declarations }
end;

var
  //�����
  Kramer_: TKramer_;
  //����� ������� ������
  ClickOnTableFlag, ClickOnSearchFlag : Boolean;

implementation

{$R *.dfm}

//������� ������������ � ����� ������� ������ �������
uses KramerDeterminant, KramerAnalysis;

procedure TKramer_.Start(Sender: TObject);
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

procedure TKramer_.TableCreate_Click(Sender: TObject);
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

procedure TKramer_.Load_Click(Sender: TObject);
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

procedure TKramer_.StartWork_Click(Sender: TObject);
var
  //����������� ����, ������� � ������� ������
  n, k, j, i : Integer;
  //������� �������������
  MatrixA, MatrixB : TMatrix;
  //������� ��������� ������ � �������
  StringA, StringB : TArray;
  //������������
  DetA, DetB : Real;
  //���������� ��� �������� ������� ���������� ��������
  iCounterPerSec : Int64;
  T1, T2 : Int64;
  KramerTime : Real;

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

  //�������� ������� ������������� A
  SetLength(MatrixA, n, n);
  //�������� ������� ������������� A
  SetLength(StringA, n);
  for k := 0 to n - 1 do
    for j := 0 to n - 1 do
      begin
        InputData_.Cells[j+1,k+1] := Trim(InputData_.Cells[j+1,k+1]);
        MatrixA[k,j] := StrToFloat(InputData_.Cells[j+1,k+1]);
        InputData_.Cells[n+1,k+1] := Trim(InputData_.Cells[n+1,k+1]);
        StringA[k] := StrToFloat(InputData_.Cells[n+1,k+1]);
      end;

  //������� ������� ���������� �������� (������)
  QueryPerformanceFrequency(iCounterPerSec);
  QueryPerformanceCounter(T1);

  //������� ������������ A
  DetA := SearchDet(MatrixA, n);
  //������������ ������
  MatrixA := nil;

  //�������� ������� ������������� B
  SetLength(MatrixB, n, n);
  //�������� ������� ������� B
  SetLength(StringB, n);
  for i := 0 to n - 1 do
  begin
    for k := 0 to n - 1 do
      begin
        for j := 0 to n - 1 do
          MatrixB[k,j] := StrToFloat(InputData_.Cells[j+1,k+1]);
        MatrixB[k,i] := StringA[k];
      end;
    //������� ������������ B
    DetB := SearchDet(MatrixB, n);

    //�������� �������
    if (DetA = 0) and (DetB = 0) then
    begin
      Showmessage('������� �� ����������!');
      //������������ ������
      StringA := nil;
      StringB := nil;
      MatrixB := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;
    if (DetA = 0) and (DetB <> 0) then
    begin
      Showmessage('������� �� ����� �������!');
      //������������ ������
      StringA := nil;
      StringB := nil;
      MatrixB := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;

    //������� �������
    StringB[i] := DetB / DetA;
  end;
  //������������ ������
  StringA := nil;
  MatrixB := nil;

  //������� ������� ���������� �������� (�����������)
  QueryPerformanceCounter(T2);
  KramerTime := (T2 - T1) / iCounterPerSec;
  Timer_.Text := FloatToStr(KramerTime);

  //����� �������
  for i := 0 to n - 1 do
  OutputData_.Cells[1,i+1] := FloatToStrF(StringB[i],ffFixed,6,2);
  //������������ ������
  StringB := nil;
end;

procedure TKramer_.SaveInFile_Click(Sender: TObject);
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

procedure TKramer_.KAnalysis_Click(Sender: TObject);
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

  //����� ������� ������ �������
  if (not Flag1) and (not Flag2) then KramerAnalysis_.ShowModal;
end;

end.
