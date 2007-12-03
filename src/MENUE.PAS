{
	Touch'n'learn - Low-barrier primary school lessons
	Copyright (C) 1998, 2007 by Alessandro Portale
	http://touchandlearn.sourceforge.net/

	This file is part of Touch'n'learn

	Touch'n'learn is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	Touch'n'learn is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with PosteRazor; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
}

unit Menue;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, RECHNEN, BUCHSTB, BESCHRFT, Palette, TPressbt,
	tcolbtn, tools, NLESEN, ITVLESEN, NSPIELEN, UHR01, UHR02;

type
	TMenue_Form = class(TForm)
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
		procedure FormPaint(Sender: TObject);
	private
		WmfButton:Array[1..5]of TWMFPressButton;
		NextMenuButton, LastMenuButton:TWMFPressButton;
		stddevstr:String;
		AktMenuPage:Integer;
		procedure getMenuButtons(Menueseite:Integer);
		procedure DropMenuButtons;
		function setstddevstr:String;
		procedure Add_10_Click(Sender: TObject);
		procedure Sub_10_Click(Sender: TObject);
		procedure Buchstabieren_Click(Sender: TObject);
		procedure Beschriften_Click(Sender: TObject);
		procedure Zaehlen_Click(Sender: TObject);
		procedure Noten_Lesen_Click(Sender: TObject);
		procedure Intervalle_Lesen_Click(Sender: TObject);
		procedure Noten_Spielen_Click(Sender: TObject);
		procedure Uhr1_Click(Sender: TObject);
		procedure Uhr2_Click(Sender: TObject);
		procedure Leer_Click(Sender: TObject);
		procedure NextPage(Sender: TObject);
		procedure LastPage(Sender: TObject);
		procedure RepaintButtons;
	end;

var	Menue_Form: TMenue_Form;

implementation
{$R *.DFM}

function TMenue_Form.setstddevstr:String;
begin
	{'© A. Portale ''98'}
	asm
		cld
		les di, @result
		mov al, 16	{Stringlänge}
		stosb
		add Al, 153	{169 '@'}
		stosb
		sub Al, 137 { 32 ' '}
		stosb
		add al, 33	{ 65 'A'}
		stosb
		sub al, 19	{ 46 '.'}
		stosb
		sub al, 14	{ 32 ' '}
		stosb
		add al, 48	{ 80 'P'}
		stosb
		add al, 31	{111 'o'}
		stosb
		add al, 3	{114 'r'}
		stosb
		add al, 2	{116 't'}
		stosb
		sub al, 19	{ 97 'a'}
		stosb
		add al, 11	{108 'l'}
		stosb
		sub al, 7	{101 'e'}
		stosb
		sub al, 69	{ 32 ' '}
		stosb
		add al, 7	{ 39 '''}
		stosb
		add al, 18	{ 57 '9'}
		stosb
		sub al, 1	{ 56 '8'}
		stosb
	end;
	if (color shr 24 > 0) or (color <>$FFFFFF) then
		color := (color and $00FFFFFF);
end;

procedure TMenue_Form.Add_10_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TRechnen_Form, Rechnen_Form);
	Rechnen_Form.Init(2, 5, 1);
	Rechnen_Form.ShowModal;
	Rechnen_Form.Free;
end;

procedure TMenue_Form.Buchstabieren_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TBuchstaben_Form, Buchstaben_Form);
	Buchstaben_Form.ShowModal;
	Buchstaben_Form.Free;
end;

procedure TMenue_Form.Sub_10_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TRechnen_Form, Rechnen_Form);
	Rechnen_Form.Init(2, 5, 2);
	Rechnen_Form.ShowModal;
	Rechnen_Form.Free;
end;

procedure TMenue_Form.Beschriften_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TBeschriften_Form, Beschriften_Form);
	Beschriften_Form.Init('Buchstabensalat', 1);
	Beschriften_Form.ShowModal;
	Beschriften_Form.Free;
end;

procedure TMenue_Form.Zaehlen_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TBeschriften_Form, Beschriften_Form);
	Beschriften_Form.Init('Zahlen', 2);
	Beschriften_Form.ShowModal;
	Beschriften_Form.Free;
end;

procedure TMenue_Form.Noten_Lesen_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TNoten_Lesen_Form, Noten_Lesen_Form);
	Noten_Lesen_Form.ShowModal;
	Noten_Lesen_Form.Free;
end;

procedure TMenue_Form.Intervalle_Lesen_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TIntervalle_Lesen_Form, Intervalle_Lesen_Form);
	Intervalle_Lesen_Form.ShowModal;
	Intervalle_Lesen_Form.Free;
end;

procedure TMenue_Form.Noten_Spielen_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TNoten_Spielen_Form, Noten_Spielen_Form);
	Noten_Spielen_Form.ShowModal;
	Noten_Spielen_Form.Free;
end;

procedure TMenue_Form.Uhr1_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TUhr1_Form, Uhr1_Form);
	Uhr1_Form.ShowModal;
	Uhr1_Form.Free;
end;

procedure TMenue_Form.Uhr2_Click(Sender: TObject);
begin
	playsound(SND_ENDE);
	Application.CreateForm(TUhr2_Form, Uhr2_Form);
	Uhr2_Form.ShowModal;
	Uhr2_Form.Free;
end;

procedure TMenue_Form.Leer_Click(Sender: TObject);
begin
	playsound(SND_FALSCH);
end;

procedure TMenue_Form.getMenuButtons(Menueseite:Integer);
begin
	case Menueseite of
	1:
	begin
		WmfButton[1].setGraphics(path + 'grafik\menu\buchsupr.wmf', 
		  path + 'grafik\menu\buchspr.wmf');
		WmfButton[1].Onclick := Buchstabieren_Click;
		WmfButton[2].setGraphics(path + 'grafik\menu\benenupr.wmf',
		  path + 'grafik\menu\benenpr.wmf');
		WmfButton[2].Onclick := Beschriften_Click;
		WmfButton[3].setGraphics(path + 'grafik\menu\zaehlupr.wmf', 
		  path + 'grafik\menu\zaehlpr.wmf');
		WmfButton[3].Onclick := Zaehlen_Click;
		WmfButton[4].setGraphics(path + 'grafik\menu\add10upr.wmf', 
		  path + 'grafik\menu\add10pr.wmf');
		WmfButton[4].Onclick := Add_10_Click;
		WmfButton[5].setGraphics(path + 'grafik\menu\sub10upr.wmf', 
		  path + 'grafik\menu\sub10pr.wmf');
		WmfButton[5].Onclick := Sub_10_Click;
		NextMenuButton.visible := true;
		LastMenuButton.visible := false;
	End;
	2:
	Begin
		WmfButton[1].setGraphics(path + 'grafik\menu\nolesupr.wmf', 
		  path + 'grafik\menu\nolespr.wmf');
		WmfButton[1].Onclick := Noten_Lesen_Click;
		WmfButton[2].setGraphics(path + 'grafik\menu\intupr.wmf', 
		  path + 'grafik\menu\intpr.wmf');
		WmfButton[2].Onclick := Intervalle_Lesen_Click;
		WmfButton[3].setGraphics(path + 'grafik\menu\nospiupr.wmf', 
		  path + 'grafik\menu\nospipr.wmf');
		WmfButton[3].Onclick := Noten_Spielen_Click;
		WmfButton[4].setGraphics(path + 'grafik\menu\Uhr1upr.wmf', 
		  path + 'grafik\menu\Uhr1pr.wmf');
		WmfButton[4].Onclick := Uhr1_Click;
		WmfButton[5].setGraphics(path + 'grafik\menu\Uhr2upr.wmf', 
		  path + 'grafik\menu\Uhr2pr.wmf');
		WmfButton[5].Onclick := Uhr2_Click;
		NextMenuButton.visible := false;
		LastMenuButton.visible := true;
	End;
	end; {case}
end;

procedure TMenue_Form.DropMenuButtons;
begin
end;

procedure TMenue_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	getOwnPalette;
	SelectPalette(Canvas.handle, OwnPaletteHandle, FALSE);
	RealizePalette(Canvas.handle);
	color := $0ffffff;
	for i := 1 to 5 do
	begin
		WmfButton[i] := 
		  TWMFPressButton.Create_Set(self,OwnPaletteHandle, 2);
		WmfButton[i].Parent := self;
	end;
	WmfButton[1].SetBounds(sca_x(5), sca_y(29), sca_x(256), sca_y(256));
	WmfButton[2].SetBounds(sca_x(271), sca_y(29), sca_x(256), sca_y(256));
	WmfButton[3].SetBounds(sca_x(271+265),sca_y(29),sca_x(256),sca_y(256));
	WmfButton[4].SetBounds(sca_x(133), sca_y(314), sca_x(256), sca_y(256));
	WmfButton[5].SetBounds(sca_x(403), sca_y(314), sca_x(256), sca_y(256));
	AktMenuPage := 1;
	NextMenuButton := TWMFPressButton.Create_Load(Self, path+
	  'grafik\buttons\nextunpr.wmf', path+'grafik\buttons\nextpr.wmf', 
	  OwnPaletteHandle, 2);
	NextMenuButton.Parent := Self;
	NextMenuButton.SetBounds(sca_x(715), sca_y(320), sca_X(80), sca_y(80));
	NextMenuButton.OnClick := NextPage;
	LastMenuButton := TWMFPressButton.Create_Load(Self, 
	  path+'grafik\buttons\lastunpr.wmf',
	path+'grafik\buttons\lastpr.wmf', OwnPaletteHandle, 2);
	LastMenuButton.Parent := Self;
	LastMenuButton.SetBounds(sca_x(6), sca_y(320), sca_x(80), sca_y(80));
	LastMenuButton.OnClick := LastPage;
	getMenuButtons(AktMenuPage);
end;

procedure TMenue_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	playsound(SND_ENDE);
	DropOwnPalette;
end;

procedure TMenue_Form.NextPage(Sender: TObject);
Begin
	playsound(SND_NOCHMAL);
	inc(AktMenuPage);
	getMenuButtons(AktMenuPage);
	repaintButtons;
End;

procedure TMenue_Form.LastPage(Sender: TObject);
Begin
	playsound(SND_NOCHMAL);
	dec(AktMenuPage);
	getMenuButtons(AktMenuPage);
	repaintButtons;
End;

procedure TMenue_Form.repaintButtons;
var i:Integer;
Begin
	For i := 1 to 5 do
		WMFButton[i].Paint;
End;

procedure TMenue_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if (ord(Key) = 27) or (ord(Key) = 8) then close
end;

procedure TMenue_Form.FormPaint(Sender: TObject);
begin
	canvas.Font.Name := 'Arial';
	canvas.Font.Size := Round(sca_x(8)*96/screen.pixelsperinch);
	canvas.Font.color := (not Color);
	canvas.textout(sca_x(722), sca_y(588), setstddevstr);
end;

end.
