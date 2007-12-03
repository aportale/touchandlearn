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

program touchandlearn;

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
