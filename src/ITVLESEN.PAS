unit Itvlesen;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, Tmfcntnr, Tgrphgrd, TAufgdta,
	TPressbt, TColBtn, Townlabl, Palette, tools, TNoten, Basis;

type
	TIntervalle_Lesen_Form = class(TBasis_Form)
		procedure initialisierung;
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		Richtige_Antwort:Integer;
		PlayNote:Array[1..2] of Integer;
		ad:TAufgabenData;
		Noten:TNotenSys;
		bild: TMetaFile;
		knopf: array [1..3] of TColorButton;
		procedure ziehen(Sender: TObject);
		procedure nochmalknopfClick(Sender: TObject);
		procedure hilfeknopfClick(Sender: TObject);
		procedure endeknopfClick(Sender: TObject);
		procedure PlayKnopfClick(Sender: TObject);
	end;
var	Intervalle_Lesen_Form: TIntervalle_Lesen_Form;

implementation
{$R *.DFM}

procedure TIntervalle_Lesen_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	inherited Formcreate(Sender);
	load_bg_Image('beschrft.wmf');
	Noten := TnotenSys.Create(Self, sca_x(129), sca_y(56), sca_x(541),
      sca_y(275), 2, path+'grafik\Musik\');
	Noten.Parent := Self;
	Noten.Clickable := FALSE;
	ad := TAufgabenData.Create_Load(Self, path + 'aufgaben.txt', 
	  'Intervalle_Lesen');
	ad.RandListStart(ad.RAwList.count - 2);
	setbkmode(HGBild.Canvas.Handle, 1);
	For i := 1 to 3 do
	begin
		knopf[i] := TColorButton.Create(Self);
		with knopf[i] do
		begin
			BackBuffering := TRUE;
			Parent := Self;
			fontsize := sca_x(45);
			fontname := 'Arial';
			onclick := ziehen;
			tag := i;
			SetBounds(sca_x(170), sca_y(346)+(i-1)*sca_y(78),
			  sca_x(460), sca_y(74));
		end;
		HGBild.Canvas.TextOut(sca_x(122), sca_y(356)+(i-1)*sca_y(78),
		  inttostr(i));
	end;
	musicButton.show;
	nextButton.Onclick := nochmalknopfClick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	musicButton.Onclick := PlayKnopfClick;
	Initialisierung;
end;

procedure TIntervalle_Lesen_Form.initialisierung;
Var	ZufallsZahl, i:Integer;
	Aufgabe:Array[1..3]Of Integer;
Begin
	For i := 1 to 3 do
	Begin
		Aufgabe[i] := ad.rand;
		Knopf[i].SetCaption(ad.GetDat(Aufgabe[i], 1));
		Knopf[i].Isenabled:= TRUE;
		Knopf[i].Clickable:= TRUE;
		Knopf[i].demark;
	end;
	Richtige_Antwort := Random(3)+1;
	Noten.ResetNotes;
	Noten.AddNote(0, strtoint(ad.GetDat(Aufgabe[Richtige_Antwort],2)),
	  0,FALSE);
	Noten.AddNote(1,strtoint(ad.GetDat(Aufgabe[Richtige_Antwort],3)),
	  0,TRUE);
	PlayNote[1] := strtoint(ad.GetDat(Aufgabe[Richtige_Antwort], 4));
	PlayNote[2] := strtoint(ad.GetDat(Aufgabe[Richtige_Antwort], 5));
	Aufgabe_Laeuft:=True;
        schonhilfegegeben:=false;
End;

procedure TIntervalle_Lesen_Form.ziehen(Sender: TObject);
var	i:Integer;
begin
	if Aufgabe_Laeuft then
		if (Sender as TColorButton).Tag = Richtige_Antwort then
		begin
			playsound(snd_richtig);
			For i := 1 to 3 do
			begin
				Knopf[i].demark;
				if i <> Richtige_Antwort then
					Knopf[i].Isenabled:= false;
				Knopf[i].Clickable:= false;
			end;
			Aufgabe_Laeuft:=false;
		end
		else
			playsound(snd_falsch);
end;

procedure TIntervalle_Lesen_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	initialisierung;
end;

procedure TIntervalle_Lesen_Form.hilfeknopfClick(Sender: TObject);
begin
	if Aufgabe_Laeuft and not(schonhilfegegeben) then
	begin
		playsound(SND_HILFE);
                schonhilfegegeben:=true;
		Knopf[Richtige_Antwort].mark;
	end;
end;

procedure TIntervalle_Lesen_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TIntervalle_Lesen_Form.FormClose(Sender: TObject;
var	Action: TCloseAction);
begin
	ad.Free;
	inherited FormClose(Sender, Action);
end;

procedure TIntervalle_Lesen_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	case Key of
	'1'..'3':
		ziehen(Knopf[strtoint(Key)]);
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

procedure TIntervalle_Lesen_Form.PlayKnopfClick(Sender: TObject);
begin
	NotenPlayer.PlayNote(PlayNote[1]);
	NotenPlayer.PlayNote(PlayNote[2]);
end;

end.
