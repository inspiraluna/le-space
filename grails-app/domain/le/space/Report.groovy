package le.space
/**

Report (DomainObject)

$Rev: 46 $:     Revision of last commit
$Author: inspiraluna $:  Author of last commit
$Date: 2009-07-12 23:30:18 +0200 (So, 12 Jul 2009) $:    Date of last commit


This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along
with this program; if not, see <http://www.gnu.org/licenses/>.
 */

class Report {

    static transients = ["dateFrom","dateTo","username","customer"]

    Date dateFrom

    Date dateTo

    String username

    String customer

}
