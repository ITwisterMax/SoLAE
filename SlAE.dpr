program SlAE;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {MainMenu_},
  Help in 'Help.pas' {Help_},
  KramerDeterminant in 'KramerDeterminant.pas',
  UnitKramer in 'UnitKramer.pas' {Kramer_},
  Vcl.Themes,
  Vcl.Styles,
  KramerAnalysis in 'KramerAnalysis.pas' {KramerAnalysis_},
  UnitGausse in 'UnitGausse.pas' {Gausse_},
  GausseAnalysis in 'GausseAnalysis.pas' {GausseAnalysis_},
  GausseDeterminant in 'GausseDeterminant.pas',
  UnitMatrix in 'UnitMatrix.pas' {Matrix_},
  MatrixAnalysis in 'MatrixAnalysis.pas' {MatrixAnalysis_},
  MatrixDeterminant in 'MatrixDeterminant.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cobalt XEMedia');
  Application.CreateForm(TMainMenu_, MainMenu_);
  Application.CreateForm(THelp_, Help_);
  Application.CreateForm(TKramer_, Kramer_);
  Application.CreateForm(TKramerAnalysis_, KramerAnalysis_);
  Application.CreateForm(TGausse_, Gausse_);
  Application.CreateForm(TGausseAnalysis_, GausseAnalysis_);
  Application.CreateForm(TMatrix_, Matrix_);
  Application.CreateForm(TMatrixAnalysis_, MatrixAnalysis_);
  Application.Run;
end.
