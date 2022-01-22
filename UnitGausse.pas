unit UnitGausse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.Grids,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TGausse_ = class(TForm)
    //Фон
    BackGround_: TImage;
    //Картинка
    Decor_: TImage;
    //Заголовок
    Head_: TLabel;
    //Текст
    TextAboutN_: TLabel;
    //Размерность
    InfoAboutN_: TSpinEdit;
    //Время выполнения операций
    Timer_: TEdit;
    //Создать таблицы
    TableCreate_: TButton;
    //Загрузить таблицы
    Load_: TButton;
    //Решить СЛАУ
    StartWork_: TButton;
    //Сохранить СЛАУ
    SaveInFile_: TButton;
    //Анализ СЛАУ
    GAnalysis_: TButton;
    //Таблица для ввода СЛАУ
    InputData_: TStringGrid;
    //Таблица для решений СЛАУ
    OutputData_: TStringGrid;
    //Выход в главное меню
    ExitToMainMenu_: TButton;

//Запуск формы
procedure Start(Sender: TObject);
//Создать таблицы
procedure TableCreate_Click(Sender: TObject);
//Загрузка из файла
procedure Load_Click(Sender: TObject);
//Решить СЛАУ
procedure StartWork_Click(Sender: TObject);
//Сохранить СЛАУ
procedure SaveInFile_Click(Sender: TObject);
//Анализ СЛАУ
procedure GAnalysis_Click(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //Форма
  Gausse_: TGausse_;
  //Флаги нажатия кнопок
  ClickOnTableFlag, ClickOnSearchFlag : Boolean;

implementation

{$R *.dfm}

//Подсчет решений и вывод анализа метода Гаусса
uses GausseDeterminant, GausseAnalysis;

procedure TGausse_.Start(Sender: TObject);
var
  //Колонки и столбцы таблиц
  Col, Row : Integer;

begin
  //Установка фокуса
  InfoAboutN_.SetFocus;
  //Обнуление флагов нажатия кнопок
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //Установка надписи в InfoAboutN_
  InfoAboutN_.Text := '10';

  //Стандартное наполнение таблицы InputData_
  InputData_.ColCount := 12;
  InputData_.RowCount := 11;
    for Col := 0 to 11 do
      for Row := 0 to 10 do
        InputData_.Cells[Col,Row] := ' ';

  //Стандартное наполнение таблицы OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := 11;
  for Col := 0 to 1 do
    for Row := 0 to 10 do
      OutputData_.Cells[Col,Row] := ' ';
end;

procedure TGausse_.TableCreate_Click(Sender: TObject);
var
  //Размерность СЛАУ, колонки и стобцы таблиц
  n, Col, Row : Integer;

begin
  //Обнуление флагов нажатия кнопок
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //Считывание размерности
  n := StrToInt(InfoAboutN_.Text);
  //Флаг нажатия кнопки
  ClickOnTableFlag := True;

  //Создание таблицы InputData_
  InputData_.ColCount := n + 2;
  InputData_.RowCount := n + 1;
  for Col := 1 to n + 1 do
    for Row := 1 to n do
      InputData_.Cells[Col,Row] := ' ';
  for Col := 1 to n do
    InputData_.Cells[Col,0] := 'K('+inttostr(Col)+')';
  InputData_.Cells[n+1,0] := 'Знач.';
  for Row := 1 to n do
    InputData_.Cells[0,Row] := Char(Row+64);

  //Создание таблицы OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := n + 1;
  for Row := 1 to n do
    OutputData_.Cells[1,Row] := ' ';
  OutputData_.Cells[1,0] := 'Знач.';
  for Row := 1 to n do
    OutputData_.Cells[0,Row] := 'X('+inttostr(Row)+')';
end;

procedure TGausse_.Load_Click(Sender: TObject);
var
  //Текстовый файл
  F : TextFile;
  //Впомогательные переменные, строки и столбцы
  n, i, j : Integer;
  Temp : String;
begin
  //Обнуление флагов нажатия кнопок
  ClickOnTableFlag := False;
  ClickOnSearchFlag := False;
  //Флаг нажатия кнопки
  ClickOnTableFlag := True;
  //Открытие и считывание из файла
  AssignFile(F, 'History.txt');
  ReSet(F);
  //Считывание размерности
  ReadLn(F, n);
  //Создание таблицы InputData_
  InputData_.ColCount := n + 2;
  InputData_.RowCount := n + 1;
  for j := 1 to n do
    InputData_.Cells[j,0] := 'K('+inttostr(j)+')';
  InputData_.Cells[n+1,0] := 'Знач.';
  for i := 1 to n do
    InputData_.Cells[0,i] := Char(i+64);

  //Создание таблицы OutputData_
  OutputData_.ColCount := 2;
  OutputData_.RowCount := n + 1;
  for i := 1 to n do
    OutputData_.Cells[1,i] := ' ';
  OutputData_.Cells[1,0] := 'Знач.';
  for i := 1 to n do
    OutputData_.Cells[0,i] := 'X('+inttostr(i)+')';
  for j := 1 to n do
    for i := 1 to n + 1 do
      begin
        ReadLn(f, Temp);
        Temp := Trim(Temp);
        InputData_.Cells[i, j] := Temp;
      end;
  //Закрытие файла
  CloseFile(f);

  //Вывод сообщения
  ShowMessage('Данные были успешно загружены.');
end;

procedure TGausse_.StartWork_Click(Sender: TObject);
var
  //Размерность СЛАУ, колонки и столбцы таблиц
  n, j, i : Integer;
  //Матрица коэффициентов
  Matrix : TMatrix;
  //Столбец решений
  Decisions : TArray;
  //Переменные для подсчета времени выполнения операций
  iCounterPerSec : Int64;
  T1, T2 : Int64;
  GausseTime : Real;

begin
  //Проверка нажатия кнопки TableCreate_
  if not ClickOnTableFlag then
    begin
      ShowMessage('Ошибка! Сначала создайте таблицу...');
      Exit;
    end;
  //Считывание размерности
  n := InputData_.ColCount - 2;
  //Флаг нажатия кнопки
  ClickOnSearchFlag := True;

  //Создание матрицы коэффициентов
  SetLength(Matrix, n, n+1);
  //Создание столбца корней
  SetLength(Decisions, n+1);
  for i := 0 to n - 1 do
    for j := 0 to n do
      begin
        InputData_.Cells[j+1,i+1] := Trim(InputData_.Cells[j+1,i+1]);
        Matrix[i,j] := StrToFloat(InputData_.Cells[j+1,i+1]);
        Decisions[i] := 0;
      end;

  //Подсчет времени выполнения операций (начало)
  QueryPerformanceFrequency(iCounterPerSec);
  QueryPerformanceCounter(T1);

  //Подсчет решений
  Decisions := SearchDec(Matrix, Decisions, n);
  //Освобождение памяти
  Matrix := nil;

  //Подсчет времени выполнения операций (продолжение)
  QueryPerformanceCounter(T2);
  GausseTime := (T2 - T1) / iCounterPerSec;
  Timer_.Text := FloatToStr(GausseTime);

  //Проверки системы
  if Decisions[n] = 1 then
    begin
      Showmessage('Система не имеет решений!');
      Decisions := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;
  if Decisions[n] = 2 then
    begin
      Showmessage('Система не определена!');
      Decisions := nil;
      ClickOnSearchFlag := False;
      Exit;
    end;

  //Вывод корней
  for i := 0 to n - 1 do
  OutputData_.Cells[1,i+1] := FloatToStrF(Decisions[i],ffFixed,6,2);
  //Освобождение памяти
  Decisions := nil;
end;

procedure TGausse_.SaveInFile_Click(Sender: TObject);
var
  //Текстовый файл
  F : TextFile;
  //Размерность, строки и столбцы
  i, j, n : Integer;
  //Флаги ошибок ввода
  Flag1, Flag2 : Boolean;

begin
  //Обнуление флагов ошибок ввода
  Flag1 := False;
  Flag2 := False;
  //Проверка нажатия кнопки TableCreate_
  if not ClickOnTableFlag then
  begin
    ShowMessage('Ошибка! Сначала создайте таблицу...');
    Flag1 := True;
  end;
  //Проверка нажатия кнопки StartWork_
  if (not ClickOnSearchFlag) and (not Flag1) then
    begin
      ShowMessage('Ошибка! Сначала получите решения...');
      Flag2 := True;
    end;
  if (not Flag1) and (not Flag2) then
    begin
      //Открытие и запись в файл
      AssignFile(F, 'History.txt');

      Rewrite(F);
      //Считывание размерности
      n := InputData_.ColCount - 2;
      //Запись InputData_ в файл
      WriteLn(f, n);
      for j := 1 to n do
       for i := 1 to n + 1 do
         WriteLn(F, InputData_.Cells[i,j]);

      //Закрытие файла
      CloseFile(F);

      //Вывод сообщения
      ShowMessage('Данные были успешно сохранены.');
    end;
end;

procedure TGausse_.GAnalysis_Click(Sender: TObject);
var
  //Флаги ошибок ввода
  Flag1, Flag2 : Boolean;

begin
  //Обнуление флагов ошибок ввода
  Flag1 := False;
  Flag2 := False;
  //Проверка нажатия кнопки TableCreate_
  if not ClickOnTableFlag then
  begin
    ShowMessage('Ошибка! Сначала создайте таблицу...');
    Flag1 := True;
  end;
  //Проверка нажатия кнопки StartWork_
  if (not ClickOnSearchFlag) and (not Flag1) then
    begin
      ShowMessage('Ошибка! Сначала получите решения...');
      Flag2 := True;
    end;

  //Вывод анализа метода Гаусса
  if (not Flag1) and (not Flag2) then GausseAnalysis_.ShowModal;
end;

end.
