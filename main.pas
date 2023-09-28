unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, Spin, Buttons, ExtCtrls, AsyncProcess, TplGaugeUnit,
  TplProgressBarUnit, ueled, ExtMessage, MPlayerCtrl;

type

  { TForm1 }

  TForm1 = class(TForm)
    AsyncProcess1: TAsyncProcess;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ImageList1: TImageList;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    mess: TExtMessage;
    mplayer1: TMPlayerControl;
    mplayer2: TMPlayerControl;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    plProgressBar1: TplProgressBar;
    plProgressBar2: TplProgressBar;
    plProgressBar3: TplProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter1: TSplitter;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mplayer1Pause(Sender: TObject);
    procedure mplayer1Playing(ASender: TObject; APosition, ADuration: single);
    procedure mplayer1Stop(Sender: TObject);
    procedure mplayer2Pause(Sender: TObject);
    procedure mplayer2Playing(ASender: TObject; APosition, ADuration: single);
    procedure mplayer2Stop(Sender: TObject);
    procedure plProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure plProgressBar2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure plProgressBar3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure _GLOBAL_REFRESH(Sender: TObject);
    procedure _PLAY(Sender: TObject);
    procedure _PAUSE(Sender: TObject);
    procedure _OpenFilm(Sender: TObject);
    procedure _OBLICZENIA(Sender: TObject);
  private
    poz1,poz2: single;
    procedure GlobalRefresh;
    procedure play_opoznienie(aSeconds: integer);
    procedure play_pause;
    procedure play_seek(aDoPrzodu: boolean);
    procedure oblicz;
  public

  end;

var
  Form1: TForm1;

implementation

uses
  ecode, lcltype;

{$R *.lfm}

type
  TARC = record
    film_docelowy,film_zrodlowy: shortstring;
    dlugosc1,dlugosc2,dlugosc3: integer;
    w1a,w1b,w2a,w2b: integer;
    wsp,wsp2: double;
    poz1,poz2: single;
  end;

var
  rec: record
    dlugosc1,dlugosc2,dlugosc3: integer;
    w1a,w1b,w2a,w2b: integer;
    wsp,wsp2: double;
  end;

{ TForm1 }

procedure TForm1.mplayer1Pause(Sender: TObject);
begin
  plProgressBar1.Position:=mplayer1.SingleMpToInteger(mplayer1.Position);
  Label28.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer1.SingleMpToTime(mplayer1.Position));
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if mplayer1.Running then mplayer1.Stop;
  if mplayer2.Running then mplayer2.Stop;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case Key of
    VK_SPACE: play_pause;
    VK_1: play_opoznienie(1);
    VK_2: play_opoznienie(2);
    VK_3: play_opoznienie(3);
    VK_4: play_opoznienie(4);
    VK_5: play_opoznienie(5);
    VK_6: play_opoznienie(6);
    VK_7: play_opoznienie(7);
    VK_8: play_opoznienie(8);
    VK_9: play_opoznienie(9);
    VK_RIGHT: play_seek(true);
    VK_LEFT: play_seek(false);
  end;
  Key:=0;
end;

procedure TForm1.mplayer1Playing(ASender: TObject; APosition, ADuration: single
  );
var
  pom: single;
begin
  if Label29.Caption='--:--:--.---' then
  begin
    pom:=mplayer1.Duration;
    if pom<1 then exit;
    Label29.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer1.SingleMpToTime(pom));
    Label39.Caption:=Label29.Caption;
    plProgressBar1.Max:=mplayer1.SingleMpToInteger(pom);
    rec.dlugosc1:=plProgressBar1.Max;
  end;
  plProgressBar1.Position:=mplayer1.SingleMpToInteger(APosition);
  Label28.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer1.SingleMpToTime(APosition));
  GlobalRefresh;
end;

procedure TForm1.mplayer1Stop(Sender: TObject);
begin
  plProgressBar1.Position:=0;
  Label28.Caption:='--:--:--.---';
  Label29.Caption:='--:--:--.---';
  Label39.Caption:='';
  rec.dlugosc1:=0;
  rec.w1a:=0;
  rec.w1b:=0;
end;

procedure TForm1.mplayer2Pause(Sender: TObject);
begin
  plProgressBar2.Position:=mplayer2.SingleMpToInteger(mplayer2.Position);
  Label30.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer2.SingleMpToTime(mplayer2.Position));
end;

procedure TForm1.mplayer2Playing(ASender: TObject; APosition, ADuration: single
  );
var
  pom: single;
begin
  if Label31.Caption='--:--:--.---' then
  begin
    pom:=mplayer2.Duration;
    if pom<1 then exit;
    Label31.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer2.SingleMpToTime(pom));
    Label45.Caption:=Label31.Caption;
    plProgressBar2.Max:=mplayer2.SingleMpToInteger(pom);
    rec.dlugosc2:=plProgressBar2.Max;
  end;
  plProgressBar2.Position:=mplayer2.SingleMpToInteger(APosition);
  Label30.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer2.SingleMpToTime(APosition));
  GlobalRefresh;
end;

procedure TForm1.mplayer2Stop(Sender: TObject);
begin
  plProgressBar2.Position:=0;
  Label30.Caption:='--:--:--.---';
  Label31.Caption:='--:--:--.---';
  Label45.Caption:='';
  rec.dlugosc2:=0;
  rec.w2a:=0;
  rec.w2b:=0;
end;

procedure TForm1.plProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pom: single;
begin
  mplayer1.SetPositionEx(X,plProgressBar1.Width);
  if mplayer1.Paused then;
  begin
    pom:=mplayer1.Position;
    poz1:=pom;
    plProgressBar1.Position:=mplayer1.SingleMpToInteger(pom);
    Label28.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer1.SingleMpToTime(pom));
    if RadioButton1.Checked then plProgressBar3.Position:=plProgressBar1.Position;
  end;
end;

procedure TForm1.plProgressBar2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pom: single;
begin
  mplayer2.SetPositionEx(X,plProgressBar2.Width);
  if mplayer2.Paused then;
  begin
    pom:=mplayer2.Position;
    poz2:=pom;
    plProgressBar2.Position:=mplayer2.SingleMpToInteger(pom);
    Label30.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer2.SingleMpToTime(pom));
    if RadioButton2.Checked then plProgressBar3.Position:=plProgressBar2.Position;
  end;
end;

procedure TForm1.plProgressBar3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pom: single;
begin
  if RadioButton1.Checked then
  begin
    mplayer1.SetPositionEx(X,plProgressBar3.Width);
    if mplayer1.Paused then;
    begin
      pom:=mplayer1.Position;
      poz1:=pom;
      plProgressBar1.Position:=mplayer1.SingleMpToInteger(pom);
      plProgressBar3.Position:=plProgressBar1.Position;
      Label28.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer1.SingleMpToTime(pom));
    end;
  end else begin
    mplayer2.SetPositionEx(X,plProgressBar3.Width);
    if mplayer2.Paused then;
    begin
      pom:=mplayer2.Position;
      poz2:=pom;
      plProgressBar2.Position:=mplayer2.SingleMpToInteger(pom);
      plProgressBar3.Position:=plProgressBar2.Position;
      Label30.Caption:=FormatDateTime('hh:nn:ss.zzz',mplayer2.SingleMpToTime(pom));
    end;
  end;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
var
  proc: TProcess;
  s,s2: string;
begin
  if RadioButton1.Checked then
  begin
    s:=ChangeFileExt(Label36.Caption,'.wav');
    s2:='źródłowego';
  end else begin
    s:=ChangeFileExt(Label37.Caption,'.wav');
    s2:='docelowego';
  end;
  if not mess.ShowConfirmationYesNo('Audio z pliku '+s2+' zostanie zapisane pod podaną nazwą:^'+s+'^^Kontynuować?') then exit;
  application.ProcessMessages;
  proc:=TProcess.Create(self);
  try
    proc.Options:=[poWaitOnExit,poUsePipes,poStderrToOutPut,poNoConsole];
    proc.ShowWindow:=swoHIDE;
    proc.Executable:='ffmpeg';
    proc.Parameters.Add('-i');
    if RadioButton1.Checked then proc.Parameters.Add(Label36.Caption) else proc.Parameters.Add(Label37.Caption);
    proc.Parameters.Add('-vn');
    if ComboBox2.ItemIndex>0 then proc.Parameters.Add('-ac');
    case ComboBox2.ItemIndex of
      1: proc.Parameters.Add('2');
      2: proc.Parameters.Add('1');
    end;
    proc.Parameters.Add('-y');
    proc.Parameters.Add(s);
    proc.Execute;
  finally
    proc.Terminate(0);
    proc.Free;
  end;
  mess.ShowInformation('Plik został zapisany.');
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
var
  f: file of TARC;
  a: TARC;
  s1,s2: string;
begin
  if OpenDialog2.Execute then
  begin
    s1:=Label36.Caption;
    s2:=Label37.Caption;
    (* odczyt *)
    assignfile(f,OpenDialog2.FileName);
    reset(f,1);
    read(f,a);
    closefile(f);
    (* odczyt danych *)
    Label36.Caption:=a.film_docelowy;
    Label37.Caption:=a.film_zrodlowy;
    rec.dlugosc1:=a.dlugosc1;
    rec.dlugosc2:=a.dlugosc2;
    rec.dlugosc3:=a.dlugosc3;
    rec.w1a:=a.w1a;
    rec.w1b:=a.w1b;
    rec.w2a:=a.w2a;
    rec.w2b:=a.w2b;
    rec.wsp:=a.wsp;
    rec.wsp2:=a.wsp2;
    poz1:=a.poz1;
    poz2:=a.poz2;
    (* wypełnienie kontrolek *)
    Label39.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.dlugosc1));
    Label45.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.dlugosc2));
    Label51.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.dlugosc3));
    Label40.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1a));
    Label43.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1b));
    Label47.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2a));
    Label49.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2b));
    Label53.Caption:=FormatFloat('0.000',a.wsp*100);
    Label55.Caption:=FormatFloat('0.000',a.wsp2*100);
    poz1:=a.poz1;
    poz2:=a.poz2;
    (* odtworzenie struktury multimedialnej *)
    if s1<>a.film_docelowy then
    begin
      if mplayer2.Playing then mplayer2.Pause;
      mplayer1.Stop;
      mplayer1.Filename:=a.film_docelowy;
      mplayer1.Play;
      sleep(1000);
      mplayer1.Position:=a.poz1;
      mplayer1.Pause;
    end;
    if s2<>a.film_zrodlowy then
    begin
      mplayer2.Stop;
      mplayer2.Filename:=a.film_zrodlowy;
      mplayer2.Play;
      sleep(1000);
      mplayer2.Position:=a.poz1;
      mplayer2.Pause;
    end;
    (* przeliczam dane *)
    oblicz;
  end;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
var
  f: file of TARC;
  a: TARC;
begin
  if SaveDialog1.Execute then
  begin
    (* wypełnienie rekordu *)
    a.film_docelowy:=Label36.Caption;
    a.film_zrodlowy:=Label37.Caption;
    a.dlugosc1:=rec.dlugosc1;
    a.dlugosc2:=rec.dlugosc2;
    a.dlugosc3:=rec.dlugosc3;
    a.w1a:=rec.w1a;
    a.w1b:=rec.w1b;
    a.w2a:=rec.w2a;
    a.w2b:=rec.w2b;
    a.wsp:=rec.wsp;
    a.wsp2:=rec.wsp2;
    a.poz1:=poz1;
    a.poz2:=poz2;
    (* zapis *)
    assignfile(f,SaveDialog1.FileName);
    rewrite(f,1);
    write(f,a);
    closefile(f);
  end;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
var
  a: TARC;
  s1,s2: string;
begin
  (* zamiana miejscami tego co jest *)
  s2:=Label36.Caption;
  s1:=Label37.Caption;
  Label36.Caption:=s1;
  Label37.Caption:=s2;
  rec.dlugosc1:=a.dlugosc1;
  rec.dlugosc2:=a.dlugosc2;
  rec.w1a:=a.w1a;
  rec.w1b:=a.w1b;
  rec.w2a:=a.w2a;
  rec.w2b:=a.w2b;
  rec.wsp:=a.wsp;
  rec.wsp2:=a.wsp2;
  poz1:=a.poz1;
  poz2:=a.poz2;
  (* wypełnienie kontrolek *)
  Label39.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.dlugosc1));
  Label45.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.dlugosc2));
  Label40.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1a));
  Label43.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1b));
  Label47.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2a));
  Label49.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2b));

  poz1:=a.poz1;
  poz2:=a.poz2;
  (* odtworzenie struktury multimedialnej *)
  if s1<>a.film_docelowy then
  begin
    if mplayer2.Playing then mplayer2.Pause;
    mplayer1.Stop;
    mplayer1.Filename:=a.film_docelowy;
    mplayer1.Play;
    sleep(1000);
    mplayer1.Position:=a.poz1;
    mplayer1.Pause;
  end;
  if s2<>a.film_zrodlowy then
  begin
    mplayer2.Stop;
    mplayer2.Filename:=a.film_zrodlowy;
    mplayer2.Play;
    sleep(1000);
    mplayer2.Position:=a.poz1;
    mplayer2.Pause;
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  rec.w1a:=mplayer1.SingleMpToInteger(mplayer1.Position);
  rec.w2a:=mplayer2.SingleMpToInteger(mplayer2.Position);
  Label40.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1a));
  Label47.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2a));
  oblicz;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  rec.w1b:=mplayer1.SingleMpToInteger(mplayer1.Position);
  rec.w2b:=mplayer2.SingleMpToInteger(mplayer2.Position);
  Label43.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w1b));
  Label49.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(rec.w2b));
  oblicz;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
var
  proc: TProcess;
  s,s2: string;
  bb: boolean;
  a,b: integer;
begin
  if RadioButton1.Checked then
  begin
    s:=ChangeFileExt(Label36.Caption,'.wav');
    s2:='źródłowego';
  end else begin
    s:=ChangeFileExt(Label37.Caption,'.wav');
    s2:='docelowego';
  end;
  if not mess.ShowConfirmationYesNo('Audio z pliku '+s2+' zostanie zapisane pod podaną nazwą:^'+s+'^^Kontynuować?') then exit;
  bb:=mess.ShowConfirmationYesNo('Niepotrzebny początek pliku audio zostanie wycięty.^Czy ma być wycięta niepotrzebna końcówka tego pliku?');
  application.ProcessMessages;
  (* obliczenia wycięć *)
  a:=round(((rec.w2a/rec.wsp)-rec.w1a)*rec.wsp);
  if a<0 then a:=0;
  b:=round((((rec.w2a/rec.wsp)-rec.w1a)+rec.dlugosc1)*rec.wsp);
  (* ekstrakcja *)
  proc:=TProcess.Create(self);
  try
    proc.Options:=[poWaitOnExit,poUsePipes,poStderrToOutPut,poNoConsole];
    proc.ShowWindow:=swoHIDE;
    proc.Executable:='ffmpeg';
    proc.Parameters.Add('-i');
    if RadioButton1.Checked then proc.Parameters.Add(Label36.Caption) else proc.Parameters.Add(Label37.Caption);
    proc.Parameters.Add('-vn');
    if ComboBox2.ItemIndex>0 then proc.Parameters.Add('-ac');
    case ComboBox2.ItemIndex of
      1: proc.Parameters.Add('2');
      2: proc.Parameters.Add('1');
    end;
    proc.Parameters.Add('-ss');
    proc.Parameters.Add(FormatDateTime('hh:nn:ss.zzz',IntegerToTime(a)));
    if bb then
    begin
      proc.Parameters.Add('-to');
      proc.Parameters.Add(FormatDateTime('hh:nn:ss.zzz',IntegerToTime(b)));
    end;
    proc.Parameters.Add('-y');
    proc.Parameters.Add(s);
    proc.Execute;
  finally
    proc.Terminate(0);
    proc.Free;
  end;
  mess.ShowInformation('Plik został zapisany.');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=false;
  if mplayer1.Playing then mplayer1.Pause;
  if mplayer2.Playing then mplayer2.Pause;
end;

procedure TForm1._GLOBAL_REFRESH(Sender: TObject);
begin
  GlobalRefresh;
end;

procedure TForm1._PLAY(Sender: TObject);
begin
  if TSpeedButton(Sender).Tag=1 then
  begin
    if mplayer2.Playing then mplayer2.Pause;
    if not mplayer1.Running then mplayer1.Play else if mplayer1.Paused then mplayer1.Replay;
  end else begin
    if mplayer1.Playing then mplayer1.Pause;
    if not mplayer2.Running then mplayer2.Play else if mplayer2.Paused then mplayer2.Replay;
  end;
end;

procedure TForm1._PAUSE(Sender: TObject);
begin
  if TSpeedButton(Sender).Tag=1 then
  begin
    if mplayer1.Playing then mplayer1.Pause;
  end else begin
    if mplayer2.Playing then mplayer2.Pause;
  end;
end;

procedure TForm1._OpenFilm(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if TSpeedButton(Sender).Tag=1 then
    begin
      poz1:=0;
      Label36.Caption:=OpenDialog1.FileName;
      if mplayer2.Playing then mplayer2.Pause;
      if mplayer1.Running then mplayer1.Stop;
      mplayer1.Filename:=OpenDialog1.FileName;
      mplayer1.Play;
    end else begin
      poz2:=0;
      Label37.Caption:=OpenDialog1.FileName;
      if mplayer1.Playing then mplayer1.Pause;
      if mplayer2.Running then mplayer2.Stop;
      mplayer2.Filename:=OpenDialog1.FileName;
      mplayer2.Play;
    end;
  end;
end;

procedure TForm1._OBLICZENIA(Sender: TObject);
begin
  oblicz;
end;

procedure TForm1.GlobalRefresh;
begin
  if RadioButton1.Checked then
  begin
    if not mplayer1.Running then exit;
    plProgressBar3.Max:=plProgressBar1.Max;
    plProgressBar3.Position:=plProgressBar1.Position;
  end else begin
    if not mplayer2.Running then exit;
    plProgressBar3.Max:=plProgressBar2.Max;
    plProgressBar3.Position:=plProgressBar2.Position;
  end;
end;

procedure TForm1.play_opoznienie(aSeconds: integer);
begin
  Timer1.Interval:=aSeconds*1000;
  if RadioButton1.Checked then
  begin
    if mplayer2.Playing then mplayer2.Pause;
    mplayer1.Position:=poz1;
    if not mplayer1.Running then mplayer1.Play else if mplayer1.Paused then mplayer1.Replay;
    Timer1.Enabled:=true;
  end else begin
    if mplayer1.Playing then mplayer1.Pause;
    mplayer2.Position:=poz2;
    if not mplayer2.Running then mplayer2.Play else if mplayer2.Paused then mplayer2.Replay;
    Timer1.Enabled:=true;
  end;
end;

procedure TForm1.play_pause;
begin
  if RadioButton1.Checked then
  begin
    if mplayer2.Playing then mplayer2.Pause;
    if not mplayer1.Running then mplayer1.Play else if mplayer1.Paused then mplayer1.Replay else mplayer1.Pause;
  end else begin
    if mplayer1.Playing then mplayer1.Pause;
    if not mplayer2.Running then mplayer2.Play else if mplayer2.Paused then mplayer2.Replay else mplayer2.Pause;
  end;
end;

procedure TForm1.play_seek(aDoPrzodu: boolean);
var
  v,a: single;
begin
  case ComboBox1.ItemIndex of
    0: v:=0.025;
    1: v:=0.050;
    2: v:=0.100;
    3: v:=0.250;
    4: v:=0.500;
    5: v:=1;
    6: v:=5;
    7: v:=10;
  end;
  if not aDoPrzodu then v:=v*(-1);
  if RadioButton1.Checked then
  begin
    if not mplayer1.Running then exit;
    if mplayer1.Playing then a:=mplayer1.GetPositionOnlyRead else a:=mplayer1.Position;
    a:=a+v;
    if a<0 then a:=0;
    poz1:=a;
    mplayer1.Position:=a;
  end else begin
    if not mplayer2.Running then exit;
    if mplayer2.Playing then a:=mplayer2.GetPositionOnlyRead else a:=mplayer2.Position;
    a:=a+v;
    if a<0 then a:=0;
    poz2:=a;
    mplayer2.Position:=a;
  end;
end;

procedure TForm1.oblicz;
var
  d1,d2,e1,e2: integer;
  a1,a2: integer;
  b1,b2: integer;
  w,w2: double;
  d: integer;
  t: TTime;
  h,m,s,ms: word;
begin
  try
    (* podstawienie pod zmienne *)
    d1:=rec.dlugosc1;
    d2:=rec.dlugosc2;
    a1:=rec.w1a;
    a2:=rec.w2a;
    b1:=rec.w1b;
    b2:=rec.w2b;
    (* obliczam długości fragmentów *)
    e1:=b1-a1;
    e2:=b2-a2;
    (* obliczam współczynnik długości wektorów *)
    w:=e2/e1;
    w2:=e1/e2;
    (* obliczam nową długość filmu źródłowego *)
    d:=round(d2/w);
    (* podstawiam dane *)
    rec.wsp:=w;
    rec.wsp2:=w2;
    rec.dlugosc3:=d;
    Label51.Caption:=FormatDateTime('hh:nn:ss.zzz',IntegerToTime(d));
    Label53.Caption:=FormatFloat('0.00000000',w*100);
    Label55.Caption:=FormatFloat('0.00000000',w2*100);
    //uELED1.Active:=false;
  except
    //uELED1.Active:=true;
  end;
end;

end.

