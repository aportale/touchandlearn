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
