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
