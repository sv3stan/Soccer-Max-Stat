unit Vyb_Play;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, EasyTable, Grids, DBGrids, NxEdit;

type
  TForm2 = class(TForm)
    Button1: TButton;
    EasyQuery1_F2: TEasyQuery;
    EasyQuery2_F2: TEasyQuery;
    NxComboBox1: TNxComboBox;
    NxComboBox2: TNxComboBox;
    NxComboBox3: TNxComboBox;
    NxComboBox4: TNxComboBox;
    NxComboBox5: TNxComboBox;
    NxComboBox6: TNxComboBox;
    NxComboBox7: TNxComboBox;
    NxCheckBox1: TNxCheckBox;
    NxCheckBox2: TNxCheckBox;
    NxCheckBox3: TNxCheckBox;
    NxCheckBox4: TNxCheckBox;
    NxCheckBox5: TNxCheckBox;
    NxCheckBox6: TNxCheckBox;
    NxCheckBox7: TNxCheckBox;
    EasyDatabase2: TEasyDatabase;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    NxComboBox8: TNxComboBox;
    NxComboBox9: TNxComboBox;
    NxDatePicker1: TNxDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure NxComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
implementation

uses Main;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var i:integer; s:string; begin


{ EasyQuery1_F2.Active:=false; EasyQuery1_F2.SQL.clear;
 EasyQuery1_F2.SQL.add('select ShortName from location order by ShortName asc');
 EasyQuery1_F2.Active:=true; EasyQuery1_F2.Open;  EasyQuery1_F2.First;
 NXComboBox1.Text:=EasyQuery1_F2.Fields[0].AsString;
 NXComboBox2.Text:=EasyQuery1_F2.Fields[0].AsString;
 for i:=0 to EasyQuery1_F2.RecordCount-1 do begin
 NXComboBox1.Items.Add(EasyQuery1_F2.Fields[0].AsString);
 NXComboBox2.Items.Add(EasyQuery1_F2.Fields[0].AsString); EasyQuery1_F2.Next;
 end;
 NXComboBox3.Text:='=0';
 NXComboBox4.Text:='=0';
 NXComboBox5.Text:='П1';
 NXComboBox6.Text:='>2.5';
 NXComboBox7.Text:='0:0';}
end;

procedure TForm2.Button1Click(Sender: TObject);
Var I, y : Integer;
begin

 If Form1.NextGrid13.RowCount > 0 then begin
  For i:= Form1.NextGrid13.RowCount-1 DownTo 0 Do Begin Form1.NextGrid13.DeleteRow(i); end;end;


 easyquery2_F2.Active:=false; easyquery2_F2.SQL.clear;
 easyquery2_F2.SQL.add('select Tur, Data, Team_1, Goal_F_1, Goal_F_2, (Goal_T_1-Goal_F_1) as Goal_S_1, (Goal_T_2-Goal_F_2) as Goal_S_2, Goal_T_1, Goal_T_2, Team_2, Referi, Location, Fans from play where (status=10) and ((Team_1=:Team) or (Team_2=:Team))');
 easyquery2_F2.ParamByName('Team').AsString:=NXComboBox1.Text;
 easyquery2_F2.Active:=true; easyquery2_F2.Open; easyquery2_F2.first;

// ShortDateFormat := 'dd/mm';
   For i:=0 to EasyQuery2_F2.RecordCount-1 do begin
   Form1.NextGrid13.AddRow(1);
   Form1.NextGrid13.Cells[0,i]:=EasyQuery2_F2.Fields[0].AsString;                                        // Тур
   Form1.NextGrid13.Cells[1,i]:=EasyQuery2_F2.Fields[1].AsString;                                        // Дата
   Form1.NextGrid13.Cells[2,i]:=EasyQuery2_F2.Fields[2].AsString;                                        // Первая команда
   Form1.NextGrid13.Cells[3,i]:=EasyQuery2_F2.Fields[3].AsString +':'+EasyQuery2_F2.Fields[4].AsString;     // Первый тайм
   Form1.NextGrid13.Cells[4,i]:=EasyQuery2_F2.Fields[5].AsString +':'+EasyQuery2_F2.Fields[6].AsString;     // Второй тайм
   Form1.NextGrid13.Cells[5,i]:=EasyQuery2_F2.Fields[7].AsString +':'+EasyQuery2_F2.Fields[8].AsString;     // Итог
   Form1.NextGrid13.Cells[6,i]:=EasyQuery2_F2.Fields[9].AsString;                                        // Вторая команда
   Form1.NextGrid13.Cells[7,i]:=EasyQuery2_F2.Fields[10].AsString;                                       // Рефери

 easyquery1_F2.Active:=false; easyquery1_F2.SQL.clear;
 easyquery1_F2.SQL.add('select Stadion, StadiumCap from Location where ID=:Locate');
 easyquery1_F2.ParamByName('Locate').AsString:=EasyQuery2_F2.Fields[11].AsString;
 easyquery1_F2.Active:=true; easyquery1_F2.Open; easyquery1_F2.first;

   Form1.NextGrid13.Cells[8,i]:=EasyQuery1_F2.Fields[0].AsString;                                        // Стадион
   Form1.NextGrid13.Cells[9,i]:=EasyQuery2_F2.Fields[12].AsString +' из '+EasyQuery1_F2.Fields[1].AsString; // Зрители

  if EasyQuery2_F2.Fields[2].AsString = NXComboBox1.Text then begin
   If EasyQuery2_F2.Fields[7].AsInteger > EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Win;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
   If EasyQuery2_F2.Fields[7].AsInteger = EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Draw;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
   If EasyQuery2_F2.Fields[7].AsInteger < EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Loss;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end; end;

  if EasyQuery2_F2.Fields[9].AsString = NXComboBox1.Text then begin
   If EasyQuery2_F2.Fields[7].AsInteger < EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Win;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
   If EasyQuery2_F2.Fields[7].AsInteger = EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Draw;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end;
   If EasyQuery2_F2.Fields[7].AsInteger > EasyQuery2_F2.Fields[8].AsInteger then begin
          for y:=0 to 9 do begin Form1.Nextgrid13.Cell[y,i].color:=Form1.Cl_Loss;
          Form1.NextGrid13.Columns[y].Font.Color:=Form1.Cl_Text;  end; end; end;



   EasyQuery2_F2.Next;
   end;   Form2.Close;

                Form1.NextGrid2.Visible:=False;             Form1.NextGrid4.Visible:=False;
                Form1.NextGrid6.Visible:=False;                Form1.StringGrid1.Visible:=False;
                Form1.xStringGrid1.Visible:=False;
                Form1.xStringGrid2.Visible:=False;                Form1.NextGrid13.Visible:=True;
end;

procedure TForm2.NxComboBox1Change(Sender: TObject);
begin
 NXComboBox2.Text:=NXComboBox1.Text;
end;

procedure TForm2.FormActivate(Sender: TObject);
var i:integer; s:string; begin


 EasyQuery1_F2.Active:=false; EasyQuery1_F2.SQL.clear;
 EasyQuery1_F2.SQL.add('select ShortName from location order by ShortName asc');
 EasyQuery1_F2.Active:=true; EasyQuery1_F2.Open;  EasyQuery1_F2.First;
 NXComboBox1.Text:=EasyQuery1_F2.Fields[0].AsString;
 NXComboBox2.Text:=EasyQuery1_F2.Fields[0].AsString;
 for i:=0 to EasyQuery1_F2.RecordCount-1 do begin
 NXComboBox1.Items.Add(EasyQuery1_F2.Fields[0].AsString);
 NXComboBox2.Items.Add(EasyQuery1_F2.Fields[0].AsString); EasyQuery1_F2.Next;
 end;
 NXComboBox3.Text:='=0';
 NXComboBox4.Text:='=0';
 NXComboBox5.Text:='П1';
 NXComboBox6.Text:='>2.5';
 NXComboBox7.Text:='0:0';

end;

end.
