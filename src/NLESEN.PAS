unit Nlesen;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, Tmfcntnr, Tgrphgrd, TAufgdta,
	TPressbt, TColBtn, Townlabl, Palette, tools, TNoten, Basis;

type
	TNoten_Lesen_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure initialisierung;
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		Richtige_Antwort:Integer;
		ad:TAufgabenData;
		Noten_name:TOwnLabel;
		Noten:Array[1..4] of TNotenSys;
		bild: TMetaFile;
		PlayNote:Integer;
		procedure ziehen(Sender: TObject);
		procedure PlayKnopfClick(Sender: TObject);
		procedure hilfeknopfClick(Sender: TObject);
		procedure nochmalknopfClick(Sender: TObject);
		procedure endeknopfClick(Sender: TObject);
	end;

var	Noten_Lesen_Form: TNoten_Lesen_Form;

implementation
{$R *.DFM}

procedure TNoten_Lesen_Form.FormCreate(Sender: TObject);
var	i, j:Integer;
begin
	inherited FormCreate(Sender);
	load_bg_image('musik_1.wmf');
	Noten_Name:= TOwnLabel.Create(Self);
	Noten_Name.Parent := Self;
	Noten_Name.FontName := 'Arial';
	Noten_Name.FontSize := Sca_x(70);
	Noten_Name.SetBounds(Sca_x(250), Sca_y(46), Sca_x(300), Sca_y(116));
	HGBild.Canvas.Font.Color := $0282bc8c;
	Noten[1] := TnotenSys.Create(Self, sca_x(170), sca_y(211), sca_x(200),
	  sca_x(150), 1, path+'grafik\Musik\');
	HGBild.Canvas.TextOut(sca_x(134), sca_y(256), '1');
	Noten[2] := TnotenSys.Create(Self, sca_x(450), sca_y(211), sca_x(200),
	  sca_x(150), 1, path+'grafik\Musik\');
	HGBild.Canvas.TextOut(sca_x(411), sca_y(256), '2');
	Noten[3] := TnotenSys.Create(Self, sca_x(170), sca_y(386), sca_x(200),
	  sca_x(150), 1, path+'grafik\Musik\');
	HGBild.Canvas.TextOut(sca_x(134), sca_y(431), '3');
	Noten[4] := TnotenSys.Create(Self, sca_x(450), sca_y(386), sca_x(200),
	  sca_x(150), 1, path+'grafik\Musik\');
	HGBild.Canvas.TextOut(sca_x(411), sca_y(431), '4');
	For i := 1 to 4 do
	begin
		Noten[i].Tag := i;
		Noten[i].Parent := Self;
		Noten[i].onclick := ziehen;
	end;
	ad:=TAufgabenData.Create_Load(Self,path+'aufgaben.txt','Noten_Lesen');
	ad.RandListStart(ad.RAwList.count - 2);
	musicButton.show;
	nextButton.Onclick := nochmalknopfClick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	musicButton.Onclick := PlayKnopfClick;
	color := $00ffffff;
	Initialisierung;
end;

procedure TNoten_Lesen_Form.Initialisierung;
var	i:Integer;
	Notensys_belegt:Array[1..4]of Integer;
Begin
	for i := 1 to 4 do
	begin
		Notensys_belegt[i] := ad.rand;
		Noten[i].ResetNotes;
	end;
	Richtige_Antwort := Random(4)+1;
	Noten[Richtige_Antwort].AddNote(0, strtoint(ad.GetDat(
	  Notensys_belegt[Richtige_Antwort], 2)), strtoint(
	  ad.GetDat(Notensys_belegt[Richtige_Antwort], 3)), FALSE);
	Noten_Name.SetCaption(ad.GetDat(Notensys_belegt[Richtige_Antwort], 1));
	PlayNote := strtoint (ad.GetDat(Notensys_belegt[Richtige_Antwort], 4));
	for i := 1 to 4 do
	begin
		Noten[i].AddNote(0, strtoint(ad.GetDat(Notensys_belegt[i], 2)),
		  strtoint(ad.GetDat(Notensys_belegt[i], 3)), FALSE);
		Noten[i].Isenabled := true;
		Noten[i].clickable := true;
		Noten[i].demark;
		Noten[i].Paint;
	end;
	Aufgabe_Laeuft:=TRUE;
        schonhilfegegeben:=false;
end;

procedure TNoten_Lesen_Form.ziehen(Sender: TObject);
var	i:Integer;
begin
	if Aufgabe_Laeuft then
		if (Sender as TNotenSys).Tag = Richtige_Antwort then
		begin
			playsound(snd_richtig);
			For i := 1 to 4 do
			begin
				If i <> Richtige_Antwort then
					Noten[i].Isenabled := false;
				Noten[i].Clickable := false;
			end;
			Aufgabe_Laeuft:=false;
		end
		else
			playsound(snd_falsch);
end;

procedure TNoten_Lesen_Form.hilfeknopfClick(Sender: TObject);
begin
	if (Aufgabe_Laeuft and not(schonhilfegegeben)) then
		if ((Noten[Richtige_Antwort].unpressed) and
		  (Noten[Richtige_Antwort].enabled)) then
		begin
			playsound(SND_HILFE);
                        schonhilfegegeben:=true;
			Noten[Richtige_Antwort].mark;
		end;
end;

procedure TNoten_Lesen_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	initialisierung;
end;

procedure TNoten_Lesen_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TNoten_Lesen_Form.FormClose(Sender: TObject;
var	Action: TCloseAction);
begin
	ad.Free;
	inherited FormClose(Sender, Action);
end;

procedure TNoten_Lesen_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	case Key of
	'1'..'4':
		ziehen(Noten[strtoint(Key)]);
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

procedure TNoten_Lesen_Form.PlayKnopfClick(Sender: TObject);
begin
	NotenPlayer.PlayNote(PlayNote);
end;

end.
