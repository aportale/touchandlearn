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
