program SocMaxStat;

uses
  Forms,
  Main in 'src\Main.pas' {Form1},
  Vyb_Play in 'src\Vyb_Play.pas' {Form2},
  Sost_Play in 'src\Sost_Play.pas' {Form3},
  Sost_Tab in 'src\Sost_Tab.pas' {Form4},
  Game_Vsego in 'src\Game_Vsego.pas' {Form5};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
