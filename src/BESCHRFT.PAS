unit Beschrft;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, TAufgdta, TPressbt, TColBtn, Townlabl, Palette, tools,
	townimg, StdCtrls, ExtCtrls, TGrphgrd, Tmfcntnr, Basis;

type
	TBeschriften_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure initialisierung;
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		ad, bild_ad: TAufgabenData;
		knopf: array [1..3] of TColorButton;
		VGBild:TownImage;
		Richtige_Antwort:Integer;
		GraphicGrid:TGraphicGrid;
		WMFContainer:TMetaFileContainer;
		Modus:Integer;
		schonhilfegegeben:boolean;
		procedure nochmalknopfClick(Sender: TObject);
		procedure endeknopfClick(Sender: TObject);
		procedure hilfeknopfClick(Sender: TObject);
		procedure ziehen(Sender: TObject);
	public
		procedure Init(AD_Sektor: String; AModus:Integer);
	end;

var	Beschriften_Form: TBeschriften_Form;

implementation
{$R *.DFM}

procedure TBeschriften_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	inherited FormCreate(Sender);
	Load_BG_Image('beschrft.wmf');
	For i := 1 to 3 do
	begin
		knopf[i] := TColorButton.Create(Self);
		with knopf[i] do
		begin
			Parent := Self;
			fontsize := sca_x(45);
			fontname := 'Arial';
			onclick := ziehen;
			SetBounds(sca_x(170), sca_y(346)+(i-1)*sca_y(78),
			  sca_x(460), sca_y(74));
			Tag := i;
			BackBuffering := TRUE;
		end;
		HGBild.Canvas.TextOut(sca_x(122), sca_y(356)+(i-1)*sca_y(78),
		  inttostr(i));
	end;
	nextButton.Onclick := nochmalknopfclick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
		schonhilfegegeben:=false;
end;

procedure TBeschriften_Form.FormClose(Sender: TObject;
var	Action: TCloseAction);
begin
	bild_ad.Free;
	ad.Free;
	WmfContainer.Free;
	inherited FormClose(Sender, Action);
end;

procedure TBeschriften_Form.Init(AD_Sektor: String; AModus:Integer);
begin
	ad := TAufgabenData.Create_Load(Self, path+'aufgaben.txt', AD_Sektor);
	ad.RandListStart(ad.RAwList.count - 2);
	Modus := AModus;
	case AModus of
	1:
		Begin
			VGBild:= TOwnImage.Create_Setup(Self, sca_x(129),
			  sca_y(56), sca_x(541), sca_y(275));
			VGBild.Parent := Self;
		end;
	2:
		Begin
			WMFContainer := TMetaFileContainer.Create(Self);
			GraphicGrid := TGraphicGrid.Create_Setup(Self,
			  sca_x(129), sca_y(56), sca_x(541), sca_y(275), 6, 3,
			  WMFContainer);
			GraphicGrid.Parent := self;
			bild_ad := TAufgabenData.Create_Load(Self, path +
			  'aufgaben.txt', 'Rechnenbilder');
			bild_ad.RandListStart(bild_ad.RAwList.count - 1);
		end;
	end;
	initialisierung;
end;

procedure TBeschriften_Form.initialisierung;
var
	i: Integer;
	Knopf_Aufgabe:Array[1..3] of Integer;
begin
	for i := 1 to 3 do
	begin
		Knopf[i].demark;
		Knopf[i].isenabled := true;
		Knopf[i].Clickable := true;
		Knopf_Aufgabe[i] := ad.rand;
	end;
	Richtige_Antwort := Random(3)+1;
	For i := 1 to 3 do
	Begin
		Knopf[i].SetCaption(ad.GetDat(Knopf_Aufgabe[i], 1))
	end;
	case Modus of
	1:
		VGbild.LoadGraphic(path + 'grafik\bilder\buchstab\'+
		  ad.GetDat(Knopf_Aufgabe[Richtige_Antwort], 2));
	2:
		Begin
			i := bild_ad.rand;
			WMFContainer.LoadGraphic(path+'grafik\bilder\rechnen\'+
			  bild_ad.Getdat(i, 1),strtoint(bild_ad.Getdat(i, 2)));
			GraphicGrid.Init(strtoint(ad.Getdat(
			  Knopf_Aufgabe[Richtige_Antwort], 2)));
		end;
	end;
	Aufgabe_Laeuft:=true;
	schonhilfegegeben:=false;
end;

procedure TBeschriften_Form.ziehen(Sender: TObject);
var	i:Integer;
begin
	if Aufgabe_Laeuft then
		if (Sender as TColorButton).Tag = Richtige_Antwort then
		begin
			playsound(SND_RICHTIG);
			(Sender as TColorButton).demark;
			for i := 1 to 3 do
			begin
				If i <> Richtige_Antwort then 
					Knopf[i].isenabled := false;
				Knopf[i].Clickable := false;
			end;
			Aufgabe_Laeuft := false;
		end
		else
			playsound(SND_FALSCH);
end;

procedure TBeschriften_Form.nochmalknopfClick(Sender: TObject);
begin
	playsound(SND_NOCHMAL);
	initialisierung;
end;

procedure TBeschriften_Form.endeknopfClick(Sender: TObject);
begin
	close;
end;

procedure TBeschriften_Form.hilfeknopfClick(Sender: TObject);
begin
	if Aufgabe_Laeuft and not(schonhilfegegeben) then
	begin
		playsound(SND_HILFE);
		Knopf[Richtige_Antwort].mark;
		schonhilfegegeben:=true;
	end;
end;

procedure TBeschriften_Form.FormKeyPress(Sender: TObject; var Key: Char);
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

end.
