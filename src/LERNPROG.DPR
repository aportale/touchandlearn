program Lernprog;

uses
  Forms,
  UHR02 in 'UHR02.PAS' {Uhr2_Form},
  BASIS in 'BASIS.PAS' {Basis_Form},
  BESCHRFT in 'BESCHRFT.PAS' {Beschriften_Form},
  BUCHSTB in 'BUCHSTB.PAS' {Buchstaben_Form},
  ITVLESEN in 'ITVLESEN.PAS' {Intervalle_Lesen_Form},
  MENUE in 'MENUE.PAS' {Menue_Form},
  MUSIK in 'MUSIK.PAS',
  NLESEN in 'NLESEN.PAS' {Noten_Lesen_Form},
  NSPIELEN in 'NSPIELEN.PAS' {Noten_Spielen_Form},
  RECHNEN in 'RECHNEN.PAS' {Rechnen_Form},
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
  UHR01 in 'UHR01.PAS' {Uhr1_Form};

{$R *.RES}

begin
  Application.Title := 'Lernprogramm';
  Application.CreateForm(TMenue_Form, Menue_Form);
  Application.CreateForm(TBasis_Form, Basis_Form);
  Application.CreateForm(TUhr2_Form, Uhr2_Form);
  Application.CreateForm(TBasis_Form, Basis_Form);
  Application.CreateForm(TBeschriften_Form, Beschriften_Form);
  Application.CreateForm(TBuchstaben_Form, Buchstaben_Form);
  Application.CreateForm(TIntervalle_Lesen_Form, Intervalle_Lesen_Form);
  Application.CreateForm(TMenue_Form, Menue_Form);
  Application.CreateForm(TNoten_Lesen_Form, Noten_Lesen_Form);
  Application.CreateForm(TNoten_Spielen_Form, Noten_Spielen_Form);
  Application.CreateForm(TRechnen_Form, Rechnen_Form);
  Application.CreateForm(TUhr1_Form, Uhr1_Form);
  Application.Run;
end.
