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

unit Townlabl;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, ExtCtrls;


type
	TOwnLabel = class(TGraphicControl)
	private
		marked:Boolean;
		roundamount: Integer;
		procedure blink(Sender: TObject);

	protected
		procedure Paint; override;

	public
		caption, fontname:String;
		Afontsize:Integer;
		Timer:TTimer;
		Backcolor:TColor;
		Text :String;
		AColor:Array[0..1] of TColor;
		ActualColor:Integer;
		BlinkerSet:Integer;
		constructor Create(AOwner: TComponent); override;
		procedure SetCaption(ACaption:String);
		procedure mark;
		procedure demark;
		procedure SetFontSize(Value: Integer);
	procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

	published
		property Fontsize:Integer write SetFontSize;
	end;

procedure Register;

implementation

constructor TOwnLabel.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	marked := false;
	Backcolor := $0282bc8c;
	AColor[0] := $0289fcfd;
	AColor[1] := $02397148;
	ActualColor := 0;
end;

procedure TOwnLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
	inherited SetBounds(ALeft, ATop, AWidth, AHeight);
	if (width < height) then
		roundamount := width div 5
	else
		roundamount := height div 5;
end;

procedure TOwnLabel.SetCaption(ACaption:String);
begin
	if (Caption <> ACaption) then
	begin
		Caption := ACaption;
	end;
	if Visible then
		paint;
end;

procedure TOwnLabel.SetFontSize(Value: Integer);
begin
	AFontsize := Round(Value * 96 / screen.pixelsPerInch);
end;

procedure TOwnLabel.Paint;
var
	AText: Array[0..79]of Char;
	RectCopy: TRect;
begin
	StrPCopy(Atext, Caption);
	canvas.font.name := fontname;
	canvas.font.size := Afontsize;
	canvas.brush.color := AColor[ActualColor];
	canvas.pen.style := psclear;
	canvas.roundrect(0, 0, width+1, height+1, roundamount, roundamount);
	setbkmode(Canvas.handle, 1);
	RectCopy := Clientrect;
	drawtext(canvas.handle, Atext, strlen(Atext), RectCopy, 53);
end;

procedure TOwnLabel.mark;
begin
	if not(marked) then
	begin
		marked := true;
		Timer := TTimer.Create(Parent);
		Timer.Interval := 500;
		Timer.onTimer := blink;
		Timer.enabled := true;
		BlinkerSet := 1;
		ActualColor := 1;
		paint;
	end;
end;

procedure TOwnLabel.blink(Sender: TObject);
begin
	BlinkerSet := ((BlinkerSet+1) mod 2);
	ActualColor := BlinkerSet;
	paint;
end;

procedure TOwnLabel.demark;
begin
	if marked then
	begin
		marked := false;
		Timer.Free;
		ActualColor := 0;
		paint;
	end;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TOwnLabel]);
end;

end.
