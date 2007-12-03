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

unit Uhr02;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, TAufgdta, TPressbt, TColBtn, Townlabl, tools,
	StdCtrls, ExtCtrls, TanClock, Basis;
type
	TUhr2_Form = class(TBasis_Form)
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure nochmalknopfclick(Sender:TObject);
		procedure hilfeknopfclick(Sender:TObject);
		procedure endeknopfclick(Sender:TObject);
		procedure ziehen(Sender:TObject);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
	private
		Uhr:Array [1..4] of TClock;
		Richtige_Antwort:Integer;
		UhrZeit:TOwnLabel;
		procedure initialisierung;
	end;

var
	Uhr2_Form: TUhr2_Form;

implementation

procedure TUhr2_Form.FormCreate(Sender: TObject);
var	i:Integer;
begin
	inherited FormCreate(Sender);
	Load_BG_Image('Uhr2.wmf');
	nextButton.Onclick := nochmalknopfClick;
	exitButton.Onclick := endeknopfclick;
	helpButton.Onclick := hilfeknopfclick;
	HGBild.Canvas.Textout(sca_x(132), sca_y(232), '1');
	HGBild.Canvas.Textout(sca_x(432), sca_y(232), '2');
	HGBild.Canvas.Textout(sca_x(132), sca_y(450), '3');
	HGBild.Canvas.Textout(sca_x(432), sca_y(450), '4');
	Uhr[1]:=TClock.Create_Set(Self, sca_x(180), sca_y(156), sca_x(200),
	  sca_y(200), path+'grafik\uhr\uhr_bg01.wmf');
	Uhr[1].Parent := Self;
	Uhr[1].Clickable := True;
	Uhr[2]:=TClock.Create_Set(Self, sca_x(480), sca_y(156), sca_x(200), 
	  sca_y(200), path+'grafik\uhr\uhr_bg01.wmf');
	Uhr[2].Parent := Self;
	Uhr[2].Clickable := True;
	Uhr[3]:=TClock.Create_Set(Self, sca_x(180), sca_y(376), sca_x(200), 
	  sca_y(200), path+'grafik\uhr\uhr_bg01.wmf');
	Uhr[3].Parent := Self;
	Uhr[3].Clickable := True;
	Uhr[4]:=TClock.Create_Set(Self, sca_x(480), sca_y(376), sca_x(200), 
	  sca_y(200), path+'grafik\uhr\uhr_bg01.wmf');
	Uhr[4].Parent := Self;
	Uhr[4].Clickable := True;
	For i:= 1 to 4 do
	begin
		Uhr[i].Tag := i;
		Uhr[i].onclick := ziehen;
		Uhr[i].Autopaint := false;
		Uhr[i].BG_Color := $0282bc8c;
	end;
	UhrZeit:= TOwnLabel.Create(Self);
	UhrZeit.Parent := Self;
	UhrZeit.FontName := 'Arial';
	UhrZeit.FontSize := Sca_x(50);
	UhrZeit.SetBounds(Sca_x(230), Sca_y(48), Sca_x(340), Sca_y(80));
	Richtige_Antwort := 1;
	initialisierung;
end;

procedure TUhr2_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	inherited FormClose(Sender, Action);
end;

procedure TUhr2_Form.initialisierung;
var	i, j:Integer;
	Uhrzeiten:Array[1..4, 1..2]of Integer;
	minutenstring, stundenstring:String[4];
	geht_weiter:boolean;
begin
	Randomize;
	{Uhr[Richtige_Antwort].unpressed := true;}
        Uhr[Richtige_Antwort].demark;
	Richtige_Antwort := Random(4)+1;
	For i := 1 to 4 do
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
		if i = Richtige_Antwort then
		begin
			stundenstring := inttostr(Uhrzeiten[i][1]);
			minutenstring := inttostr(Uhrzeiten[i][2]);
			if length(stundenstring)<2 then
				stundenstring := '  '+ stundenstring;
			if length(minutenstring)<2 then 
				minutenstring := '0'+ minutenstring;
		end;
		Uhr[i].SetTime(Uhrzeiten[i][1], Uhrzeiten[i][2]);
		Uhr[i].isenabled := true;
		Uhr[i].clickable := true;
		Uhr[i].Paint;
	end;
	UhrZeit.SetCaption(stundenstring+'.'+minutenstring+' Uhr');
	Aufgabe_Laeuft := true;
        schonhilfegegeben:=false;
end;

procedure TUhr2_Form.nochmalknopfclick(Sender:TObject);
begin
	initialisierung;
	playsound(snd_nochmal);
end;

procedure TUhr2_Form.hilfeknopfclick(Sender:TObject);
begin
	if Aufgabe_Laeuft and not(schonhilfegegeben) then
	begin
		{Uhr[Richtige_Antwort].unpressed := false;
		Uhr[Richtige_Antwort].Paint;}
                schonhilfegegeben:=true;
                Uhr[Richtige_Antwort].mark;
		playsound(snd_hilfe);
	end;
end;

procedure TUhr2_Form.endeknopfclick(Sender:TObject);
begin
	close;
end;

procedure TUhr2_Form.Ziehen(Sender:TObject);
var	i: Integer;
begin
	if Aufgabe_Laeuft then
		if (Sender as TClock).Tag = Richtige_Antwort then
		begin
			Uhr[Richtige_Antwort].unpressed := false;
			playsound(snd_richtig);
			for i := 1 to 4 do
			begin
				Uhr[i].Clickable := false;
				Aufgabe_laeuft := false;
				if i <> Richtige_Antwort then
				begin
					Uhr[i].IsEnabled := false;
				end
				else
					Uhr[i].unpressed := true;
				Uhr[i].Paint;
			end;
		end
		else
			playsound(snd_falsch);
end;

procedure TUhr2_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
	Case Key of
	'1'..'4':
		ziehen(Uhr[strtoint(Key)]);
	chr(32):
		hilfeknopfClick(HelpButton);
	chr(8), chr(27):
		EndeknopfClick(ExitButton);
	chr(13):
		nochmalknopfClick(nextButton);
	end;
end;

end.
