unit MatrixDeterminant;

interface
  //Подсчет определителя
  uses KramerDeterminant;
  //Подсчет обратной матрицы
  function Matrix_NxN(var Matrix_ : TMatrix; n : Integer) : TMatrix ;
  //Подсчет решений
  function SearchDec(var Matrix_ : TMatrix; var Decisions_ : TArray; n : Integer) : TArray;

implementation

function Matrix_NxN(var Matrix_ : TMatrix; n : Integer) : TMatrix ;
var
  //Строки и столбцы
  i, j, Idol : Integer;
  //Коэффициент пропорциональности строк
  Coef : Real;
  //Обратная матрица
  BackMatrix_ : TMatrix;

begin
  //Создание единичной матрицы
  SetLength(BackMatrix_, n, n);
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do
      if i = j then BackMatrix_[i,j] := 1
        else BackMatrix_[i, j] := 0;

  //Проход сверху вниз (разрешающий элемент 1, а элементы ниже 0)
  for Idol := 0 to n - 1 do
    for i := Idol + 1 to n-1 do
      begin
        Coef := Matrix_[i, Idol];
        for j := Idol to n - 1 do
          Matrix_[i, j] := Matrix_[i,j] - Coef * (Matrix_[Idol, j] / Matrix_[Idol,Idol]);
        for j := 0 to n - 1 do
          BackMatrix_[i,j] := BackMatrix_[i,j] - Coef * (BackMatrix_[Idol,j] / Matrix_[Idol,Idol]);
      end;

  //Проход снизу вверх (делая разрешающий элемент 1, а элементы выше 0)
  for Idol := n - 1 downto 1 do
    for i := Idol downto 1 do
      begin
        Coef := Matrix_[i-1,Idol];
        for j := Idol downto 0 do
          Matrix_[i-1,j] := Matrix_[i-1,j] - Coef * (Matrix_[Idol,j] / Matrix_[Idol,Idol]);
        for j := 0 to n - 1 do
          BackMatrix_[i-1,j] := BackMatrix_[i-1,j] - Coef * (BackMatrix_[Idol,j] / Matrix_[Idol,Idol]);
      end;

  //Деление на разрешающий элемент
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do
      BackMatrix_[i,j] := BackMatrix_[i,j] / Matrix_[i,i];
  Result := BackMatrix_;
end;

function SearchDec(var Matrix_ : TMatrix; var Decisions_ : TArray; n : Integer) : TArray;
var
  //Строки и столбцы
  i, j : Integer;
  //Обратная матрица
  BackMatrix_ : TMatrix;
  //Решения
  String_ : TArray;

begin
  //Создание обратной матрицы
  SetLength(BackMatrix_, n, n);
  //Создание и зануление решения
  SetLength(String_, n);
  for i := 0 to n - 1 do
    String_[i] := 0;

  //Подсчет обратной матрицы
  BackMatrix_ := Matrix_NxN(Matrix_, n);
  //Подсчет решений
  for i := 0 to n - 1 do
    for j := 0 to n - 1 do
      String_[i] := String_[i] + BackMatrix_[i,j] * Decisions_[j];
  Result := String_;
end;

end.

