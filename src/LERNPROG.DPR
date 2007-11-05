program Lernprog;



uses
  Forms,
  RECHNEN in 'RECHNEN.PAS' {Rechnen_Form},
  MENUE in 'MENUE.PAS' {Menue_Form},
  BUCHSTB in 'BUCHSTB.PAS' {Buchstaben_Form},
  BESCHRFT in 'BESCHRFT.PAS' {Beschriften_Form},
  NLESEN in 'NLESEN.PAS' {Noten_Lesen_Form},
  ITVLESEN in 'ITVLESEN.PAS' {Intervalle_Lesen_Form},
  NSPIELEN in 'NSPIELEN.PAS' {Noten_Spielen_Form},
  UHR01 in 'UHR01.PAS' {Uhr1_Form},
  BASIS in 'BASIS.PAS' {Basis_Form},
  UHR02 in 'UHR02.PAS' {Uhr2_Form};

{$R *.RES}

begin
  Application.Title := 'Lernprogramm';
  Application.CreateForm(TMenue_Form, Menue_Form);
  Application.CreateForm(TBasis_Form, Basis_Form);
  Application.Run;
end.
