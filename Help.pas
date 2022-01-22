unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  THelp_ = class(TForm)
    //Фон
    BackGround_: TImage;
    //Заголовок
    Head_: TLabel;
    //Рамка
    Frame_: TPanel;
    //Справка
    Reference_: TImage;
    //Пункт 0
    Start_: TLabel;
    //Пункт 1
    Point1_: TLabel;
    //Пункт 2
    Point2_: TLabel;
    //Пункт 3
    Point3_: TLabel;
    //Пункт 4
    Point4_: TLabel;
    //Пункт 5
    Point5_: TLabel;
    //Пункт 6
    Point6_: TLabel;
    //Пункт 7
    Point7_: TLabel;
    //Пункт 8
    Point8_: TLabel;
    //Выход в главное меню
    ExitToMainMenu_: TButton;



private
  { Private declarations }
public
  { Public declarations }
end;

var
  //Форма
  Help_: THelp_;

implementation

{$R *.dfm}

end.
