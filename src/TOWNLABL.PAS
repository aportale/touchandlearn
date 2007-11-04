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
		procedure paint; override;
		procedure blink(Sender: TObject);
	public
		FarbPalette:HPalette;
		caption, fontname:String;
		Afontsize:Integer;
		Timer:TTimer;
		Backcolor:TColor;
		Text :String;
		AColor:Array[0..1] of TColor;
		ActualColor:Integer;
		BlinkerSet:Integer;
		constructor Create(AOwner: TComponent;
                  AFarbPalette:HPalette);
		procedure SetCaption(ACaption:String);
		procedure mark;
		procedure demark;
		procedure SetFontSize(Value: Integer);
                procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
                  override;
		function GetPalette: HPALETTE; override;
	published
		property Fontsize:Integer write SetFontSize;
	end;

procedure Register;

implementation

constructor TOwnLabel.Create(AOwner: TComponent; AFarbPalette:HPalette);
begin
	inherited Create(AOwner);
        FarbPalette := AFarbPalette;
	marked := false;
        Backcolor := $0282bc8c;
	AColor[0] := $0289fcfd;
	AColor[1] := $02397148;
	ActualColor := 0;
end;

function TOwnLabel.GetPalette: HPALETTE;
begin
	result := FarbPalette;
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
var	AText: Array[0..79]of Char;
begin
    SelectPalette(Canvas.handle, FarbPalette, TRUE);
    RealizePalette(Canvas.handle);
    StrPCopy(Atext, Caption);
    canvas.font.name := fontname;
    canvas.font.size := Afontsize;
    canvas.brush.color := AColor[ActualColor];
    {canvas.Fillrect(Clientrect);}
    canvas.pen.style := psclear;
    canvas.roundrect(0, 0, width+1, height+1, roundamount, roundamount);
    setbkmode(Canvas.handle, 1);
    drawtext(canvas.handle, Atext, strlen(Atext), Clientrect, 53);
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
