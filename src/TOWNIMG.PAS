unit Townimg;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TOwnImage = class(TGraphicControl)
	private
		WMFbild:TMetaFile;
	public
		procedure paint; override;
		constructor Create(AOwner: TComponent); override;
		constructor Create_Setup(AOwner: TComponent; ATop, ALeft, 
		  AWidth, AHeight:Integer);
		procedure LoadGraphic(DName:String);
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
  AHeight:Integer);
begin
	Create(AOwner);
	Setbounds(ATop, ALeft, AWidth, AHeight);
end;

destructor TOwnImage.Destroy;
begin
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
		Bild.Canvas.Fillrect(rect(0,0,bild.width, bild.height));
		Bild.Canvas.Draw((Width - wmfbild.width) div 2,
		  (Height - wmfbild.height) div 2,wmfbild);
		Canvas.draw(0, 0, bild);
	finally
		bild.free;
	end;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TOwnImage]);
end;

end.
