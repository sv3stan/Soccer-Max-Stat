unit Sost_Play;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NxColumnClasses, NxColumns, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxFieldChooser;
{  NxCellSource}


//  Grids, DBGrids, Db, EasyTable, StdCtrls, ExtCtrls,
//  XStringGrid, Menus, NxColumnClasses, NxColumns, NxScrollControl,
//  NxCustomGridControl, NxCustomGrid, NxGrid, NxFieldChooser, NxCellSource,
//  ComCtrls, RXSplit, ImgList, RXSwitch, RXSpin, Buttons, NxEdit;

type
  TForm3 = class(TForm)
    procedure Sost_Play(date_1_vyb:TDate; date_2_vyb:TDate; Var_Play: Integer);
    // процещура составления списка игр
    // var_play - 1 по датам  - 2 по турам
    procedure Sost_Player(date_1:TDate; date_2:TDate; PlayerID : Integer; Team : String);
    // составление статистики по игроку
    procedure Sost_Otchet(Team:string; date_1_vyb:TDate);
    // составление отчета о матче
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Main;

{$R *.dfm}




procedure TForm3.Sost_Play(date_1_vyb:TDate; date_2_vyb:TDate; Var_Play: Integer);
Var i, x, y : Integer;
    count_row : integer;
    count_I : integer;
begin
  Form1.NextGrid2.Visible:=False;   Form1.NextGrid4.Visible:=False;   Form1.NextGrid6.Visible:=False;
    Form1.NextGrid13.Visible:=False;
  Form1.StringGrid1.Visible:=False;  Form1.xStringGrid1.Visible:=False; Form1.xStringGrid2.Visible:=False;

  If Form1.NextGrid13.RowCount > 0 then begin
  For i:= Form1.NextGrid13.RowCount-1 DownTo 0 Do Begin Form1.NextGrid13.DeleteRow(i); end;end;
//  ShortDateFormat := 'dd/mm';

  If Var_Play = 1 then begin
 Form1.easyquery3.Active:=false; Form1.easyquery3.SQL.clear;
 Form1.easyquery3.SQL.add('select Distinct (Data) from play where (status=10) and ((Data>=:Data_B) and (Data<=:Data_F)) order by data Desc');
 Form1.easyquery3.ParamByName('Data_B').AsDate:=Date_1_Vyb;
 Form1.easyquery3.ParamByName('Data_F').AsDate:=Date_2_Vyb;
 Form1.easyquery3.Active:=true; Form1.easyquery3.Open; Form1.easyquery3.first;
 count_row:=0; count_I:=0;
 For x:=0 To Form1.EasyQuery3.RecordCount-1 do begin

 Form1.easyquery1.Active:=false; Form1.easyquery1.SQL.clear;
 Form1.easyquery1.SQL.add('select Tur, Data, Team_1, Goal_F_1, Goal_F_2, (Goal_T_1-Goal_F_1) as Goal_S_1, (Goal_T_2-Goal_F_2) as Goal_S_2, Goal_T_1, Goal_T_2, Team_2, Referi, Location, Fans from play where (Data=:Data)');
 Form1.easyquery1.ParamByName('Data').AsString:=Form1.EasyQuery3.Fields[0].AsString;
 Form1.easyquery1.Active:=true; Form1.easyquery1.Open; Form1.easyquery1.first;

 Form1.NextGrid13.AddRow(1); Form1.NextGrid13.RowHeight[Count_Row]:=24;
 Form1.NextGrid13.Cells[1,count_row]:=Form1.EasyQuery3.Fields[0].AsString;Count_Row:=Count_row+1;

For i:=0 to Form1.EasyQuery1.RecordCount-1 do begin Form1.NextGrid13.AddRow(1);

   Form1.NextGrid13.Cells[0,count_row]:=Form1.EasyQuery1.Fields[0].AsString;                                        // Тур
//   NextGrid13.Cells[1,i]:=Form1.EasyQuery1.Fields[1].AsString;                                              // Дата
   Form1.NextGrid13.Cells[2,count_row]:=Form1.EasyQuery1.Fields[2].AsString;                                        // Первая команда
   Form1.NextGrid13.Cells[3,count_row]:=Form1.EasyQuery1.Fields[3].AsString +':'+Form1.EasyQuery1.Fields[4].AsString;     // Первый тайм
   Form1.Nextgrid13.Cells[4,count_row]:=Form1.EasyQuery1.Fields[5].AsString +':'+Form1.EasyQuery1.Fields[6].AsString;     // Второй тайм
   Form1.Nextgrid13.Cells[5,count_row]:=Form1.EasyQuery1.Fields[7].AsString +':'+Form1.EasyQuery1.Fields[8].AsString;     // Итог
   Form1.Nextgrid13.Cells[6,count_row]:=Form1.EasyQuery1.Fields[9].AsString;                                        // Вторая команда
   Form1.Nextgrid13.Cells[7,count_row]:=Form1.EasyQuery1.Fields[10].AsString;                                       // Рефери

 Form1.EasyQuery2.Active:=false; Form1.EasyQuery2.SQL.clear;
 Form1.EasyQuery2.SQL.add('select Stadion, StadiumCap from Location where ID=:Locate');
 Form1.EasyQuery2.ParamByName('Locate').AsString:=Form1.EasyQuery1.Fields[11].AsString;
 Form1.EasyQuery2.Active:=true; Form1.EasyQuery2.Open; Form1.EasyQuery2.first;

   Form1.Nextgrid13.Cells[8,count_row]:=Form1.EasyQuery2.Fields[0].AsString;                                        // Стадион
   Form1.Nextgrid13.Cells[9,count_row]:=Form1.EasyQuery1.Fields[12].AsString +' из '+Form1.EasyQuery2.Fields[1].AsString; // Зрители
If Form1.EasyQuery1.Fields[7].AsInteger > Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Win;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
If Form1.EasyQuery1.Fields[7].AsInteger = Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Draw;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text; end; end;
If Form1.EasyQuery1.Fields[7].AsInteger < Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Loss;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text; end; end;


   Form1.EasyQuery1.Next; Count_Row:=Count_row+1; end;
      Form1.EasyQuery3.Next; end;
                Form1.Nextgrid13.Columns[1].Font.Color:=Form1.CL_Text_1; end;

  If Var_Play = 2 then begin

 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 Form1.EasyQuery3.SQL.add('select Distinct (Tur) from play where (status=10) and ((Data>=:Data_B) and (Data<=:Data_F)) order by Tur Desc');
 Form1.EasyQuery3.ParamByName('Data_B').AsDate:=Date_1_Vyb;
 Form1.EasyQuery3.ParamByName('Data_F').AsDate:=Date_2_Vyb;
 Form1.EasyQuery3.Active:=true; Form1.EasyQuery3.Open; Form1.EasyQuery3.first;
 count_row:=0; count_I:=0;
 For x:=0 To Form1.EasyQuery3.RecordCount-1 do begin

 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select Tur, Data, Team_1, Goal_F_1, Goal_F_2, (Goal_T_1-Goal_F_1) as Goal_S_1, (Goal_T_2-Goal_F_2) as Goal_S_2, Goal_T_1, Goal_T_2, Team_2, Referi, Location, Fans from play where (Tur=:Tur) Order By Data desc');
 Form1.EasyQuery1.ParamByName('Tur').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery1.Active:=true; Form1.EasyQuery1.Open; Form1.EasyQuery1.first;

 Form1.Nextgrid13.AddRow(1); Form1.Nextgrid13.RowHeight[Count_Row]:=24;
 Form1.Nextgrid13.Cells[0,count_row]:=Form1.EasyQuery3.Fields[0].AsString;Count_Row:=Count_row+1;

For i:=0 to Form1.EasyQuery1.RecordCount-1 do begin Form1.Nextgrid13.AddRow(1);

//   Form1.Nextgrid13.Cells[0,count_row]:=Form1.EasyQuery1.Fields[0].AsString;                                        // Тур
   Form1.Nextgrid13.Cells[1,count_row]:=Form1.EasyQuery1.Fields[1].AsString;                                              // Дата
   Form1.Nextgrid13.Cells[2,count_row]:=Form1.EasyQuery1.Fields[2].AsString;                                        // Первая команда
   Form1.Nextgrid13.Cells[3,count_row]:=Form1.EasyQuery1.Fields[3].AsString +':'+Form1.EasyQuery1.Fields[4].AsString;     // Первый тайм
   Form1.Nextgrid13.Cells[4,count_row]:=Form1.EasyQuery1.Fields[5].AsString +':'+Form1.EasyQuery1.Fields[6].AsString;     // Второй тайм
   Form1.Nextgrid13.Cells[5,count_row]:=Form1.EasyQuery1.Fields[7].AsString +':'+Form1.EasyQuery1.Fields[8].AsString;     // Итог
   Form1.Nextgrid13.Cells[6,count_row]:=Form1.EasyQuery1.Fields[9].AsString;                                        // Вторая команда
   Form1.Nextgrid13.Cells[7,count_row]:=Form1.EasyQuery1.Fields[10].AsString;                                       // Рефери

 Form1.EasyQuery2.Active:=false; Form1.EasyQuery2.SQL.clear;
 Form1.EasyQuery2.SQL.add('select Stadion, StadiumCap from Location where ID=:Locate');
 Form1.EasyQuery2.ParamByName('Locate').AsString:=Form1.EasyQuery1.Fields[11].AsString;
 Form1.EasyQuery2.Active:=true; Form1.EasyQuery2.Open; Form1.EasyQuery2.first;

   Form1.Nextgrid13.Cells[8,count_row]:=Form1.EasyQuery2.Fields[0].AsString;                                        // Стадион
   Form1.Nextgrid13.Cells[9,count_row]:=Form1.EasyQuery1.Fields[12].AsString +' из '+Form1.EasyQuery2.Fields[1].AsString; // Зрители
If Form1.EasyQuery1.Fields[7].AsInteger > Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Win;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
If Form1.EasyQuery1.Fields[7].AsInteger = Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Draw;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text; end; end;
If Form1.EasyQuery1.Fields[7].AsInteger < Form1.EasyQuery1.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,count_row].color:=Form1.Cl_Loss;
          Form1.Nextgrid13.Columns[y].Font.Color:=Form1.Cl_Text; end; end;
   Form1.EasyQuery1.Next; Count_Row:=Count_row+1; end;
      Form1.EasyQuery3.Next; end;
                Form1.Nextgrid13.Columns[0].Font.Color:=Form1.Cl_Text_1; end;
                Form1.Nextgrid13.Visible:=True;
end;

procedure TForm3.Sost_Player(date_1:TDate; date_2:TDate; PlayerID : Integer; Team : String);
Var i, x:integer;
    Kol_goal, Kol_Pen, Kol_Pen_X, Kol_AG    :    integer;
    Kol_YC, Kol_RC                          :    integer;
    Kol_Goal_P                              :    integer;
    Cnt_Row                                 :    Integer;
begin
 Form1.Label3.Caption:=IntToStr(PlayerID);
 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
// Form1.EasyQuery3.SQL.add('select event.IDMatch, event.IDPlayer, event.team_2, Count (event.type), Play.Data from Event, play where ((Play.Data>=:Date_B) and (Play.Data<=:Date_F)) and (Event.IDPlayer=:PlayerID) Group By Event.IDMatch, Event.IDPlayer, Event.Team_2, Play.Data');
// Form1.EasyQuery3.SQL.add('select IDMatch, IDPlayer, team_2, Count (type) from Event where (IDPlayer=:PlayerID) and ((Data>=:Date_B) and (Data<=:Date_F)) Group By IDMatch, IDPlayer, Team_2');
Form1.EasyQuery3.SQL.add('select IDMatch, IDPlayer, team_2, Count (type) from Event where (IDPlayer=:PlayerID) and (Team_1=:Team) Group By IDMatch, IDPlayer, Team_2');
 Form1.EasyQuery3.ParamByName('PlayerID').AsInteger:=PlayerID;
 Form1.EasyQuery3.ParamByName('Team').AsString:=Team; 
// Form1.EasyQuery3.ParamByName('Date_B').AsDate:=Form1.Date_1_Vyb;
// Form1.EasyQuery3.ParamByName('Date_F').AsDate:=Form1.Date_2_Vyb;
 Form1.EasyQuery3.Active:=true;Form1.EasyQuery3.Open;Form1.EasyQuery3.first;
 Cnt_Row:=0;
 Kol_Goal:=0;  Kol_YC:=0;  Kol_RC:=0;     Kol_Pen:=0;     Kol_Pen_X:=0;     Kol_AG:=0;    Kol_Goal_P:=0;
  If Form1.NextGrid12.RowCount > 0 then begin
  For i:= Form1.NextGrid12.RowCount-1 DownTo 0 Do Begin Form1.NextGrid12.DeleteRow(i); end;end;

 for i:=1 to Form1.EasyQuery3.RecordCount do begin

 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select Count (Type) as Cnt , Type, Team_2, assist from Event where ((IDMatch=:MatchID) and (IDPlayer=:PlayerID)) GROUP BY Team_2, Type, assist');
 Form1.EasyQuery4.ParamByName('MatchID').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery4.ParamByName('PlayerID').AsInteger:=Form1.EasyQuery3.Fields[1].AsInteger;
 Form1.EasyQuery4.Active:=true;Form1.EasyQuery4.Open;Form1.EasyQuery4.first;



 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select Data from Play where (IDMatch=:MatchID)');
 Form1.EasyQuery1.ParamByName('MatchID').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery1.Active:=true;Form1.EasyQuery1.Open;Form1.EasyQuery1.first;
      If (Form1.EasyQuery1.Fields[0].AsDateTime >= Form1.Date_1_v) and
    (Form1.EasyQuery1.Fields[0].AsDateTime <= Form1.Date_2_v)
    then begin
 Form1.NextGrid12.AddRow(1);  Cnt_Row:=Cnt_Row+1;
 Form1.NextGrid12.Cells[0,Cnt_Row-1]:=Form1.EasyQuery1.Fields[0].AsString;

 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select Count (Assist) as Cnt from Event where ((IDMatch=:MatchID) and (Assist=:PlayerID)) Group By Team_2');
 Form1.EasyQuery1.ParamByName('MatchID').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery1.ParamByName('PlayerID').AsInteger:=Form1.EasyQuery3.Fields[1].AsInteger;
 Form1.EasyQuery1.Active:=true;Form1.EasyQuery1.Open;Form1.EasyQuery1.first;
 Kol_Goal_P:=Kol_Goal_P+Form1.EasyQuery1.Fields[0].AsInteger;


 Form1.NextGrid12.Cells[1,Cnt_Row-1]:=Form1.EasyQuery4.Fields[2].AsString;
 Form1.NextGrid12.Cells[2,Cnt_Row-1]:='0'; Form1.NextGrid12.Cells[7,Cnt_Row-1]:='0';
 Form1.NextGrid12.Cells[3,Cnt_Row-1]:='0'; Form1.NextGrid12.Cells[4,Cnt_Row-1]:='0';
 Form1.NextGrid12.Cells[5,Cnt_Row-1]:='0'; Form1.NextGrid12.Cells[6,Cnt_Row-1]:='0';
 Form1.NextGrid12.Cells[8,Cnt_Row-1]:='0'; Form1.NextGrid12.Cells[9,Cnt_Row-1]:='S'; Form1.NextGrid12.Cells[10,Cnt_Row-1]:='F';
 for x:=1 to Form1.EasyQuery4.RecordCount do begin

 if Form1.EasyQuery4.Fields[1].AsInteger = 10 then begin Kol_Goal:=Kol_goal+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 20 then begin Kol_YC:=Kol_YC+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 21 then begin Kol_YC:=Kol_YC+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 22 then begin Kol_RC:=Kol_RC+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 11 then begin Kol_AG:=Kol_AG+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 12 then begin Kol_Pen:=Kol_Pen+Form1.EasyQuery4.Fields[0].AsInteger; end;
 if Form1.EasyQuery4.Fields[1].AsInteger = 13 then begin Kol_Pen_X:=Kol_Pen_X+Form1.EasyQuery4.Fields[0].AsInteger; end;

 if Form1.EasyQuery4.Fields[1].AsInteger = 31 then begin
 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select vrm from Event where ((IDMatch=:MatchID) and (IDPlayer=:PlayerID) and (Type=31))');
 Form1.EasyQuery1.ParamByName('MatchID').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery1.ParamByName('PlayerID').AsInteger:=Form1.EasyQuery3.Fields[1].AsInteger;
 Form1.EasyQuery1.Active:=true;Form1.EasyQuery1.Open;Form1.EasyQuery1.first;
 Form1.NextGrid12.Cells[10,Cnt_Row-1]:=IntToStr(Form1.EasyQuery1.Fields[0].AsInteger); end;

 if Form1.EasyQuery4.Fields[1].AsInteger = 32 then begin
 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select vrm from Event where ((IDMatch=:MatchID) and (IDPlayer=:PlayerID) and (Type=32))');
 Form1.EasyQuery1.ParamByName('MatchID').AsInteger:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery1.ParamByName('PlayerID').AsInteger:=Form1.EasyQuery3.Fields[1].AsInteger;
 Form1.EasyQuery1.Active:=true;Form1.EasyQuery1.Open;Form1.EasyQuery1.first;
 Form1.NextGrid12.Cells[9,Cnt_Row-1]:=IntToStr(Form1.EasyQuery1.Fields[0].AsInteger); end; Form1.EasyQuery4.Next;     end;

  Form1.NextGrid12.Cells[2,Cnt_Row-1]:=IntToStr(Kol_Goal);    Form1.NextGrid12.Cells[7,Cnt_Row-1]:=IntToStr(Kol_YC);
  Form1.NextGrid12.Cells[3,Cnt_Row-1]:=IntToStr(Kol_Goal_P);  Form1.NextGrid12.Cells[4,Cnt_Row-1]:=IntToStr(Kol_Pen);
  Form1.NextGrid12.Cells[5,Cnt_Row-1]:=IntToStr(Kol_Pen_X);   Form1.NextGrid12.Cells[6,Cnt_Row-1]:=IntToStr(Kol_AG);
  Form1.NextGrid12.Cells[8,Cnt_Row-1]:=IntToStr(Kol_RC);
                                                                                               end;
 Kol_Goal:=0;Kol_YC:=0;Kol_RC:=0;Kol_Pen:=0;Kol_Pen_X:=0;Kol_AG:=0;Kol_Goal_P:=0; Form1.EasyQuery3.Next; end;
 Form1.NextGrid12.Visible:=True;
 end;

 procedure TForm3.Sost_Otchet(Team:string; date_1_vyb:TDate);
var  t_1, T_2 : string;
     num_play : integer;
     i, x     : integer;
     IDPlayer : INteger;

begin

Form1.NextGrid7.VisiBle:=False; Form1.NextGrid9.VisiBle:=False; Form1.NextGrid8.VisiBle:=False;Form1.NextGrid10.VisiBle:=False;
Form1.NextGrid11.visiBle:=False;
 if Form1.NextGrid7.RowCount>0 then for i:=Form1.NextGrid7.RowCount-1 downto 0 do Form1.NextGrid7.DeleteRow(I);
 if Form1.NextGrid8.RowCount>0 then for i:=Form1.NextGrid8.RowCount-1 downto 0 do Form1.NextGrid8.DeleteRow(I);
 if Form1.NextGrid9.RowCount>0 then for i:=Form1.NextGrid9.RowCount-1 downto 0 do Form1.NextGrid9.DeleteRow(I);
 if Form1.NextGrid10.RowCount>0 then for i:=Form1.NextGrid10.RowCount-1 downto 0 do Form1.NextGrid10.DeleteRow(I);

 Form1.NextGrid7.Width:=1000; Form1.NextGrid7.Height:=1000;  Form1.NextGrid9.Width:=1000; Form1.NextGrid9.Height:=1000;
 Form1.NextGrid8.Width:=1000; Form1.NextGrid8.Height:=1000;  Form1.NextGrid10.Width:=1000; Form1.NextGrid10.Height:=1000;

 Form1.EasyQuery1.Active:=false; Form1.EasyQuery1.SQL.clear;
 Form1.EasyQuery1.SQL.add('select Data, Team_1, Team_2, Goal_T_1, Goal_T_2, IDMatch, Goal_F_1, Goal_F_2, Tur, Referi, Location, Fans from play where (Team_1=:Team) and (Data=:Data) or (Team_2=:Team) and (Data=:Data)');
 Form1.EasyQuery1.ParamByName('Team').AsString:=Form1.Team_1;
 Form1.EasyQuery1.ParamByName('Data').AsDate:=Form1.Date_Match;
 Form1.EasyQuery1.Active:=true; Form1.EasyQuery1.Open; Form1.EasyQuery1.first;


 Form1.NextGrid11.Columns[0].Header.Caption:=Form1.EasyQuery1.Fields[1].AsString;
 Form1.NextGrid11.Columns[1].Header.Caption:=Form1.EasyQuery1.Fields[3].AsString+':'+ Form1.EasyQuery1.Fields[4].AsString
 +' ('+ Form1.EasyQuery1.Fields[6].AsString +':'+ Form1.EasyQuery1.Fields[7].AsString+')';
 Form1.NextGrid11.Columns[2].Header.Caption:=Form1.EasyQuery1.Fields[2].AsString;

 Form1.EasyQuery2.Active:=false; Form1.EasyQuery2.SQL.clear;
 Form1.EasyQuery2.SQL.add('select ID, Stadion, Town from Location where (ID=:Locate)');
 Form1.EasyQuery2.ParamByName('Locate').AsInteger:=Form1.EasyQuery1.Fields[10].AsInteger;
 Form1.EasyQuery2.Active:=true; Form1.EasyQuery2.Open; Form1.EasyQuery2.first;



 Form1.NextGrid10.AddRow(2);
 Form1.NextGrid10.Cells[0,1]:=Form1.EasyQuery1.Fields[8].AsString + ' Тур';
 Form1.NextGrid10.Cells[0,0]:=Form1.EasyQuery1.Fields[0].AsString;
 Form1.NextGrid10.Cells[1,1]:='  Cудья  : ' + Form1.EasyQuery1.Fields[9].AsString;
 Form1.NextGrid10.Cells[1,0]:='  Город  : ' + Form1.EasyQuery2.Fields[2].AsString + '      Стадион : ' + Form1.EasyQuery2.Fields[1].AsString +'      Зрт : ' +Form1.EasyQuery1.Fields[11].AsString;



 t_1:=Form1.EasyQuery1.Fields[1].AsString;
 t_2:=Form1.EasyQuery1.Fields[2].AsString;
 Form1.MatchID:=Form1.EasyQuery1.Fields[5].AsInteger;



 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 Form1.EasyQuery3.SQL.add('select IDplayer, vrm, type, assist, vrm1, vrm2 from Event where (((IDMatch=:MatchID) and (Team_1=:Team1)) and (type>0))Order By vrm asc, vrm1 asc, vrm2 asc, vrm1 asc, vrm2 asc, type asc');
 Form1.EasyQuery3.ParamByName('Team1').AsString:=T_1;
 Form1.EasyQuery3.ParamByName('MatchID').AsInteger:=Form1.MatchID;
 Form1.EasyQuery3.Active:=true;Form1.EasyQuery3.Open;Form1.EasyQuery3.first;

  Form1.NextGrid7.AddRow(Form1.EasyQuery3.RecordCount);
   x:=0;

 for i:=0 to Form1.EasyQuery3.RecordCount-1 do begin

 Form1.NextGrid7.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString;


 if Form1.EasyQuery3.Fields[1].AsInteger = 45 then begin
 if Form1.EasyQuery3.Fields[4].AsInteger = 0 then begin
 Form1.NextGrid7.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString; end else begin
 Form1.NextGrid7.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString+'+'+ IntToStr(Form1.EasyQuery3.Fields[4].AsInteger); end; end;

 if Form1.EasyQuery3.Fields[1].AsInteger = 90 then begin
 if Form1.EasyQuery3.Fields[5].AsInteger = 0 then begin
 Form1.NextGrid7.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString; end else begin
 Form1.NextGrid7.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString+'+'+ IntToStr(Form1.EasyQuery3.Fields[5].AsInteger); end; end;




 IDPlayer:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select playerID, Family from Sostav where (PlayerID=:IDPlayer)');
 Form1.EasyQuery4.ParamByName('IDPlayer').AsInteger:=IDplayer;
 Form1.EasyQuery4.Active:=true;Form1.EasyQuery4.Open;Form1.EasyQuery4.first;
 Form1.NextGrid7.Cells[1,i+x]:=Form1.EasyQuery4.Fields[1].AsString;


if Form1.EasyQuery3.Fields[2].AsString = '10' then begin

  if Form1.EasyQuery3.Fields[3].AsInteger <> 0 then  begin
Form1.NextGrid7.AddChildRow(i+x, crLast);

 IDPlayer:=Form1.EasyQuery3.Fields[3].AsInteger;
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select playerID, Family from Sostav where (PlayerID=:IDPlayer)');
 Form1.EasyQuery4.ParamByName('IDPlayer').AsInteger:=IDplayer;
 Form1.EasyQuery4.Active:=true;Form1.EasyQuery4.Open;Form1.EasyQuery4.first;

Form1.NextGrid7.Cells[1,i+x+1]:=Form1.EasyQuery4.Fields[1].AsString;

Form1.NextGrid7.Cell[0,I+x+1].Hint:='Ассистент'; Form1.NextGrid7.Cell[2,i+x+1].asInteger :=26;
Form1.NextGrid7.Cell[2,I+x].asInteger :=3; Form1.NextGrid7.Cell[0,I+x].Hint :='Гол'; x:=x+1;
end else begin
Form1.NextGrid7.Cell[2,I+x].asInteger :=3;  Form1.NextGrid7.Cell[0,I+x].Hint :='Гол';   end; end;

if Form1.EasyQuery3.Fields[2].AsString = '32' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=1;  Form1.NextGrid7.Cell[0,I+x].Hint :='Вышел на замену'; end;
if Form1.EasyQuery3.Fields[2].AsString = '31' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=2;  Form1.NextGrid7.Cell[0,I+x].Hint :='Заменен'; end;
if Form1.EasyQuery3.Fields[2].AsString = '20' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=7;  Form1.NextGrid7.Cell[0,I+x].Hint :='Желтая карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '11' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=6;  Form1.NextGrid7.Cell[0,I+x].Hint :='АвтоГол'; end;

if Form1.EasyQuery3.Fields[2].AsString = '12' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=4;  Form1.NextGrid7.Cell[0,I+x].Hint :='Пенальти'; end;
if Form1.EasyQuery3.Fields[2].AsString = '13' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=5;  Form1.NextGrid7.Cell[0,I+x].Hint :='Не забит пенальти'; end;
if Form1.EasyQuery3.Fields[2].AsString = '21' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=8;  Form1.NextGrid7.Cell[0,I+x].Hint :='2 желтая карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '22' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=9;  Form1.NextGrid7.Cell[0,I+x].Hint :='Красная карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '33' then
begin Form1.NextGrid7.Cell[2,i+x].asInteger :=0;  Form1.NextGrid7.Cell[0,I+x].Hint :='Травма'; end;

    Form1.EasyQuery3.next; //zap1:=i+x;
    end;

Form1.NextGrid8.AddRow(8);
Form1.NextGrid8.Columns[1].Header.Caption:='Статистика';
Form1.NextGrid8.Cells[1,0]:='Время владения';
Form1.NextGrid8.Cells[1,1]:='Удары';
Form1.NextGrid8.Cells[1,2]:='Удары в створ';
Form1.NextGrid8.Cells[1,3]:='Угловые';
Form1.NextGrid8.Cells[1,4]:='Фолы';
Form1.NextGrid8.Cells[1,5]:='Оффсайды';
Form1.NextGrid8.Cells[1,6]:='Желтые карточки';
Form1.NextGrid8.Cells[1,7]:='Красные карточки';


 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 Form1.EasyQuery3.SQL.add('select YC_1, YC_2, RC_1, RC_2, UDAR_1, UDAR_2, UDR_ST_1, UDR_ST_2, Corner_1, Corner_2, Offside_1, Offside_2, vlad_1, vlad_2, fol_1, fol_2 from Play where IDMatch=:MatchID');
 Form1.EasyQuery3.ParamByName('MatchID').AsInteger:=Form1.MatchID;
 Form1.EasyQuery3.Active:=true;Form1.EasyQuery3.Open;Form1.EasyQuery3.first;


Form1.NextGrid8.Cells[0,0]:=Form1.EasyQuery3.Fields[12].AsString;    // Время владения
Form1.NextGrid8.Cells[2,0]:=Form1.EasyQuery3.Fields[13].AsString;
Form1.NextGrid8.Cells[0,1]:=Form1.EasyQuery3.Fields[4].AsString;    // Удары
Form1.NextGrid8.Cells[2,1]:=Form1.EasyQuery3.Fields[5].AsString;
Form1.NextGrid8.Cells[0,2]:=Form1.EasyQuery3.Fields[6].AsString;    // Удары в створ
Form1.NextGrid8.Cells[2,2]:=Form1.EasyQuery3.Fields[7].AsString;
Form1.NextGrid8.Cells[0,3]:=Form1.EasyQuery3.Fields[8].AsString;    // Угловые
Form1.NextGrid8.Cells[2,3]:=Form1.EasyQuery3.Fields[9].AsString;
Form1.NextGrid8.Cells[0,4]:=Form1.EasyQuery3.Fields[14].AsString;    // Фолы
Form1.NextGrid8.Cells[2,4]:=Form1.EasyQuery3.Fields[15].AsString;
Form1.NextGrid8.Cells[0,5]:=Form1.EasyQuery3.Fields[10].AsString;   // Оффсайды
Form1.NextGrid8.Cells[2,5]:=Form1.EasyQuery3.Fields[11].AsString;
Form1.NextGrid8.Cells[0,6]:=Form1.EasyQuery3.Fields[0].AsString;    // ЖК
Form1.NextGrid8.Cells[2,6]:=Form1.EasyQuery3.Fields[1].AsString;
Form1.NextGrid8.Cells[0,7]:=Form1.EasyQuery3.Fields[2].AsString;    // КК
Form1.NextGrid8.Cells[2,7]:=Form1.EasyQuery3.Fields[3].AsString;


 Form1.EasyQuery3.Active:=false; Form1.EasyQuery3.SQL.clear;
 Form1.EasyQuery3.SQL.add('select IDplayer, vrm, type, assist, vrm1, vrm2 from Event where (((IDMatch=:MatchID) and (Team_1=:Team1)) and (type>0))Order By vrm asc, vrm1 asc, vrm2 asc, type asc');
 Form1.EasyQuery3.ParamByName('Team1').AsString:=T_2;
 Form1.EasyQuery3.ParamByName('MatchID').AsInteger:=Form1.MatchID;
 Form1.EasyQuery3.Active:=true;Form1.EasyQuery3.Open;Form1.EasyQuery3.first;




  Form1.NextGrid9.AddRow(Form1.EasyQuery3.RecordCount);
   x:=0;

 for i:=0 to Form1.EasyQuery3.RecordCount-1 do begin

 Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString;
 if Form1.EasyQuery3.Fields[1].AsInteger = 45 then begin
 if Form1.EasyQuery3.Fields[4].AsInteger = 0 then begin
 Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString; end else begin
 Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString+'+'+ IntToStr(Form1.EasyQuery3.Fields[4].AsInteger); end; end;

 if Form1.EasyQuery3.Fields[1].AsInteger = 90 then begin
 if Form1.EasyQuery3.Fields[5].AsInteger = 0 then begin
 Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString; end else begin
 Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString+'+'+ IntToStr(Form1.EasyQuery3.Fields[5].AsInteger); end; end;


// if Form1.EasyQuery3.Fields[1].AsInteger = 90 then begin
// Form1.NextGrid9.Cells[0,i+x]:=Form1.EasyQuery3.Fields[1].AsString+'+'+Form1.EasyQuery3.Fields[5].AsString; end;

 IDPlayer:=Form1.EasyQuery3.Fields[0].AsInteger;
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select playerID, Family from Sostav where (PlayerID=:IDPlayer)');
 Form1.EasyQuery4.ParamByName('IDPlayer').AsInteger:=IDplayer;
 Form1.EasyQuery4.Active:=true;Form1.EasyQuery4.Open;Form1.EasyQuery4.first;

  Form1.NextGrid9.Cells[1,i+x]:=Form1.EasyQuery4.Fields[1].AsString;


if Form1.EasyQuery3.Fields[2].AsString = '10' then begin

  if Form1.EasyQuery3.Fields[3].AsInteger <> 0 then  begin
Form1.NextGrid9.AddChildRow(i+x, crLast);

IDPlayer:=Form1.EasyQuery3.Fields[3].AsInteger;
 Form1.EasyQuery4.Active:=false; Form1.EasyQuery4.SQL.clear;
 Form1.EasyQuery4.SQL.add('select playerID, Family from Sostav where (PlayerID=:IDPlayer)');
 Form1.EasyQuery4.ParamByName('IDPlayer').AsInteger:=IDplayer;
 Form1.EasyQuery4.Active:=true;Form1.EasyQuery4.Open;Form1.EasyQuery4.first;
Form1.NextGrid9.Cells[1,i+x+1]:=Form1.EasyQuery4.Fields[1].AsString;

Form1.NextGrid9.Cell[0,I+x+1].Hint:='Ассистент'; Form1.NextGrid9.Cell[2,i+x+1].asInteger :=26;

Form1.NextGrid9.Cell[2,I+x].asInteger :=3; Form1.NextGrid9.Cell[0,I+x].Hint :='Гол'; x:=x+1; end else begin
Form1.NextGrid9.Cell[2,I+x].asInteger :=3;  Form1.NextGrid9.Cell[0,I+x].Hint :='Гол';   end; end;

if Form1.EasyQuery3.Fields[2].AsString = '32' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=1;  Form1.NextGrid9.Cell[0,I+x].Hint :='Вышел на замену'; end;
if Form1.EasyQuery3.Fields[2].AsString = '31' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=2;  Form1.NextGrid9.Cell[0,I+x].Hint :='Заменен'; end;
if Form1.EasyQuery3.Fields[2].AsString = '20' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=7;  Form1.NextGrid9.Cell[0,I+x].Hint :='Желтая карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '11' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=6;  Form1.NextGrid9.Cell[0,I+x].Hint :='АвтоГол'; end;
if Form1.EasyQuery3.Fields[2].AsString = '12' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=4;  Form1.NextGrid9.Cell[0,I+x].Hint :='Пенальти'; end;
if Form1.EasyQuery3.Fields[2].AsString = '13' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=5;  Form1.NextGrid9.Cell[0,I+x].Hint :='Не забит пенальти'; end;
if Form1.EasyQuery3.Fields[2].AsString = '21' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=8;  Form1.NextGrid9.Cell[0,I+x].Hint :='2 желтая карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '22' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=9;  Form1.NextGrid9.Cell[0,I+x].Hint :='Красная карточка'; end;
if Form1.EasyQuery3.Fields[2].AsString = '33' then
begin Form1.NextGrid9.Cell[2,i+x].asInteger :=0;  Form1.NextGrid9.Cell[0,I+x].Hint :='Травма'; end;

  Form1.EasyQuery3.next; //zap1:=i+x;
  end;



Form1.NextGrid7.Width:=Form1.NextGrid7.Columns[0].Width + Form1.NextGrid7.Columns[1].Width+Form1.NextGrid7.Columns[2].Width+1;

Form1.NextGrid7.Height:=(Form1.NextGrid7.RowSize+1)*Form1.NextGrid7.RowCount + Form1.NextGrid7.HeaderSize;

Form1.NextGrid8.Width:=Form1.NextGrid8.Columns[0].Width+Form1.NextGrid8.Columns[1].Width+Form1.NextGrid8.Columns[2].Width+1;
Form1.NextGrid8.Height:=(Form1.NextGrid8.RowSize+1)*Form1.NextGrid8.RowCount + Form1.NextGrid8.HeaderSize*2;


Form1.NextGrid9.Width:=Form1.NextGrid9.Columns[0].Width + Form1.NextGrid9.Columns[1].Width+Form1.NextGrid9.Columns[2].Width+1;
Form1.NextGrid9.Height:=(Form1.NextGrid9.RowSize+1)*Form1.NextGrid9.RowCount + Form1.NextGrid9.HeaderSize;

Form1.NextGrid10.Width:=Form1.NextGrid7.Width+Form1.NextGrid8.Width+Form1.NextGrid9.Width+10;

Form1.NextGrid10.Columns[0].Width:=100;
Form1.NextGrid10.Columns[1].Width:=Form1.NextGrid10.Width - Form1.NextGrid10.Columns[0].Width - 1;
Form1.NextGrid10.Height:=((Form1.NextGrid10.RowSize+2)*2);


Form1.NextGrid11.Columns[0].Width:=(Form1.NextGrid10.Width div 2) - 50;
Form1.NextGrid11.Columns[1].Width:=100;
Form1.NextGrid11.Columns[2].Width:=(Form1.NextGrid10.Width div 2) - 50;
Form1.NextGrid11.Width:=Form1.NextGrid10.Width;
Form1.NextGrid11.Height:= Form1.NextGrid11.HeaderSize;


Form1.NextGrid7.Left:=(Form1.Panel5.Width - Form1.NextGrid7.Width - Form1.NextGrid8.Width - Form1.NextGrid9.Width-15) div 2;
Form1.NextGrid7.Top:=Form1.NextGrid11.Height+Form1.NextGrid10.Height+11;
Form1.NextGrid8.Top:=Form1.NextGrid11.Height+Form1.NextGrid10.Height+11;
Form1.NextGrid9.Top:=Form1.NextGrid11.Height+Form1.NextGrid10.Height+11;

Form1.NextGrid8.Left:=Form1.NextGrid7.Left + Form1.NextGrid7.Width+5;
Form1.NextGrid9.Left:=Form1.NextGrid7.Left+ Form1.NextGrid7.Width + Form1.NextGrid8.Width+10;

Form1.NextGrid10.Left:=(Form1.Panel5.Width - Form1.NextGrid7.Width - Form1.NextGrid8.Width - Form1.NextGrid9.Width-15) div 2;
Form1.NextGrid10.Top:=Form1.NextGrid11.Height+8;
Form1.NextGrid11.Left:=(Form1.Panel5.Width - Form1.NextGrid7.Width - Form1.NextGrid8.Width - Form1.NextGrid9.Width-15) div 2;
Form1.NextGrid11.Top:=5;

Form1.NextGrid7.VisiBle:=True;Form1.NextGrid9.VisiBle:=True;Form1.NextGrid8.VisiBle:=True;Form1.NextGrid10.VisiBle:=True;
Form1.NextGrid11.VisiBle:=True;
end;


end.
