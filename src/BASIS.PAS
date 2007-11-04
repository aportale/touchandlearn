unit Basis;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, TAufgdta, TPressbt, TColBtn, Townlabl, Palette, tools,
	StdCtrls, ExtCtrls, TanClock, mplayer, TNotPlay;

type
	TBasis_Form = class(TForm)
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		function GetPalette: HPALETTE; override;
	public
		HGBild:Timage;
		bild: TMetaFile;
		nextButton,helpButton,exitButton,musicButton:TWMFPressButton;
		Aufgabe_Laeuft:boolean;
		MediaPlayer:TMediaPlayer;
		NotenPlayer:TNotenPlayer;
                schonhilfegegeben:boolean;
                (*dummy:TOwnLabel;*)
		procedure Load_BG_Image(Filename: String);
	end;

var	Basis_Form: TBasis_Form;

implementation
{$R *.DFM}

procedure TBasis_Form.FormCreate(Sender: TObject);
begin
	getownpalette;
	MediaPlayer := TMediaPlayer.Create(Self);
	MediaPlayer.Parent := Self;
	MediaPlayer.Visible := FALSE;
	NotenPlayer := TNotenPlayer.Create_Set(MediaPlayer,path+'Sound\Midi\');
	HGBild:= TImage.Create(Self);
	HGBild.Parent := Self;
	HGBild.SetBounds(0, 0, sca_x(800) , sca_y(600));
	bild := Tmetafile.create;
	HGBild.Canvas.Font.Name := 'Arial';
	HGBild.Canvas.Font.Size := Round(sca_x(36)*96 / screen.Pixelsperinch);
	HGBild.Canvas.Font.Color := clwhite;
	setbkmode(HGBild.Canvas.Handle, 1);
	nextButton:=TWMFPressButton.Create_load(self, path +
	  'grafik\buttons\nextunpr.wmf', path + 'grafik\buttons\nextpr.wmf',
	  OwnPaletteHandle, 1);
	nextButton.Parent := self;
	nextButton.SetBounds(sca_x(715), sca_y(320), sca_X(80), sca_y(80));
	exitButton:=TWMFPressButton.Create_load(self, path +
	  'grafik\buttons\exitunpr.wmf', path + 'grafik\buttons\exitpr.wmf',
	  OwnPaletteHandle, 1);
	exitButton.Parent := self;
	exitButton.SetBounds(sca_x(715), sca_Y(200), sca_x(80), sca_Y(80));
	helpButton:=TWMFPressButton.Create_load(self, path +
	  'grafik\buttons\helpunpr.wmf', path + 'grafik\buttons\helppr.wmf',
	  OwnPaletteHandle, 1);
	helpButton.Parent := self;
	helpButton.SetBounds(sca_x(6), sca_y(200), sca_x(80), sca_y(80));
	musicButton:=TWMFPressButton.Create_load(self, path +
	  'grafik\buttons\mus_unpr.wmf', path + 'grafik\buttons\mus_pr.wmf',
	  OwnPaletteHandle, 1);
	musicButton.Parent := self;
	musicButton.SetBounds(sca_x(6), sca_y(320), sca_x(80), sca_y(80));
	musicButton.hide;

        (*dummy := TOwnLabel.Create(Self, OwnPaletteHandle);
        dummy.parent := Self;*)
end;

procedure TBasis_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	NotenPlayer.free;
	playsound(snd_Ende);
	dropownpalette;
end;

function TBasis_Form.GetPalette: HPALETTE;
begin
	result := OwnPaletteHandle;
end;

procedure TBasis_Form.Load_BG_Image(Filename: String);
begin
	bild.LoadFromFile(path + 'grafik\Backgrnd\'+Filename);
	selectpalette(HGBild.Canvas.handle, OwnPalettehandle, FALSE);
	realizepalette(HGBild.Canvas.handle);
	HGBild.Canvas.StretchDraw(rect(sca_x(-10), sca_y(-14), sca_x(810),
	  sca_y(614)),Bild);
end;

end.
