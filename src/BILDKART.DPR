program Bildkart;

uses
  Forms,
  Setuppas in 'SETUPPAS.PAS' {SetupForm},
  S_wmfpic in 'S_WMFPIC.PAS' {WMFPicker},
  S_hilfe in 'S_HILFE.PAS' {HilfeFenster};

{$R *.RES}

begin
  Application.Title := 'Lernprogramm Bilderkartei';
  Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TWMFPicker, WMFPicker);
  Application.CreateForm(THilfeFenster, HilfeFenster);
  Application.Run;
end.
