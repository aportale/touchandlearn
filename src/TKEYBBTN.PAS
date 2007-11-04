unit Tkeybbtn;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TKeyboardTaste = class(Tobject)
	private
		Top, Left, Width, Height:Integer;
	public
		ButtonType:Integer;
		Area:TRect;
		unpressed:Boolean;
		constructor Create;
		Procedure SetArea(AArea:TRect);
		Procedure SetButtonType(AButtonType:Integer);
		Procedure Paint(Canvas:TCanvas);
		Procedure Press;
		Procedure Release;
		Function IsClicked(X_Pos, Y_Pos:Integer): Boolean;
	end;

implementation

Constructor TKeyboardTaste.Create;
begin
	unpressed := TRUE;
end;

Procedure TKeyboardTaste.Paint(Canvas:TCanvas);
begin
	if (ButtonType = 1) then
	begin
		if not unpressed then
			Canvas.brush.color := clOlive
		else
			Canvas.Brush.Color := clWhite;
		Canvas.Fillrect(Area);
		Canvas.Pen.Color := clBlack;
		Canvas.Rectangle(Left, Top, Left+Width, Top+Height);
		Canvas.Pixels[Left+1, Top+1] := clBlack;
		Canvas.Pixels[Area.Right-2, Top+1] := clBlack;
		Canvas.Pixels[Area.Right-2, Area.Bottom-2] := clBlack;
		Canvas.Pixels[Left+1, Area.Bottom-2] := clBlack;
		canvas.moveto(Left+3, Area.Bottom-4);
		canvas.lineto(Area.Right-4, Area.Bottom-4);
		canvas.moveto(Area.Right-4, Area.Bottom-5);
		canvas.lineto(Area.Right-4, Top+4)
	end
	else
	begin
		if not unpressed then
			Canvas.brush.color := clolive
		else
			Canvas.Brush.Color := clBlack;
		Canvas.Fillrect(Area);
		Canvas.Pen.Color := clWhite;
		canvas.moveto(Area.Right-4, Area.Top+3);
		canvas.lineto(Area.Left+3, Area.Top+3);
		canvas.moveto(Area.Left+3, Area.Top+4);
		canvas.lineto(Area.Left+3, Area.Bottom-4)
	end;
end;

Procedure TKeyboardTaste.Press;
begin
	unpressed := False;
end;

Procedure TKeyboardTaste.Release;
begin
	unpressed := True;
end;

Procedure TKeyboardTaste.SetArea(AArea:TRect);
begin
	Area := AArea;
	Top := Area.Top;
	Left := Area.Left;
	Width := Area.Right - Area.Left;
	Height := Area.Bottom - Area.Top;
end;

Procedure TKeyboardTaste.SetButtonType(AButtonType:Integer);
begin
	ButtonType := AButtonType;
end;

Function TKeyboardTaste.IsClicked(X_Pos, Y_Pos:Integer): Boolean;
begin
	Result := PtInRect(Area, point(X_Pos, Y_Pos));
end;

end.
