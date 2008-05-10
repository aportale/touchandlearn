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

unit Tpressbt;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TWMFPressButton = class(TGraphicControl)
	private
		Fbutton1:TMetafile;
		Fbutton2:TMetafile;
		ungedrueckt:boolean;
		PaintModus:Integer;
	public
		procedure Paint; override;
		constructor Create(AOwner: TComponent); override;
		constructor Create_Set(AOwner: TComponent;
		  APaintmodus:Integer);
		constructor Create_Load(AOwner: TComponent; unpressed,
		  pressed:String; APaintmodus:Integer);
		procedure setGraphics(unpressed, pressed:String);
		procedure MouseDown(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		destructor Destroy; override;
	published
		property OnClick;
		property OnMouseDown;
		property OnMouseUp;
	end;

procedure Register;

implementation

constructor TWMFPressButton.Create(AOwner:Tcomponent);
begin
	inherited Create(aowner);
	ungedrueckt := true;
	width := 100;
	height := 100;
	Fbutton1:= TMetaFile.Create;
	Fbutton2:= TMetaFile.Create;
end;

constructor TWMFPressButton.Create_Set(AOwner: TComponent; APaintmodus:Integer);
begin
	Create(AOwner);
	Paintmodus := APaintmodus;
end;

constructor TWMFPressButton.Create_Load(AOwner: TComponent; unpressed,
  pressed: String; APaintmodus:Integer);
begin
	Create_Set(AOwner, APaintmodus);
	setGraphics(unpressed, pressed);
end;

destructor TWMFPressButton.Destroy;
begin
	Fbutton1.Free;
	Fbutton2.Free;
	inherited Destroy;
end;

procedure TWMFPressButton.setGraphics(unpressed, pressed:String);
begin
	Fbutton1.LoadFromFile(unpressed);
	Fbutton2.LoadFromFile(pressed);
end;

procedure TWMFPressButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if (Button = mbLeft) then
	begin
		inherited MouseDown(Button, Shift, X, Y);
		ungedrueckt := false;
		paint;
	end;
end;

procedure TWMFPressButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	inherited MouseDown(Button, Shift, X, Y);
	ungedrueckt := true;
	paint;
end;

procedure TWMFPressButton.Paint;
var	Buffer:TBitmap;
begin
	if Paintmodus = 1 then
	begin
		if ungedrueckt then Canvas.stretchDraw(Clientrect, Fbutton1)
		else Canvas.stretchDraw(Clientrect, Fbutton2)
	end
	else
	begin
		Buffer := TBitmap.Create;
		try
			Buffer.Height := Height;
			Buffer.Width := Width;
			if ungedrueckt then
				Buffer.Canvas.stretchDraw(Clientrect, Fbutton1)
			else Buffer.Canvas.stretchDraw(Clientrect, Fbutton2);
			Canvas.Draw(0, 0, Buffer);
		finally
			Buffer.free;
		end;
	end;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TWMFPressButton]);
end;

end.
