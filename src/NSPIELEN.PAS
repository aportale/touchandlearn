unit Nspielen;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, Tmfcntnr, Tgrphgrd, TAufgdta, 
	TPressbt, TColBtn, Townlabl, tools, TNoten, TKBOARD, MPlayer, 
	TNotPlay, Musik, Basis;

type
	TNoten_Spielen_Form = class(TBasis_Form)
		procedure initialisierung;
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		ad:TAufgabenData;
		KeyBoard:TKeyBoard;
		Richtige_Antwort:Array[1..3]of Integer;
		AktTeilSchritt:Integer;
		Noten:TNotenSys;
		procedure ziehen(Sender: TObject);
		procedure nochmalknopfClick(Sender: TObject);
		procedure hilfeknopfClick(Sender: TObject);
		procedure endeknopfClick(Sender: TObject);
		procedure PlayKnopfClick(Sender: TObject);
	published
		property enabled;
	end;

var	Noten_Spielen_Form: TNoten_Spielen_Form;

implementation
{$R *.DFM}

procedure TNoten_Spielen_Form.FormCreate(Sender: TObject);
begin
	inherited FormCreate(Sender);
	Load_BG_Image('musik_2.wmf');
	ad := TAufgabenData.Create_Load(Self, path + 'aufgaben.txt', 
	  'Noten_Spielen');
	ad.RandListStart(ad.RAwList.count div 2);
	Keyboard := TKeyboard.Create_Set(Self, NotenPlayer,
	  sca_x(120), sca_y(258), sca_x(559) , sca_y(294));

	Keyboard.Parent := Self;
	KeyBoard.KeyFilterActive := TRUE;
	Noten:= TNotenSys.Create(Self, sca_x(133), sca_y(49), sca_x(535),
	  sca_y(175), 3, path+'Grafik\Musik\');

	Noten.Parent := Self;
	Noten.Clickable := FALSE;
	KeyBoard.Onclick := Ziehen;
	musicButton.show;
	nextButton.Onclick := nochmalknopfClick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	musicButton.Onclick := PlayKnopfClick;
	Initialisierung;
end;

procedure TNoten_Spielen_Form.FormClose(Sender: TObject; 
  var Action: TCloseAction);
begin
	ad.Free;
	inherited FormClose(Sender, Action);
end;

procedure TNoten_Spielen_Form.initialisierung;
var	Zufallszahl, i:Integer;
	NotenData:TNotenData;
Begin
	Noten.ResetNotes;
	Zufallszahl := ad.rand;
	AktTeilSchritt := 1;
	for i := 0 to 2 do
	begin
		NotenData := KeytoNotenData(strtoint(ad.getdat(Zufallszahl, 
		  (i+1))));
		Noten.AddNote(i, NotenData.Zeile, NotenData.Wichtung, FALSE);
		Richtige_Antwort[i+1] := strtoint(ad.getdat(Zufallszahl, 
		  (i+1)));
	end;
	Noten.markiereSpalte(0);
	Noten.Paint;
	KeyBoard.MarkButton(-1, FALSE, TRUE);
	KeyBoard.Isenabled := true;
	KeyBoard.Clickable := true;
	KeyBoard.KeyFilter := Richtige_Antwort[AktTeilSchritt]
end;

procedure TNoten_Spielen_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	initialisierung;
end;

procedure TNoten_Spielen_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TNoten_Spielen_Form.hilfeknopfClick(Sender: TObject);
begin
	If KeyBoard.enabled and 
	  (KeyBoard.KbButton[Richtige_Antwort[AktTeilSchritt]].unpressed) then
	begin
		playsound(SND_HILFE);
		KeyBoard.markButton(Richtige_Antwort[AktTeilSchritt], 
		  TRUE, TRUE);
	end;
end;

procedure TNoten_Spielen_Form.ziehen(Sender: TObject);
begin
	if Keyboard.Clickable then
	begin
		if KeyBoard.LastPressedKey = Richtige_Antwort[AktteilSchritt] then
		begin
			inc(AktTeilSchritt);
			KeyBoard.KeyFilter := Richtige_Antwort[AktTeilSchritt];
			Noten.markiereSpalte(AktTeilSchritt-1);
		end
		else
			playsound(snd_falsch);
		if AktteilSchritt = 4 then
		begin
			playsound(snd_richtig);
			KeyBoard.Isenabled := false;
			KeyBoard.Clickable := False;
		end;
	end;
end;

procedure TNoten_Spielen_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	case Key of
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

procedure TNoten_Spielen_Form.PlayKnopfClick(Sender: TObject);
var	i:Integer;
begin
	for i := 1 to 3 do
		NotenPlayer.PlayNote(Richtige_Antwort[i]);
end;

end.
