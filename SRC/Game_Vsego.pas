unit Game_Vsego;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  NxColumns,
  NxScrollControl, NxColumnClasses,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxFieldChooser, Dialogs;
{ NxCellSource, }

type
  TForm5 = class(TForm)
    procedure sost_Game_vsego(
        Team      : string;
        date_1_vyb: TDate;
        date_2_vyb: TDate;
        vyb_1_tur : Integer;
        vyb_2_tur : Integer;
        vr        : Integer;
        vr_I      : Integer;
        vr_L      : Integer);
    // процедура составлени€ сыгранных матчей
    // переменные команда, дата начала выбора, дата окончани€ выбора, номер начального тура выбора
    // номер конечного тура выбора, вариант выбора: 0 - по дате, 1 - по турам
    // вариант выбора: 0 - все игры, 1 - победы, 2 - ничьи, 3 - проигрыши
    // вариант итогов: 1 - полный, 2 - 1тайм, 3 - 2 тайм
    // ¬ыбор варианта места игры : 1-всего, 2 - 1 тайм, 3 - 2 тайм
    procedure sost_result(
        date_1_vyb: TDate;
        date_2_vyb: TDate;
        vyb_1_tur : Integer;
        vyb_2_tur : Integer;
        vr_result : Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Main;

{$R *.dfm}

procedure TForm5.sost_Game_vsego(
    Team      : string;
    date_1_vyb: TDate;
    date_2_vyb: TDate;
    vyb_1_tur : Integer;
    vyb_2_tur : Integer;
    vr        : Integer;
    vr_I      : Integer;
    vr_L      : Integer);
  var
    i, k, x, z, y: Integer;
    t1, t2       : Integer;
    cnt          : Integer;
    t1_2, t2_2   : Integer;
    t1_1, t2_1   : Integer;
    t1_s, t2_s   : string;
    datas        : string;
  begin
    Form1.NextGrid3.Visible := False;
    // Form1.NextGrid13.Visible:=False; Form1.NextGrid4.Visible:=False;
    // Form1.NextGrid6.Visible:=False;   Form1.NextGrid2.Visible:=False;

    if Form1.NextGrid3.RowCount > 0 then
      for i := 0 to Form1.NextGrid3.RowCount - 1 do
        Form1.NextGrid3.DeleteRow(0);

    k                                       := 0;
    x                                       := 0;
    i                                       := 0;
    for z                                   := 0 to 5 do
      Form1.NextGrid3.Columns[z].Font.Color := ClBlack;

    if (vr_L = 1) or (vr_L = 2) then
      begin // дома плюс везде

        if vr = 0 then
          begin // все игры
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            Form1.EasyQuery3.SQL.add
                ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where ((Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2))  and (Status = 10))');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);

                    // ShortDateFormat := 'dd/mm';

                    Form1.NextGrid3.Cells[0, i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Draw;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Loss;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Draw;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Loss;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Draw;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;

                    Form1.NextGrid3.Cells[4, i - 1] := Form1.EasyQuery3.Fields
                        [3].text + ':' + Form1.EasyQuery3.Fields[4].text;
                    Form1.NextGrid3.Cells[2, i - 1] := Form1.EasyQuery3.Fields
                        [5].text + ':' + Form1.EasyQuery3.Fields[6].text;
                    Form1.NextGrid3.Cells[3, i - 1] := Form1.EasyQuery3.Fields
                        [7].text + ':' + Form1.EasyQuery3.Fields[8].text;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 1 then
          begin // победы
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1>Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1>Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1>Goal_s_2)');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);;
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Draw;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Loss;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Draw;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Loss;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Draw;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 2 then
          begin

            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1=Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1=Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1=Goal_s_2)');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Draw;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Loss;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Draw;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Loss;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Draw;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;

                    Form1.NextGrid3.Cells[4, i - 1] := Form1.EasyQuery3.Fields
                        [3].text + ':' + Form1.EasyQuery3.Fields[4].text;
                    Form1.NextGrid3.Cells[2, i - 1] := Form1.EasyQuery3.Fields
                        [5].text + ':' + Form1.EasyQuery3.Fields[6].text;
                    Form1.NextGrid3.Cells[3, i - 1] := Form1.EasyQuery3.Fields
                        [7].text + ':' + Form1.EasyQuery3.Fields[8].text;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 3 then
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1<Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1<Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_1=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1<Goal_s_2)');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Draw;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, i - 1].Color := Form1.cl_Loss;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Draw;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, i - 1].Color := Form1.cl_Loss;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.Cl_Win;
                        // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Draw;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, i - 1].Color := Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;

                    Form1.NextGrid3.Cells[4, i - 1] := Form1.EasyQuery3.Fields
                        [3].text + ':' + Form1.EasyQuery3.Fields[4].text;
                    Form1.NextGrid3.Cells[2, i - 1] := Form1.EasyQuery3.Fields
                        [5].text + ':' + Form1.EasyQuery3.Fields[6].text;
                    Form1.NextGrid3.Cells[3, i - 1] := Form1.EasyQuery3.Fields
                        [7].text + ':' + Form1.EasyQuery3.Fields[8].text;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;
      end;

    if (vr_L = 1) or (vr_L = 3) then
      begin // ¬ыезд плюс полный
        if vr_L = 1 then
          cnt := Form1.NextGrid3.RowCount;

        if vr = 0 then
          begin

            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            Form1.EasyQuery3.SQL.add
                ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2))');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;
            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 1 then
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1<Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1<Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1<Goal_s_2)');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 2 then
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1=Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1=Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1=Goal_s_2)');

            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;

        if vr = 3 then
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            if vr_I = 1 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_t_1>Goal_t_2)');
            if vr_I = 2 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_f_1>Goal_f_2)');
            if vr_I = 3 then
              Form1.EasyQuery3.SQL.add
                  ('select data, team_1, team_2, goal_t_1, goal_t_2, goal_f_1, goal_f_2, (goal_t_1 - goal_f_1) as goal_s_1, (goal_t_2 - goal_f_2) as goal_s_2 from play where (Team_2=:Team)  and (Status = 10) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (goal_s_1>Goal_s_2)');
            Form1.EasyQuery3.ParamByName('Team').AsString := Form1.Team_1;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := Form1.date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := Form1.date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;

            if Form1.EasyQuery3.RecordCount > 0 then
              begin
                for i := 1 to Form1.EasyQuery3.RecordCount do
                  begin
                    Form1.NextGrid3.AddRow(1);
                    Form1.NextGrid3.Cells[0, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[0].text;
                    Form1.NextGrid3.Cells[1, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[1].text;
                    Form1.NextGrid3.Cells[5, cnt + i - 1] :=
                        Form1.EasyQuery3.Fields[2].text;
                    t1   := strtoint(Form1.EasyQuery3.Fields[3].text);
                    t2   := strtoint(Form1.EasyQuery3.Fields[4].text);
                    t1_1 := strtoint(Form1.EasyQuery3.Fields[5].text);
                    t2_1 := strtoint(Form1.EasyQuery3.Fields[6].text);
                    t1_2 := strtoint(Form1.EasyQuery3.Fields[7].text);
                    t2_2 := strtoint(Form1.EasyQuery3.Fields[8].text);
                    if Form1.checkbox1.Checked = true then
                      begin
                        Form1.NextGrid3.Columns[2].Visible := true;
                        Form1.NextGrid3.Columns[3].Visible := true;
                        for z                              := 2 to 4 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        if t1_1 < t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 1 тайма
                        if t1_1 = t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_1 > t2_1 then
                          Form1.NextGrid3.Cell[2, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1_2 < t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем итог 2 тайма
                        if t1_2 = t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1_2 > t2_2 then
                          Form1.NextGrid3.Cell[3, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        if t1 < t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.Cl_Win; // подсвечиваем полный итог
                        if t1 = t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Draw;
                        if t1 > t2 then
                          Form1.NextGrid3.Cell[4, cnt + i - 1].Color :=
                              Form1.cl_Loss;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        Form1.NextGrid3.Cells[2, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[5].text + ':' +
                            Form1.EasyQuery3.Fields[6].text;
                        Form1.NextGrid3.Cells[3, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[7].text + ':' +
                            Form1.EasyQuery3.Fields[8].text;
                      end
                    else
                      begin
                        for z := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Columns[2].Visible := False;
                        Form1.NextGrid3.Columns[3].Visible := False;
                        for z                              := 0 to 5 do
                          Form1.NextGrid3.Columns[z].Font.Color :=
                              Form1.Cl_Text;
                        Form1.NextGrid3.Cells[4, cnt + i - 1] :=
                            Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[4].text;
                        // подсвечиваем полный итог
                        if t1 < t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.Cl_Win;
                          end;
                        if t1 = t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Draw;
                          end;
                        if t1 > t2 then
                          begin
                            for y := 0 to 5 do
                              Form1.NextGrid3.Cell[y, cnt + i - 1].Color :=
                                  Form1.cl_Loss;
                          end;
                      end;
                    Form1.EasyQuery3.Next;
                    x := i;
                  end;
              end;
          end;
      end;

    Form1.NextGrid3.Columns[0].Sorted := true;
    Form1.NextGrid3.Visible           := true;


    // ShortDateFormat := 'dd/mm/yy';

  end;

procedure TForm5.sost_result(
    date_1_vyb: TDate;
    date_2_vyb: TDate;
    vyb_1_tur : Integer;
    vyb_2_tur : Integer;
    vr_result : Integer);
  Var
    i, k, j, i1, i2, code: Integer; // результаты
    flag                 : boolean;
    com, s, ss, sss, tur : string;
    ch                   : char;
    s1, s2               : string[2];
    data                 : string;
    col_count            : Integer;
    ss1, ss2             : string;
    max_game_1           : Integer;
    max_game_2           : Integer;
    max_game_3           : Integer;
    max_game             : Integer;
  begin
    flag                       := False;
    Form1.StringGrid1.Visible  := False;
    Form1.xStringGrid1.Visible := False;
    Form1.xStringGrid2.Visible := False;
    Form1.NextGrid2.Visible    := False;
    Form1.NextGrid6.Visible    := False;
    Form1.NextGrid4.Visible    := False;
    Form1.NextGrid13.Visible   := False;
    // ShortDateFormat := 'dd/mm/yyyy';

    if Form1.NextGrid2.RowCount > 0 then
      begin
        for i := 0 to Form1.NextGrid2.RowCount - 1 do
          Form1.NextGrid2.DeleteRow(0);
      end;
    if Form1.NextGrid2.Columns.Count > 0 then
      begin
        for i := 0 to Form1.NextGrid2.Columns.Count - 1 do
          Form1.NextGrid2.Columns.Delete(0);
      end;

    Form1.NextGrid2.Width  := 800;
    Form1.NextGrid2.Height := 800;

    Form1.NextGrid2.Columns.add(
        TNxTextColumn,
        ' оманда');
    Form1.NextGrid2.Columns[0].Options := [CoCanSort];
    Form1.NextGrid2.Columns[0].Width   := 100;

    Form1.EasyQuery4.Active := False;
    Form1.EasyQuery4.SQL.clear;
    Form1.EasyQuery4.SQL.add
        ('select team from tablica order by points_v desc, zab_v desc, prop_v asc');
    Form1.EasyQuery4.Active := true;
    Form1.EasyQuery4.Open;
    Form1.EasyQuery4.first;

    for i := 1 to Form1.EasyQuery4.RecordCount do
      Form1.NextGrid2.AddRow(1);

    if vr_result = 1 then
      begin
        max_game_1 := 0;
        for i      := 1 to Form1.EasyQuery4.RecordCount do
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_1=:Team) or (Team_2 =:Team)) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10)');
            Form1.EasyQuery3.ParamByName('Team').AsString :=
                Form1.EasyQuery4.Fields[0].AsString;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;
            If max_game_1 < Form1.EasyQuery3.RecordCount then
              max_game_1 := Form1.EasyQuery3.RecordCount;
            Form1.EasyQuery4.Next;
          end;
      end;

    if vr_result = 2 then
      begin
        max_game_2 := 0;
        // ShowMessage('RecordCount4 ' + IntTostr(Form1.EasyQuery4.RecordCount));
        for i := 1 to Form1.EasyQuery4.RecordCount do
          begin
            // ShowMessage('I= ' + IntTostr(I));
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10))');
            Form1.EasyQuery3.ParamByName('Team').AsString :=
                Form1.EasyQuery4.Fields[0].AsString;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;
            // ShowMessage('Max_Game_2 '+ IntToStr(Max_Game_2)+ ' RecordCount3 ' + IntTostr(Form1.EasyQuery3.RecordCount));
            If max_game_2 < Form1.EasyQuery3.RecordCount then
              max_game_2 := Form1.EasyQuery3.RecordCount;
            Form1.EasyQuery4.Next;
          end;
      end;
    // ShowMessage('¬ышел ¬ышел');
    if vr_result = 3 then
      begin
        max_game_3 := 0;
        for i      := 1 to Form1.EasyQuery4.RecordCount do
          begin
            Form1.EasyQuery3.Active := False;
            Form1.EasyQuery3.SQL.clear;
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_2=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10))');
            Form1.EasyQuery3.ParamByName('Team').AsString :=
                Form1.EasyQuery4.Fields[0].AsString;
            Form1.EasyQuery3.ParamByName('Date_1').AsDate := date_1_vyb;
            Form1.EasyQuery3.ParamByName('Date_2').AsDate := date_2_vyb;
            Form1.EasyQuery3.Active                       := true;
            Form1.EasyQuery3.Open;
            Form1.EasyQuery3.first;
            If max_game_3 < Form1.EasyQuery3.RecordCount then
              max_game_3 := Form1.EasyQuery3.RecordCount;
            Form1.EasyQuery4.Next;
          end;
      end;

    Form1.EasyQuery4.first;
    for i := 1 to Form1.EasyQuery4.RecordCount do
      begin
        com                             := Form1.EasyQuery4.Fields[0].text;
        Form1.NextGrid2.Cells[0, i - 1] := Form1.EasyQuery4.Fields[0].text;

        Form1.EasyQuery3.Active := False;
        Form1.EasyQuery3.SQL.clear;
        if vr_result = 1 then
          begin
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_1=:Team) or (Team_2 =:Team)) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10)');
            max_game := max_game_1;
          end;
        if vr_result = 2 then
          begin
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_1=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2))  and (Status = 10))');
            max_game := max_game_2;
          end;
        if vr_result = 3 then
          begin
            Form1.EasyQuery3.SQL.add
                ('select team_1, team_2, goal_t_1, goal_t_2, tur, DATA, goal_f_1, goal_f_2 from play where ((Team_2=:Team) and ((DATA>=:Date_1) and (DATA<=:Date_2)) and (Status = 10))');
            max_game := max_game_3;
          end;
        Form1.EasyQuery3.ParamByName('Team').AsString := com;
        Form1.EasyQuery3.ParamByName('Date_1').AsDate := date_1_vyb;
        Form1.EasyQuery3.ParamByName('Date_2').AsDate := date_2_vyb;
        Form1.EasyQuery3.Active                       := true;
        Form1.EasyQuery3.Open;
        Form1.EasyQuery3.first;

        If Form1.EasyQuery3.RecordCount > 0 then
          begin

            for k := 1 to Form1.EasyQuery3.RecordCount do
              begin
                if flag = False then
                  begin

                    for j := 1 to max_game do
                      begin
                        str(
                            j,
                            sss);
                        Form1.NextGrid2.Columns.add(
                            TNxTextColumn,
                            sss);
                        Form1.NextGrid2.Columns[j].Alignment := taCenter;
                        Form1.NextGrid2.Columns[j].Width := 30;
                        Form1.NextGrid2.Columns[j].Font.Color := Form1.Cl_Text;;
                        Form1.NextGrid2.Columns[j].Header.Alignment := taCenter;
                        Form1.NextGrid2.Columns[j].Options := [CoCanSort];

                      end;
                    flag := true;
                  end;

                if vr_result = 1 then
                  begin
                    if Form1.EasyQuery3.Fields[0].text = com then
                      begin
                        s := Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text;
                        Form1.NextGrid2.Cell[k, i - 1].Hint :=
                            Form1.EasyQuery3.Fields[5].text + ' : ' +
                            Form1.EasyQuery3.Fields[0].text + '-' +
                            Form1.EasyQuery3.Fields[1].text + ' ' +
                            Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text + ' (' +
                            Form1.EasyQuery3.Fields[6].text + ':' +
                            Form1.EasyQuery3.Fields[7].text + ')'; // (д)
                      end;
                    if Form1.EasyQuery3.Fields[1].text = com then
                      begin
                        s := Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[2].text;
                        Form1.NextGrid2.Cell[k, i - 1].Hint :=
                            Form1.EasyQuery3.Fields[5].text + ' : ' +
                            Form1.EasyQuery3.Fields[0].text + '-' +
                            Form1.EasyQuery3.Fields[1].text + ' ' +
                            Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text + ' (' +
                            Form1.EasyQuery3.Fields[6].text + ':' +
                            Form1.EasyQuery3.Fields[7].text + ')'; // (г)
                      end;

                    Form1.NextGrid2.Cells[k, i - 1] := s;
                    ch                              := s[1];
                    s1                              := s[1];
                    s2                              := s[3];
                    Val(
                        s1,
                        i1,
                        code);
                    Val(
                        s2,
                        i2,
                        code);
                    if i1 > i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.Cl_Win;
                    if i1 < i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Loss;
                    if i1 = i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Draw;
                    tur := Form1.EasyQuery3.Fields[4].text;

                    Form1.NextGrid2.Columns[k].Header.Caption := tur + 'т.';
                  end;

                if vr_result = 2 then
                  begin
                    if Form1.EasyQuery3.Fields[0].text = com then
                      begin
                        s := Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text;
                        Form1.NextGrid2.Cell[k, i - 1].Hint :=
                            Form1.EasyQuery3.Fields[5].text + ' : ' +
                            Form1.EasyQuery3.Fields[0].text + '-' +
                            Form1.EasyQuery3.Fields[1].text + ' ' +
                            Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text + ' (' +
                            Form1.EasyQuery3.Fields[6].text + ':' +
                            Form1.EasyQuery3.Fields[7].text + ')'; // (д)
                      end;
                    Form1.NextGrid2.Cells[k, i - 1] := s;
                    ch                              := s[1];
                    s1                              := s[1];
                    s2                              := s[3];
                    Val(
                        s1,
                        i1,
                        code);
                    Val(
                        s2,
                        i2,
                        code);
                    if i1 > i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.Cl_Win;
                    if i1 < i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Loss;
                    if i1 = i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Draw;
                    // tur:=Form1.EasyQuery3.fields[4].text; Form1.NextGrid2.Columns[k].Header.Caption :=tur+ 'т.';
                  end;

                if vr_result = 3 then
                  begin
                    if Form1.EasyQuery3.Fields[1].text = com then
                      begin
                        s := Form1.EasyQuery3.Fields[3].text + ':' +
                            Form1.EasyQuery3.Fields[2].text;
                        Form1.NextGrid2.Cell[k, i - 1].Hint :=
                            Form1.EasyQuery3.Fields[5].text + ' : ' +
                            Form1.EasyQuery3.Fields[0].text + '-' +
                            Form1.EasyQuery3.Fields[1].text + ' ' +
                            Form1.EasyQuery3.Fields[2].text + ':' +
                            Form1.EasyQuery3.Fields[3].text + ' (' +
                            Form1.EasyQuery3.Fields[6].text + ':' +
                            Form1.EasyQuery3.Fields[7].text + ')'; // (г)
                      end;

                    Form1.NextGrid2.Cells[k, i - 1] := s;
                    ch                              := s[1];
                    s1                              := s[1];
                    s2                              := s[3];
                    Val(
                        s1,
                        i1,
                        code);
                    Val(
                        s2,
                        i2,
                        code);
                    if i1 > i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.Cl_Win;
                    if i1 < i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Loss;
                    if i1 = i2 then
                      Form1.NextGrid2.Cell[k, i - 1].Color := Form1.cl_Draw;
                    // tur:=Form1.EasyQuery3.fields[4].text; Form1.NextGrid2.Columns[k].Header.Caption :=tur+ 'т.';
                  end;

                Form1.EasyQuery3.Next;
              end;
          end;
        Form1.EasyQuery4.Next;

      end;

    if Form1.Game_Future > 0 then
      begin

      end;

    if Form1.NextGrid2.Columns.Count > 1 then
      begin
        Form1.NextGrid2.Width := (Form1.NextGrid2.Columns[1].Width) *
            (Form1.NextGrid2.Columns.Count - 1) +
            (Form1.NextGrid2.Columns[0].Width + 1) + 1;
      end
    else
      Form1.NextGrid2.Width := Form1.NextGrid2.Columns[0].Width + 1;
    Form1.NextGrid2.Height  := (Form1.NextGrid2.RowSize + 1) *
        (Form1.NextGrid2.RowCount) + Form1.NextGrid2.HeaderSize + 2;
    If Form1.Panel13.Width > Form1.NextGrid2.Width then
      Form1.NextGrid2.Left :=
          ((Form1.Panel13.Width - Form1.NextGrid2.Width) div 2)
    else
      Form1.NextGrid2.Left  := 5;
    Form1.NextGrid2.Visible := true;
  end;

end.
