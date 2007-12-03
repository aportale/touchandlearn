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

unit Tgrphgrd;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, StdCtrls, ExtCtrls, Tmfcntnr;

type
	TGraphicGrid = class(TGraphicControl)
		private
			Spalten, Zeilen:word;
			Container:TMetaFileContainer;
			DrawRect:Trect;
		public
			Bilderanzahl:Integer;
			bild:TBitmap;
			procedure Paint; override;
			constructor Create(AOwner: TComponent); override;
			constructor Create_Setup(AOwner:TComponent;ATop, ALeft,
			  AWidth, AHeight:Integer; Aspalten, Azeilen:Word;
			  AContainer:TMetaFileContainer);
			procedure Init(Anzahl: Integer);
			procedure Init_Spread(grd1:TGraphicGrid; grd1_n:Integer;
			  grd2:TGraphicGrid; grd2_n:Integer);
			procedure Clear;
			procedure ClearCell(ASpalte, AZeile: Integer);
			procedure SetCell_XY(Aspalte, AZeile:Integer; 
			  BildID:TMetaFile);
			procedure SetCell_POS(Position: integer; BildID:TMetaFile);
			procedure Add_Picture(BildID:TMetaFile);
			destructor Destroy; override;
	end;

procedure Register;

implementation

constructor TGraphicGrid.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	bild := TBitmap.Create;
	Bilderanzahl := 0;
end;

constructor TGraphicGrid.Create_Setup(AOwner: TComponent; ATop, ALeft, AWidth,
  AHeight:Integer; Aspalten, Azeilen:Word; AContainer: TMetaFileContainer);
begin
	Create(AOwner);
	if Aspalten = 0 then Aspalten := 1;
	if Azeilen = 0 then Azeilen := 1;
	Spalten := Aspalten;
	Zeilen := Azeilen;
	Setbounds(ATop, ALeft, AWidth, AHeight);
	if (AWidth div Aspalten) < (AHeight div AZeilen) then
	begin
		DrawRect:=rect(0,(AHeight-Azeilen*(AWidth div Aspalten)) div 2,
		  AWidth,AHeight-(AHeight-Azeilen*(AWidth div Aspalten)) div 2);
		AHeight := Azeilen *(AWidth div Aspalten);
	end
	else
	begin
		DrawRect:=rect((AWidth-Aspalten*(AHeight div AZeilen)) div 2,0,
		AWidth-(AWidth-Aspalten*(AHeight div AZeilen)) div 2, AHeight);
		AWidth := Aspalten *(AHeight div AZeilen);
	end;
	bild.width := AWidth;
	bild.Height := AHeight;
	Container := AContainer;
end;

destructor TGraphicGrid.Destroy;
begin
	bild.free;
	inherited Destroy;
end;

procedure TGraphicGrid.SetCell_XY(Aspalte, AZeile:Integer; BildID:TMetaFile);
begin
	if Container <> nil then
	begin
		BildID.Width := 
		  Round(Bild.Width / Spalten * 96 / screen.pixelsperinch);
		BildID.Height := Bild.Height div Zeilen;
		Bild.Canvas.Draw((Bild.Width div Spalten) * (ASpalte - 1),
		  (Bild.Height div Zeilen) * (AZeile - 1), BildID);
	end;
	inc(Bilderanzahl);
end;

procedure TGraphicGrid.SetCell_POS(Position: integer; BildID:TMetaFile);
var	x_Pos, y_Pos: integer;
begin
	x_Pos := ((Position - 1) div 5) + 1;
	y_Pos := ((Position - 1) mod 5) + 1;
	SetCell_XY(x_Pos, y_Pos, BildID);
end;

procedure TGraphicGrid.Clear;
begin
	Bild.Canvas.Fillrect(clientrect);
	BilderAnzahl := 0;
end;

procedure TGraphicGrid.ClearCell(ASpalte, AZeile:Integer);
begin
	Bild.Canvas.Fillrect(rect((Width div Spalten) * (ASpalte - 1),
	  (Height div Zeilen) * (AZeile - 1), (Width div Spalten) * (ASpalte),
	  (Height div Zeilen) * (AZeile)));
end;

procedure TGraphicGrid.Init(Anzahl: Integer);
var
	i: Integer;
begin
	Clear;
	For i := 1 to Anzahl do
	begin
		SetCell_POS(i,Container.Bild[random(Container.Bilderanzahl)+1]);
	end;
	paint;
end;

procedure TGraphicGrid.Init_Spread(grd1:TGraphicGrid; grd1_n:Integer;
  grd2:TGraphicGrid; grd2_n:Integer);
var	i:Integer;
	BildID:TMetaFile;
begin
	Clear;
	grd1.Clear;
	grd2.Clear;
	for i := 1 to grd1_n do
	begin
		BildId := Container.Bild[random(Container.Bilderanzahl)+1];
		add_Picture(BildID);
		grd1.add_Picture(BildID);
	end;
	for i := 1 to grd2_n do
	begin
		BildId := Container.Bild[random(Container.Bilderanzahl)+1];
		add_Picture(BildID);
		grd2.add_Picture(BildID);
	end;
	grd1.paint;
	grd2.paint;
	paint;
end;

procedure TGraphicGrid.Add_Picture(BildID:TMetaFile);
begin
	SetCell_POS(Bilderanzahl + 1, BildID);
end;

procedure TGraphicGrid.Paint;
begin
	inherited paint;
	Canvas.Stretchdraw(Drawrect, bild);
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TGraphicGrid]);
end;

end.
