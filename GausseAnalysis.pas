unit GausseAnalysis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TGausseAnalysis_ = class(TForm)
    //Таблица
    Analysis_: TStringGrid;
    //Выход
    Cancel_: TButton;

//Запуск Формы
procedure Start(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //Форма
  GausseAnalysis_: TGausseAnalysis_;

implementation

{$R *.dfm}

//Метод Гаусса
uses UnitGausse;

procedure TGausseAnalysis_.Start(Sender: TObject);
var
  n : Integer;
begin
  //Установка фокуса
  Cancel_.SetFocus;

  n := UnitGausse.Gausse_.InputData_.ColCount - 2;
  //Заполнение таблицы
  Analysis_.Cells[0,0] := 'Пункты';
  Analysis_.Cells[1,0] := 'Характеристика';
  Analysis_.Cells[0,1] := '1. Наименование метода';
  Analysis_.Cells[1,1] := 'Метод Гаусса';
  Analysis_.Cells[0,2] := '2. Сложность алгоритма';
  Analysis_.Cells[1,2] := 'O(n^3), где n - кол. уравнений';
  Analysis_.Cells[0,3] := '3. Количество уравнений';
  Analysis_.Cells[1,3] := IntToStr(n);
  Analysis_.Cells[0,4] := '4. Скорость выполнения (сек)';
  Analysis_.Cells[1,4] := UnitGausse.Gausse_.Timer_.Text;
  Analysis_.Cells[0,5] := '5. Достоинства';
  Analysis_.Cells[1,5] := 'Менее трудоемкий, позволяет определить rang(A)';
  Analysis_.Cells[0,6] := '6. Недостатки';
  Analysis_.Cells[1,6] := 'Нельзя выразить формулы, машинная погрешность';
end;

end.
