unit Tnoten;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, Musik, ExtCtrls;

type
	TNotenSys = class(TGraphicControl)
	private
		NotenSWMF, NoteWMF, BWMF, ZaunWMF: TMetafile;
		LinienAbstand, LinienOffset, NotenOffset, Zaun_y_Offset,
		  Zaun_x_offset, B_y_Offset, B_x_Offset, LinienYPos,
		  SpaltenOffset, Spaltenabstand, HLinien_x_Offset,
		  HLinienLaenge, Markier_y_Offset, Markier_Breite:Real;
		FarbPalette: HPalette;
		Notenanzahl, Spaltenanzahl, Rahmendicke:Integer;
		NotenData:ARRAY[1..8]of TNotenData;
		Paintanzahl:Integer;
        	Timer :TTimer;
        	procedure blink(Sender: TObject);
	public
        	highlighted, marked:boolean;
		unpressed, Aclickable, AIsenabled:boolean;
		MarkierteSpalte:Integer;
		procedure paint; override;
		procedure MouseDown(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		procedure MouseUp(Button: TMouseButton;
		  Shift: TShiftState; X, Y: Integer); override;
		Procedure AddNote(Spalte, Zeile, Wichtung:Integer;
		  ARepaint:Boolean);
		Procedure ResetNotes;
		procedure mark;
		procedure demark;
		procedure markiereSpalte(ASpalte:Integer);
		procedure Setclickable(Value: Boolean);
		procedure SetIsEnabled(Value: Boolean);
		function GetIsEnabled:Boolean;
		constructor Create(AOwner: TComponent; pos_x, pos_y, breite,
		  hoehe, ASpaltenAnzahl :Integer; wmfpfad:String;
		  AFarbPalette: HPalette);
		destructor Destroy; override;
	published
		property OnClick;
		property OnMouseDown;
		property OnMouseUp;
		property clickable:Boolean write Setclickable;
		property isenabled:Boolean read GetIsEnabled write SetIsEnabled;
		property enabled;
	end;

procedure Register;

implementation

constructor TNotenSys.Create(AOwner: TComponent; pos_x, pos_y, breite, hoehe,
  ASpaltenAnzahl :Integer; wmfpfad:String; AFarbPalette: HPalette);
begin
	inherited Create(AOwner);
	FarbPalette := AFarbPalette;
	SetBounds(pos_x, pos_y, breite, hoehe);
	NotenSWMF := TMetaFile.Create;
	NotenSWMF.LoadFromFile(wmfpfad+'notensl.wmf');
	NotenSWMF.Height := hoehe;
	NotenSWMF.Width := Round(Hoehe * 0.38 * 96/screen.pixelsperinch);
	NoteWMF := TMetaFile.Create;
	NoteWMF.LoadFromFile(wmfpfad+'note.wmf');
	NoteWMF.Height := Round(Hoehe * 0.182);
	NoteWMF.Width := Round(NoteWMF.Height * 1.25 * 96/screen.pixelsperinch);
	ZaunWMF := TMetaFile.Create;
	ZaunWMF.LoadFromFile(wmfpfad+'zaun.wmf');
	ZaunWMF.Height := Round(Hoehe * 0.45);
	ZaunWMF.Width := Round(ZaunWMF.Height * 0.45 * 96/screen.pixelsperinch);
	BWMF := TMetaFile.Create;
	BWMF.LoadFromFile(wmfpfad+'B.wmf');
	BWMF.Height := Round(Hoehe * 0.34);
	BWMF.Width := Round(BWMF.Height * 0.45 * 96/screen.pixelsperinch);
	unpressed:=TRUE;
	SpaltenAnzahl := ASpaltenAnzahl;
	SpaltenAbstand := ((Width - NotenSWMF.Width)/SpaltenAnzahl);
	SpaltenOffset := NotenSWMF.Width + Spaltenabstand/2 - NoteWMF.Width/2;
	Notenanzahl:=0;
	LinienOffset := Clientrect.Bottom / 4.8;
	LinienAbstand := Clientrect.Bottom / 14.2;
	NotenOffset := Clientrect.Bottom / 5.3;
	Zaun_y_Offset := Clientrect.Bottom / 15;
	Zaun_x_Offset := -(Clientrect.Bottom / 5);
	Markier_y_Offset := SpaltenOffset-(Clientrect.Bottom / 4.3);
	Markier_Breite := (Clientrect.Bottom / 1.37);
	B_y_Offset := Clientrect.Bottom / 20;
	B_x_Offset := -(Clientrect.Bottom / 6.2);
	HLinien_x_Offset := NotenOffset*0.1;
	HLinienLaenge := NoteWMF.Width * 1.15;
	Rahmendicke := Round(Height * 0.045);
	Aclickable := TRUE;
	AIsenabled := TRUE;
	highlighted := false;
	marked := false;
	MarkierteSpalte:=-1;
	Paintanzahl := 0;
end;

destructor TNotenSys.Destroy;
Begin
	DeleteObject(FarbPalette);
	NotenSWMF.Free;
	NoteWMF.Free;
	ZaunWMF.Free;
	BWMF.Free;
	inherited Destroy;
end;

procedure TNotenSys.Setclickable(Value: Boolean);
begin
	Aclickable := value;
end;

function TNotenSys.GetIsEnabled:Boolean;
begin
	result := AIsEnabled;
end;

procedure TNotenSys.SetIsEnabled(Value: Boolean);
begin
	if (AIsenabled)<>(Value) then
	begin
		AIsEnabled := Value;
		Paint;
	end;
end;

procedure TNotenSys.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if (Button = mbLeft)and Aclickable then
	begin
		unpressed := false;
        highlighted := true;
        demark;
		paint;
	end;
end;

procedure TNotenSys.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if (Button = mbLeft)and not(unpressed) then
	begin
		unpressed := true;
        highlighted := false;
        demark;
		paint;
	end;
end;

Procedure TNotenSys.ResetNotes;
Begin
	NotenAnzahl := 0;
End;

Procedure TNotenSys.AddNote(Spalte, Zeile, Wichtung:Integer; ARepaint:Boolean);
begin
	inc(NotenAnzahl);
	Notendata[NotenAnzahl].Spalte := Spalte;
	Notendata[NotenAnzahl].Zeile := Zeile;
	Notendata[NotenAnzahl].Wichtung := Wichtung;
	if ARepaint then paint;
end;

procedure TNotenSys.markiereSpalte(ASpalte:Integer);
begin
	if ASpalte <> MarkierteSpalte then
	begin
		MarkierteSpalte := ASpalte;
		Paint;
	end;
end;

procedure TNotenSys.Paint;
var	i:Integer;
	Buffer:TBitmap;
Begin
	inc(Paintanzahl);
	Buffer := TBitmap.Create;
	try
		Buffer.Height := Height;
		Buffer.Width := Width;
		SelectPalette(Buffer.Canvas.handle, FarbPalette, FALSE);
		RealizePalette(Buffer.Canvas.handle);
		if ((highlighted) and AIsEnabled) then
		begin
			Buffer.Canvas.Brush.Color := clOlive;
                        Buffer.Canvas.Pen.style := psclear;
			Buffer.Canvas.Roundrect(0, 0, width+1, height+1,
                          RahmenDicke*3, RahmenDicke*3);
			Buffer.Canvas.Brush.Color := clWHITE;
			{Buffer.Canvas.Fillrect(rect(Clientrect.Left+Rahmendicke,
			  Clientrect.Top+Rahmendicke,
			  Clientrect.Right-Rahmendicke,
			  Clientrect.Bottom-Rahmendicke));}
			Buffer.Canvas.Roundrect(Rahmendicke, Rahmendicke,
                          width+1-Rahmendicke, height+1-Rahmendicke,
                          RahmenDicke, RahmenDicke);
                        Buffer.Canvas.Pen.style := pssolid;
		end
		else
		begin
			Buffer.Canvas.Brush.Color := clWHITE;
			Buffer.Canvas.Fillrect(Clientrect);
		end;
		Buffer.Canvas.Draw(0, 0, NotenSWMF);
		if MarkierteSpalte >= 0 then
		begin
			Buffer.Canvas.Brush.Color := PaletteIndex(2);
			{Buffer.Canvas.Fillrect(rect(Round(Markier_y_Offset+
			  MarkierteSpalte*(spaltenabstand)),0,
			  Round(Markier_y_Offset+MarkierteSpalte*
			  (spaltenabstand)+Markier_Breite), height));}
                        Buffer.Canvas.Pen.style := psclear;
                        Buffer.Canvas.Roundrect(Round(Markier_y_Offset+
			  MarkierteSpalte*(spaltenabstand)),0,
			  Round(Markier_y_Offset+MarkierteSpalte*
			  (spaltenabstand)+Markier_Breite), height,
                          Rahmendicke*4, Rahmendicke*4);
                        Buffer.Canvas.Pen.style := pssolid;
		end;
		Buffer.Canvas.Pen.width := 2;
		Buffer.Canvas.Pen.Color := clblack;
		For i := 1 to 5 do
		begin
			LinienYPos := (i-1)*2*LinienAbstand + LinienOffset;
			Buffer.Canvas.MoveTo(0, round(LinienYPos));
			Buffer.Canvas.LineTo(Clientrect.Right,
			  round(LinienYPos));
		end;
		For i := 1 to NotenAnzahl do
		begin
			Buffer.Canvas.Draw(Round(SpaltenOffset+
			  NotenData[i].Spalte*SpaltenAbstand),
			  Round(Notenoffset+(9-NotenData[i].Zeile)*
			  Linienabstand), NoteWMF);
			if (NotenData[i].Zeile <= 0) then
			begin
				LinienYPos := (5-NotenData[i].Zeile)*
				  2*LinienAbstand + LinienOffset;
				Buffer.canvas.moveto(Round(SpaltenOffset-
				  HLinien_x_Offset+NotenData[i].Spalte*
				  SpaltenAbstand), Round(LinienYPos));
				Buffer.canvas.Lineto(Round(SpaltenOffset-
				  HLinien_x_Offset+HLinienLaenge+
				  NotenData[i].Spalte*SpaltenAbstand),
				  Round(LinienYPos));
			end;
			{Vorzeichen b #:}
			Case NotenData[i].Wichtung of
			-1: begin
				Buffer.Canvas.Draw(Round(SpaltenOffset+
				  NotenData[i].Spalte*SpaltenAbstand+
				  B_x_offset), Round(B_y_offset+(9-
				  NotenData[i].Zeile)*Linienabstand), BWMF);
			    end;
			1:  begin
				Buffer.Canvas.Draw(Round(SpaltenOffset+
				  NotenData[i].Spalte*SpaltenAbstand+
				  Zaun_x_offset),Round(Zaun_y_offset+(9-
				  NotenData[i].Zeile)*Linienabstand), ZaunWMF);
			    end;
			end;
		end;
		if not AIsenabled then
		begin
			Buffer.Canvas.Copymode := cmMergePaint;
			Buffer.Canvas.Draw(1, 1, Buffer);
		end;
		Canvas.Draw(0, 0, Buffer);
	finally
		Buffer.free;
	end;
end;

procedure TNotenSys.mark;
begin
	if not(marked) then
    begin
        Timer := TTimer.Create(Parent);
		Timer.Interval := 350;
		Timer.onTimer := blink;
		Timer.enabled := true;
		highlighted := true;
        marked := true;
		paint;
	end;
end;

procedure TNotenSys.demark;
begin
	if marked then
    begin
		marked := false;
        highlighted := false;
		Timer.Free;
		paint;
	end;
end;

procedure TNotenSys.blink(Sender: TObject);
begin
	highlighted := not(highlighted);
	paint;
end;

procedure Register;
begin
	RegisterComponents('Beispiele', [TNotenSys]);
end;

end.
