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

unit Uhr01;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, TAufgdta, TPressbt, TColBtn, Townlabl, tools,
	StdCtrls, ExtCtrls, TanClock, Basis;

type
	TUhr1_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure initialisierung;
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	public
		knopf: array [1..3] of TColorButton;
		Richtige_Antwort:Integer;
		Clock:TClock;
		procedure nochmalknopfclick(Sender:TObject);
		procedure hilfeknopfclick(Sender:TObject);
		procedure endeknopfclick(Sender:TObject);
		procedure ziehen(Sender:TObject);
	end;

var	Uhr1_Form: TUhr1_Form;

implementation

procedure TUhr1_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	inherited FormCreate(Sender);
	Load_BG_Image('Uhr.wmf');
	setbkmode(HGBild.Canvas.Handle, 1);
	HGBild.Canvas.Font.Color := clwhite;
	nextButton.Onclick := nochmalknopfClick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	For i := 1 to 3 do
	begin
		knopf[i] := TColorButton.Create(Self);
		with knopf[i] do
		begin
			Parent := Self;
			fontsize := sca_x(45);
			fontname := 'Arial';
			onclick := ziehen;
			SetBounds(sca_x(250), sca_y(346)+(i-1)*sca_y(78),
			  sca_x(300), sca_y(74));
			Tag := i;
			BackBuffering := TRUE;
		end;
		HGBild.Canvas.TextOut(sca_x(202), sca_y(358)+(i-1)*sca_y(78),
		  inttostr(i));
	end;
	Clock:=TClock.Create_Set(Self, sca_x(258), sca_y(40), sca_x(284),
	  sca_y(284),
	path+'grafik\uhr\uhr_bg01.wmf');
	Clock.Parent := Self;
	Clock.Clickable := False;
	Clock.BG_Color := $0282bc8c;
	initialisierung;
end;

procedure TUhr1_Form.initialisierung;
var	i, j:Integer;
	Uhrzeiten:Array[1..3, 1..2]of Integer;
	minutenstring, stundenstring:String[3];
	geht_weiter:boolean;
begin
	Randomize;
	Richtige_Antwort := Random(3)+1;
	For i := 1 to 3 do
	begin
		repeat
			geht_weiter := true;
			Uhrzeiten[i][1] := Random(12)+1;
			Uhrzeiten[i][2] := (Random(12))*5;
			For j := 1 to (i - 1) do
				if (Uhrzeiten[j][1] = Uhrzeiten[i][1]) and 
				  (Uhrzeiten[j][2] = Uhrzeiten[i][2]) then
					geht_weiter := false;
		until geht_weiter;
		stundenstring := inttostr(Uhrzeiten[i][1]);
		minutenstring := inttostr(Uhrzeiten[i][2]);
		if length(stundenstring) < 2 then 
			stundenstring := '  '+ stundenstring;
		if length(minutenstring) < 2 then
			minutenstring := '0'+ minutenstring;
		Knopf[i].demark;
		Knopf[i].Isenabled := true;
		Knopf[i].Clickable := true;
		Knopf[i].SetCaption(stundenstring+'.'+minutenstring+' Uhr');
	end;
	Clock.SetTime(Uhrzeiten[Richtige_Antwort][1], 
	  Uhrzeiten[Richtige_Antwort][2]);
	Aufgabe_Laeuft := true;
        schonhilfegegeben:=false;
end;

procedure TUhr1_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	inherited formclose(Sender, Action);
end;

procedure TUhr1_Form.nochmalknopfclick(Sender:TObject);
begin
	initialisierung;
	playsound(snd_nochmal);
end;

procedure TUhr1_Form.hilfeknopfclick(Sender:TObject);
begin
	if Aufgabe_Laeuft and not(schonhilfegegeben) then
	begin
		Knopf[Richtige_Antwort].mark;
                schonhilfegegeben:=true;
		playsound(snd_hilfe);
	end;
end;

procedure TUhr1_Form.endeknopfclick(Sender:TObject);
begin
	close;
end;

procedure TUhr1_Form.Ziehen(Sender:TObject);
var	i: Integer;
begin
	if Aufgabe_Laeuft then
		if (Sender as TColorButton).Tag = Richtige_Antwort then
		begin
			Knopf[Richtige_Antwort].demark;
			playsound(snd_richtig);
			for i := 1 to 3 do
			begin
				Knopf[i].Clickable := false;
				Aufgabe_laeuft := false;
				if i <> Richtige_Antwort then
					Knopf[i].IsEnabled := false;
			end;
		end
		else
			playsound(snd_falsch);
end;

procedure TUhr1_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	Case Key of
	'1'..'3':
		Ziehen(knopf[strtoint(key)]);
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

end.
