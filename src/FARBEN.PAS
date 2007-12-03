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

unit Farben;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormPaint(Sender: TObject);
var x, y:integer;
begin
     with canvas do
     begin
          for x:= 0 to 15 do
              for y:= 0 to 15 do
              begin
                    brush.color := $01000000 +x*16 +y;
                    rectangle(x*20, y*20, (x+1)*20, (y+1)*20);
              end;
     end;
end;

end.
