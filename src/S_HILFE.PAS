unit S_hilfe;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Buttons;

type
  THilfeFenster = class(TForm)
    SpeedButton1: TSpeedButton;
    Memo1: TMemo;
    procedure SpeedButton1Click(Sender: TObject);
  end;

var
  HilfeFenster: THilfeFenster;

implementation

{$R *.DFM}

procedure THilfeFenster.SpeedButton1Click(Sender: TObject);
begin
	close;
end;

end.
