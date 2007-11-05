unit Buchstb;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, TAufgdta, TPressbt, TColBtn, 
	Townlabl, Palette, tools, townimg, Basis;

type
	TBuchstaben_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure initialisierung;
		procedure nochmalknopfClick(Sender: TObject);
		procedure endeknopfClick(Sender: TObject);
		procedure hilfeknopfClick(Sender: TObject);
		procedure ziehen(Sender: Tobject);
		procedure flaechefaerben(nr: Integer);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		function stringsort(istr:STRING):STRING;
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		VorherigeWortLaenge: Integer;
		VGBild:TownImage;
		schonhilfegegeben :boolean;
		knopf: array [1..10] of TColorButton;
		flaeche: array[1..10] of TOwnLabel;
		wortindex: Integer;
		ad: TAufgabenData;
		ParamsKnopf, ParamsFlaeche:Array[1..4] of Integer;
	end;

var	Buchstaben_Form: TBuchstaben_Form;

implementation
var	wort:String[10];
	akt_buchstabe:Integer;
{$R *.DFM}

procedure TBuchstaben_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	inherited FormCreate(Sender);
	Load_BG_Image('Buchstb.wmf');
	VGBild:= TOwnImage.Create_Setup(Self, sca_x(130), sca_y(111),
	  sca_x(540), sca_y(378));
        VGBild.Parent := Self;
	ad := TAufgabenData.Create_Load(Self,path+'aufgaben.txt',
	  'Buchstabensalat');
	ad.RandListStart(ad.RAwList.count - 2);

	for i := 1 to 10 do
	begin
		knopf[i] := TColorButton.Create(Self);
		with knopf[i] do
		begin
			Parent := Self;
			OnClick := ziehen;
			fontsize := sca_x(40);
			fontname := 'Arial';
		end;
		flaeche[i] := TOwnLabel.Create(Self);
		with flaeche[i] do
		begin
			Parent := Self;
			fontsize := sca_x(49);
			fontname := 'Arial';
		end;
	end;
	nextButton.Onclick := nochmalknopfclick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	VorherigeWortLaenge := 0;
	schonhilfegegeben := FALSE;
	ParamsKnopf[2] := sca_y(495);
	ParamsKnopf[3] := sca_x(74);
	ParamsKnopf[4] := sca_y(74);
	ParamsFlaeche[2] := sca_y(31);
	ParamsFlaeche[3] := sca_x(76);
	ParamsFlaeche[4] := sca_y(76);
	initialisierung;
end;

function TBuchstaben_Form.stringsort(istr:STRING):STRING;
var	i, j:INTEGER;
	hilfe:Char;
begin
	for i := length(istr)-1 downto 1 do
		for j := 1 to i do
			if upcase(istr[j]) > Upcase(istr[j+1]) then
			begin
				hilfe := istr[j];
				istr[j] := istr[j+1];
				istr[j+1] := hilfe;
			end;
	stringsort := istr;
end;

procedure TBuchstaben_Form.initialisierung;
var	i:Integer;
	mixwort:String;
	zufallszahl:Integer;
begin
	schonhilfegegeben := FALSE;
	zufallszahl := ad.rand;
	wort := ad.GetDat(zufallszahl, 1);
	mixwort := stringsort(wort);
	akt_buchstabe := 1;
	if VorherigeWortLaenge <> length(wort) then
		for i := 1 to 10 do
		begin
			knopf[i].hide;
			flaeche[i].hide;
		end;
	VorherigeWortLaenge := length(wort);
	ParamsKnopf[1] := (sca_x(403)-VorherigeWortLaenge*sca_x(40));
	ParamsFlaeche[1] := (sca_x(402)-VorherigeWortLaenge*sca_x(40));
	flaechefaerben(1);
	for i := 1 to VorherigeWortLaenge do
	begin
		with knopf[i] do
		begin
			setbounds(ParamsKnopf[1] +(i-1)*sca_x(80),
			  ParamsKnopf[2], ParamsKnopf[3], ParamsKnopf[4]);
			SetCaption(mixwort[i]);
			demark;
			IsEnabled := true;
			Clickable := True;
			show;
		end;
		with flaeche[i] do
		begin
			setbounds(ParamsFlaeche[1]+(i-1)*sca_x(80),
			  ParamsFlaeche[2],ParamsFlaeche[3], ParamsFlaeche[4]);
			SetCaption('');
			Text := wort[i];
			show;
		end;
	end;
	VGbild.LoadGraphic(path + 'grafik\bilder\buchstab\' +
	  ad.GetDat(zufallszahl, 2));
	Aufgabe_Laeuft:=True;
end;

procedure TBuchstaben_Form.flaechefaerben(nr: Integer);
var	i:Integer;
begin
	for i := 1 to length(wort) do
		if i <> nr then
			flaeche[i].demark
		else
			flaeche[i].mark;
end;

procedure TBuchstaben_Form.ziehen(Sender: TObject);
var	i:Integer;
begin
	if Aufgabe_Laeuft and (Sender as TColorButton).Clickable then
		if(wort[akt_buchstabe]=(Sender as TColorButton).caption) then
		begin
			for i := 1 to length(wort) do
				Knopf[i].demark;
			if akt_buchstabe = length(wort) then
			begin
				playsound(SND_RICHTIG);
				Aufgabe_Laeuft:=FALSE;
			end
			else
			begin
				playsound(SND_SCHRITT_RICHTIG);
			end;
			flaeche[akt_buchstabe].setcaption(wort[akt_buchstabe]);
			inc(akt_buchstabe);
			flaechefaerben(akt_buchstabe);
			(Sender as TColorButton).Isenabled := false;
			(Sender as TColorButton).Clickable := false;
			schonhilfegegeben := FALSE;
		end
		else
			playsound(SND_FALSCH);
end;

procedure TBuchstaben_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	initialisierung;
end;

procedure TBuchstaben_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TBuchstaben_Form.hilfeknopfClick(Sender: TObject);
var 	i:Integer;
begin
	if not(schonhilfegegeben) and Aufgabe_Laeuft then
		For i := 1 to length(wort) do
			if (wort[akt_buchstabe] = Knopf[i].caption) and 
			  Knopf[i].Isenabled and not(Knopf[i].highlighted) then
			begin
				playsound(SND_HILFE);
				Knopf[i].mark;
				schonhilfegegeben := TRUE;
				break; {nur einen knopf markieren (nicht mehrere)}
			end;
end;

procedure TBuchstaben_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	ad.Destroy;
	inherited FormClose(Sender, Action);
end;

procedure TBuchstaben_Form.FormKeyPress(Sender: TObject; var Key: Char);
var	i:Integer;
begin
	case Key of
	'A'..'Z', 'a'..'z':
		For i := 1 to length(wort) do
			if (upcase(Key) = upcase(Knopf[i].caption[1])) and 
			  Knopf[i].Isenabled then
			begin
				ziehen(Knopf[i]);
				break;
			end;
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

end.
