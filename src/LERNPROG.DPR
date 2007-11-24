program Lernprog;

uses
  Forms,
  UHR02 in 'UHR02.PAS',
  BASIS in 'BASIS.PAS' {Basis_Form},
  BESCHRFT in 'BESCHRFT.PAS',
  BUCHSTB in 'BUCHSTB.PAS',
  ITVLESEN in 'ITVLESEN.PAS',
  MENUE in 'MENUE.PAS' {Menue_Form},
  MUSIK in 'MUSIK.PAS',
  NLESEN in 'NLESEN.PAS',
  NSPIELEN in 'NSPIELEN.PAS',
  RECHNEN in 'RECHNEN.PAS',
  TANCLOCK in 'TANCLOCK.PAS',
  TAUFGDTA in 'TAUFGDTA.PAS',
  TCOLBTN in 'TCOLBTN.PAS',
  TGRPHGRD in 'TGRPHGRD.PAS',
  TKBOARD in 'TKBOARD.PAS',
  TKEYBBTN in 'TKEYBBTN.PAS',
  TMFCNTNR in 'TMFCNTNR.PAS',
  TNOTEN in 'TNOTEN.PAS',
  TNOTPLAY in 'TNOTPLAY.PAS',
  TOOLS in 'TOOLS.PAS',
  TOWNIMG in 'TOWNIMG.PAS',
  TOWNLABL in 'TOWNLABL.PAS',
  TPRESSBT in 'TPRESSBT.PAS',
  UHR01 in 'UHR01.PAS';

{$R *.RES}

begin
  Application.Title := 'Touch ''n learn';
  Application.CreateForm(TMenue_Form, Menue_Form);
  Application.Run;
end.
