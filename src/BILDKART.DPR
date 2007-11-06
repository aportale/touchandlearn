program Bildkart;

uses
  Forms,
  SETUPPAS in 'SETUPPAS.PAS' {SetupForm},
  S_WMFPIC in 'S_WMFPIC.PAS' {WMFPicker},
  S_HILFE in 'S_HILFE.PAS' {HilfeFenster},
  TMFCNTNR in 'TMFCNTNR.PAS';

{$R *.RES}

begin
  Application.Title := 'Lernprogramm Bilderkartei';
  Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TWMFPicker, WMFPicker);
  Application.CreateForm(THilfeFenster, HilfeFenster);
  Application.Run;
end.
