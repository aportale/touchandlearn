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
