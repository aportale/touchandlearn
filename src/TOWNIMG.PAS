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

unit Townimg;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TOwnImage = class(TGraphicControl)
	private
		WMFbild:TMetaFile;
		FarbPalette:HPalette;
	public
		procedure paint; override;
		constructor Create(AOwner: TComponent); override;
		constructor Create_Setup(AOwner: TComponent; ATop, ALeft, 
		  AWidth, AHeight:Integer; AFarbPalette: HPalette);
		procedure LoadGraphic(DName:String);
		function GetPalette: HPALETTE; override;
		destructor Destroy; override;
	end;

procedure Register;

implementation

constructor TOwnImage.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	WMFbild := TMetaFile.Create;
end;

constructor TOwnImage.Create_Setup(AOwner: TComponent; ATop, ALeft, AWidth,
  AHeight:Integer; AFarbPalette: HPalette);
begin
	Create(AOwner);
	FarbPalette := AFarbPalette;
	Setbounds(ATop, ALeft, AWidth, AHeight);
end;

destructor TOwnImage.Destroy;
begin
	Deleteobject(FarbPalette);
	WMFbild.free;
	inherited Destroy;
end;

procedure TOwnImage.LoadGraphic(DName:String);
var	h, w:Longint;
	bscalf:Real;
begin
	wmfbild.LoadFromFile(DName);
	bscalf := width / wmfbild.width;
	w := round(WMFbild.width * bscalf * 96 / screen.pixelsperinch);
	h := round(WMFbild.height * bscalf);
	if height < h then
	begin
		bscalf := height / h;
		w := round(w * bscalf);
		h := round(h * bscalf);
	end;
	wmfbild.height := h;
	wmfbild.width := w;
	paint;
end;

procedure TOwnImage.Paint;
var	bild:TBitmap;
begin
	bild := TBitmap.Create;
	try
		bild.width := Width;
		bild.Height := Height;
		selectpalette(Bild.Canvas.handle, FarbPalette, FALSE);
		realizepalette(Bild.Canvas.handle);
		Bild.Canvas.Fillrect(rect(0,0,bild.width, bild.height));
		Bild.Canvas.Draw((Width - wmfbild.width) div 2,
		  (Height - wmfbild.height) div 2,wmfbild);
		Canvas.draw(0, 0, bild);
	finally
		bild.free;
	end;
end;

function TOwnImage.GetPalette: HPALETTE;
begin
	result := FarbPalette;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TOwnImage]);
end;

end.
