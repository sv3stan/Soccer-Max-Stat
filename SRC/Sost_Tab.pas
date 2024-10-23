unit Sost_Tab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     NxColumns, NxScrollControl, NxColumnClasses,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxFieldChooser,

  Db, EasyTable, Dialogs, StdCtrls;
{  NxCellSource,}

type
  TForm4 = class(TForm)
    Label1: TLabel;
  Procedure Sost_Tablicu(Date1:TDate; Date2:TDate);  // Таблица //

  procedure sost_table(date_1_vyb:TDate; date_2_vyb:TDate; vyb_1_tur:Integer; vyb_2_tur:Integer; vr_table:Integer);
    // процедура составления таблиц
    // vr_table  1 - общая с последними играми
    // vr_table  2 - общая + дома + выезд
    // vr_table  3 - общая + 1 тайм + 2 тайм
    // vr_table  4 - дома с последними играми
    // vr_table  5 - дома + 1 тайм + 2 тайм
    // vr_table  6 - выезд с последними играми
    // vr_table  7 - выезд + 1 тайм + 2 тайм
  procedure sost_shamat_vsego(date_1_vyb:TDate; date_2_vyb:TDate; vyb_1_tur:Integer; vyb_2_tur:Integer; vr:Integer; vr_i:integer);
    // процедура составления шахматки по итогам всей игры
    // переменные дата начала выбора, дата окончания выбора, номер начального тура выбора
    // номер конечного тура выбора, вариант выбора: 0 - по дате, 1 - по турам
    // vr_I: вариант игога 1- всего, 2 - 1 тайм, 3 - 2 тайм
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Main;

{$R *.dfm}
  Procedure TForm4.Sost_Tablicu(Date1:TDate; Date2:TDate);  // Таблица //
Var Date_1, Date_2: TDate;
    i, k, code:integer;
    Kom_1, Kom_2, Kom_1_F, Kom_2_F, Kom_1_S, Kom_2_s:Integer;

    Point_Vsego, Game_Vsego, Win_Vsego, Draw_Vsego, Loss_Vsego, Zab_Vsego, Prop_Vsego:Integer;
    Point_Home, Game_Home, Win_Home, Draw_Home, Loss_Home, Zab_Home, Prop_Home:Integer;
    Point_Away, Game_Away, Win_Away, Draw_Away, Loss_Away, Zab_Away, Prop_Away:Integer;

    Point_Vsego_1, Game_Vsego_1, Win_Vsego_1, Draw_Vsego_1, Loss_Vsego_1, Zab_Vsego_1, Prop_Vsego_1:Integer;
    Point_Home_1, Game_Home_1, Win_Home_1, Draw_Home_1, Loss_Home_1, Zab_Home_1, Prop_Home_1:Integer;
    Point_Away_1, Game_Away_1, Win_Away_1, Draw_Away_1, Loss_Away_1, Zab_Away_1, Prop_Away_1:Integer;

    Point_Vsego_2, Game_Vsego_2, Win_Vsego_2, Draw_Vsego_2, Loss_Vsego_2, Zab_Vsego_2, Prop_Vsego_2:Integer;
    Point_Home_2, Game_Home_2, Win_Home_2, Draw_Home_2, Loss_Home_2, Zab_Home_2, Prop_Home_2:Integer;
    Point_Away_2, Game_Away_2, Win_Away_2, Draw_Away_2, Loss_Away_2, Zab_Away_2, Prop_Away_2:Integer;

    rez_vstrechi:string[3];   // содержит результат встречи двух команд
    rez_vstrechi_1:string[3]; // содержит результат встречи двух команд в первом тайме
    rez_vstrechi_2:string[3]; // содержит результат встречи двух команд во втором тайме
    Com:String;
    Ch_K_1: Char;             //Количество голов забитых первой командой за встречу
    Ch_K_2: Char;             //Количество голов забитых второй командой за встречу
    Ch_K_1_F: Char;           //Количество голов забитых первой командой за первый тайм
    Ch_K_2_F: Char;           //Количество голов забитых второй командой за первый тайм
    Ch_K_1_S: Char;           //Количество голов забитых первой командой за второй тайм
    Ch_K_2_S: Char;           //Количество голов забитых второй командой за второй тайм
    dates_1:string[10];
    dates_2:string[10];


    begin


    if Form1.EasyTable2.Exists = True then begin
    Form1.EasyQuery1.Active:=False;    Form1.EasyQuery2.Active:=False;
    Form1.EasyQuery3.Active:=False;    Form1.EasyQuery4.Active:=False;
    Form1.EasyQuery5.Active:=False;    Form1.EasyQuery6.Active:=False;
    Form1.EasyQuery7.Active:=False;

    Form1.EasyTable2.close; Form1.EasyTable2.DeleteTable; end;

    with Form1.EasyTable2 do begin  Active:=False; TableName:=('Tablica');


with fielddefs do begin clear;
with AddFieldDef do begin Name:='Team';DataType:=ftString;Size:=15;Required:=True;end;
with AddFieldDef do begin Name:='Game_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_v';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_h';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_a';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_a';DataType:=ftInteger;Required:=True;end;

with AddFieldDef do begin Name:='Game_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_v_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_h_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_a_1';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_a_1';DataType:=ftInteger;Required:=True;end;

with AddFieldDef do begin Name:='Game_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_v_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_h_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Game_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Points_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Win_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Draw_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Loss_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Zab_a_2';DataType:=ftInteger;Required:=True;end;
with AddFieldDef do begin Name:='Prop_a_2';DataType:=ftInteger;Required:=True;end;


end;CreateTable;end;Form1.EasyTable2.Active:=True;


 Form1.EasyQuery2.Active:=false; Form1.EasyQuery2.SQL.clear;
 Form1.EasyQuery2.SQL.add('select ShortName from Location');
 Form1.EasyQuery2.Active:=true;  Form1.EasyQuery2.Open;
 Form1.EasyQuery2.first;

 dates_1:=DateToStr(Form1.Date_1_Vyb); dates_2:=DateToStr(Form1.Date_2_Vyb);

 for k:=1 to Form1.EasyQuery2.recordcount do begin
 com:=Form1.EasyQuery2.Fields[0].text;
 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 Form1.EasyQuery3.SQL.add('select team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2 from play where ((Team_1=:Team) and ((Data>=:Data_1) and (Data<=:Data_2))  and (Status = 10)) or ((Team_2=:Team) and ((Data>=:Data_1) and (Data<=:Data_2)) and (Status = 10))');
 Form1.EasyQuery3.ParamByName('Team').AsString:=com;
 Form1.EasyQuery3.ParamByName('Data_1').AsString:=Dates_1;
 Form1.EasyQuery3.ParamByName('Data_2').AsString:=Dates_2;
 Form1.EasyQuery3.Active:=true;  Form1.EasyQuery3.Open;;
 Form1.EasyQuery3.First;

 Game_Vsego:=0;Point_Vsego:=0;Zab_Vsego:=0;Prop_Vsego:=0;Win_Vsego:=0;Loss_Vsego:=0;Draw_Vsego:=0;
 Game_Home:=0;Point_Home:=0;Zab_Home:=0;Prop_Home:=0;Win_Home:=0;Loss_Home:=0;Draw_Home:=0;
 Game_Away:=0;Point_Away:=0;Zab_Away:=0;Prop_Away:=0;Win_Away:=0;Loss_Away:=0;Draw_Away:=0;

 Game_Vsego_1:=0;Point_Vsego_1:=0;Zab_Vsego_1:=0;Prop_Vsego_1:=0;Win_Vsego_1:=0;Loss_Vsego_1:=0;Draw_Vsego_1:=0;
 Game_Home_1:=0;Point_Home_1:=0;Zab_Home_1:=0;Prop_Home_1:=0;Win_Home_1:=0;Loss_Home_1:=0;Draw_Home_1:=0;
 Game_Away_1:=0;Point_Away_1:=0;Zab_Away_1:=0;Prop_Away_1:=0;Win_Away_1:=0;Loss_Away_1:=0;Draw_Away_1:=0;

 Game_Vsego_2:=0;Point_Vsego_2:=0;Zab_Vsego_2:=0;Prop_Vsego_2:=0;Win_Vsego_2:=0;Loss_Vsego_2:=0;Draw_Vsego_2:=0;
 Game_Home_2:=0;Point_Home_2:=0;Zab_Home_2:=0;Prop_Home_2:=0;Win_Home_2:=0;Loss_Home_2:=0;Draw_Home_2:=0;
 Game_Away_2:=0;Point_Away_2:=0;Zab_Away_2:=0;Prop_Away_2:=0;Win_Away_2:=0;Loss_Away_2:=0;Draw_Away_2:=0;


 for i:=1 to Form1.EasyQuery3.RecordCount do begin
    Game_Vsego:=Game_Vsego+1;    Game_Vsego_1:=Game_Vsego_1+1; Game_Vsego_2:=Game_Vsego_2+1;

    if Form1.EasyQuery3.fields[0].text = com then begin                                        // домашние
rez_vstrechi:=Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text;                   // Итоговый счет
rez_vstrechi_1:=Form1.EasyQuery3.fields[4].text+':'+Form1.EasyQuery3.fields[5].text;                 // Итог первого тайма
ch_k_1:=rez_vstrechi[1];ch_k_2:=rez_vstrechi[3];
val(ch_k_1,Kom_1,Code); val(ch_k_2,Kom_2,Code);
ch_k_1_F:=rez_vstrechi_1[1];ch_k_2_F:=rez_vstrechi_1[3];
val(ch_k_1_F,Kom_1_F,Code); val(ch_k_2_F,Kom_2_F,Code);

Kom_1_S:=Kom_1-Kom_1_F; Kom_2_S:=Kom_2-Kom_2_F;                                           // Итог второго тайма


Game_Home:=Game_Home+1;
Game_Home_1:=Game_Home_1+1;
Game_Home_2:=Game_Home_1+2;

    if  Kom_1>Kom_2 then  begin
Win_Vsego:=Win_Vsego+1;Win_Home:=Win_Home+1;Point_Vsego:=Point_Vsego+3;
Point_Home:=Point_Home+3;Zab_Vsego:=Zab_Vsego+Kom_1;Prop_Vsego:=Prop_Vsego+Kom_2;
Zab_Home:=Zab_Home+Kom_1;Prop_Home:=Prop_Home+Kom_2;                              end;
    if  Kom_1=Kom_2 then  begin
Draw_Vsego:=Draw_Vsego+1;Draw_Home:=Draw_Home+1;Point_Vsego:=Point_Vsego+1;
Point_Home:=Point_Home+1;Zab_Vsego:=Zab_Vsego+Kom_1;Prop_Vsego:=Prop_Vsego+Kom_2;
Zab_Home:=Zab_Home+Kom_1;Prop_Home:=Prop_Home+Kom_2;                              end;
    if  Kom_1<Kom_2 then  begin
Loss_Vsego:=Loss_Vsego+1;Loss_Home:=Loss_Home+1;Zab_Vsego:=Zab_Vsego+Kom_1;
Prop_Vsego:=Prop_Vsego+Kom_2;Zab_Home:=Zab_Home+Kom_1;Prop_Home:=Prop_Home+Kom_2; end;

    if  Kom_1_F>Kom_2_F then  begin
Win_Vsego_1:=Win_Vsego_1+1; Win_Home_1:=Win_Home_1+1; Point_Vsego_1:=Point_Vsego_1+3;
Point_Home_1:=Point_Home_1+3; Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F; Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;
Zab_Home_1:=Zab_Home_1+Kom_1_F; Prop_Home_1:=Prop_Home_1+Kom_2_F;                 end;

    if  Kom_1_F=Kom_2_F then  begin
Draw_Vsego_1:=Draw_Vsego_1+1;Draw_Home_1:=Draw_Home_1+1;Point_Vsego_1:=Point_Vsego_1+1;
Point_Home_1:=Point_Home_1+1;Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F;Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;
Zab_Home_1:=Zab_Home_1+Kom_1_F;Prop_Home_1:=Prop_Home_1+Kom_2_F;                              end;

    if  Kom_1_F<Kom_2_F then  begin
Loss_Vsego_1:=Loss_Vsego_1+1;Loss_Home_1:=Loss_Home_1+1;Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F;
Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;Zab_Home_1:=Zab_Home_1+Kom_1_F;Prop_Home_1:=Prop_Home_1+Kom_2_F;
 end;

     if  Kom_1_S>Kom_2_S then  begin
Win_Vsego_2:=Win_Vsego_2+1; Win_Home_2:=Win_Home_2+1; Point_Vsego_2:=Point_Vsego_2+3;
Point_Home_2:=Point_Home_2+3; Zab_Vsego_2:=Zab_Vsego_2+Kom_1_S; Prop_Vsego_2:=Prop_Vsego_2+Kom_2_S;
Zab_Home_2:=Zab_Home_2+Kom_1_S; Prop_Home_2:=Prop_Home_2+Kom_2_S;                 end;

    if  Kom_1_S=Kom_2_S then  begin
Draw_Vsego_2:=Draw_Vsego_2+1;Draw_Home_2:=Draw_Home_2+1;Point_Vsego_2:=Point_Vsego_2+1;
Point_Home_2:=Point_Home_2+1;Zab_Vsego_2:=Zab_Vsego_2+Kom_1_S;Prop_Vsego_2:=Prop_Vsego_2+Kom_2_S;
Zab_Home_2:=Zab_Home_2+Kom_1_S;Prop_Home_2:=Prop_Home_2+Kom_2_S;                              end;

    if  Kom_1_S<Kom_2_S then  begin
Loss_Vsego_2:=Loss_Vsego_2+1;Loss_Home_2:=Loss_Home_2+1;Zab_Vsego_2:=Zab_Vsego_2+Kom_1_S;
Prop_Vsego_2:=Prop_Vsego_2+Kom_2_S;Zab_Home_2:=Zab_Home_2+Kom_1_S;Prop_Home_2:=Prop_Home_2+Kom_2_S;
 end;




end;

    if Form1.EasyQuery3.fields[1].text = com then begin               // гостевые
rez_vstrechi:=Form1.EasyQuery3.fields[3].text+':'+Form1.EasyQuery3.fields[2].text;
ch_k_1:=rez_vstrechi[1]; ch_k_2:=rez_vstrechi[3]; val(ch_k_1,Kom_1,Code);val(ch_k_2,Kom_2,Code);
rez_vstrechi_1:=Form1.EasyQuery3.fields[5].text+':'+Form1.EasyQuery3.fields[4].text;
ch_k_1_F:=rez_vstrechi_1[1]; ch_k_2_F:=rez_vstrechi_1[3]; val(ch_k_1_F,Kom_1_f,Code);val(ch_k_2_F,Kom_2_f,Code);
Kom_1_S:=Kom_1-Kom_1_F; Kom_2_S:=Kom_2-Kom_2_F;

    Game_Away:=Game_Away+1;
    Game_Away_1:=Game_Away_1+1;
    Game_Away_2:=Game_Away_2+1;

    if  Kom_1>Kom_2  then  begin
Win_Vsego:=Win_Vsego+1;Win_Away:=Win_Away+1;Point_Vsego:=Point_Vsego+3;
Point_Away:=Point_Away+3;Zab_Vsego:=Zab_Vsego+Kom_1;Prop_Vsego:=Prop_Vsego+Kom_2;
Zab_Away:=Zab_Away+Kom_1;Prop_Away:=Prop_Away+Kom_2;                              end;
    if  Kom_1=Kom_2  then  begin
Draw_Vsego:=Draw_Vsego+1;Draw_Away:=Draw_Away+1;Point_Vsego:=Point_Vsego+1;
Point_Away:=Point_Away+1;Zab_Vsego:=Zab_Vsego+Kom_1;Prop_Vsego:=Prop_Vsego+Kom_2;
Zab_Away:=Zab_Away+Kom_1;Prop_Away:=Prop_Away+Kom_2;                              end;
    if  Kom_1<Kom_2  then  begin
Loss_Vsego:=Loss_Vsego+1;Loss_Away:=Loss_Away+1;Zab_Vsego:=Zab_Vsego+Kom_1;
Prop_Vsego:=Prop_Vsego+Kom_2;Zab_Away:=Zab_Away+Kom_1;Prop_Away:=Prop_Away+Kom_2; end;

    if  Kom_1_F>Kom_2_F  then  begin
Win_Vsego_1:=Win_Vsego_1+1;Win_Away_1:=Win_Away_1+1;Point_Vsego_1:=Point_Vsego_1+3;
Point_Away_1:=Point_Away_1+3;Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F;Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;
Zab_Away_1:=Zab_Away_1+Kom_1_F;Prop_Away_1:=Prop_Away_1+Kom_2_F;                              end;
    if  Kom_1_F=Kom_2_F  then  begin
Draw_Vsego_1:=Draw_Vsego_1+1;Draw_Away_1:=Draw_Away_1+1;Point_Vsego_1:=Point_Vsego_1+1;
Point_Away_1:=Point_Away_1+1;Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F;Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;
Zab_Away_1:=Zab_Away_1+Kom_1_F;Prop_Away_1:=Prop_Away_1+Kom_2_F;                              end;
    if  Kom_1_F<Kom_2_F  then  begin
Loss_Vsego_1:=Loss_Vsego_1+1;Loss_Away_1:=Loss_Away_1+1;Zab_Vsego_1:=Zab_Vsego_1+Kom_1_F;
Prop_Vsego_1:=Prop_Vsego_1+Kom_2_F;Zab_Away_1:=Zab_Away_1+Kom_1_F;Prop_Away_1:=Prop_Away_1+Kom_2_F; end;



    if  Kom_1_S>Kom_2_S  then  begin
Win_Vsego_2:=Win_Vsego_2+1;Win_Away_2:=Win_Away_2+1;Point_Vsego_2:=Point_Vsego_2+3;
Point_Away_2:=Point_Away_2+3;Zab_Vsego_2:=Zab_Vsego_2+Kom_1_S;Prop_Vsego_2:=Prop_Vsego_2+Kom_2_S;
Zab_Away_2:=Zab_Away_2+Kom_1_S;Prop_Away_2:=Prop_Away_2+Kom_2_S;                              end;
    if  Kom_1_S=Kom_2_S  then  begin
Draw_Vsego_2:=Draw_Vsego_2+1;Draw_Away_2:=Draw_Away_2+1;Point_Vsego_2:=Point_Vsego_2+1;
Point_Away_2:=Point_Away_2+1;Zab_Vsego_2:=Zab_Vsego_2+Kom_1_F;Prop_Vsego_2:=Prop_Vsego_2+Kom_2_S;
Zab_Away_2:=Zab_Away_2+Kom_1_S;Prop_Away_2:=Prop_Away_2+Kom_2_S;                              end;
    if  Kom_1_S<Kom_2_S  then  begin
Loss_Vsego_2:=Loss_Vsego_2+1;Loss_Away_2:=Loss_Away_2+1;Zab_Vsego_2:=Zab_Vsego_2+Kom_1_S;
Prop_Vsego_2:=Prop_Vsego_2+Kom_2_F;Zab_Away_2:=Zab_Away_2+Kom_1_S;Prop_Away_2:=Prop_Away_2+Kom_2_S; end;

end;




                      Form1.EasyQuery3.next;

                                           end;
Form1.EasyTable2.Insert;
Form1.EasyTable2.Fields[1].asInteger:=Game_Vsego;Form1.EasyTable2.Fields[2].asInteger:=Point_Vsego;
Form1.EasyTable2.Fields[3].asInteger:=Win_Vsego;  Form1.EasyTable2.Fields[4].asInteger:=Draw_Vsego;
Form1.EasyTable2.Fields[5].asInteger:=Loss_Vsego;  Form1.EasyTable2.Fields[6].asInteger:=Zab_Vsego;
Form1.EasyTable2.Fields[7].asInteger:=Prop_Vsego;
Form1.EasyTable2.Fields[8].asInteger:=Game_Home;  Form1.EasyTable2.Fields[9].asInteger:=Point_Home;
Form1.EasyTable2.Fields[10].asInteger:=Win_Home;  Form1.EasyTable2.Fields[11].asInteger:=Draw_Home;
Form1.EasyTable2.Fields[12].asInteger:=Loss_Home;  Form1.EasyTable2.Fields[13].asInteger:=Zab_Home;
Form1.EasyTable2.Fields[14].asInteger:=Prop_Home;
Form1.EasyTable2.Fields[15].asInteger:=Game_Away;Form1.EasyTable2.Fields[16].asInteger:=Point_Away;
Form1.EasyTable2.Fields[17].asInteger:=Win_Away;  Form1.EasyTable2.Fields[18].asInteger:=Draw_Away;
Form1.EasyTable2.Fields[19].asInteger:=Loss_Away;  Form1.EasyTable2.Fields[20].asInteger:=Zab_Away;
Form1.EasyTable2.Fields[21].asInteger:=Prop_Away; Form1.EasyTable2.Fields[0].Text:=Com;

Form1.EasyTable2.Fields[22].asInteger:=Game_Vsego_1;Form1.EasyTable2.Fields[23].asInteger:=Point_Vsego_1;
Form1.EasyTable2.Fields[24].asInteger:=Win_Vsego_1;  Form1.EasyTable2.Fields[25].asInteger:=Draw_Vsego_1;
Form1.EasyTable2.Fields[26].asInteger:=Loss_Vsego_1;  Form1.EasyTable2.Fields[27].asInteger:=Zab_Vsego_1;
Form1.EasyTable2.Fields[28].asInteger:=Prop_Vsego_1;
Form1.EasyTable2.Fields[29].asInteger:=Game_Home_1;  Form1.EasyTable2.Fields[30].asInteger:=Point_Home_1;
Form1.EasyTable2.Fields[31].asInteger:=Win_Home_1;  Form1.EasyTable2.Fields[32].asInteger:=Draw_Home_1;
Form1.EasyTable2.Fields[33].asInteger:=Loss_Home_1;  Form1.EasyTable2.Fields[34].asInteger:=Zab_Home_1;
Form1.EasyTable2.Fields[35].asInteger:=Prop_Home_1;
Form1.EasyTable2.Fields[36].asInteger:=Game_Away_1;Form1.EasyTable2.Fields[37].asInteger:=Point_Away_1;
Form1.EasyTable2.Fields[38].asInteger:=Win_Away_1;  Form1.EasyTable2.Fields[39].asInteger:=Draw_Away_1;
Form1.EasyTable2.Fields[40].asInteger:=Loss_Away_1;  Form1.EasyTable2.Fields[41].asInteger:=Zab_Away_1;
Form1.EasyTable2.Fields[42].asInteger:=Prop_Away_1;

Form1.EasyTable2.Fields[43].asInteger:=Game_Vsego_2;Form1.EasyTable2.Fields[44].asInteger:=Point_Vsego_2;
Form1.EasyTable2.Fields[45].asInteger:=Win_Vsego_2;  Form1.EasyTable2.Fields[46].asInteger:=Draw_Vsego_2;
Form1.EasyTable2.Fields[47].asInteger:=Loss_Vsego_2;  Form1.EasyTable2.Fields[48].asInteger:=Zab_Vsego_2;
Form1.EasyTable2.Fields[49].asInteger:=Prop_Vsego_2;
Form1.EasyTable2.Fields[50].asInteger:=Game_Home_2;  Form1.EasyTable2.Fields[51].asInteger:=Point_Home_2;
Form1.EasyTable2.Fields[52].asInteger:=Win_Home_2;  Form1.EasyTable2.Fields[53].asInteger:=Draw_Home_2;
Form1.EasyTable2.Fields[54].asInteger:=Loss_Home_2;  Form1.EasyTable2.Fields[55].asInteger:=Zab_Home_2;
Form1.EasyTable2.Fields[56].asInteger:=Prop_Home_2;
Form1.EasyTable2.Fields[57].asInteger:=Game_Away_2;Form1.EasyTable2.Fields[58].asInteger:=Point_Away_2;
Form1.EasyTable2.Fields[59].asInteger:=Win_Away_2;  Form1.EasyTable2.Fields[60].asInteger:=Draw_Away_2;
Form1.EasyTable2.Fields[61].asInteger:=Loss_Away_2;  Form1.EasyTable2.Fields[62].asInteger:=Zab_Away_2;
Form1.EasyTable2.Fields[63].asInteger:=Prop_Away_2;


Form1.EasyTable2.Post;Form1.EasyTable2.Next;Form1.EasyQuery2.next;
                                end;

    end;


procedure TForm4.sost_table(date_1_vyb:TDate; date_2_vyb:TDate; vyb_1_tur:Integer; vyb_2_tur:Integer; vr_table:Integer);
var  ss:string[2];
     i1, i2, code, i, k, z:integer;                     // составить таблицы
     com, s2, s1, s:string;
     Cnt_play      :  Integer;
     ch:char;
     begin
 //    ShortDateFormat := 'dd/mm/yyyy';
     Cnt_Play:=0;
 Form1.NextGrid3.Visible:=False; Form1.NextGrid4.Visible:=False; Form1.xStringGrid2.Visible:=False;
 Form1.NextGrid2.Visible:=False;
 Form1.NextGrid6.Visible:=False; Form1.StringGrid1.Visible:=False; Form1.xStringGrid1.Visible:=False;
   Form1.NextGrid13.Visible:=False;
 Form1.StringGrid1.RowCount:=Form1.Team_Vsego+1;   Form1.StringGrid1.FixedRows:=1;
 Form1.xStringGrid1.RowCount:=Form1.Team_Vsego+1;  Form1.xStringGrid1.FixedRows:=1;
 Form1.xStringGrid2.RowCount:=Form1.Team_Vsego+1;  Form1.xStringGrid2.FixedRows:=1;

 if Vr_Table=2 then begin  Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_v, points_v, win_v, draw_v, loss_v, zab_v, prop_v from Tablica order by points_v desc, zab_v desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first;
 Form1.EasyQuery6.Active:=false; Form1.EasyQuery6.SQL.clear;
 Form1.EasyQuery6.SQL.add('select team, game_h, points_h, win_h, draw_h, loss_h, zab_h, prop_h from Tablica order by points_h desc, zab_h desc');
 Form1.EasyQuery6.Active:=true;  Form1.EasyQuery6.Open; Form1.EasyQuery6.first;
 Form1.EasyQuery7.Active:=false; Form1.EasyQuery7.SQL.clear;
 Form1.EasyQuery7.SQL.add('select team, game_a, points_a, win_a, draw_a, loss_a, zab_a, prop_a from Tablica order by points_a desc, zab_a desc');
 Form1.EasyQuery7.Active:=true;  Form1.EasyQuery7.Open; Form1.EasyQuery7.first;end;

 if Vr_Table=3 then begin  Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_v, points_v, win_v, draw_v, loss_v, zab_v, prop_v from Tablica order by points_v desc, zab_v desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first;
 Form1.EasyQuery6.Active:=false; Form1.EasyQuery6.SQL.clear;
 Form1.EasyQuery6.SQL.add('select team, game_v_1, points_v_1, win_v_1, draw_v_1, loss_v_1, zab_v_1, prop_v_1 from Tablica order by points_v_1 desc, zab_v_1 desc');
 Form1.EasyQuery6.Active:=true;  Form1.EasyQuery6.Open; Form1.EasyQuery6.first;
 Form1.EasyQuery7.Active:=false; Form1.EasyQuery7.SQL.clear;
 Form1.EasyQuery7.SQL.add('select team, game_v_2, points_v_2, win_v_2, draw_v_2, loss_v_2, zab_v_2, prop_v_2 from Tablica order by points_v_2 desc, zab_v_2 desc');
 Form1.EasyQuery7.Active:=true;  Form1.EasyQuery7.Open; Form1.EasyQuery7.first;end;

 if Vr_Table=5 then begin  Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_h, points_h, win_h, draw_h, loss_h, zab_h, prop_h from Tablica order by points_h desc, zab_h desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first;
 Form1.EasyQuery6.Active:=false; Form1.EasyQuery6.SQL.clear;
 Form1.EasyQuery6.SQL.add('select team, game_h_1, points_h_1, win_h_1, draw_h_1, loss_h_1, zab_h_1, prop_h_1 from Tablica order by points_h_1 desc, zab_h_1 desc');
 Form1.EasyQuery6.Active:=true;  Form1.EasyQuery6.Open; Form1.EasyQuery6.first;
 Form1.EasyQuery7.Active:=false; Form1.EasyQuery7.SQL.clear;
 Form1.EasyQuery7.SQL.add('select team, game_h_2, points_h_2, win_h_2, draw_h_2, loss_h_2, zab_h_2, prop_h_2 from Tablica order by points_h_2 desc, zab_h_2 desc');
 Form1.EasyQuery7.Active:=true;  Form1.EasyQuery7.Open; Form1.EasyQuery7.first;end;

 if Vr_Table=7 then begin  Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_a, points_a, win_a, draw_a, loss_a, zab_a, prop_a from Tablica order by points_a desc, zab_a desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first;
 Form1.EasyQuery6.Active:=false; Form1.EasyQuery6.SQL.clear;
 Form1.EasyQuery6.SQL.add('select team, game_a_1, points_a_1, win_a_1, draw_a_1, loss_a_1, zab_a_1, prop_a_1 from Tablica order by points_a_1 desc, zab_a_1 desc');
 Form1.EasyQuery6.Active:=true;  Form1.EasyQuery6.Open; Form1.EasyQuery6.first;
 Form1.EasyQuery7.Active:=false; Form1.EasyQuery7.SQL.clear;
 Form1.EasyQuery7.SQL.add('select team, game_a_2, points_a_2, win_a_2, draw_a_2, loss_a_2, zab_a_2, prop_a_2 from Tablica order by points_a_2 desc, zab_a_2 desc');
 Form1.EasyQuery7.Active:=true;  Form1.EasyQuery7.Open; Form1.EasyQuery7.first;end;

if (vr_table=2) or (vr_table=3) or (vr_table=5) or (vr_table=7) then begin
 Form1.stringgrid1.cells[2,0]:='И'; Form1.stringgrid1.cells[3,0]:='В'; Form1.stringgrid1.cells[4,0]:='Н';
 Form1.stringgrid1.cells[5,0]:='П'; Form1.stringgrid1.cells[6,0]:='М'; Form1.stringgrid1.cells[7,0]:='М';
 Form1.stringgrid1.cells[0,0]:='М'; Form1.stringgrid1.cells[8,0]:='О'; Form1.stringgrid1.cells[1,0]:='Команда';
 for i:=1 to Form1.EasyQuery5.recordcount do begin str(i,s); Form1.stringgrid1.cells[0,i]:=s;
 Form1.StringGrid1.cells[1,i]:=Form1.EasyQuery5.Fields[0].text; Form1.StringGrid1.cells[2,i]:=Form1.EasyQuery5.Fields[1].text;
 Form1.StringGrid1.cells[3,i]:=Form1.EasyQuery5.Fields[3].text; Form1.StringGrid1.cells[4,i]:=Form1.EasyQuery5.Fields[4].text;
 Form1.StringGrid1.cells[5,i]:=Form1.EasyQuery5.Fields[5].text; Form1.StringGrid1.cells[6,i]:=Form1.EasyQuery5.Fields[6].text;
 Form1.StringGrid1.cells[7,i]:=Form1.EasyQuery5.Fields[7].text; Form1.StringGrid1.cells[8,i]:=Form1.EasyQuery5.Fields[2].text;
 Form1.EasyQuery5.next; end;

 Form1.xStringGrid1.cells[2,0]:='И'; Form1.xStringGrid1.cells[3,0]:='В'; Form1.xStringGrid1.cells[4,0]:='Н';
 Form1.xStringGrid1.cells[5,0]:='П'; Form1.xStringGrid1.cells[6,0]:='М'; Form1.xStringGrid1.cells[7,0]:='М';
 Form1.xStringGrid1.cells[0,0]:='М'; Form1.xStringGrid1.cells[8,0]:='О'; Form1.xStringGrid1.cells[1,0]:='Команда';
 for i:=1 to Form1.EasyQuery6.recordcount do begin str(i,s); Form1.xStringGrid1.cells[0,i]:=s;
 Form1.xStringGrid1.cells[1,i]:=Form1.EasyQuery6.Fields[0].text; Form1.xStringGrid1.cells[2,i]:=Form1.EasyQuery6.Fields[1].text;
 Form1.xStringGrid1.cells[3,i]:=Form1.EasyQuery6.Fields[3].text; Form1.xStringGrid1.cells[4,i]:=Form1.EasyQuery6.Fields[4].text;
 Form1.xStringGrid1.cells[5,i]:=Form1.EasyQuery6.Fields[5].text; Form1.xStringGrid1.cells[6,i]:=Form1.EasyQuery6.Fields[6].text;
 Form1.xStringGrid1.cells[7,i]:=Form1.EasyQuery6.Fields[7].text; Form1.xStringGrid1.cells[8,i]:=Form1.EasyQuery6.Fields[2].text;
 Form1.EasyQuery6.next;  end;

 Form1.xStringGrid2.cells[2,0]:='И'; Form1.xStringGrid2.cells[3,0]:='В'; Form1.xStringGrid2.cells[4,0]:='Н';
 Form1.xStringGrid2.cells[5,0]:='П'; Form1.xStringGrid2.cells[6,0]:='М'; Form1.xStringGrid2.cells[7,0]:='М';
 Form1.xStringGrid2.cells[0,0]:='М'; Form1.xStringGrid2.cells[8,0]:='О'; Form1.xStringGrid2.cells[1,0]:='Команда';
 for i:=1 to Form1.EasyQuery7.recordcount do begin  str(i,s); Form1.xStringGrid2.cells[0,i]:=s;
 Form1.xStringGrid2.cells[1,i]:=Form1.EasyQuery7.Fields[0].text; Form1.xStringGrid2.cells[2,i]:=Form1.EasyQuery7.Fields[1].text;
 Form1.xStringGrid2.cells[3,i]:=Form1.EasyQuery7.Fields[3].text; Form1.xStringGrid2.cells[4,i]:=Form1.EasyQuery7.Fields[4].text;
 Form1.xStringGrid2.cells[5,i]:=Form1.EasyQuery7.Fields[5].text; Form1.xStringGrid2.cells[6,i]:=Form1.EasyQuery7.Fields[6].text;
 Form1.xStringGrid2.cells[7,i]:=Form1.EasyQuery7.Fields[7].text; Form1.xStringGrid2.cells[8,i]:=Form1.EasyQuery7.Fields[2].text;
 Form1.EasyQuery7.next; end;

 Form1.StringGrid1.width:= Form1.StringGrid1.columns[2].Width*8+Form1.StringGrid1.columns[1].Width+10;
 Form1.StringGrid1.height:=(Form1.StringGrid1.defaultrowheight+1)*Form1.StringGrid1.RowCount+1;

 Form1.xStringGrid1.width:= Form1.xStringGrid1.columns[2].Width*8+Form1.xStringGrid1.columns[1].Width+10;
 Form1.xStringGrid1.height:=(Form1.xStringGrid1.defaultrowheight+1)*Form1.xStringGrid1.RowCount+1;

 Form1.xStringGrid2.width:= Form1.xStringGrid2.columns[2].Width*8+Form1.xStringGrid2.columns[1].Width+10;
 Form1.xStringGrid2.height:=(Form1.xStringGrid2.defaultrowheight+1)*Form1.xStringGrid2.RowCount+1;

 Form1.StringGrid1.Visible:=True;Form1.xStringGrid1.Visible:=True;Form1.xStringGrid2.Visible:=True;
end;



 if (Vr_Table=1) or (Vr_Table=4) or (Vr_Table=6) then begin
if Form1.NextGrid6.RowCount>0 then begin for i:=0 to Form1.NextGrid6.RowCount-1 do Form1.NextGrid6.DeleteRow(0); end;

 Form1.NextGrid6.addrow(Form1.Team_vsego);

 if (Vr_Table=1) then begin
 Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_v, points_v, win_v, draw_v, loss_v, zab_v, prop_v from Tablica order by points_v desc, zab_v desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first; end;

 if (Vr_Table=4) then begin
 Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_h, points_h, win_h, draw_h, loss_h, zab_h, prop_h from Tablica order by points_h desc, zab_h desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first; end;

 if (Vr_Table=6) then begin
 Form1.EasyQuery5.Active:=false; Form1.EasyQuery5.SQL.clear;
 Form1.EasyQuery5.SQL.add('select team, game_a, points_a, win_a, draw_a, loss_a, zab_a, prop_a from Tablica order by points_a desc, zab_a desc');
 Form1.EasyQuery5.Active:=true; Form1.EasyQuery5.Open;Form1.EasyQuery5.first; end;

 for i:=0 to Form1.EasyQuery5.recordcount-1 do begin str(i+1,s); Form1.NextGrid6.cells[0,i]:=s;
 Form1.NextGrid6.cells[1,i]:=Form1.EasyQuery5.Fields[0].text; Form1.NextGrid6.cells[2,i]:=Form1.EasyQuery5.Fields[1].text;
 Form1.NextGrid6.cells[3,i]:=Form1.EasyQuery5.Fields[3].text; Form1.NextGrid6.cells[4,i]:=Form1.EasyQuery5.Fields[4].text;
 Form1.NextGrid6.cells[5,i]:=Form1.EasyQuery5.Fields[5].text; Form1.NextGrid6.cells[6,i]:=Form1.EasyQuery5.Fields[6].text;
 Form1.NextGrid6.cells[7,i]:=Form1.EasyQuery5.Fields[7].text; Form1.NextGrid6.cells[8,i]:=Form1.EasyQuery5.Fields[2].text;
 Form1.EasyQuery5.next; end;

 for i:=1 to Form1.Team_Vsego do begin
 com:=Form1.NextGrid6.cells[1,i-1]; Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 if (Vr_Table=1) then
 Form1.EasyQuery3.SQL.add('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where (((Team_1=:Team) or (Team_2 =:Team))  and ((DATA>=:DATA_B) and (DATA<=:DATA_F))  and (Status = 10)) order by Data desc');
 if (Vr_Table=4) then
 Form1.EasyQuery3.SQL.add('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_1=:Team) and ((DATA>=:DATA_B) and (DATA<=:DATA_F))  and (Status = 10)) order by Data desc');
 if (Vr_Table=6) then
 Form1.EasyQuery3.SQL.add('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_2=:Team) and ((DATA>=:DATA_B) and (DATA<=:DATA_F))  and (Status = 10)) order by Data desc');
 Form1.EasyQuery3.ParamByName('Team').AsString:=com;
 Form1.EasyQuery3.ParamByName('DATA_B').AsDate:=Date_1_vyb;
 Form1.EasyQuery3.ParamByName('DATA_F').AsDate:=Date_2_vyb;
 Form1.EasyQuery3.Active:=true; Form1.EasyQuery3.Open;; Form1.EasyQuery3.first;
 If Form1.EasyQuery3.RecordCount > 8 then Cnt_Play:=8;
 If Form1.EasyQuery3.RecordCount <= 8 then Cnt_Play:=Form1.EasyQuery3.RecordCount;
 
for z:=16  downto 16 - Cnt_Play +1 do begin

 if (Vr_Table=1) then begin
if Form1.EasyQuery3.fields[0].text = com then begin
s:=Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text;
Form1.NextGrid6.Cell[z,i-1].Hint :=Form1.EasyQuery3.fields[5].text+' : '
+Form1.EasyQuery3.fields[0].text+'-'+ Form1.EasyQuery3.fields[1].text + ' '
+Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text+' ('
+ Form1.EasyQuery3.fields[6].text+':'+Form1.EasyQuery3.fields[7].text+ ')'; end; // (д)
if Form1.EasyQuery3.fields[1].text = com then begin
s:=Form1.EasyQuery3.fields[3].text+':'+Form1.EasyQuery3.fields[2].text;
Form1.NextGrid6.Cell[z,i-1].Hint :=Form1.EasyQuery3.fields[5].text+' : '
+Form1.EasyQuery3.fields[0].text+'-'+Form1.EasyQuery3.fields[1].text + ' '
+Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text+' ('
+ Form1.EasyQuery3.fields[6].text+':'+Form1.EasyQuery3.fields[7].text+ ')';  end; //(г)
Form1.NextGrid6.cells[z,i-1]:=s; s:=Form1.NextGrid6.Cells[z,i-1]; ch:= s[1]; s1:=s[1];   s2:=s[3];
   Val(s1, I1, Code); Val(s2, I2, Code);
     if i1>i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_win;
     if i1<i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Loss;
     if i1=i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Draw;
    Form1.EasyQuery3.next; end;

if (Vr_Table=4) then begin
if Form1.EasyQuery3.fields[0].text = com then begin
s:=Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text;
Form1.NextGrid6.Cell[z,i-1].Hint :=Form1.EasyQuery3.fields[5].text+' : '
+Form1.EasyQuery3.fields[0].text+'-'+ Form1.EasyQuery3.fields[1].text + ' '
+Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text+' ('
+ Form1.EasyQuery3.fields[6].text+':'+Form1.EasyQuery3.fields[7].text+ ')'; end; // (д)
Form1.NextGrid6.cells[z,i-1]:=s; s:=Form1.NextGrid6.Cells[z,i-1]; ch:= s[1]; s1:=s[1];   s2:=s[3];
   Val(s1, I1, Code); Val(s2, I2, Code);
     if i1>i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_win;
     if i1<i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Loss;
     if i1=i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Draw;
    Form1.EasyQuery3.next; end;

 if (Vr_Table=6) then begin
if Form1.EasyQuery3.fields[1].text = com then begin
s:=Form1.EasyQuery3.fields[3].text+':'+Form1.EasyQuery3.fields[2].text;
Form1.NextGrid6.Cell[z,i-1].Hint :=Form1.EasyQuery3.fields[5].text+' : '
+Form1.EasyQuery3.fields[0].text+'-'+Form1.EasyQuery3.fields[1].text + ' '
+Form1.EasyQuery3.fields[2].text+':'+Form1.EasyQuery3.fields[3].text+' ('
+ Form1.EasyQuery3.fields[6].text+':'+Form1.EasyQuery3.fields[7].text+ ')';  end; //(г)
Form1.NextGrid6.cells[z,i-1]:=s; s:=Form1.NextGrid6.Cells[z,i-1]; ch:= s[1]; s1:=s[1];   s2:=s[3];
   Val(s1, I1, Code); Val(s2, I2, Code);
     if i1>i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_win;
     if i1<i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Loss;
     if i1=i2    then Form1.NextGrid6.Cell[z,i-1].color := Form1.cl_Draw;
    Form1.EasyQuery3.next; end; end;  end;
Form1.NextGrid6.width:=1000; Form1.NextGrid6.height:=1000;
Form1.NextGrid6.Width:=Form1.NextGrid6.Columns[0].Width*8+Form1.NextGrid6.Columns[1].Width+Form1.NextGrid6.Columns[14].Width*8+2;
Form1.NextGrid6.Height:=(Form1.NextGrid6.RowSize+1)*(Form1.NextGrid6.RowCount) + Form1.NextGrid6.HeaderSize+2;
Form1.NextGrid6.Visible:=True; end; end;

procedure TForm4.sost_shamat_vsego(date_1_vyb:TDate; date_2_vyb:TDate; vyb_1_tur:Integer; vyb_2_tur:Integer; vr:Integer; vr_i:integer);
var i, k, n:integer;                                                   // Шахматка //
    s:string;
    team_1, team_2 : string;
    t1, t2         : integer;
    t1_1, t2_1     : integer;
    t1_s, t2_s     : string;
begin

if Form1.NextGrid4.RowCount>0 then begin for i:=0 to Form1.NextGrid4.RowCount-1 do Form1.NextGrid4.DeleteRow(0); end;
if Form1.NextGrid4.columns.Count > 0 then
begin for i:=0 to Form1.NextGrid4.columns.Count-1 do Form1.NextGrid4.columns.Delete(0); end;

 Form1.NextGrid4.Visible:=False;     Form1.NextGrid2.Visible:=False;    Form1.NextGrid6.Visible:=False;
 Form1.xStringgrid1.Visible:=False;  Form1.Stringgrid1.Visible:=False;  Form1.xStringgrid2.Visible:=False;
  Form1.NextGrid13.Visible:=False;
 Form1.NextGrid4.Width:=1000;  Form1.NextGrid4.Height:=1000;


 Form1.NextGrid4.AddRow(Form1.Team_Vsego);

 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'М');

 with Form1.NextGrid4.Columns[0] do begin Header.Alignment :=taCenter; Width:=18;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter;
 Font.Name:= 'Times New Roman';
 Font.Size:= 8;
 enabled:=false;
 end;

 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'Команда');
 with Form1.NextGrid4.Columns[1] do begin
 Width:=100;
 Font.Name:= 'Times New Roman';
 Font.Size:= 8;
 Options:=[coCanSort];
 Options:=[coFixedSize];
 enabled:=false;
  end;

 for i:=1 to Form1.Team_Vsego do begin str(i, s);
 Form1.NextGrid4.Columns.Add(TNxTextColumn, s);
 Form1.NextGrid4.Columns[i+1].Width:=20;
 Form1.NextGrid4.Columns[i+1].Font.Name:= 'Times New Roman';
 Form1.NextGrid4.Columns[i+1].Font.Size:= 7;
 k:=i;
 Form1.NextGrid4.Columns[i+1].Header.Alignment :=taCenter;
 Form1.NextGrid4.Columns[i+1].Options:=[coCanSort];
 Form1.NextGrid4.Columns[i+1].Options:=[coFixedSize];
 Form1.NextGrid4.Columns[i+1].Alignment :=taCenter;
 end; k:=k+2;


 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'И');
 with Form1.NextGrid4.Columns[k] do begin
 Header.Alignment :=taCenter;
 Width:=18;
  Font.Size:= 8;
 enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'В');
 with Form1.NextGrid4.Columns[k+1] do begin Header.Alignment :=taCenter; Width:=18;
  Font.Size:= 8;
 enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'Н');
 with Form1.NextGrid4.Columns[k+2] do begin Header.Alignment :=taCenter; Width:=18;
  Font.Size:= 8;
 enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'П');
 with Form1.NextGrid4.Columns[k+3] do begin Header.Alignment :=taCenter; Width:=18;
  Font.Size:= 8;
 enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'М');
 with Form1.NextGrid4.Columns[k+4] do begin Header.Alignment :=taCenter; Width:=18;
 enabled:=false;
  Font.Size:= 8;
 enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'М');
 with Form1.NextGrid4.Columns[k+5] do begin Header.Alignment :=taCenter; Width:=18;
  Font.Size:= 8;
 enabled:=false;
  enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;
 Form1.NextGrid4.Columns.Add(TNxTextColumn, 'О');
 with Form1.NextGrid4.Columns[k+6] do begin Header.Alignment :=taCenter; Width:=18;
  Font.Size:= 8;
 enabled:=false;
  enabled:=false;
 Options:=[coCanSort]; Options:=[coFixedSize]; Alignment :=taCenter; end;

  for i:=2 to Form1.Team_Vsego+1 do Form1.NextGrid4.Cell[i,i-2].color := clBlack;                     // кубики
  for i:=Form1.Team_Vsego+2 to Form1.Team_Vsego+8 do begin Form1.NextGrid4.Columns[i].Font.Color:=Form1.Cl_Text;  // таблица
  for n:=0 to Form1.Team_Vsego-1 do begin  Form1.NextGrid4.Cell[i,n].color := clGray; end; end;



 if Form1.Variant_I=1 then begin
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select team, game_v, points_v, win_v, draw_v, loss_v, zab_v, prop_v from Tablica order by points_v desc, zab_v desc, prop_v asc');
 Form1.EasyQuery4.Active:=true; Form1.EasyQuery4.Open; end;

 if Form1.Variant_I=2 then begin
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select team, game_v_1, points_v_1, win_v_1, draw_v_1, loss_v_1, zab_v_1, prop_v_1 from Tablica order by points_v_1 desc, zab_v_1 desc, prop_v_1 asc');
 Form1.EasyQuery4.Active:=true; Form1.EasyQuery4.Open; end;

 if Form1.Variant_I=3 then begin
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select team, game_v_2, points_v_2, win_v_2, draw_v_2, loss_v_2, zab_v_2, prop_v_2 from Tablica order by points_v_2 desc, zab_v_2 desc, prop_v_2 asc');
 Form1.EasyQuery4.Active:=true; Form1.EasyQuery4.Open; end;



  for i:=1 to Form1.EasyQuery4.RecordCount do begin
  str(i,s); Form1.NextGrid4.Cells[0,i-1]:=s;
  Form1.NextGrid4.Cells[1,i-1]:=Form1.EasyQuery4.Fields[0].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+2,i-1]:=Form1.EasyQuery4.Fields[1].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+3,i-1]:=Form1.EasyQuery4.Fields[3].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+4,i-1]:=Form1.EasyQuery4.Fields[4].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+5,i-1]:=Form1.EasyQuery4.Fields[5].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+6,i-1]:=Form1.EasyQuery4.Fields[6].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+7,i-1]:=Form1.EasyQuery4.Fields[7].AsString;
  Form1.NextGrid4.Cells[Form1.Team_Vsego+8,i-1]:=Form1.EasyQuery4.Fields[2].AsString;
  Form1.EasyQuery4.Next; end;


 if Form1.Variant_I=1 then begin
 for n:=1 to Form1.EasyQuery4.RecordCount do begin
 team_1:=Form1.NextGrid4.Cells[1,n-1];
 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select team_1, team_2, goal_t_1, goal_t_2 from play where (Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2))  and (Status = 10)');
 Form1.EasyQuery1.ParamByName('Team').AsString:=Team_1;
 Form1.EasyQuery1.ParamByName('Date_1').AsDate:=Date_1_vyb;
 Form1.EasyQuery1.ParamByName('Date_2').AsDate:=Date_2_vyb;
 Form1.EasyQuery1.Active:=true; Form1.EasyQuery1.Open;; Form1.EasyQuery1.first;
 for i:=1 to Form1.EasyQuery1.RecordCount do begin
 team_2:=Form1.EasyQuery1.Fields[1].AsString;K:=0;
 while team_2<>Form1.NextGrid4.Cells[1,k] do k:=k+1;
 Form1.NextGrid4.Cells[k+2,n-1]:=Form1.EasyQuery1.Fields[2].AsString+':'+Form1.EasyQuery1.Fields[3].AsString;
 Form1.EasyQuery1.next; end; Form1.EasyQuery4.next; end;  end;


 if Form1.Variant_I=2 then begin
 for n:=1 to Form1.EasyQuery4.RecordCount do begin
 team_1:=Form1.NextGrid4.Cells[1,n-1];
 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select team_1, team_2, goal_f_1, goal_f_2 from play where (Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10)');
 Form1.EasyQuery1.ParamByName('Team').AsString:=Team_1;
 Form1.EasyQuery1.ParamByName('Date_1').AsDate:=Date_1_vyb;
 Form1.EasyQuery1.ParamByName('Date_2').AsDate:=Date_2_vyb;
 Form1.EasyQuery1.Active:=true; Form1.EasyQuery1.Open;; Form1.EasyQuery1.first;
 for i:=1 to Form1.EasyQuery1.RecordCount do begin
 team_2:=Form1.EasyQuery1.Fields[1].AsString;K:=0;
 while team_2<>Form1.NextGrid4.Cells[1,k] do k:=k+1;
 Form1.NextGrid4.Cells[k+2,n-1]:=Form1.EasyQuery1.Fields[2].AsString+':'+Form1.EasyQuery1.Fields[3].AsString;
 Form1.EasyQuery1.next; end; Form1.EasyQuery4.next; end;
 end;

 if Form1.Variant_I=3 then begin
 for n:=1 to Form1.EasyQuery4.RecordCount do begin
 team_1:=Form1.NextGrid4.Cells[1,n-1];
 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2 from play where (Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10)');
 Form1.EasyQuery1.ParamByName('Team').AsString:=Team_1;
 Form1.EasyQuery1.ParamByName('Date_1').AsDate:=Date_1_vyb;
 Form1.EasyQuery1.ParamByName('Date_2').AsDate:=Date_2_vyb;
 Form1.EasyQuery1.Active:=true; Form1.EasyQuery1.Open;; Form1.EasyQuery1.first;

 for i:=1 to Form1.EasyQuery1.RecordCount do begin
 team_2:=Form1.EasyQuery1.Fields[1].AsString;K:=0;
 while team_2<>Form1.NextGrid4.Cells[1,k] do k:=k+1;
 t1:=strtoint(Form1.EasyQuery1.Fields[2].AsString);  t1_1:=strtoint(Form1.EasyQuery1.Fields[4].AsString);
 t2:=strtoint(Form1.EasyQuery1.Fields[3].AsString);  t2_1:=strtoint(Form1.EasyQuery1.Fields[5].AsString);
 t1:=t1-t1_1; t2:=t2-t2_1; str(t1, t1_s);  str(t2, t2_s);
 Form1.NextGrid4.Cells[k+2,n-1]:=t1_s+':'+t2_s;
 Form1.EasyQuery1.next; end; Form1.EasyQuery4.next; end; end;


 Form1.NextGrid4.FixedCols:=2;
 Form1.NextGrid4.Width:= Form1.NextGrid4.Columns[1].Width+ (Form1.NextGrid4.Columns[0].Width*8)
 +(Form1.NextGrid4.Columns[12].Width*Form1.Team_Vsego)+2;
 Form1.NextGrid4.Height:= Form1.NextGrid4.HeaderSize + (Form1.NextGrid4.RowSize+1)*(Form1.Team_Vsego)+2;
 Form1.NextGrid4.Visible:=true;
end;


end.
