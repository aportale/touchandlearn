unit Tools;

interface

uses
	mmsystem, sysutils, Forms;

const
	SND_RICHTIG = 1;
	SND_SCHRITT_RICHTIG = 2;
	SND_FALSCH = 3;
	SND_NOCHMAL = 4;
	SND_ENDE = 5;
	SND_HILFE = 6;

var	Path:String;

procedure Playsound(id:Integer);
function sca_x(coord: Integer):integer;
function sca_y(coord: Integer):integer;

implementation

const
	Wavdateien:Array[1..6] of String =
	('richtig.wav', 'srichtig.wav', 'falsch.wav', 'nochmal.wav',
	  'ende.wav', 'hilfe.wav');

var	s_Filename:Array[0..80] of CHAR;
	sca_faktor_x, sca_faktor_y :Real;

procedure Playsound(id:Integer);
begin
	strPcopy(s_Filename, path + 'sound\'+Wavdateien[id]);
	if WaveOutGetNumDevs > 0 then
		sndplaysound(s_filename, SND_ASYNC);
end;

function sca_x(coord: Integer):integer;
begin
	sca_x := round(sca_faktor_x * coord);
end;

function sca_y(coord: Integer):integer;
begin
	sca_y := round(sca_faktor_y * coord);
end;

begin

Path := ExtractFilePath(paramstr(0));
sca_faktor_x := Screen.Width / 800;
sca_faktor_y := Screen.Height / 600;

end.
