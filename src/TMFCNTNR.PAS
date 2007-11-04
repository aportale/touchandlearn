unit Tmfcntnr;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TMetaFileContainer = class(TComponent)
	public
		Bilderanzahl:Integer;
		Bild:Array[1..8]of TMetaFile;
		constructor Create(AOwner: TComponent); override;
		Procedure LoadGraphic(Filename:String; Anzahl:Integer);
		function randombild:TMetaFile;
		destructor Destroy; override;
	end;

procedure Register;

implementation

constructor TMetaFileContainer.Create(AOwner: TComponent);
var	i:Integer;
begin
	inherited create(AOwner);
	For i := 1 to 8 do
		bild[i] := TMetaFile.Create;
end;

destructor TMetaFileContainer.Destroy;
var	i:Integer;
begin
	For i := 1 to 8 do
		bild[i].free;
	inherited destroy;
end;

procedure TMetaFileContainer.LoadGraphic(Filename:String; Anzahl:Integer);
var	i:Integer;
begin
	if Anzahl > 8 then Anzahl := 8;
	Bilderanzahl := Anzahl;
	for i := 1 to Anzahl do
		bild[i].LoadFromFile(Filename+inttostr(i)+'.wmf');
end;

function TMetaFileContainer.randombild:TMetaFile;
begin
	randombild := Bild[1];
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TMetaFileContainer]);
end;

end.
