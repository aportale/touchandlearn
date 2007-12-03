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

unit Taufgdta;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs;

type
	TAufgabenData = class(TComponent)
		private
			rand_list_running:Boolean;
			rand_list:ARRAY[0..63]OF Integer;
			protected
		public
			RAWList:TStringList;
			rand_list_max, rand_list_count:Integer;
			procedure ini_lesen(ini_dat, sektion: String);
			function parsestring(istr:String; index:Integer):String;
			function GetDatSet(id:Integer):String;
			function GetRandDatSet:String;
			function GetDelDatSet(id:Integer):String;
			function GetDat(id, element:Integer):String;
			function GetRandDat(element:Integer):String;
			procedure DelDat(id:Integer);
			function rand:Integer;
			procedure RandListStart(max:Integer);
			procedure RandListStop;
			constructor Create(AOwner:TComponent); override;
			constructor Create_Load(AOwner:TComponent; FileName, 
			  SectionName :string);
			destructor Destroy; override;
end;

procedure Register;

implementation

constructor TAufgabenData.Create (AOwner:TComponent);
begin
	inherited Create(AOwner);
	RAWList := TStringList.create;
	rand_list_running := false;
end;

constructor TAufgabenData.Create_Load(AOwner:TComponent; FileName,
  SectionName :string);
begin
	Create(AOwner);
	ini_lesen(FileName, SectionName);
end;

destructor TAufgabenData.Destroy;
begin
	inherited Destroy;
end;

procedure TAufgabenData.RandListStart(max:Integer);
var	i:Integer;
begin
	rand_list_running := TRUE;
	rand_list_count := 0;
	if max = -1 then rand_list_max := RAWList.count div 2
	else if max > (RAWList.count-1) then rand_list_max := (RAWList.count-1)
	else rand_list_max := max;
	for i := 0 to (max-1) do
		rand_list[i] := -1;
end;

procedure TAufgabenData.RandListStop;
begin
	rand_list_running := FALSE;
end;

function TAufgabenData.rand:Integer;
var	rueckgabe, i:Integer;
	ist_vorhanden:Boolean;
begin
	if rand_list_running then
	begin
		repeat
			ist_vorhanden := FALSE;
			rueckgabe := random(RAWList.count);
			for i := 0 to (rand_list_max-1) do
				if rueckgabe = rand_list[i] then 
					ist_vorhanden := TRUE;
		until not(ist_vorhanden);
		rand_list_count := (rand_list_count + 1) mod rand_list_max;
		if rand_list_count = 0 then randomize;
		rand_list[rand_list_count] := rueckgabe;
	end
	else 
		rueckgabe := random(RAWList.count);
	rand := rueckgabe;
end;

function TAufgabenData.GetDatSet(id:Integer):String;
begin
	if id < RAWList.count then
		GetDatSet := RAWList.strings[id]
	else
		GetDatSet := 'Falscher Zugriff!!;Falscher Zugriff!!;'+
		'Falscher Zugriff!!;Falscher Zugriff!!;';
end;

function TAufgabenData.GetDelDatSet(id:Integer):String;
begin
	GetDelDatSet := GetDatSet(id);
	RAWList.delete(id);
end;

function TAufgabenData.GetRandDatSet:String;
begin
	GetRandDatSet := GetDatSet(rand);
end;

function TAufgabenData.GetDat(id, element:Integer):String;
begin
	GetDat := parsestring(GetDatSet(id), element);
end;

function TAufgabenData.GetRandDat(element:integer):String;
begin
	GetRandDat := GetDat(rand, element);
end;

procedure TAufgabenData.DelDat(id:Integer);
begin
	RAWList.delete(id);
end;

function TAufgabenData.parsestring(istr:String; index:Integer):String;
var 	i:Integer;
begin
	for i := 1 to index-1 do
	begin
		istr :=copy(istr,pos(';',istr)+1,length(istr)-pos(';',istr)+1);
	end;
	if pos(';', istr)>0 then
		istr := copy(istr, 1, pos(';', istr)-1);
	parsestring:=istr;
end;

procedure TAufgabenData.ini_lesen(ini_dat, sektion: String);
var 	lzeile:String;
	infile:TextFile;
	sektion_erreicht:boolean;
begin
	sektion_erreicht:=false;
	assignfile(infile, ini_dat);
	reset(infile);
	while (not EOF(infile)) do
	begin
		readln(infile, lzeile);
		sektion_erreicht := (sektion_erreicht AND NOT(lzeile[1]='['));
		if sektion_erreicht AND NOT(lzeile[1]='#') and not(lzeile='')
		  then RAWList.add(lzeile);	
		sektion_erreicht := 
		  (copy(lzeile,1,length(sektion)+2) = '['+sektion+']')
		  OR sektion_erreicht;
	end;
	closefile(infile);
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TAufgabenData]);
end;

end.
