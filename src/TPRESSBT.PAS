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
		FarbPalette:HPalette;
		PaintModus:Integer;
	public
		procedure paint; override;
		constructor Create(AOwner: TComponent); override;
		constructor Create_Set(AOwner: TComponent;
		  AFarbPalette: HPalette; APaintmodus:Integer);
		constructor Create_Load(AOwner: TComponent; unpressed, 
		  pressed:String; AFarbPalette: HPalette; APaintmodus:Integer);
		procedure setGraphics(unpressed, pressed:String);
		procedure MouseDown(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		destructor Destroy; override;
		function GetPalette: HPALETTE; override;
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

constructor TWMFPressButton.Create_Set(AOwner: TComponent; AFarbPalette: HPalette; APaintmodus:Integer);
begin
	Create(AOwner);
	FarbPalette := AFarbPalette;
	Paintmodus := APaintmodus;
end;

constructor TWMFPressButton.Create_Load(AOwner: TComponent; unpressed,
  pressed: String; AFarbPalette: HPalette; APaintmodus:Integer);
begin
	Create_Set(AOwner, AFarbpalette, APaintmodus);
	setGraphics(unpressed, pressed);
end;

destructor TWMFPressButton.Destroy;
begin
	Fbutton1.Free;
	Fbutton2.Free;
	inherited Destroy;
end;

function TWMFPressButton.GetPalette: HPALETTE;
begin
	result := FarbPalette;
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
		SelectPalette(Canvas.handle, FarbPalette, FALSE);
		RealizePalette(Canvas.handle);
		if ungedrueckt then Canvas.stretchDraw(Clientrect, Fbutton1)
		else Canvas.stretchDraw(Clientrect, Fbutton2)
	end
	else
	begin
		Buffer := TBitmap.Create;
		try
			Buffer.Height := Height;
			Buffer.Width := Width;
			SelectPalette(Buffer.Canvas.handle, FarbPalette, FALSE);
			RealizePalette(Buffer.Canvas.handle);
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
