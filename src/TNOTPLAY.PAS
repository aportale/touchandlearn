unit Tnotplay;

interface

uses 
	mplayer, sysutils;

type
	TNotenPlayer = class(Tobject)
	public
		midipath:String;
		MediaPlayer:TMediaPlayer;
		constructor Create_Set(AMediaPlayer:TMediaPlayer; 
		  AMidiPath:String);
		procedure PlayNote(NoteId:Integer);
	end;

implementation

Constructor TNotenPlayer.Create_Set(AMediaPlayer:TMediaPlayer;AMidiPath:String);
begin
	inherited create;
	MediaPlayer:=AMediaPlayer;
	midipath:=Amidipath;
end;

procedure TNotenPlayer.PlayNote(NoteId:Integer);
begin
	Mediaplayer.Filename := MidiPath+inttostr(NoteId)+'.mid';
	Mediaplayer.Open;
	Mediaplayer.Wait := True;
	Mediaplayer.Play;
	MediaPlayer.Close;
end;

end.
