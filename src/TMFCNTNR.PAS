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
	along with Touch'n'learn; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
}

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
