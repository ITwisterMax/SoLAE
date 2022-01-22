unit KramerDeterminant;

interface
  type
    //��� �����
    TArray = array of Real;
    //��� ������ �������������
    TMatrix = array of TArray;
  //���������� �����
  procedure Sort(var Matrix : TMatrix; Idol, n : Integer);
  //���������� � ������������ ����
  procedure Matrix_NxN(var Matrix : TMatrix; n : Integer);
  //������� ������������
  function SearchDet(var Matrix : TMatrix; n : Integer) : Real;

implementation

procedure Sort(var Matrix : TMatrix; Idol, n : Integer);
var
  //������ � �������
  i, j, k : Integer;
  //��������������� ����������
  Temp : Real;

begin
  for j := Idol to n - 2 do
    begin
      if Matrix[Idol,j] = 0 then
        //������ ������ � ������� ��������� � ��������� �� ��� �������
        for i := Idol to n - 2 do
          for k := 0 to n - 1 do
            begin
              Temp := Matrix[i,k];
              Matrix[i,k] := Matrix[i+1,k];
              Matrix[i+1,k] := -1 * Temp;
            end;
    end;
end;

procedure Matrix_NxN(var Matrix : TMatrix; n : Integer);
var
  //������ � �������
  i, j, Idol : Integer;
  //����������� ������������������ �����
  Coef : Real;

begin
  Idol := -1;
  repeat
    //������� ������� ���������
    inc(Idol);
    //������ ������ � ������� ��������� � ��������� �� ��� �������
    if Matrix[Idol,Idol] = 0 then Sort(Matrix, Idol, n);
    for i := Idol + 1 to n - 1 do
      begin
        if Matrix[Idol,Idol] = 0 then Continue;
        //������� ������������ ������������������ �����
        Coef := Matrix[i,Idol] / Matrix[Idol,Idol];
        //�������������� �����
        for j := Idol to n - 1 do
          Matrix[i,j] := Matrix[i,j] - Matrix[Idol,j] * Coef;
      end;
  until Idol = n - 2;
end;

function SearchDet(var Matrix : TMatrix; n : Integer) : Real;
var
  //������ �������� ������� ���������
  i : Integer;
  //������������
  Det : Real;

begin
  Det := 1;
  Matrix_NxN(Matrix, n);

  //����������� �������� ������� ���������
  for i := 0 to n - 1 do
    Det := Det * Matrix[i,i];
  Result := Det;
end;
end.

