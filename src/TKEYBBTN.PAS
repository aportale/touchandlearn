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
