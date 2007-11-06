unit Setuppas;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, TOwnImg, Grids, Outline, StdCtrls, Palette,
  TAufgdta, tools, Buttons;

type
  TSetupForm = class(TForm)
    PreviewBevel: TBevel;
    BildNameEdit: TEdit;
		BildNameListBox: TListBox;
		ExitButton: TSpeedButton;
		SortButton: TSpeedButton;
		SpeedButton1: TSpeedButton;
		SpeedButton2: TSpeedButton;
		SpeedButton3: TSpeedButton;
		procedure FormCreate(Sender: TObject);
		procedure BildNameListBoxClick(Sender: TObject);
		procedure BildNameEditExit(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure ExitButtonClick(Sender: TObject);
		procedure SortButtonClick(Sender: TObject);
		procedure SpeedButton1Click(Sender: TObject);
		procedure Selectitem(id :Integer);
		procedure FormShow(Sender: TObject);
		procedure SpeedButton2Click(Sender: TObject);
		procedure BildNameEditKeyUp(Sender: TObject; var Key: Word;
			Shift: TShiftState);
		procedure SpeedButton3Click(Sender: TObject);
	private
		Preview:TownImage;
		ListboxItemIndex:Integer;
		ad: TAufgabenData;
		dateinamen:tstringlist;
		NameVeraendert:boolean;
		procedure SaveSetup;
		{ Private-Deklarationen }
	public
		{ Public-Deklarationen }
	end;

var
	SetupForm: TSetupForm;

implementation

uses S_wmfpic, s_hilfe;

{$R *.DFM}

procedure TSetupForm.FormCreate(Sender: TObject);
var i:Integer;
begin
		 top := (screen.height - height) div 2;
		 left := (screen.width - width) div 2;
		 preview := TOwnImage.Create_Setup(Self, PreviewBevel.Left+1,
			 PreviewBevel.Top+1, PreviewBevel.Width-2, PreviewBevel.Height-2);
		 PREVIEW.Parent := Self;
		 ad := TAufgabenData.Create_Load(Self,path+'aufgaben.txt', 'Buchstabensalat');
		 dateinamen := Tstringlist.create;
		 for i := 0 to ad.rawlist.count-1 do
		 begin
				 BildNameListBox.items.add(ad.getdat(i,1));
				 dateinamen.add(ad.getdat(i,2));
		 end;
		 ListboxItemIndex:=-1;
		NameVeraendert:=false;
end;

procedure TSetupForm.Selectitem(id :Integer);
begin
		 if id = -1 then
		 begin
				ListboxItemIndex:= BildNameListBox.ItemIndex;
		 end
		 else
		 begin
				ListboxItemIndex:= id;
		 end;
				preview.LoadGraphic(path + 'grafik\bilder\buchstab\' + dateinamen.strings[ListboxItemIndex]);
				BildNameEdit.text := BildNameListBox.Items.Strings[ListboxItemIndex];
				BildNameEdit.SetFocus;
				BildNameListBox.ItemIndex := ListboxItemIndex;
end;

procedure TSetupForm.BildNameListBoxClick(Sender: TObject);
begin
		 selectItem(-1);
end;

procedure TSetupForm.BildNameEditExit(Sender: TObject);
begin
{				if NameVeraendert then
				begin
					SaveSetup;
					NameVeraendert := false;
				end;
}
end;

procedure TSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
		 SaveSetup;
		 Preview.free;
		 ad.Destroy;
		 dateinamen.free;
end;

procedure TSetupForm.savesetup;
var alt, neu:tstringlist;
		indexOfBuchstabensalat, EndofBuchstabensalat, i:Integer;
begin
		 alt := tstringlist.create;
		 neu := tstringlist.create;
		 alt.Loadfromfile(path+'Aufgaben.txt');

		 for i := 0 to alt.count-1 do
		 begin
					neu.add(alt[i]);
				 if pos('[Buchstabensalat]', alt[i]) > 0 then
				 begin
						indexOfBuchstabensalat:=i;
						break;
				 end
		 end;

		 for i := indexOfBuchstabensalat+1 to alt.count-1 do
		 begin
				if alt[i][1] = '#' then
								neu.add(alt[i]);
				if pos('[', alt[i]) > 0 then
				begin
						EndofBuchstabensalat:=i;
						break;
				end;
		 end;

		 for i := 0 to BildNameListBox.Items.count -1 do
				 neu.add(BildNameListBox.Items[i]+';'+dateinamen[i]);

		 for i := EndofBuchstabensalat to alt.count-1 do
				 neu.add(alt[i]);

		 neu.SaveToFile(path+'Aufgaben.txt' );

		 alt.free;
		 neu.free;
end;

procedure TSetupForm.ExitButtonClick(Sender: TObject);
begin
		 close;
end;

procedure TSetupForm.SortButtonClick(Sender: TObject);
begin
		 dateinamen.sorted := false;
		 dateinamen.sorted := true;
		 Bildnamelistbox.sorted := false;
		 Bildnamelistbox.sorted := true;
		 selectItem(0);
		 SaveSetup;
end;

procedure TSetupForm.SpeedButton1Click(Sender: TObject);
begin

		 if (dateinamen.count > 1) then
		 begin
				 if messagedlg('Das Bild "'+BildnameListBox.items[ListboxItemIndex]+'"wirklich löschen?',
				 mtConfirmation, [mbYes, mbAbort], 0) = mrYes then
				 begin
							SaveSetup;
							DeleteFile(PChar(path + 'grafik\bilder\buchstab\' + dateinamen.strings[ListboxItemIndex]));
							dateinamen.delete(ListboxItemIndex);
							bildnameListbox.items.delete(ListboxItemIndex);
							if ListboxItemIndex <= (dateinamen.count-1) then
								 selectItem(ListboxItemIndex)
							else
									selectItem(ListboxItemIndex-1);
				 end;
		 end
		 else messagedlg('Es muß mindestens Name in der Liste bleiben.', mtInformation, [mbOk], 0);
		 SaveSetup;
end;

procedure TSetupForm.FormShow(Sender: TObject);
begin
		 if ListboxItemIndex = -1 then
				selectItem(0);
end;

procedure TSetupForm.SpeedButton2Click(Sender: TObject);
var FName :string;
		BildNameTemp:String;
begin
	WmfPicker.showModal;
	if WmfPicker.Filename <>'' then
	begin
		if not(Fileexists(path + 'grafik\bilder\buchstab\' + ExtractFileName(WmfPicker.Filename))) then
		begin
			BildNameTemp := lowercase(copy(ExtractFileName(WmfPicker.Filename), 1, pos('.', ExtractFileName(WmfPicker.Filename))-1));
			BildNameTemp[1] := uppercase(BildNameTemp[1])[1];
			bildNameListBox.items.add(BildNameTemp);
			dateinamen.add(ExtractFileName(WmfPicker.Filename));
			FName := path + 'grafik\bilder\buchstab';
			copyfile(PChar(WmfPicker.Filename), PChar(FName), TRUE);
			selectItem(dateinamen.count-1);
		end
		else
		begin
			messagedlg('Eine Bilddatei Namens "'+WmfPicker.Filename+'" existier bereits in der Liste.', mtInformation, [mbOk], 0);
		end;
	end;
end;

procedure TSetupForm.BildNameEditKeyUp(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if length(BildNameEdit.text) < 10 then
		BildNameListBox.Items.Strings[ListboxItemIndex] := BildNameEdit.text
	else
	begin
		messagedlg('Ein Wort im Lernprogramm darf nicht mehr als 9 Buchstaben'+
	 ' enthalten. Mehr Buchstaben würden bei der Schriftgröße nicht auf den Bildschirm passen.', mtInformation, [mbOk], 0);
		BildNameEdit.text := copy(BildNameEdit.text, 1, 9);
	end;
	NameVeraendert := true;
end;

procedure TSetupForm.SpeedButton3Click(Sender: TObject);
begin
	HilfeFenster.show;
end;

end.
