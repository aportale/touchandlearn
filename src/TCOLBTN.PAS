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

unit Tcolbtn;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, ExtCtrls;


type
	TColorButton = class(TGraphicControl)
	private
		Farbe:Array[1..4] of TColorRef;
		unpressed:boolean;
		FarbPalette: HPalette;
                Timer:TTimer;
                procedure blink(Sender: TObject);
		procedure paint; override;
	public
                marked:boolean;
		highlighted:boolean;
		Backbuffering:boolean;
		caption, fontname:String;
		afontsize:Integer;
		AClickable, AIsenabled:Boolean;
		constructor Create(AOwner: TComponent; AFarbPalette: HPalette);
		destructor Destroy; override;
		procedure MouseDown(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		procedure mark;
		procedure demark;
		procedure SetCaption(ACaption:String);
		procedure SetFontSize(Value: Integer);
		procedure SetClickable(Value: Boolean);
		function GetClickable:Boolean;
		procedure SetIsEnabled(Value: Boolean);
		function GetIsEnabled:Boolean;
		function GetPalette: HPALETTE; override;
	published
		property OnClick;
		property OnMouseDown;
		property OnMouseUp;
		property font;
		property Isenabled:Boolean read GetIsEnabled write SetIsEnabled;
		property Clickable:Boolean read GetClickable write SetClickable;
		property Fontsize: Integer write SetFontSize;
	end;

procedure Register;

implementation

constructor TColorButton.Create(AOwner: TComponent; AFarbPalette: HPalette);
begin
inherited Create(AOwner);
	FarbPalette := AFarbPalette;
	ParentColor := false;
	fontsize := 10;
	highlighted := false;
	unpressed := true;
	enabled := true;
	AClickable := true;
	AIsEnabled := true;
	Backbuffering:= FALSE;
        marked := false;
end;

destructor TColorButton.Destroy;
begin
	DeleteObject(FarbPalette);
	inherited Destroy;
end;

procedure TColorButton.SetClickable(Value: Boolean);
begin
	if (Value = not(AClickable)) then AClickable := Value;
end;

function TColorButton.GetClickable:Boolean;
begin
	result := AClickable;
end;

procedure TColorButton.SetIsEnabled(Value: Boolean);
begin
	if (Value = not(AIsEnabled)) then
	begin
		AIsEnabled := Value;
		paint;
	end;
end;

function TColorButton.GetIsEnabled:Boolean;
begin
	result := AIsEnabled;
end;

procedure TColorButton.SetFontSize(Value: Integer);
begin
	AFontsize := Round(Value * 96 / screen.pixelsperinch);
end;

function TColorButton.GetPalette: HPALETTE;
begin
	result := FarbPalette;
end;

procedure TColorButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if (AClickable and (Button = mbLeft))then
	begin
		inherited MouseDown(Button, Shift, X, Y);
                demark;
		unpressed := false;
		paint;
	end;
end;

procedure TColorButton.MouseUp(Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
	if (not(unpressed) and (Button = mbLeft))then
	begin
		unpressed := true;
                demark;
		paint;
	end;
end;

procedure TColorButton.SetCaption(ACaption:String);
begin
	Caption := ACaption;
	paint;
end;

procedure TColorButton.Paint;
var	AText: Array[0..79]of Char;
	i:Integer;
	Buffer:TBitmap;
	MyCanvas:TCanvas;
begin
	if Backbuffering then
	begin
		Buffer := TBitmap.Create;
		MyCanvas := Buffer.Canvas;
	end
	else MyCanvas := Canvas;
	try
		if Backbuffering then
		begin
			Buffer.Height := Height;
			Buffer.Width := Width;
		end;
		SelectPalette(MyCanvas.handle, FarbPalette, FALSE);
		RealizePalette(MyCanvas.handle);
		if visible then
		begin
			StrPCopy(Atext, Caption);
			MyCanvas.font.name := fontname;
			MyCanvas.font.size := Afontsize;
			if Isenabled then
				if unpressed then
				begin
					if highlighted then
						MyCanvas.brush.color:=$02EDF9F9
					else
						MyCanvas.brush.color:=$02add6e7;
					MyCanvas.Fillrect(Clientrect);
					MyCanvas.pen.color := $02000000;
					MyCanvas.font.color := $02000000;
					setbkmode(MyCanvas.handle, 1);
					drawtext(MyCanvas.handle, Atext, 
					  strlen(Atext), Clientrect, 53);
					MyCanvas.moveto(0, height - 1);
					MyCanvas.lineto(width -1, height - 1);
					MyCanvas.lineto(width -1, -1);
					MyCanvas.pen.color := $0242a5c6;
					MyCanvas.moveto(1, Height - 2);
					MyCanvas.lineto(width -2, height - 2);
					MyCanvas.lineto(width -2, 0);
					MyCanvas.pen.color := $02EDF9F9;
					MyCanvas.moveto(width -3 , 1);
					MyCanvas.lineto(1 , 1);
					MyCanvas.lineto(1, height - 2);
				end
				else
				begin
					MyCanvas.brush.color := $02EDF9F9;
					MyCanvas.Fillrect(Clientrect);
					MyCanvas.pen.color := $02000000;
					rectangle(MyCanvas.handle, 0,0, 
					  width, height);
					MyCanvas.pen.color := $0242a5c6;
					MyCanvas.rectangle(1,1,width,height);
					MyCanvas.pen.color := $02add6e7;
					MyCanvas.moveto(2, Height - 2);
					MyCanvas.lineto(width -2, height - 2);
					MyCanvas.lineto(width -2, 1);
					setbkmode(MyCanvas.handle, 1);
					drawtext(MyCanvas.handle, Atext, 
					  strlen(Atext), rect(1,1,width+1,
					  height+1), 53);
			end
			else
			begin
				if highlighted then
					MyCanvas.brush.color := $02EDF9F9
				else
					MyCanvas.brush.color := $02add6e7;
				MyCanvas.Fillrect(Clientrect);
				MyCanvas.font.color := $02EDF9F9;
				setbkmode(MyCanvas.handle, 1);
				drawtext(MyCanvas.handle, Atext, strlen(Atext), rect(1,1,width+1,height+1), 53);
				MyCanvas.font.color := $0242a5c6;
				setbkmode(MyCanvas.handle, 1);
				drawtext(MyCanvas.handle, Atext, strlen(Atext), Clientrect, 53);
				MyCanvas.pen.color := $02000000;
				MyCanvas.moveto(0, height - 1);
				MyCanvas.lineto(width -1, height - 1);
				MyCanvas.lineto(width -1, -1);
				MyCanvas.pen.color := $0242a5c6;
				MyCanvas.moveto(1, Height - 2);
				MyCanvas.lineto(width -2, height - 2);
				MyCanvas.lineto(width -2, 0);
				MyCanvas.pen.color := $02EDF9F9;
				MyCanvas.moveto(width -3 , 1);
				MyCanvas.lineto(1 , 1);
				MyCanvas.lineto(1, height - 2);
			end;
		end;
		if Backbuffering then
			Canvas.Draw(0, 0, Buffer);
	finally
		if Backbuffering then
		Buffer.free;
	end;
end;

procedure TColorButton.mark;
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

procedure TColorButton.demark;
begin
	if marked then
    begin
		marked := false;
        highlighted := false;
		Timer.Free;
		paint;
	end;
end;

procedure TColorButton.blink(Sender: TObject);
begin
	highlighted := not(highlighted);
	paint;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TColorButton]);
end;

end.
