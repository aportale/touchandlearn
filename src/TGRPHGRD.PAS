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
			FarbPalette:HPalette;
			procedure paint; override;
			constructor Create(AOwner: TComponent); override;
			constructor Create_Setup(AOwner:TComponent;ATop, ALeft,
			  AWidth, AHeight:Integer; Aspalten, Azeilen:Word;
			  AContainer:TMetaFileContainer;AFarbPalette:HPalette);
			procedure Init(Anzahl: Integer);
			procedure Init_Spread(grd1:TGraphicGrid; grd1_n:Integer;
			  grd2:TGraphicGrid; grd2_n:Integer);
			procedure Clear;
			procedure ClearCell(ASpalte, AZeile: Integer);
			procedure SetCell_XY(Aspalte, AZeile:Integer; 
			  BildID:TMetaFile);
			procedure SetCell_POS(Position: byte; BildID:TMetaFile);
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
  AHeight:Integer; Aspalten, Azeilen:Word; AContainer: TMetaFileContainer;
  AFarbPalette: HPalette);
begin
	Create(AOwner);
	FarbPalette := AFarbPalette;
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
	Deleteobject(FarbPalette);
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
		selectPalette(Bild.Canvas.handle, FarbPalette, FALSE);
		Bild.Canvas.Draw((Bild.Width div Spalten) * (ASpalte - 1),
		  (Bild.Height div Zeilen) * (AZeile - 1), BildID);
	end;
	inc(Bilderanzahl);
end;

procedure TGraphicGrid.SetCell_POS(Position: byte; BildID:TMetaFile);
var	x_Pos, y_Pos:byte;
	z:word;
begin
	z := Zeilen;
	asm
		xor AH, AH
		mov al, Position
		mov bx, z
		div bl
		inc al
		cmp ah, 0
		jnz @weiter
		mov ah, bl
		dec al
		@weiter:
		mov x_pos, al
		mov y_pos, ah
	end;
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
var 	i, BildID:Integer;
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
	selectPalette(Canvas.handle, FarbPalette, FALSE);
	realizepalette(Canvas.handle);
	Canvas.Stretchdraw(Drawrect, bild);
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TGraphicGrid]);
end;

end.