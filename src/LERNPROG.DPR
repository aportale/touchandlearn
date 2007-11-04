program Lernprog;

uses
  Forms,
  Rechnen in 'RECHNEN.PAS' {Rechnen_Form},
  Menue in 'MENUE.PAS' {Menue_Form},
  Buchstb in 'BUCHSTB.PAS' {Buchstaben_Form},
  Beschrft in 'BESCHRFT.PAS' {Beschriften_Form},
  Nlesen in 'NLESEN.PAS' {Noten_Lesen_Form},
  Itvlesen in 'ITVLESEN.PAS' {Intervalle_Lesen_Form},
  Nspielen in 'NSPIELEN.PAS' {Noten_Spielen_Form},
  Uhr01 in 'UHR01.PAS' {Uhr1_Form},
  Basis in 'BASIS.PAS' {Basis_Form},
  Uhr02 in 'UHR02.PAS' {Uhr2_Form};

{$R *.RES}

begin
  Application.Title := 'Lernprogramm';
  Application.CreateForm(TMenue_Form, Menue_Form);
  Application.CreateForm(TBasis_Form, Basis_Form);
  Application.Run;
end.
