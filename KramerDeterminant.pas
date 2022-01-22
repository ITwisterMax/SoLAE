unit KramerDeterminant;

interface
  type
    //Для строк
    TArray = array of Real;
    //Для матриц коэффициентов
    TMatrix = array of TArray;
  //Сортировка строк
  procedure Sort(var Matrix : TMatrix; Idol, n : Integer);
  //Приведение к треугольному виду
  procedure Matrix_NxN(var Matrix : TMatrix; n : Integer);
  //Подсчет определителя
  function SearchDet(var Matrix : TMatrix; n : Integer) : Real;

implementation

procedure Sort(var Matrix : TMatrix; Idol, n : Integer);
var
  //Строки и столбцы
  i, j, k : Integer;
  //Вспомогательная переменная
  Temp : Real;

begin
  for j := Idol to n - 2 do
    begin
      if Matrix[Idol,j] = 0 then
        //Меняем строку с нулевым элементом и следующую за ней местами
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
  //Строки и столбцы
  i, j, Idol : Integer;
  //Коэффициент пропорциональности строк
  Coef : Real;

begin
  Idol := -1;
  repeat
    //Элемент главной диагонали
    inc(Idol);
    //Меняем строку с нулевым элементом и следующую за ней местами
    if Matrix[Idol,Idol] = 0 then Sort(Matrix, Idol, n);
    for i := Idol + 1 to n - 1 do
      begin
        if Matrix[Idol,Idol] = 0 then Continue;
        //Подсчет коэффициента пропорциональности строк
        Coef := Matrix[i,Idol] / Matrix[Idol,Idol];
        //Преобразование строк
        for j := Idol to n - 1 do
          Matrix[i,j] := Matrix[i,j] - Matrix[Idol,j] * Coef;
      end;
  until Idol = n - 2;
end;

function SearchDet(var Matrix : TMatrix; n : Integer) : Real;
var
  //Индекс элемента главной диагонали
  i : Integer;
  //Определитель
  Det : Real;

begin
  Det := 1;
  Matrix_NxN(Matrix, n);

  //Перемножаем элементы главной диагонали
  for i := 0 to n - 1 do
    Det := Det * Matrix[i,i];
  Result := Det;
end;
end.

