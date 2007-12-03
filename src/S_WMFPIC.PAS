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
