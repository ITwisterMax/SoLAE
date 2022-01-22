unit GausseAnalysis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TGausseAnalysis_ = class(TForm)
    //�������
    Analysis_: TStringGrid;
    //�����
    Cancel_: TButton;

//������ �����
procedure Start(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //�����
  GausseAnalysis_: TGausseAnalysis_;

implementation

{$R *.dfm}

//����� ������
uses UnitGausse;

procedure TGausseAnalysis_.Start(Sender: TObject);
var
  n : Integer;
begin
  //��������� ������
  Cancel_.SetFocus;

  n := UnitGausse.Gausse_.InputData_.ColCount - 2;
  //���������� �������
  Analysis_.Cells[0,0] := '������';
  Analysis_.Cells[1,0] := '��������������';
  Analysis_.Cells[0,1] := '1. ������������ ������';
  Analysis_.Cells[1,1] := '����� ������';
  Analysis_.Cells[0,2] := '2. ��������� ���������';
  Analysis_.Cells[1,2] := 'O(n^3), ��� n - ���. ���������';
  Analysis_.Cells[0,3] := '3. ���������� ���������';
  Analysis_.Cells[1,3] := IntToStr(n);
  Analysis_.Cells[0,4] := '4. �������� ���������� (���)';
  Analysis_.Cells[1,4] := UnitGausse.Gausse_.Timer_.Text;
  Analysis_.Cells[0,5] := '5. �����������';
  Analysis_.Cells[1,5] := '����� ����������, ��������� ���������� rang(A)';
  Analysis_.Cells[0,6] := '6. ����������';
  Analysis_.Cells[1,6] := '������ �������� �������, �������� �����������';
end;

end.
