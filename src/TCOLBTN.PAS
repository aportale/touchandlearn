unit Tcolbtn;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, ExtCtrls;


type
	TColorButton = class(TGraphicControl)

	private
		unpressed: boolean;
		FarbPalette: HPalette;
		Timer: TTimer;
		procedure blink(Sender: TObject);

	protected
		procedure Paint; override;

	public
		marked:boolean;
		highlighted:boolean;
		Backbuffering:boolean;
		caption, fontname:String;
		afontsize:Integer;
		AClickable, AIsenabled:Boolean;
		constructor Create(AOwner: TComponent); override;
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

constructor TColorButton.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
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
	Buffer:TBitmap;
	MyCanvas:TCanvas;
	RectCopy: TRect;
begin
	Buffer := TBitmap.Create;
	if Backbuffering then
	begin
		MyCanvas := Buffer.Canvas;
	end
	else MyCanvas := Canvas;
	try
		if Backbuffering then
		begin
			Buffer.Height := Height;
			Buffer.Width := Width;
		end;
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
					MyCanvas.Fillrect(ClientRect);
					MyCanvas.pen.color := $02000000;
					MyCanvas.font.color := $02000000;
					setbkmode(MyCanvas.handle, 1);
					RectCopy := ClientRect;
					drawtext(MyCanvas.handle, Atext, strlen(Atext), RectCopy, 53);
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
					MyCanvas.Fillrect(RectCopy);
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
					RectCopy := rect(1, 1, width+1, height+1);
					drawtext(MyCanvas.handle, Atext, 
					  strlen(Atext), RectCopy, 53);
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
				RectCopy := rect(1,1,width+1,height+1);
				drawtext(MyCanvas.handle, Atext, strlen(Atext), RectCopy, 53);
				MyCanvas.font.color := $0242a5c6;
				setbkmode(MyCanvas.handle, 1);
				RectCopy := Clientrect;
				drawtext(MyCanvas.handle, Atext, strlen(Atext), RectCopy, 53);
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
