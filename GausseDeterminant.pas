unit GausseDeterminant;

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
  //������� �������
  function SearchDec(var Matrix : TMatrix; var Decisions : TArray; n : Integer) : TArray;

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
          for k := 0 to n do
            begin
              Temp := Matrix[i,k];
              Matrix[i,k] := Matrix[i+1,k];
              Matrix[i+1,k] := Temp;
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
        for j := Idol to n do
          Matrix[i,j] := Matrix[i,j] - Matrix[Idol,j] * Coef;
      end;
  until Idol = n - 2;
end;

function SearchDec(var Matrix : TMatrix; var Decisions : TArray; n : Integer) : TArray;
var
  //������ �������� ������� ���������
  i, j : Integer;
  Flag : Boolean;

begin
  Matrix_NxN(Matrix, n);
  //n-�� ������� �������� �� ��� ������ (0 - ������ ���, 1 - ��� �������, 2 - ������� �� ����������)
  Decisions[n] := 0;

  //�������� �������
  for i := 0 to n - 1 do
    begin
      Flag := False;
      for j := 0 to n - 1 do
        if Matrix[i,j] <> 0 then Flag := True;
      if not Flag and (Matrix[i,n] <> 0) then Decisions[n] := 1;
    end;
  if Decisions[n] <> 1 then
    begin
      Flag := False;
      for i := 0 to n - 1 do
        begin
          if Matrix[i,i] = 0 then Flag := True;
          if Flag then  Decisions[n] := 2;
        end;
    end;

  //������� �������
  if (Decisions[n] <> 1) and (Decisions[n] <> 2) then
    for i := n - 1 downto 0 do
      begin
        for j := 0 to n - 1 do
          Matrix[i,n] := Matrix[i,n] - Decisions[j] * Matrix[i,j];
        Decisions[i] := Matrix[i,n] / Matrix[i,i];
      end;
  Result := Decisions;
end;

end.
