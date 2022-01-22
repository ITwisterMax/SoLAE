unit MatrixAnalysis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TMatrixAnalysis_ = class(TForm)
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
  MatrixAnalysis_: TMatrixAnalysis_;

implementation

{$R *.dfm}

//Матричный способ
uses UnitMatrix;

procedure TMatrixAnalysis_.Start(Sender: TObject);
var
  n : Integer;
begin
  //Установка фокуса
  Cancel_.SetFocus;

  n := UnitMatrix.Matrix_.InputData_.ColCount - 2;
  //Заполнение таблицы
  Analysis_.Cells[0,0] := 'Пункты';
  Analysis_.Cells[1,0] := 'Характеристика';
  Analysis_.Cells[0,1] := '1. Наименование метода';
  Analysis_.Cells[1,1] := 'Матричный способ';
  Analysis_.Cells[0,2] := '2. Сложность алгоритма';
  Analysis_.Cells[1,2] := 'O(n^4), где n - кол. уравнений';
  Analysis_.Cells[0,3] := '3. Количество уравнений';
  Analysis_.Cells[1,3] := IntToStr(n);
  Analysis_.Cells[0,4] := '4. Скорость выполнения (сек)';
  Analysis_.Cells[1,4] := UnitMatrix.Matrix_.Timer_.Text;
  Analysis_.Cells[0,5] := '5. Достоинства';
  Analysis_.Cells[1,5] := 'Хороша при небольших СЛАУ, теоретич. интерес';
  Analysis_.Cells[0,6] := '6. Недостатки';
  Analysis_.Cells[1,6] := 'Трудоемкость, выполняется только при Det<>0';
end;

end.
