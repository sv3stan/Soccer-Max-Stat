unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls, ExtCtrls,
  XStringGrid, Menus, NxColumnClasses, NxColumns, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxFieldChooser,
  ComCtrls, RXSplit, ImgList, RXSwitch, RXSpin, Buttons, NxEdit, EasyTable;
{ NxCellSource, }

type
  TForm1 = class(TForm)
    EasyDatabase1: TEasyDatabase;
    EasyQuery1: TEasyQuery;
    EasyQuery2: TEasyQuery;
    EasyQuery3: TEasyQuery;
    EasyQuery5: TEasyQuery;
    EasyQuery6: TEasyQuery;
    EasyQuery7: TEasyQuery;
    EasyTable2: TEasyTable;
    EasyQuery4: TEasyQuery;
    StringGrid1: TXStringGrid;
    XStringGrid1: TXStringGrid;
    XStringGrid2: TXStringGrid;
    NextGrid2: TNextGrid;
    NextGrid4: TNextGrid;
    NextGrid3: TNextGrid;
    NextGrid1: TNextGrid;
    NextGrid5: TNextGrid;
    NextGrid6: TNextGrid; {общая таблица + последние игры}
    NextGrid7: TNextGrid;
    NextGrid8: TNextGrid;
    NextGrid9: TNextGrid;
    NextGrid10: TNextGrid;
    NextGrid11: TNextGrid;
    NextGrid12: TNextGrid;
    NextGrid13: TNextGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    RxSplitter2: TRxSplitter;
    RxSplitter3: TRxSplitter;
    RxSplitter4: TRxSplitter;
    RxSplitter6: TRxSplitter;
    RxSplitter5: TRxSplitter;
    RxSplitter1: TRxSplitter;
    ImageList1: TImageList;
    ImageList2: TImageList;
    NxTreeColumn1: TNxTreeColumn;
    NxTextColumn5: TNxTextColumn;
    NxTextColumn6: TNxTextColumn;
    NxTextColumn7: TNxTextColumn;
    NxTextColumn8: TNxTextColumn;
    NxTextColumn9: TNxTextColumn;
    NxTextColumn10: TNxTextColumn;
    NxTextColumn11: TNxTextColumn;
    NxTextColumn12: TNxTextColumn;
    NxTextColumn13: TNxTextColumn;
    NxTextColumn14: TNxTextColumn;
    NxTextColumn15: TNxTextColumn;
    NxTextColumn16: TNxTextColumn;
    NxTextColumn17: TNxTextColumn;
    NxTextColumn18: TNxTextColumn;
    NxTextColumn19: TNxTextColumn;
    NxTextColumn20: TNxTextColumn;
    NxTextColumn21: TNxTextColumn;
    NxTextColumn22: TNxTextColumn;
    NxTextColumn23: TNxTextColumn;
    NxTextColumn24: TNxTextColumn;
    NxTextColumn25: TNxTextColumn;
    NxDateColumn1: TNxDateColumn;
    NxTextColumn1: TNxTextColumn;
    NxTextColumn2: TNxTextColumn;
    NxTextColumn3: TNxTextColumn;
    NxTextColumn4: TNxTextColumn;
    NxTextColumn26: TNxTextColumn;
    NxTextColumn29: TNxImageColumn;
    NxTextColumn27: TNxTextColumn;
    NxTextColumn33: TNxTextColumn;
    NxTextColumn34: TNxTextColumn;
    NxTextColumn35: TNxTextColumn;
    NxTextColumn36: TNxTextColumn;
    NxImageColumn1: TNxImageColumn;
    NxTreeColumn2: TNxTextColumn;
    NxTextColumn28: TNxTextColumn;
    NxTextColumn30: TNxTextColumn;
    NxTextColumn31: TNxTextColumn;
    NxTextColumn32: TNxTextColumn;
    NxTextColumn37: TNxTextColumn;
    NxDateColumn2: TNxDateColumn;
    NxTextColumn38: TNxTextColumn;
    NxTextColumn39: TNxTextColumn;
    NxTextColumn40: TNxTextColumn;
    NxTextColumn41: TNxTextColumn;
    NxTextColumn42: TNxTextColumn;
    NxTextColumn43: TNxTextColumn;
    NxTextColumn44: TNxTextColumn;
    NxTextColumn45: TNxTextColumn;
    NxTextColumn46: TNxTextColumn;
    NxTextColumn47: TNxTextColumn;
    NxTextColumn48: TNxTextColumn;
    NxTextColumn49: TNxTextColumn;
    NxTextColumn50: TNxTextColumn;
    NxTextColumn51: TNxTextColumn;
    NxTextColumn52: TNxTextColumn;
    NxTextColumn53: TNxTextColumn;
    NxTextColumn54: TNxTextColumn;
    NxTextColumn55: TNxTextColumn;
    NxTextColumn56: TNxTextColumn;
    NxTextColumn57: TNxTextColumn;
    NxTextColumn58: TNxTextColumn;
    NxDatePicker1: TNxDatePicker;
    NxDatePicker2: TNxDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Label3: TLabel;

    procedure StringGrid1Click(Sender: TObject);
    procedure NextGrid1MouseDown(
        Sender: TObject;
        Button: TMouseButton;
        Shift : TShiftState;
        X, Y  : Integer);
    procedure NextGrid2CellClick(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1MouseDown(
        Sender: TObject;
        Button: TMouseButton;
        Shift : TShiftState;
        X, Y  : Integer);
    procedure XStringGrid1MouseDown(
        Sender: TObject;
        Button: TMouseButton;
        Shift : TShiftState;
        X, Y  : Integer);
    procedure XStringGrid2MouseDown(
        Sender: TObject;
        Button: TMouseButton;
        Shift : TShiftState;
        X, Y  : Integer);
    procedure xStringGrid1Click(Sender: TObject);
    procedure NextGrid5SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid5Resize(Sender: TObject);
    procedure NextGrid5CellClick(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure Sost_Vybor;
    procedure NextGrid4SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid4Click(Sender: TObject);
    procedure NextGrid1Resize(Sender: TObject);
    procedure NextGrid1SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid1CellClick(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure XStringGrid2Click(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure NextGrid6CellClick(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid6SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid9SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid9Click(Sender: TObject);
    procedure NextGrid7Click(Sender: TObject);
    procedure NextGrid7SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure NxDatePicker1Change(Sender: TObject);
    procedure NxDatePicker2Change(Sender: TObject);
    procedure Panel14MouseUp(
        Sender: TObject;
        Button: TMouseButton;
        Shift : TShiftState;
        X, Y  : Integer);
    procedure Label2Click(Sender: TObject);
    procedure Panel13Resize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure NextGrid3SelectCell(
        Sender    : TObject;
        ACol, ARow: Integer);
    procedure NextGrid3Click(Sender: TObject);

  private

    { Private declarations }
  public
    date_1_Vyb   : TDate;   // Начальная дата выборки
    date_2_Vyb   : TDate;   // Конечная дата выборки
    date_1_Tur   : TDate;   // Дата начала соревнований
    date_Last_Tur: TDate;   // Дата последнего тура
    Vyb_1_tur    : Integer; // Начальный тур для выборок
    Vyb_2_tur    : Integer; // Конечный тур для выборок
    Date_1_V     : TDate;
    Date_2_V     : TDate;

    Team_Vsego: Integer; // Количество команд в лиге
    Team_1    : String;  // Выбор первой команды
    Team_2    : String;  // Выбор второй команды
    MatchID   : Integer; // Идентификатор матча
    PlayerID  : Integer; // Идентификатор игрока

    Game_Future: Integer; // Количество будущих матчей

    Date_Match: TDate; // Дата Выбранного матча

    Var_Stat: Integer;
    // Вариант выбора матча если 1 - выбор отчета по матчу если 2 - выбор резултатов матчей
    Var_Game: Integer;
    // Выбор варианта для подборки игр : 0-все, 1-победы, 2-ничьи, 3-Поражения
    Var_location: Integer;
    // Выбор варианта места игры : 1-все, 2 - дома, 3 - выезд
    Var_Itogo: Integer;
    // Выбор варианта места игры : 1-всего, 2 - 1 тайм, 3 - 2 тайм

    Var_Play: Integer;
    // Вариант составления списка игр 1 - по датам 2 - по турам
    CurrentRow: Longint;
    CurrentCol: Longint;
    Vyb_League: Integer; // Выбор чемпионата для просмотра статистики

    Var_Stat_1: Integer;
    // 1 составляющая для выбора варианта просмотра статистики из NextGrida5
    Var_stat_2: Integer;
    // 2 составляющая для выбора варианта просмотра статистики из NextGrida5
    Variant  : Integer; // Вариант выбора 0 - по дате, 1 - по турам
    Variant_I: Integer;
    // Вариант выбора по итогам 1 - всего, 2 - 1 тайм, 3 - 2 тайм
    Vr_Table : Integer; // Вариант составления таблиц
    Vr_Result: Integer;
    // Вариант составления таблиц результатов 1-всего 2-дома 3-выезд

    Cl_Win   : tColor; // Цвет для подсвечивания побед
    Cl_Draw  : tColor; // Цвет для подсвечивания ничьих
    Cl_Loss  : tColor; // Цвет для подсвечивания проигрышей
    Cl_Future: tColor; // Цвет для подсвечивания отложенных матчей
    Cl_Team_1: tColor; // Цвет для подсвечивания первой команды
    Cl_Team_2: tColor; // Цвет для подсвечивания второй команды
    Cl_Grid  : tColor; // Цвет линий в таблицах
    Cl_Text  : tColor; // Цвет текста в таблицах
    Cl_Text_1: tColor; // Цвет текста в таблицах альтернативный

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Game_Vsego, Vyb_play, Sost_Play, Sost_Tab;
{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
  begin
    Cl_Text_1 := clBlack;
    Cl_Win    := clBlue;
    Cl_Draw   := clGreen;
    Cl_Loss   := clRed;
    Cl_Future := clYellow;
    Cl_Team_1 := clPurple;
    Cl_Team_2 := clMaroon;
    Cl_Grid   := clSilver;
    Cl_Text   := clWhite;

    StringGrid1.FixedColor       := clBtnFace;
    StringGrid1.FixedLineColor   := clGray;
    StringGrid1.GridLineColor    := clGray;
    StringGrid1.Color            := clMenu;
    StringGrid1.Ctl3d            := False;
    StringGrid1.Columns[3].Color := cl3DLight;
    StringGrid1.Columns[5].Color := cl3DLight;
    StringGrid1.Columns[7].Color := cl3DLight;

    XStringGrid1.FixedColor       := clBtnFace;
    XStringGrid1.FixedLineColor   := clGray;
    XStringGrid1.GridLineColor    := clGray;
    XStringGrid1.Color            := clMenu;
    XStringGrid1.Ctl3d            := False;
    XStringGrid1.Columns[3].Color := cl3DLight;
    XStringGrid1.Columns[5].Color := cl3DLight;
    XStringGrid1.Columns[7].Color := cl3DLight;

    XStringGrid2.FixedColor       := clBtnFace;
    XStringGrid2.FixedLineColor   := clGray;
    XStringGrid2.GridLineColor    := clGray;
    XStringGrid2.Color            := clMenu;
    XStringGrid2.Ctl3d            := False;
    XStringGrid2.Columns[3].Color := cl3DLight;
    XStringGrid2.Columns[5].Color := cl3DLight;
    XStringGrid2.Columns[7].Color := cl3DLight;

    StringGrid1.Top  := 5;
    XStringGrid1.Top := 5;
    XStringGrid2.Top := 5;

    // StringGrid1.Left:=4; StringGrid1.Top:=5;
    // xStringGrid1.Left:=220; xStringGrid1.Top:=5;
    // xStringGrid2.Left:=436; xStringGrid2.Top:=5;

    NextGrid2.Top := 5;
    NextGrid4.Top := 5;
    NextGrid6.Top := 5;

    NextGrid3.Top              := 100;
    NextGrid3.Left             := 664;
    NextGrid1.Columns[0].Width := Panel3.Width - 10;
    NextGrid5.Columns[1].Width := Panel3.Width - NextGrid5.Columns[0].Width - 6;
    // NextGrid5.Columns[1].width:=NextGrid5.Columns[1].width - NextGrid5.Columns[0].width;

    If Panel13.Width > NextGrid2.Width then
      NextGrid2.Left := ((Panel13.Width - NextGrid2.Width) div 2) - 1
    else
      NextGrid2.Left := 5;
    If Panel13.Width > NextGrid4.Width then
      NextGrid4.Left := ((Panel13.Width - NextGrid4.Width) div 2) - 1
    else
      NextGrid4.Left := 5;
    If Panel13.Width > NextGrid6.Width then
      NextGrid6.Left := ((Panel13.Width - NextGrid6.Width) div 2) - 1
    else
      NextGrid6.Left := 5;
    If Panel13.Width > (StringGrid1.Width + XStringGrid1.Width +
        XStringGrid2.Width + 10) then
      Begin
        StringGrid1.Left :=
            (Panel13.Width - (StringGrid1.Width + XStringGrid1.Width +
            XStringGrid2.Width + 10)) div 2;
        XStringGrid1.Left := StringGrid1.Left + StringGrid1.Width + 2;
        XStringGrid2.Left := StringGrid1.Left + StringGrid1.Width +
            XStringGrid1.Width + 4;
      end
    else
      begin
        StringGrid1.Left  := 4;
        StringGrid1.Top   := 5;
        XStringGrid1.Left := 220;
        XStringGrid1.Top  := 5;
        XStringGrid2.Left := 436;
        XStringGrid2.Top  := 5;
      end;

    Game_Future     := 2;
    ShortDateFormat := 'dd/mm/yyyy';
    NextGrid1.AddRow(2);
    NextGrid1.Cells[0, 0]     := 'Франция Лига 1 08/09';
    NextGrid1.Cells[0, 1]     := 'Германия Бундеслига 08/09';
    StatusBar1.Panels[0].Text := 'Чемпионат Франции : Лига 1 : 2008/2009';

  end;

procedure TForm1.NextGrid1MouseDown(
    Sender: TObject;
    Button: TMouseButton;
    Shift : TShiftState;
    X, Y  : Integer);
  begin
    // NextGrid1.MouseToCell(X, Y, CurrentCol, CurrentRow);
  end;

procedure TForm1.NextGrid2CellClick(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    D_Match: string[10];
  begin
    If Length(NextGrid2.Cell[ACol, ARow].Hint) > 0 then
      begin
        D_Match    := NextGrid2.Cell[ACol, ARow].Hint;
        Date_Match := strtodate(D_Match);
        Team_1     := NextGrid2.Cell[0, ARow].AsString;
        Form3.sost_otchet(
            Team_1,
            Date_Match);
      end;
  end;

procedure TForm1.StringGrid1MouseDown(
    Sender: TObject;
    Button: TMouseButton;
    Shift : TShiftState;
    X, Y  : Integer);
  var
    Srect: TGridRect;
    i    : Integer;
    vr   : string;
  begin

    StringGrid1.MouseToCell(
        X,
        Y,
        CurrentCol,
        CurrentRow);
    Team_1   := StringGrid1.Cells[1, CurrentRow];
    vr       := StringGrid1.Cells[CurrentCol, 0];
    Var_Game := 100;
    if vr = 'И' then
      Var_Game := 0;
    if vr = 'В' then
      Var_Game := 1;
    if vr = 'Н' then
      Var_Game := 2;
    if vr = 'П' then
      Var_Game := 3;

    for i := 1 to 20 do
      if StringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect.Top             := i;
              Srect.Bottom          := i;
              Srect.Left            := CurrentCol;
              Srect.Right           := CurrentCol;
              StringGrid1.selection := Srect;
            end
          else
            begin
              Srect.Top             := i;
              Srect.Bottom          := i;
              Srect.Left            := 0;
              Srect.Right           := 8;
              StringGrid1.selection := Srect
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect.Top              := i;
              Srect.Bottom           := i;
              Srect.Left             := CurrentCol;
              Srect.Right            := CurrentCol;
              XStringGrid1.selection := Srect;
            end
          else
            begin
              Srect.Top              := i;
              Srect.Bottom           := i;
              Srect.Left             := 0;
              Srect.Right            := 8;
              XStringGrid1.selection := Srect
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid2.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect.Top              := i;
              Srect.Bottom           := i;
              Srect.Left             := CurrentCol;
              Srect.Right            := CurrentCol;
              XStringGrid2.selection := Srect;
            end
          else
            begin
              Srect.Top              := i;
              Srect.Bottom           := i;
              Srect.Left             := 0;
              Srect.Right            := 8;
              XStringGrid2.selection := Srect
            end;
        end;

  end;

procedure TForm1.XStringGrid1MouseDown(
    Sender: TObject;
    Button: TMouseButton;
    Shift : TShiftState;
    X, Y  : Integer);
  var
    Srect1: TGridRect;
    i     : Integer;
    vr    : string;
  begin
    XStringGrid1.MouseToCell(
        X,
        Y,
        CurrentCol,
        CurrentRow);
    Team_1 := XStringGrid1.Cells[1, CurrentRow];

    vr       := XStringGrid1.Cells[CurrentCol, 0];
    Var_Game := 100;
    if vr = 'И' then
      Var_Game := 0;
    if vr = 'В' then
      Var_Game := 1;
    if vr = 'Н' then
      Var_Game := 2;
    if vr = 'П' then
      Var_Game := 3;

    for i := 1 to 20 do
      if StringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect1.Top            := i;
              Srect1.Bottom         := i;
              Srect1.Left           := CurrentCol;
              Srect1.Right          := CurrentCol;
              StringGrid1.selection := Srect1;
            end
          else
            begin
              Srect1.Top            := i;
              Srect1.Bottom         := i;
              Srect1.Left           := 0;
              Srect1.Right          := 8;
              StringGrid1.selection := Srect1
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect1.Top             := i;
              Srect1.Bottom          := i;
              Srect1.Left            := CurrentCol;
              Srect1.Right           := CurrentCol;
              XStringGrid1.selection := Srect1;
            end
          else
            begin
              Srect1.Top             := i;
              Srect1.Bottom          := i;
              Srect1.Left            := 0;
              Srect1.Right           := 8;
              XStringGrid1.selection := Srect1
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid2.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect1.Top             := i;
              Srect1.Bottom          := i;
              Srect1.Left            := CurrentCol;
              Srect1.Right           := CurrentCol;
              XStringGrid2.selection := Srect1;
            end
          else
            begin
              Srect1.Top             := i;
              Srect1.Bottom          := i;
              Srect1.Left            := 0;
              Srect1.Right           := 8;
              XStringGrid2.selection := Srect1
            end;
        end;

  end;

procedure TForm1.XStringGrid2MouseDown(
    Sender: TObject;
    Button: TMouseButton;
    Shift : TShiftState;
    X, Y  : Integer);
  var
    Srect2: TGridRect;
    i     : Integer;
    vr    : string;
  begin
    XStringGrid2.MouseToCell(
        X,
        Y,
        CurrentCol,
        CurrentRow);
    Team_1 := XStringGrid2.Cells[1, CurrentRow];

    vr       := XStringGrid2.Cells[CurrentCol, 0];
    Var_Game := 100;
    if vr = 'И' then
      Var_Game := 0;
    if vr = 'В' then
      Var_Game := 1;
    if vr = 'Н' then
      Var_Game := 2;
    if vr = 'П' then
      Var_Game := 3;

    for i := 1 to 20 do
      if StringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect2.Top            := i;
              Srect2.Bottom         := i;
              Srect2.Left           := CurrentCol;
              Srect2.Right          := CurrentCol;
              StringGrid1.selection := Srect2;
            end
          else
            begin
              Srect2.Top            := i;
              Srect2.Bottom         := i;
              Srect2.Left           := 0;
              Srect2.Right          := 8;
              StringGrid1.selection := Srect2
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid1.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect2.Top             := i;
              Srect2.Bottom          := i;
              Srect2.Left            := CurrentCol;
              Srect2.Right           := CurrentCol;
              XStringGrid1.selection := Srect2;
            end
          else
            begin
              Srect2.Top             := i;
              Srect2.Bottom          := i;
              Srect2.Left            := 0;
              Srect2.Right           := 8;
              XStringGrid1.selection := Srect2
            end;
        end;

    for i := 1 to 20 do
      if XStringGrid2.Cells[1, i] = Team_1 then
        begin
          if CurrentCol > 1 then
            begin
              Srect2.Top             := i;
              Srect2.Bottom          := i;
              Srect2.Left            := CurrentCol;
              Srect2.Right           := CurrentCol;
              XStringGrid2.selection := Srect2;
            end
          else
            begin
              Srect2.Top             := i;
              Srect2.Bottom          := i;
              Srect2.Left            := 0;
              Srect2.Right           := 8;
              XStringGrid2.selection := Srect2
            end;
        end;

  end;

procedure TForm1.xStringGrid1Click(Sender: TObject);
  begin
    if (Var_Stat_1 = 2) and (Var_stat_2 = 2) and (Var_Game <> 100) then
      begin
        // ShortDateFormat := 'dd/mm/yy';
        Var_location := 2;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;
    if (Var_Stat_1 = 2) and (Var_stat_2 = 3) and (Var_Game <> 100) then
      begin
        // ShortDateFormat := 'dd/mm/yy';
        Var_location := 1;
        Var_Itogo    := 2;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;
    if (Var_Stat_1 = 2) and (Var_stat_2 = 5) and (Var_Game <> 100) then
      begin
        // ShortDateFormat := 'dd/mm/yy';
        Var_location := 2;
        Var_Itogo    := 2;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;
    if (Var_Stat_1 = 2) and (Var_stat_2 = 7) and (Var_Game <> 100) then
      begin
        // ShortDateFormat := 'dd/mm/yy';
        Var_location := 3;
        Var_Itogo    := 2;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;
  end;

procedure TForm1.Sost_Vybor; // составить выбор
  var
    i: Integer;
  begin

    NextGrid5.AddRow(1);
    NextGrid5.Cells[1, 0] := 'Шахматки';
    NextGrid5.Cells[2, 0] := '1';
    NextGrid5.Cells[3, 0] := '0';
    NextGrid5.AddChildRow(
        0,
        crLast);
    NextGrid5.Cell[1, 1].AsString := 'Шахматка общая';
    NextGrid5.Cells[2, 1]         := '1';
    NextGrid5.Cells[3, 1]         := '1';
    NextGrid5.AddChildRow(
        0,
        crLast);
    NextGrid5.Cell[1, 2].AsString := 'Шахматка 1 тайм';
    NextGrid5.Cells[2, 2]         := '1';
    NextGrid5.Cells[3, 2]         := '2';
    NextGrid5.AddChildRow(
        0,
        crLast);
    NextGrid5.Cell[1, 3].AsString := 'Шахматка 2 тайм';
    NextGrid5.Cells[2, 3]         := '1';
    NextGrid5.Cells[3, 3]         := '3';

    NextGrid5.AddRow(1);
    NextGrid5.Cells[1, 4] := 'Таблицы';
    NextGrid5.Cells[2, 4] := '2';
    NextGrid5.Cells[3, 4] := '0';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 5].AsString := 'Всего+послед.игры';
    NextGrid5.Cells[2, 5]         := '2';
    NextGrid5.Cells[3, 5]         := '1';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 6].AsString := 'Всего+Дома+Выезд';
    NextGrid5.Cells[2, 6]         := '2';
    NextGrid5.Cells[3, 6]         := '2';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 7].AsString := 'Всего+1т.+2т.';
    NextGrid5.Cells[2, 7]         := '2';
    NextGrid5.Cells[3, 7]         := '3';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 8].AsString := 'Дома+послед.игры';
    NextGrid5.Cells[2, 8]         := '2';
    NextGrid5.Cells[3, 8]         := '4';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 9].AsString := 'Дома+1т.+2т.';
    NextGrid5.Cells[2, 9]         := '2';
    NextGrid5.Cells[3, 9]         := '5';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 10].AsString := 'Выезд+послед.игры';
    NextGrid5.Cells[2, 10]         := '2';
    NextGrid5.Cells[3, 10]         := '6';
    NextGrid5.AddChildRow(
        4,
        crLast);
    NextGrid5.Cell[1, 11].AsString := 'Выезд+1т.+2т.';
    NextGrid5.Cells[2, 11]         := '2';
    NextGrid5.Cells[3, 11]         := '7';

    NextGrid5.AddRow(1);
    NextGrid5.Cells[1, 12] := 'Результаты';
    NextGrid5.Cells[2, 12] := '3';
    NextGrid5.Cells[3, 12] := '0';
    NextGrid5.AddChildRow(
        12,
        crLast);
    NextGrid5.Cell[1, 13].AsString := 'Всего';
    NextGrid5.Cells[2, 13]         := '3';
    NextGrid5.Cells[3, 13]         := '1';
    NextGrid5.AddChildRow(
        12,
        crLast);
    NextGrid5.Cell[1, 14].AsString := 'Дома';
    NextGrid5.Cells[2, 14]         := '3';
    NextGrid5.Cells[3, 14]         := '2';
    NextGrid5.AddChildRow(
        12,
        crLast);
    NextGrid5.Cell[1, 15].AsString := 'Выезд';
    NextGrid5.Cells[2, 15]         := '3';
    NextGrid5.Cells[3, 15]         := '3';

    NextGrid5.AddRow(1);

    NextGrid5.Cells[1, 16] := 'Список игр';
    NextGrid5.Cells[2, 16] := '4';
    NextGrid5.Cells[3, 16] := '0';
    NextGrid5.AddChildRow(
        16,
        crLast);
    NextGrid5.Cell[1, 17].AsString := 'По датам';
    NextGrid5.Cells[2, 17]         := '4';
    NextGrid5.Cells[3, 17]         := '1';
    NextGrid5.AddChildRow(
        16,
        crLast);
    NextGrid5.Cell[1, 18].AsString := 'По турам';
    NextGrid5.Cells[2, 18]         := '4';
    NextGrid5.Cells[3, 18]         := '2';



    // for i:=0 to easyquery2.RecordCount-1 do begin NextGrid5.AddChildRow(16, crLast);
    // NextGrid5.Cell[1, I+17].AsString:=easyquery2.fields[0].AsString; easyquery2.next; end;

    NxTreeColumn1.ShowLines := True;
  end;

procedure TForm1.NextGrid5SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer); // выбор варианта статистики
  var
    i, Code: Integer;
  begin
    Val(
        NextGrid5.Cells[2, ARow],
        Var_Stat_1,
        Code);
    Val(
        NextGrid5.Cells[3, ARow],
        Var_stat_2,
        Code);
  end;

procedure TForm1.NextGrid5Resize(Sender: TObject);
  begin
    // NextGrid5.Columns[1].Width:=Panel3.Width-10;
    // NextGrid5.Columns[1].width:=NextGrid5.Columns[1].width - NextGrid5.Columns[0].width;
  end;

procedure TForm1.NextGrid5CellClick(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    i, k, n       : Integer;
    s             : string;
    Team_1, Team_2: string;
  begin

    if Var_Stat_1 = 1 then
      begin
        if Var_stat_2 = 1 then
          begin
            Variant_I := 1;
            Form4.sost_shamat_vsego(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Variant,
                Variant_I);
            Panel6.Height := NextGrid4.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Шахматка общая';
            Label1.Caption            := 'Шахматка общая';
          end;
        if Var_stat_2 = 2 then
          begin
            Variant_I := 2;
            Form4.sost_shamat_vsego(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Variant,
                Variant_I);
            Panel6.Height := NextGrid4.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Шахматка 1 тайм';
            Label1.Caption            := 'Шахматка 1 тайм';

          end;
        if Var_stat_2 = 3 then
          begin
            Variant_I := 3;
            Form4.sost_shamat_vsego(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Variant,
                Variant_I);
            Panel6.Height := NextGrid4.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Шахматка 2 тайм';
            Label1.Caption            := 'Шахматка 2 тайм';
          end;
      end;

    if Var_Stat_1 = 2 then
      begin

        if Var_stat_2 = 1 then
          begin
            Vr_Table := 1;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := NextGrid6.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Общая таблица + последние игры';
            Label1.Caption            := 'Общая таблица + последние игры';
          end;

        if Var_stat_2 = 2 then
          begin
            Vr_Table := 2;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := StringGrid1.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Общая таблица + разбивка дома/выезд';
            Label1.Caption            := 'Общая таблица + разбивка дома/выезд';
          end;

        if Var_stat_2 = 3 then
          begin
            Vr_Table := 3;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := StringGrid1.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text :=
                'Общая таблица + разбивка 1 тайм / 2 тайм';
            Label1.Caption := 'Общая таблица + разбивка 1 тайм / 2 тайм';
          end;

        if Var_stat_2 = 4 then
          begin
            Vr_Table := 4;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := NextGrid6.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text :=
                'Таблица домашних игр + последние игры';
            Label1.Caption := 'Таблица домашних игр + последние игры';
          end;

        if Var_stat_2 = 5 then
          begin
            Vr_Table := 5;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := StringGrid1.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text :=
                'Таблица домашних игр + разбивка 1 тайм / 2 тайм';
            Label1.Caption := 'Таблица домашних игр + разбивка 1 тайм / 2 тайм';
          end;

        if Var_stat_2 = 6 then
          begin
            Vr_Table := 6;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := NextGrid6.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text :=
                'Таблица выездных игр + последние игры';
            Label1.Caption := 'Таблица выездных игр + последние игры';
          end;
        if Var_stat_2 = 7 then
          begin
            Vr_Table := 7;
            Form4.sost_table(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Table);
            Panel6.Height := StringGrid1.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text :=
                'Таблица выездных игр + разбивка 1 тайм / 2 тайм';
            Label1.Caption := 'Таблица выездных игр + разбивка 1 тайм / 2 тайм';
          end;
      end;

    if Var_Stat_1 = 3 then
      begin
        if Var_stat_2 = 1 then
          begin
            Vr_Result := 1;
            Form5.sost_result(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Result);
            Panel6.Height := NextGrid2.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Сводная таблица игр';
            Label1.Caption            := 'Сводная таблица игр';
          end;
        if Var_stat_2 = 2 then
          begin
            Vr_Result := 2;
            Form5.sost_result(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Result);
            Panel6.Height := NextGrid2.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Сводная таблица домашних игр';
            Label1.Caption            := 'Сводная таблица домашних игр';
          end;
        if Var_stat_2 = 3 then
          begin
            Vr_Result := 3;
            Form5.sost_result(
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Vr_Result);
            Panel6.Height := NextGrid2.Height + Panel11.Height +
                Panel12.Height + 10;
            StatusBar1.Panels[1].Text := 'Сводная таблица выездных игр';
            Label1.Caption            := 'Сводная таблица выездных игр';

          end;
      end;

    if Var_Stat_1 = 4 then
      begin
        if Var_stat_2 = 1 then
          begin
            Var_Play := 1;
            Form3.Sost_Play(
                date_1_Vyb,
                date_2_Vyb,
                Var_Play);
          end;
        if Var_stat_2 = 2 then
          begin
            Var_Play := 2;
            Form3.Sost_Play(
                date_1_Vyb,
                date_2_Vyb,
                Var_Play);
          end;
      end;

  end;

procedure TForm1.StringGrid1Click(Sender: TObject);
  begin

    if (Var_Stat_1 = 2) and (Var_stat_2 = 2) and (Var_Game <> 100) then
      begin
        // ShortDateFormat:='dd/mm/yy';
        // showMessage('Команда : '+ Team_1+'Дата 1 : ' + DateToStr(date_1_vyb) +'Дата 2 : '+DateToStr(date_2_vyb) );
        Var_location := 1;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 3) and (Var_Game <> 100) then
      begin
        // ShortDateFormat:='dd/mm/yy';
        Var_location := 1;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 5) and (Var_Game <> 100) then
      begin
        // ShortDateFormat:='dd/mm/yy';
        Var_location := 2;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 7) and (Var_Game <> 100) then
      begin
        // ShortDateFormat:='dd/mm/yy';
        Var_location := 3;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

  end;

procedure TForm1.NextGrid1Resize(Sender: TObject);
  begin
    NextGrid1.Columns[0].Width := Panel3.Width - 10;
  end;

procedure TForm1.NextGrid1SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    i, Code: Integer;
    s      : string;
  begin
    Vyb_League := ARow + 1;

  end;

procedure TForm1.NextGrid1CellClick(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    i, Code: Integer;
    s      : string;
  begin

    if EasyDatabase1.Connected = True then
      begin
        EasyDatabase1.Connected := False;
        EasyDatabase1.CloseDataSets;
      end;
    if EasyTable2.Active = True then
      begin
        EasyTable2.Active := False;
        EasyTable2.Close;
      end;
    if EasyQuery1.Active = True then
      begin
        EasyQuery1.Active := False;
        EasyQuery1.Close;
      end;
    if EasyQuery2.Active = True then
      begin
        EasyQuery2.Active := False;
        EasyQuery2.Close;
      end;
    if EasyQuery3.Active = True then
      begin
        EasyQuery3.Active := False;
        EasyQuery3.Close;
      end;
    if EasyQuery4.Active = True then
      begin
        EasyQuery4.Active := False;
        EasyQuery4.Close;
      end;
    if EasyQuery5.Active = True then
      begin
        EasyQuery5.Active := False;
        EasyQuery5.Close;
      end;
    if EasyQuery6.Active = True then
      begin
        EasyQuery6.Active := False;
        EasyQuery6.Close;
      end;
    if EasyQuery7.Active = True then
      begin
        EasyQuery7.Active := False;
        EasyQuery7.Close;
      end;

    if Form2.EasyQuery1_F2.Active = True then
      begin
        EasyQuery1.Active := False;
        EasyQuery1.Close;
      end;
    if Form2.EasyQuery2_F2.Active = True then
      begin
        EasyQuery2.Active := False;
        EasyQuery2.Close;
      end;

    NextGrid2.Visible    := False;
    NextGrid4.Visible    := False;
    NextGrid3.Visible    := False;
    NextGrid6.Visible    := False;
    StringGrid1.Visible  := False;
    XStringGrid1.Visible := False;
    XStringGrid2.Visible := False;
    NextGrid13.Visible   := False;
    NextGrid12.Visible   := False;
    NextGrid7.Visible    := False;
    NextGrid8.Visible    := False;
    NextGrid9.Visible    := False;
    NextGrid10.Visible   := False;
    NextGrid11.Visible   := False;

    if Vyb_League = 1 then
      begin
        EasyDatabase1.DataBaseFileName       := 'C:\FootStat\Table\Franse.edb';
        Form2.EasyDataBase2.DataBaseFileName := 'C:\FootStat\Table\Franse.edb';
        EasyTable2.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery1.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery2.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery3.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery4.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery5.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery6.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        EasyQuery7.DataBaseFileName          := 'C:\FootStat\Table\Franse.edb';
        Form2.EasyQuery1_F2.DataBaseFileName := 'C:\FootStat\Table\Franse.edb';
        Form2.EasyQuery2_F2.DataBaseFileName := 'C:\FootStat\Table\Franse.edb';
      end;

    if Vyb_League = 2 then
      begin
        EasyDatabase1.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        Form2.EasyDataBase2.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyTable2.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyQuery1.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyQuery2.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyQuery3.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyQuery4.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        EasyQuery5.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        Form2.EasyQuery1_F2.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
        Form2.EasyQuery2_F2.DataBaseFileName := 'C:\FootStat\Table\Germany.edb';
      end;

    EasyQuery1.Active := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.SQL.add('select Data from play where IDMatch=1 ');
    EasyQuery1.Active := True;
    EasyQuery1.Open;;
    EasyQuery1.first;
    date_1_Tur         := EasyQuery1.fields[0].AsDateTime;
    NxDatePicker1.Date := EasyQuery1.fields[0].AsDateTime;
    EasyQuery1.Active  := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.Close;

    EasyQuery1.Active := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.SQL.add('select Data from play');
    EasyQuery1.Active := True;
    EasyQuery1.Open;;
    EasyQuery1.Last;
    date_Last_Tur     := EasyQuery1.fields[0].AsDateTime;
    EasyQuery1.Active := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.Close;

    EasyQuery1.Active := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.SQL.add('select ID from Location');
    EasyQuery1.Active := True;
    EasyQuery1.Open;;
    EasyQuery1.Last;
    Team_Vsego        := EasyQuery1.recordcount;
    EasyQuery1.Active := False;
    EasyQuery1.SQL.clear;
    EasyQuery1.Close;

    NxDatePicker2.Date := Now;
    date_1_Vyb         := date_1_Tur;
    Date_1_V           := date_1_Tur;
    date_2_Vyb         := NxDatePicker2.Date;
    Date_2_V           := NxDatePicker2.Date;
    Form4.sost_tablicu(
        date_1_Vyb,
        date_2_Vyb);

    if NextGrid5.RowCount > 0 then
      begin
        for i := NextGrid5.RowCount - 1 downto 0 do
          NextGrid5.DeleteRow(i);
      end;
    Sost_Vybor;

  end;

procedure TForm1.CheckBox1Click(Sender: TObject);
  begin

    Form5.sost_Game_vsego(
        Team_1,
        date_1_Vyb,
        date_2_Vyb,
        Vyb_1_tur,
        Vyb_2_tur,
        Var_Game,
        Var_Itogo,
        Var_location);

    if CheckBox1.Checked = True then
      begin
        NextGrid3.Width := NextGrid3.Columns[0].Width + NextGrid3.Columns[1]
            .Width + NextGrid3.Columns[2].Width + NextGrid3.Columns[3].Width +
            NextGrid3.Columns[4].Width + NextGrid3.Columns[5].Width + 20;
        Panel1.Width := NextGrid3.Width;
      end
    else
      begin
        NextGrid3.Width := NextGrid3.Columns[0].Width + NextGrid3.Columns[1]
            .Width + +NextGrid3.Columns[4].Width + NextGrid3.Columns[5].Width;
        Panel1.Left := Form1.Width - NextGrid3.Width + 10;
      end;

  end;

procedure TForm1.XStringGrid2Click(Sender: TObject);
  begin

    if (Var_Stat_1 = 2) and (Var_stat_2 = 2) and (Var_Game <> 100) then
      begin
        Var_location := 3;
        Var_Itogo    := 1;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 3) and (Var_Game <> 100) then
      begin
        Var_location := 1;
        Var_Itogo    := 3;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 5) and (Var_Game <> 100) then
      begin
        Var_location := 2;
        Var_Itogo    := 3;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

    if (Var_Stat_1 = 2) and (Var_stat_2 = 7) and (Var_Game <> 100) then
      begin
        Var_location := 3;
        Var_Itogo    := 3;
        Form5.sost_Game_vsego(
            Team_1,
            date_1_Vyb,
            date_2_Vyb,
            Vyb_1_tur,
            Vyb_2_tur,
            Var_Game,
            Var_Itogo,
            Var_location);
      end;

  end;

procedure TForm1.Panel5Resize(Sender: TObject);
  begin
    NextGrid7.Left := (Panel5.Width - NextGrid7.Width - NextGrid8.Width -
        NextGrid9.Width - 15) div 2;
    NextGrid8.Left  := NextGrid7.Left + NextGrid7.Width + 5;
    NextGrid9.Left  := NextGrid7.Left + NextGrid7.Width + NextGrid8.Width + 10;
    NextGrid10.Left := ((Panel5.Width - NextGrid10.Width) div 2) - 3;
    NextGrid11.Left := ((Panel5.Width - NextGrid11.Width) div 2) - 3;
  end;

procedure TForm1.NextGrid6CellClick(
    Sender    : TObject;
    ACol, ARow: Integer); // выбор статистики из таблиц
  var
    D_Match: string[10];
  begin
    D_Match := NextGrid6.Cell[ACol, ARow].Hint;
    If Length(D_Match) > 0 then
      begin
        if Var_Game = 10 then
          begin
            Date_Match := strtodate(D_Match);
            Team_1     := NextGrid6.Cell[1, ARow].AsString;
            Form3.sost_otchet(
                Team_1,
                Date_Match);
          end;
      end;

    if ((Var_Game = 0) or (Var_Game = 1) or (Var_Game = 2) or (Var_Game = 3))
    then
      Form5.sost_Game_vsego(
          Team_1,
          date_1_Vyb,
          date_2_Vyb,
          Vyb_1_tur,
          Vyb_2_tur,
          Var_Game,
          Var_Itogo,
          Var_location);

  end;

procedure TForm1.NextGrid6SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer); // выбор статистики из таблиц
  var
    vr: string[1];
  begin

    Team_1       := NextGrid6.Cells[1, ARow];
    vr           := NextGrid6.Columns[ACol].header.Caption;
    Var_Game     := 100;
    Var_Itogo    := 100;
    Var_location := 100;

    if ((Var_Stat_1 = 2) and (Var_stat_2 = 1)) then
      begin
        Var_Itogo    := 1;
        Var_location := 1;
      end;
    if ((Var_Stat_1 = 2) and (Var_stat_2 = 4)) then
      begin
        Var_Itogo    := 1;
        Var_location := 2;
      end;
    if ((Var_Stat_1 = 2) and (Var_stat_2 = 6)) then
      begin
        Var_Itogo    := 1;
        Var_location := 3;
      end;

    if ACol = 2 then
      Var_Game := 0;
    if ACol = 3 then
      Var_Game := 1;
    if ACol = 4 then
      Var_Game := 2;
    if ACol = 5 then
      Var_Game := 3;

    if ACol >= 9 then
      begin
        Var_Game := 10;
      end;

  end;

procedure TForm1.NextGrid9SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    vr         : string[1];
    Name_Player: String;
  begin // Подготовка выбора игрока из отчета гостевой команды
    Name_Player       := NextGrid9.Cells[1, ARow];
    EasyQuery3.Active := False;
    EasyQuery3.SQL.clear;
    EasyQuery3.SQL.add('select PlayerID from Sostav where Family=:PlayerID');
    EasyQuery3.ParamByName('PlayerID').AsString := Name_Player;
    EasyQuery3.Active                           := True;
    EasyQuery3.Open;
    EasyQuery3.first;
    PlayerID := EasyQuery3.fields[0].AsInteger;
  end;

procedure TForm1.NextGrid9Click(Sender: TObject);
// Выбор игрока из отчета гостевой команды
  begin
    // ShortDateFormat := 'dd/mm';
    Team_2 := NextGrid11.Columns[2].header.Caption;
    Form3.Sost_Player(
        date_1_Vyb,
        date_2_Vyb,
        PlayerID,
        Team_2);
  end;

procedure TForm1.NextGrid7Click(Sender: TObject);
// Выбор игрока из отчета домашней команды
  begin
    // ShortDateFormat := 'dd/mm';
    Team_1 := NextGrid11.Columns[0].header.Caption;
    Form3.Sost_Player(
        date_1_Vyb,
        date_2_Vyb,
        PlayerID,
        Team_1);
  end;

procedure TForm1.NextGrid7SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer);
  var
    vr         : string[1];
    Name_Player: String; // Подготовка выбора игрока из отчета домашней команды
  begin
    Name_Player       := NextGrid7.Cells[1, ARow];
    EasyQuery3.Active := False;
    EasyQuery3.SQL.clear;
    EasyQuery3.SQL.add('select PlayerID from Sostav where Family=:PlayerID');
    EasyQuery3.ParamByName('PlayerID').AsString := Name_Player;
    EasyQuery3.Active                           := True;
    EasyQuery3.Open;
    EasyQuery3.first;
    PlayerID := EasyQuery3.fields[0].AsInteger;
  end;

procedure TForm1.Button4Click(Sender: TObject);
  begin
    TForm2.Create(Application);
    Form2.Show;
  end;

procedure TForm1.NxDatePicker1Change(Sender: TObject);
  begin
    date_1_Vyb := NxDatePicker1.Date;
  end;

procedure TForm1.NxDatePicker2Change(Sender: TObject);
  begin
    date_2_Vyb := NxDatePicker2.Date;
  end;

procedure TForm1.Button2Click(Sender: TObject);

  Var
    i: Integer;
  begin
    date_1_Vyb := NxDatePicker1.Date;
    date_2_Vyb := NxDatePicker2.Date;

    If NextGrid13.RowCount > 0 then
      begin
        For i := NextGrid13.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid13.DeleteRow(i);
          end;
      end;
    If NextGrid12.RowCount > 0 then
      begin
        For i := NextGrid12.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid12.DeleteRow(i);
          end;
      end;
    If NextGrid11.RowCount > 0 then
      begin
        For i := NextGrid12.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid11.DeleteRow(i);
          end;
      end;
    If NextGrid10.RowCount > 0 then
      begin
        For i := NextGrid10.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid10.DeleteRow(i);
          end;
      end;

    If NextGrid2.RowCount > 0 then
      begin
        For i := NextGrid2.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid2.DeleteRow(i);
          end;
      end;
    If NextGrid3.RowCount > 0 then
      begin
        For i := NextGrid3.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid3.DeleteRow(i);
          end;
      end;

    If NextGrid4.RowCount > 0 then
      begin
        For i := NextGrid4.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid4.DeleteRow(i);
          end;
      end;
    If NextGrid6.RowCount > 0 then
      begin
        For i := NextGrid6.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid6.DeleteRow(i);
          end;
      end;
    If NextGrid7.RowCount > 0 then
      begin
        For i := NextGrid7.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid7.DeleteRow(i);
          end;
      end;
    If NextGrid8.RowCount > 0 then
      begin
        For i := NextGrid8.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid8.DeleteRow(i);
          end;
      end;

    If NextGrid9.RowCount > 0 then
      begin
        For i := NextGrid9.RowCount - 1 DownTo 0 Do
          Begin
            NextGrid9.DeleteRow(i);
          end;
      end;

    NextGrid2.Visible    := False;
    NextGrid3.Visible    := False;
    NextGrid4.Visible    := False;
    NextGrid6.Visible    := False;
    NextGrid7.Visible    := False;
    NextGrid8.Visible    := False;
    NextGrid9.Visible    := False;
    NextGrid10.Visible   := False;
    NextGrid11.Visible   := False;
    NextGrid12.Visible   := False;
    NextGrid13.Visible   := False;
    StringGrid1.Visible  := False;
    XStringGrid1.Visible := False;
    XStringGrid2.Visible := False;

    Form4.sost_tablicu(
        date_1_Vyb,
        date_2_Vyb);
    Panel14.Height        := 20;
    NxDatePicker1.Visible := False;
    NxDatePicker2.Visible := False;
    Label2.Visible        := True;
    Button2.Visible       := False;
    Button1.Visible       := False;

  end;

procedure TForm1.Panel14MouseUp(
    Sender: TObject;
    Button: TMouseButton;
    Shift : TShiftState;
    X, Y  : Integer);
  begin
    Panel14.Height        := 65;
    NxDatePicker1.Visible := True;
    NxDatePicker2.Visible := True;
    Label2.Visible        := False;
    Button2.Visible       := True;
    Button1.Visible       := True;
  end;

procedure TForm1.Label2Click(Sender: TObject);
  begin
    Panel14.Height        := 65;
    NxDatePicker1.Visible := True;
    NxDatePicker2.Visible := True;
    Label2.Visible        := False;
    Button2.Visible       := True;
    Button1.Visible       := True;
  end;

procedure TForm1.Panel13Resize(Sender: TObject);
  begin
    If Panel13.Width > NextGrid2.Width then
      NextGrid2.Left := ((Panel13.Width - NextGrid2.Width) div 2) - 1
    else
      NextGrid2.Left := 5;
    If Panel13.Width > NextGrid4.Width then
      NextGrid4.Left := ((Panel13.Width - NextGrid4.Width) div 2) - 1
    else
      NextGrid4.Left := 5;
    If Panel13.Width > NextGrid6.Width then
      NextGrid6.Left := ((Panel13.Width - NextGrid6.Width) div 2) - 1
    else
      NextGrid6.Left := 5;
    If Panel13.Width > (StringGrid1.Width + XStringGrid1.Width +
        XStringGrid2.Width + 10) then
      Begin
        StringGrid1.Left :=
            (Panel13.Width - (StringGrid1.Width + XStringGrid1.Width +
            XStringGrid2.Width + 10)) div 2;
        XStringGrid1.Left := StringGrid1.Left + StringGrid1.Width + 2;
        XStringGrid2.Left := StringGrid1.Left + StringGrid1.Width +
            XStringGrid1.Width + 4;
      end
    else
      begin
        StringGrid1.Left  := 4;
        StringGrid1.Top   := 5;
        XStringGrid1.Left := 220;
        XStringGrid1.Top  := 5;
        XStringGrid2.Left := 436;
        XStringGrid2.Top  := 5;
      end;
  end;

procedure TForm1.Button1Click(Sender: TObject);
  begin
    Panel14.Height        := 20;
    NxDatePicker1.Visible := False;
    NxDatePicker2.Visible := False;
    Label2.Visible        := True;
    Button2.Visible       := False;
    Button1.Visible       := False;
  end;

procedure TForm1.NextGrid4Click(Sender: TObject);
// выбор статистики из шахматок
  begin
    if ((CurrentCol > 1) and (CurrentCol < 26)) then
      begin

        if ((CurrentCol > 1) and (CurrentCol < 22)) then
          begin
            Form3.sost_otchet(
                Team_1,
                Date_Match);
          end;

        if (CurrentCol > 21) then
          begin
            Form5.sost_Game_vsego(
                Team_1,
                date_1_Vyb,
                date_2_Vyb,
                Vyb_1_tur,
                Vyb_2_tur,
                Var_Game,
                Var_Itogo,
                Var_location);
          end;

      end;

  end;

procedure TForm1.NextGrid4SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer); // выбор статистики из шахматок
  var
    vr: string[1];
  begin
    CurrentCol := ACol;
    CurrentRow := ARow;
    Team_1     := NextGrid4.Cells[1, ARow];
    vr         := NextGrid4.Columns[ACol].header.Caption;

    If ((ACol > 1) and (ACol < 22)) then
      Begin
        Team_2 := NextGrid4.Cells
            [1, StrToInt(NextGrid4.Columns[ACol].header.Caption) - 1];

        EasyQuery1.Active := False;
        EasyQuery1.SQL.clear;
        EasyQuery1.SQL.add
            ('select Data, Status from play where ((Team_1=:Team1) and (Team_2=:Team2))');
        EasyQuery1.ParamByName('Team1').AsString := Team_1;
        EasyQuery1.ParamByName('Team2').AsString := Team_2;
        EasyQuery1.Active                        := True;
        EasyQuery1.Open;
        EasyQuery1.first;
        Date_Match := EasyQuery1.fields[0].AsDateTime;
      end;

    Var_Game := 100;
    if ((Var_Stat_1 = 1) and (Var_stat_2 = 1)) then
      Var_Itogo := 1;
    if ((Var_Stat_1 = 1) and (Var_stat_2 = 2)) then
      Var_Itogo := 2;
    if ((Var_Stat_1 = 1) and (Var_stat_2 = 3)) then
      Var_Itogo  := 3;
    Var_location := 1;
    if vr = 'И' then
      Var_Game := 0;
    if vr = 'В' then
      Var_Game := 1;
    if vr = 'Н' then
      Var_Game := 2;
    if vr = 'П' then
      Var_Game := 3;
  end;

procedure TForm1.NextGrid3SelectCell(
    Sender    : TObject;
    ACol, ARow: Integer); // Составить отчет об игре из NextGrid3
  begin
    Date_Match := strtodate(NextGrid3.Cells[0, ARow]);
    Team_1     := NextGrid3.Cells[1, ARow];
  end;

procedure TForm1.NextGrid3Click(Sender: TObject);
// Составить отчет об игре из NextGrid3
  begin
    Form3.sost_otchet(
        Team_1,
        Date_Match);
  end;

end.

    SELECT Count
(Type) as Cnt, Type , Team_2 FROM Event WHERE IDPlayer = 568 GROUP BY
    Team_2, Type

    SELECT Event.IDMatch, Event.IDPlayer, Event.Type, Event.Team_1,
    Event.Team_2, Play.Goal_T_1 FROM Event,
    Play WHERE(Event.IDMatch = Play.IDMatch) and (Event.IDMatch = 3)
    Order BY Team_1;
