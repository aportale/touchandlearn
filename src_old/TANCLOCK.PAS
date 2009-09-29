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

unit Tanclock;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, ExtCtrls;
type
	TClock = class(TGraphicControl)
        private
        	highlighted, marked:boolean;
                Timer: TTimer;
                procedure blink(Sender: TObject);
        public
		FarbPalette:HPalette;
		Stunden, Minuten:Integer;
		BG_Color:TColor;
		BG_Bild:TMetaFile;
		x0,y0   : single;
		Praez_Stunden:Boolean;
		unpressed:Boolean;
		autopaint:boolean;
		Clickable, Aisenabled:Boolean;
		Paintanzahl:Integer;
		procedure Paint; override;
		procedure mark;
		procedure demark;
		procedure KreisLinie(winkel, laenge : single; ACanvas:TCanvas);
		constructor create_Set(AOwner: TComponent; ALeft, ATop, AWidth,
		  AHeight:Integer; AWMFFileName:String);
		destructor Destroy; override;
		procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
		  X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
		  X, Y: Integer); override;
		procedure SetTime(AStunde, AMinute:Integer);
		procedure SetEnabled(Value: Boolean); override;
		function GetPalette: HPALETTE; override;
	published
		property OnClick;
		property isenabled:Boolean write SetEnabled;
	end;

procedure Register;

implementation

constructor TClock.create_Set(AOwner: TComponent; ALeft, ATop, AWidth,
  AHeight:Integer; AWMFFileName:String);
begin
	inherited Create(AOwner);
	BG_Bild := TMetaFile.Create;
	BG_Bild.LoadFromFile(AWMFFileName);
	if AWidth > AHeight then
	begin
		ALeft := ALeft + (AWidth-AHeight)div 2;
		AWidth := AHeight;
	end
	else
	begin
		ATop := ATop + (AHeight-AWidth)div 2;
		AHeight := AWidth;
	end;
	SetBounds(ALeft, ATop, AWidth, AHeight);
	Stunden := 0;
	Minuten := 0;
	x0 := Width / 2;
	y0 := Width / 2;
	BG_Color:=$02ffc280;
	Praez_Stunden:=true;
	Clickable:= true;
	unpressed:=true;
        Marked := false;
        highlighted := false;
	Aisenabled:=true;
	autopaint := true;
	Paintanzahl:=0;
end;

destructor TClock.Destroy;
begin
	BG_Bild.Free;
	inherited destroy;
end;

function TClock.GetPalette: HPALETTE;
begin
	result := FarbPalette;
end;

procedure TClock.SetEnabled(Value: Boolean);
begin
	if Value = not(AIsEnabled) then
	begin
		AIsEnabled := Value;
		if autopaint then paint;
	end;
end;

procedure TClock.mark;
begin
	if not(marked) then
    	begin
        	Timer := TTimer.Create(Parent);
		Timer.Interval := 350;
		Timer.onTimer := blink;
		Timer.enabled := true;
		highlighted := true;
        	marked := true;
		paint;
	end;
end;

procedure TClock.demark;
begin
	if marked then
    	begin
		marked := false;
        	highlighted := false;
		Timer.Free;
		paint;
	end;
end;

procedure TClock.blink(Sender: TObject);
begin
	highlighted := not(highlighted);
	paint;
end;

procedure TClock.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	If Clickable and unpressed then
	begin
		unpressed := false;
                demark;
		paint
	end;
end;

procedure TClock.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	If Clickable and not(unpressed) then
	begin
		unpressed := true;
                demark;
		paint
	end;
end;

procedure TClock.KreisLinie(winkel, laenge : single; ACanvas:TCanvas);
var 	x1,y1, si, co: single;
begin
	si := Sin((winkel-90)/180*pi);
	co := Cos((winkel-90)/180*pi);
	x1 := x0 + co * laenge;
	y1 := y0 + si * laenge;
	Acanvas.moveto(round(x0),round(y0));
	Acanvas.Lineto(round(x1),round(y1));
End;

procedure TClock.paint;
var
	Stundenwinkel:single;
	Buffer:TBitmap;
begin
	inc(Paintanzahl);
	Buffer := TBitmap.Create;
	try
		Buffer.Height := Height;
		Buffer.Width := Width;
		SelectPalette(Buffer.Canvas.handle, FarbPalette, FALSE);
		RealizePalette(Buffer.Canvas.handle);
		Buffer.Canvas.Brush.Color := BG_Color;
		Buffer.Canvas.Fillrect(Clientrect);
		Buffer.Canvas.Pen.Style := psclear;
		if Aisenabled then
			if (not(unpressed) or highlighted) then
			begin
				Buffer.Canvas.Brush.Color := clolive;
				Buffer.Canvas.Ellipse(0, 0, width+1, height+1);
				Buffer.Canvas.Brush.Color := clWhite;
				Buffer.Canvas.Ellipse(Round(Width/2+Width/2*
				  0.92), Round(Width/2+Width/2*0.92),
				  Round(Width/2-Width/2*0.92), Round(Width/2-
				  Width/2*0.92));
			end
			else
			begin
				Buffer.Canvas.Brush.Color := clWhite;
				Buffer.Canvas.Ellipse(0, 0, width+1, height+1);
			end;
		Buffer.Canvas.Stretchdraw(Clientrect, BG_Bild);
		Buffer.Canvas.Pen.Style := pssolid;
		Buffer.Canvas.Pen.Width := round(12*width/500);
		if Aisenabled then
			Buffer.Canvas.Pen.Color := clOlive
		else
			Buffer.Canvas.Pen.Color := clBlack;
		Stundenwinkel := Stunden *360/12;
		if Praez_Stunden then
			StundenWinkel := Stundenwinkel + Minuten *360/60/12;
		KreisLinie(Stundenwinkel, (Width / 2) * 0.60, Buffer.Canvas);
		Buffer.Canvas.Pen.Width := round(12*width/500);
		if Aisenabled then
			Buffer.Canvas.Pen.Color := clOlive
		else
			Buffer.Canvas.Pen.Color := clBlack;
		KreisLinie(Minuten *360/60, (Width / 2)* 0.95, Buffer.Canvas);
		Buffer.Canvas.Brush.Color := clOlive;
		Buffer.Canvas.Pen.Style := psclear;
		Buffer.Canvas.Ellipse(Round(Width/2+Width/2*0.05),
		  Round(Width/2+Width/2*0.05),
		Round(Width/2-Width/2*0.05), Round(Width/2-Width/2*0.05));
		Canvas.Draw(0, 0, Buffer);
	finally
		Buffer.free;
	end;
end;

procedure TClock.SetTime(AStunde, AMinute:Integer);
begin
	Stunden := AStunde;
	Minuten := AMinute;
	if autopaint then paint;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TClock]);
end;

end.
