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
	along with Touch'n'learn; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
}

unit Tkboard;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, Tkeybbtn, MPlayer, TNotPlay;

type
	TKeyBoard = class(TGraphicControl)
		private
			NotenPlayer:TNotenPlayer;
			FarbPalette: HPalette;
		public
			KBButton:Array[1..12]of TKeyboardTaste;
			lastpressedkey:Integer;
			KeyFilterActive:Boolean;
			KeyFilter:Integer;
			AIsEnabled:Boolean;
			Clickable:Boolean;
			constructor Create_Set(AOwner:TComponent; ANotenPlayer:TNotenPlayer;
			  ALeft, ATop, AWidth, AHeight:Integer);
			destructor Destroy; override;
			function GetPalette: HPALETTE; override;
			procedure Action(id:Integer);
			procedure MouseDown(Button: TMouseButton;
			  Shift: TShiftState; X, Y: Integer);override;
			procedure Paint; override;
			Procedure MarkButton(ButtonId:Integer; 
			  modus, APaint:Boolean);
			Procedure SetIsEnabled(Value:Boolean);
		published
			property OnClick;
			property OnMouseDown;
			property OnMouseUp;
			property IsEnabled:Boolean write SetIsEnabled;
	end;

procedure Register;

implementation

constructor TKeyBoard.Create_Set(AOwner: TComponent;
  ANotenPlayer:TNotenPlayer; ALeft, ATop, AWidth, AHeight:Integer);
var	i, schw_kn_breite:Integer;
	Y_sca:Real;
begin
	inherited Create(AOwner);
	Setbounds(ALeft, ATop, AWidth, AHeight);
	NotenPlayer := ANotenPlayer;
	for i := 1 to 12 do
	begin
		KBButton[i] := TKeyboardTaste.Create;
		schw_kn_breite := Round((Clientrect.Right-1)/12.5);
		y_sca := (Clientrect.Right-1)/1000;
		Case i Of
		1: Begin
			KBButton[i].SetArea(rect((i-1) *Round((Clientrect.Right-
			  1)/7), 0, i*Round((Clientrect.Right-1)/7), 
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		3: Begin
			KBButton[i].SetArea(rect((i-2) *Round((Clientrect.Right-
			  1)/7), 0, (i-1)*Round((Clientrect.Right-1)/7), 
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		5: Begin
			KBButton[i].SetArea(rect((i-3) *Round((Clientrect.Right-
			  1)/7), 0, (i-2)*Round((Clientrect.Right-1)/7),
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		6: Begin
			KBButton[i].SetArea(rect((i-3) *Round((Clientrect.Right-
			  1)/7), 0, (i-2)*Round((Clientrect.Right-1)/7),
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		8: Begin
			KBButton[i].SetArea(rect((i-4) *Round((Clientrect.Right-
			  1)/7), 0, (i-3)*Round((Clientrect.Right-1)/7), 
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		10:Begin
			KBButton[i].SetArea(rect((i-5) *Round((Clientrect.Right-
			  1)/7), 0, (i-4)*Round((Clientrect.Right-1)/7), 
			  Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		12:Begin
			KBButton[i].SetArea(rect((i-6) *Round((Clientrect.Right-
			  1)/7), 0, Clientrect.Right , Clientrect.Bottom));
			KBButton[i].SetButtonType(1);
		   end;
		2: Begin
			KBButton[i].SetArea(rect(Round(y_sca* 84), 0, 
			  Round(y_sca* 84) + schw_kn_breite, 
			  round(Clientrect.Bottom*0.6)));
			KBButton[i].SetButtonType(2);
		   end;
		4: Begin
			KBButton[i].SetArea(rect(Round(Y_sca* 260), 0,
			  Round(Y_sca* 260) + schw_kn_breite,
			  round(Clientrect.Bottom*0.6)));
			KBButton[i].SetButtonType(2);
		   end;
		7: Begin
			KBButton[i].SetArea(rect(Round(Y_sca* 512), 0,
			  Round(Y_sca* 512) + schw_kn_breite,
			  round(Clientrect.Bottom*0.6)));
			KBButton[i].SetButtonType(2);
		   end;
		9: Begin
			KBButton[i].SetArea(rect(Round(Y_sca* 672), 0,
			  Round(Y_sca* 672) + schw_kn_breite,
			  round(Clientrect.Bottom*0.6)));
			KBButton[i].SetButtonType(2);
		   end;
		11:Begin
			KBButton[i].SetArea(rect(Round(Y_sca* 832), 0,
			  Round(Y_sca* 832) + schw_kn_breite, 
			  round(Clientrect.Bottom*0.6)));
			KBButton[i].SetButtonType(2);
		   end;
		end;

	end;
	KeyFilterActive := FALSE;
	KeyFilter := -1;
	Clickable:= TRUE;
end;

destructor TKeyBoard.Destroy;
var i:Integer;
begin
	for i := 1 to 12 do
		KBButton[i].Free;
	inherited Destroy;
end;

Procedure TKeyBoard.SetIsEnabled(Value:Boolean);
begin
	If Value = not(AIsenabled) then
	begin
		AIsenabled := Value;
		paint;
	end;
end;

function TKeyBoard.GetPalette: HPALETTE;
begin
	result := FarbPalette;
end;

procedure TKeyBoard.Paint;
var	i, Durchgang:Integer;
	Buffer:TBitmap;
begin
	inherited Paint;
	Buffer := TBitmap.Create;
	try
		Buffer.Height := Height;
		Buffer.Width := Width;
		For Durchgang := 1 to 2 do
		For i := 1 to 12 do
		begin
			if (Durchgang = 1) and (KBButton[i].ButtonType = 1) then
				KBButton[i].Paint(Buffer.Canvas);
			if (Durchgang = 2) and (KBButton[i].ButtonType = 2) then
				KBButton[i].Paint(Buffer.Canvas);
		end;
		If not(AIsEnabled) then
		begin
			Buffer.Canvas.Copymode := cmMergePaint;
			Buffer.Canvas.Draw(-3, -3, Buffer);
		end;
		Canvas.Draw(0, 0, Buffer)
	finally
		Buffer.free;
	end;
end;

procedure TKeyBoard.Action(id:Integer);
begin
	if not(KeyFilterActive) or (KeyFilter = id) then
	begin
		KBButton[id].Press;
		paint;
		NotenPlayer.PlayNote(id);
		KBButton[id].Release;
		paint;
	end;
	LastpressedKey := id;
end;

procedure TKeyBoard.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var 	i, Durchgang:Integer;
begin
	If Clickable then
		If Button = MbLeft then
		begin
			For Durchgang := 1 to 2 do
			for i := 1 to 12 do
			begin
				if (Durchgang = 1) And (Kbbutton[i].ButtonType=
				  2) And (Kbbutton[i].Isclicked(X, Y)) then
				begin
					Action(i);
					exit;
				end;
				if (Durchgang = 2) And (Kbbutton[i].ButtonType=
				  1) And (Kbbutton[i].Isclicked(X, Y)) then
					Action(i);
			end;
			paint;
		end;
end;

Procedure TKeyBoard.MarkButton(ButtonId:Integer; modus, APaint:Boolean);
var	i:Integer;
begin
	if ButtonId = -1 then
		For i := 1 to 12 do KbButton[i].unpressed := not(modus)
	else
		KbButton[ButtonId].unpressed := not(modus);
	if APaint then Paint;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TKeyBoard]);
end;

end.
