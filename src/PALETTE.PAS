unit Palette;

interface

Uses
	WinTypes, Graphics, WinProcs;

var	OwnPaletteHandle: HPALETTE;
	procedure GetOwnPalette;
	procedure DropOwnPalette;

implementation

const
	OwnPaletteEntries = 42;
	OwnPalette: Array[0..OwnPaletteEntries-1]of Array[0..2] of Byte =
	(
	(($00),($00),($00)),	{Buttons}
	(($c6),($a5),($42)),
	(($e7),($d6),($ad)),
	((249),(249),(237)),
	((128),(194),(255)),
	((194),(194),(0)),
	((255),(255),(255)),
	((194),(255),(128)),	{Fisch}
	((0),(194),(0)),
	((255),(255),(128)),	{Kerze}
	((255),(128),(128)),
	((194),(0),(0)),
	((161),(161),(161)),	{Schere}
	((255),(255),(0)),	{Blume}
	((128),(64),(0)),	{Banane}
	((0),(0),(255)),	{Roboter}
	((224),(224),(224)),
	((192),(192),(192)),	{Elefant}
	((255),(128),(0)),	{Flugzeug}
	((249),(182),(40)),	{Hahn}
	((0),(64),(128)),
	((13),(77),(102)),
	((26),(90),(77)),
	((38),(102),(51)),
	((51),(115),(26)),
	((64),(128),(0)),
	((255),(0),(0)),	{Äpfel}
	((161),(97),(33)),
	((198),(0),(0)),
	((128),(255),(0)),
	((255),(28),(0)),
	((255),(192),(128)),   	{Fische}
	((128),(0),(64)),
	(($fd),($fc),($89)),	{WMFButtons}
	(($48),($71),($39)),
	((64),(64),(64)),	{Menu}
	((255),(192),(128)),
	((194),(0),(0)),
	((128),(128),(128)),
	((255),(255),(128)),
	((225),(210),(39)),
	((140),(188),(130))	{minzgrün}
	);
	(* (($),($),($)), *)
	(* ((),(),()), *)

var	i: Integer;
	OwnPalettePointer: PLOGPALETTE;
	OwnPaletteSize: LongInt;

procedure GetOwnPalette;
begin
	OwnPaletteSize := SizeOf(TLogPalette) + 
	  OwnPaletteEntries * SizeOf(TPaletteEntry);
	OwnPalettePointer := MemAlloc(OwnPaletteSize);
	OwnPalettePointer^.PalVersion := $300;
	OwnPalettePointer^.PalNumEntries := OwnPaletteEntries;
	{$R-}
	for i := 0 to (OwnPaletteEntries - 1)  do
	begin
		OwnPalettePointer^.palPalEntry[i].peRed := OwnPalette[i, 0];
		OwnPalettePointer^.palPalEntry[i].peGreen := OwnPalette[i, 1];
		OwnPalettePointer^.palPalEntry[i].peBlue := OwnPalette[i, 2];
		OwnPalettePointer^.palPalEntry[i].peFlags := PC_RESERVED;
	end;
	{$R+}
	OwnPaletteHandle := CreatePalette(OwnPalettePointer^);
	FreeMem(OwnPalettePointer, OwnPaletteSize);
end;

procedure DropOwnPalette;
begin
	DeleteObject(OwnPaletteHandle);
end;

end.
