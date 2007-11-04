unit S_wmfpic;

interface

uses
	SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
	Forms, Dialogs, ExtCtrls, FileCtrl, StdCtrls,  TOwnImg, Palette,
	Buttons;

type
	TWMFPicker = class(TForm)
		PreviewBevel: TBevel;
		DriveComboBox1: TDriveComboBox;
		DirectoryListBox1: TDirectoryListBox;
		FileListBox1: TFileListBox;
		SpeedButton1: TSpeedButton;
		SpeedButton2: TSpeedButton;
		procedure FormCreate(Sender: TObject);
		procedure FileListBox1Change(Sender: TObject);
		procedure SpeedButton2Click(Sender: TObject);
		procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
	private
		Preview: TOwnImage;
		{ Private-Deklarationen }
	public
		FileName:String;
		{ Public-Deklarationen }
	end;

var
	WMFPicker: TWMFPicker;

implementation

{$R *.DFM}

procedure TWMFPicker.FormCreate(Sender: TObject);
begin
	GetOwnPalette;
	preview := TOwnImage.Create_Setup(self, PreviewBevel.Left+1,
	 PreviewBevel.Top+1, PreviewBevel.Width-2,
	 PreviewBevel.Height-2, OwnPalettehANDLE);
	preview.parent := self;
	Filename := '';
end;

procedure TWMFPicker.FileListBox1Change(Sender: TObject);
begin
	if fileexists(FileListBox1.FileName) then
	begin
		preview.loadGraphic(FileListBox1.FileName);
		FileName := FileListBox1.FileName;
	end;
end;

procedure TWMFPicker.SpeedButton2Click(Sender: TObject);
begin
	FileName := '';
	close;
end;

procedure TWMFPicker.SpeedButton1Click(Sender: TObject);
begin
	close;
end;

procedure TWMFPicker.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	DropOwnPalette;
end;

end.
