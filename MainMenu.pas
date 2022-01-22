unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.MPlayer;

type
  TMainMenu_ = class(TForm)
    //Музыка
    Music_: TMediaPlayer;
    //Фон
    BackGround_: TImage;
    //Картинка
    Decor_: TImage;
    //Заголовок
    Head_: TLabel;
    //Матричный способ
    MatrixMethod_: TButton;
    //Формулы Крамера
    KramerMethod_: TButton;
    //Метод Гаусса
    GausseMethod_: TButton;
    //Справка
    Reference_: TButton;
    //Выход
    Exit_: TButton;

//Запуск формы
procedure Start(Sender: TObject);
//Повторение мелодии
procedure OnNotify(Sender: TObject);
//Матричный способ
procedure MatrixMethod_Click(Sender: TObject);
//Формулы Крамера
procedure KramerMethod_Click(Sender: TObject);
//Метод Гаусса
procedure GausseMethod_Click(Sender: TObject);
//Справка
procedure Reference_Click(Sender: TObject);
//Выход
procedure Exit_Click(Sender: TObject);

private
  { Private declarations }
public
  { Public declarations }
end;

var
  //Форма
  MainMenu_: TMainMenu_;

implementation

{$R *.dfm}

//Матричный способ, формулы Крамера, метод Гаусса и справка
uses UnitMatrix, UnitKramer, Help, UnitGausse;

procedure TMainMenu_.Start(Sender: TObject);
begin
  //Установка фокуса
  Exit_.SetFocus;
  //Воспроизведение мелодии
  Music_.Play;
end;

procedure TMainMenu_.OnNotify(Sender: TObject);
begin
  //Повторение мелодии
  with Music_ do
  if NotifyValue = nvSuccessful then
    begin
      Notify := True;
      Play;
    end;
end;

procedure TMainMenu_.MatrixMethod_Click(Sender: TObject);
begin
  //Вывод формы "Матричный способ"
  Matrix_.ShowModal;
end;

procedure TMainMenu_.KramerMethod_Click(Sender: TObject);
begin
  //Вывод формы "Формулы Крамера"
  Kramer_.ShowModal;
end;

procedure TMainMenu_.GausseMethod_Click(Sender: TObject);
begin
  //Вывод формы "Метод Крамера"
  Gausse_.ShowModal;
end;

procedure TMainMenu_.Reference_Click(Sender: TObject);
begin
  //Вывод Формы "Справка"
  Help_.ShowModal;
end;

procedure TMainMenu_.Exit_Click(Sender: TObject);
begin
  //Закрытие формы "Главное Меню"
  MainMenu_.Close;
end;

end.
