unit Rechnen;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, Tmfcntnr, Tgrphgrd, TAufgdta,
	TPressbt, TColBtn, Townlabl, tools, Basis;

type
	TRechnen_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure Init(Spalten, Zeilen, AAufgabenTyp:Integer);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
        	schonhilfegegeben:boolean;
		operanden_str:String[6];
		operanden_str_pos, max_nummer, Aufgabentyp:Integer;
		Button:Array[0..9] OF TColorButton;
		flaeche:Array[1..6] of TOwnLabel;
		GraphicGrid:Array[1..3] of TGraphicGrid;
		WMFContainer:TMetaFileContainer;
		ad:TAufgabenData;
		procedure hilfeknopfClick(Sender: TObject);
		procedure nochmalknopfClick(Sender: TObject);
		procedure cursor_weiter;
		procedure FlaecheFaerben(nr:Integer);
		procedure endeknopfClick(Sender: TObject);
		procedure ziehen(Sender: TObject);
		procedure Neue_Aufgabe;
	public
		wert:Integer;
	end;

var	Rechnen_Form: TRechnen_Form;

implementation
{$R *.DFM}

procedure TRechnen_Form.FormCreate(Sender: TObject);
var	i, j:Integer;
begin
	inherited FormCreate(Sender);
	Load_BG_Image('rechnen.wmf');
	ad := TAufgabenData.Create_Load(Self, path + 'aufgaben.txt',
	  'Rechnenbilder');
	ad.RandListStart(1);
	For i := 0 to 9 do
	begin
		Button[i] := TColorButton.Create(Self);
		Button[i].Parent := Self;
		Button[i].SetCaption(IntToStr((i+1)  mod 10));
		Button[i].fontsize := sca_x(52);
		Button[i].fontname := 'Arial';
		Button[i].SetBounds(i*sca_x(75)+sca_X(26), sca_y(492), sca_x(71), sca_y(86));
		Button[i].onclick := ziehen;
		Button[i].BackBuffering := TRUE;
	end;
	For i := 1 to 6 do
	begin
		Flaeche[i] := TOwnLabel.Create(Self);
		Flaeche[i].Parent := Self;
		Flaeche[i].fontsize := sca_x(56);
		Flaeche[i].fontname := 'Arial';
	end;
	for j := 1 to 3 do
		for i := (j*2)-1 to (j*2) do
		begin
			Flaeche[i].SetBounds((i-1)*sca_x(65)+(j-1)*sca_x(100)+
			  sca_x(105), sca_y(25), sca_y(63), sca_y(76));
			(* (i-1)*sca(x) = Abstand innerhalb der Zweiergruppen
			   (j-1)*sca(x) = Abstand zwischen den Zweiergruppen  *)
		end;
		nextButton.OnClick := nochmalknopfclick;
		exitButton.Onclick := endeknopfclick;
		helpButton.Onclick := hilfeknopfclick;
end;

procedure TRechnen_Form.Init(Spalten, Zeilen, AAufgabenTyp:Integer);
var	i:Integer;
begin
	AufgabenTyp := AAufgabenTyp;
	WMFContainer := TMetaFileContainer.Create(Self);
	For i := 1 to 3 do
	begin
		GraphicGrid[i]:= TGraphicGrid.Create_Setup(Self,sca_x(230)*
		  (i-1)+sca_x(107), sca_y(134), sca_x(126), sca_y(329),
                  Spalten, Zeilen, WMFContainer);
		GraphicGrid[i].Parent := Self;
	end;
	max_nummer := Spalten * Zeilen;
	HGBild.Canvas.Brush.Color := clBlack;
	HGBild.Canvas.FillRect(rect(Sca_x(485), sca_y(260), sca_x(545),
	  sca_Y(270)));
	HGBild.Canvas.FillRect(rect(Sca_x(485), sca_Y(290), sca_x(545),
	  sca_y(300)));
	if AufgabenTyp = 1 then	{Addition}
	begin
		HGBild.Canvas.FillRect(rect(Sca_x(279),sca_Y(250),
		  sca_x(289), sca_y(310)));
		HGBild.Canvas.FillRect(rect(Sca_x(254),sca_Y(275),
		  sca_x(314), sca_y(285)));
	end
	else
	begin
		HGBild.Canvas.FillRect(rect(Sca_x(254),sca_Y(275), sca_x(314),
		  sca_y(285)));
	end;
	Neue_Aufgabe;
end;

procedure TRechnen_Form.Neue_Aufgabe;
var	wert:Array[1..3] of Integer;
	wert_str:String[2];
	i:Integer;
begin
	for i := 0 to 9 do
		Button[i].demark;
	i := ad.rand;
	WMFContainer.LoadGraphic(path + 'grafik\bilder\rechnen\' +
	  ad.Getdat(i, 1), strtoint(ad.Getdat(i, 2)));
	wert[1] := random(max_nummer - 1) + 1;
	wert[2] := random(max_nummer - wert[1]) + 1;
	if AufgabenTyp = 1 then	{Addition}
	begin
		GraphicGrid[3].Init_Spread(GraphicGrid[1], wert[1], 
		  GraphicGrid[2], wert[2]);
		wert[3] := wert[1] + wert[2];
	end
	else
	begin
		GraphicGrid[1].Init_Spread(GraphicGrid[3], wert[2],
		  GraphicGrid[2], wert[1]);
		wert[3] := wert[2];
		wert[2] := wert[1];
		wert[1] := wert[2] + wert[3];
	end;
	operanden_str_pos := 0;
	operanden_str := '';
	for i := 1 to 3 do
	begin
		wert_str := inttostr(wert[i]);
		if length(wert_str) = 1 then
			wert_str := '*' + wert_str;
		operanden_str := operanden_str + wert_str;
	end;
	for i := 1 to 6 do
	begin
		Flaeche[i].Visible := operanden_str[i] <> '*';
		Flaeche[i].SetCaption('');
	end;
	cursor_weiter;
	for i := 0 to 9 do
	begin
		Button[i].Isenabled := TRUE;
		Button[i].Clickable := TRUE;
	end;
	Aufgabe_Laeuft := TRUE;
        schonhilfegegeben:=false;
end;

procedure TRechnen_Form.cursor_weiter;
begin
	inc(operanden_str_pos);
	while operanden_str[operanden_str_pos] = '*' do
		inc(operanden_str_pos);
	Flaechefaerben(operanden_str_pos);
end;

procedure TRechnen_Form.flaechefaerben(nr: Integer);
var	i:Integer;
begin
	for i := 1 to 6 do
		if i <> nr then
			flaeche[i].demark
		else
			flaeche[i].mark;
end;

procedure TRechnen_Form.ziehen(Sender: TObject);
var	i, j:Integer;
begin
	if (Sender as TColorButton).Caption=operanden_str[operanden_str_pos] 
	then begin
		for i := 0 to 9 do Button[i].demark;
		Flaeche[operanden_str_pos].SetCaption(
		  operanden_str[operanden_str_pos]);
		if operanden_str_pos < 6 then
		begin
			playsound(SND_SCHRITT_RICHTIG);
			cursor_weiter;
		end
		else
		begin
			playsound(SND_RICHTIG);
			for j := 0 to 9 do
			begin
				Button[j].Isenabled := FALSE;
				Button[j].Clickable := FALSE;
			end;
			flaeche[6].demark;
			Aufgabe_Laeuft := FALSE;
		end;
	end
	else
		playsound(SND_FALSCH);
end;

procedure TRechnen_Form.hilfeknopfClick(Sender: TObject);
var	i:Integer;
begin
	For i := 0 to 9 do
		if (operanden_str[operanden_str_pos] = Button[i].caption) and
		  not(Button[i].marked) and Aufgabe_Laeuft then
		begin
			playsound(SND_HILFE);
			Button[i].mark;
		end;
end;

procedure TRechnen_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	Neue_Aufgabe;
end;

procedure TRechnen_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TRechnen_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	WMFContainer.Free;
	inherited FormClose(Sender, Action);
end;

procedure TRechnen_Form.FormKeyPress(Sender: TObject; var Key: Char);
var	i:Integer;
begin
	case Key of
	'0'..'9':
		For i := 0 to 9 do
		if (Key = Button[i].caption[1]) and Button[i].enabled then
		begin
			ziehen(Button[i]);
			break; {nur einen passenden knopf markieren}
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
