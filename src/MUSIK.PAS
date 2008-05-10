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

unit Musik;

interface

Type
	TNotenData = Record
		Spalte, Zeile, Wichtung:Integer;
	end;
	TNotenDataTRLTab = Record
		NotenData:TNotenData;
		Key:Integer;
	end;

Const NotenDataTRLTab:ARRAY [1..17] of TNotenDataTRLTab =
	((NotenData:( Spalte:-1;  Zeile:0;  Wichtung:0 );  Key:1 ),
	(NotenData:( Spalte:-1;  Zeile:0;  Wichtung:1 );  Key:2 ),
	(NotenData:( Spalte:-1;  Zeile:1;  Wichtung:-1 );  Key:2 ),
	(NotenData:( Spalte:-1;  Zeile:1;  Wichtung:0 );  Key:3 ),
	(NotenData:( Spalte:-1;  Zeile:1;  Wichtung:1 );  Key:4 ),
	(NotenData:( Spalte:-1;  Zeile:2;  Wichtung:-1 );  Key:4 ),
	(NotenData:( Spalte:-1;  Zeile:2;  Wichtung:0 );  Key:5 ),
	(NotenData:( Spalte:-1;  Zeile:3;  Wichtung:0 );  Key:6 ),
	(NotenData:( Spalte:-1;  Zeile:3;  Wichtung:1 );  Key:7 ),
	(NotenData:( Spalte:-1;  Zeile:4;  Wichtung:-1 );  Key:7 ),
	(NotenData:( Spalte:-1;  Zeile:4;  Wichtung:0 );  Key:8 ),
	(NotenData:( Spalte:-1;  Zeile:4;  Wichtung:1 );  Key:9 ),
	(NotenData:( Spalte:-1;  Zeile:5;  Wichtung:-1 );  Key:9 ),
	(NotenData:( Spalte:-1;  Zeile:5;  Wichtung:0 );  Key:10),
	(NotenData:( Spalte:-1;  Zeile:5;  Wichtung:1 );  Key:11),
	(NotenData:( Spalte:-1;  Zeile:6;  Wichtung:-1 );  Key:11),
	(NotenData:( Spalte:-1;  Zeile:6;  Wichtung:0 );  Key:12));

	Function KeytoNotenData(AKey: Integer):TNotenData;

implementation

Function KeytoNotenData(AKey: Integer):TNotenData;
var i:Integer;
begin
	For i := 1 to 17 do
	begin
		If NotenDataTRLTab[i].Key = AKey then
		begin
			result := NotenDataTRLTab[i].NotenData;
			break;
		end;
	end;
end;

end.
