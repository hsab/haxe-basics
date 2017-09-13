package;

// http://api.haxe.org/sys/db/Mysql.html
// http://api.haxe.org/sys/db/Connection.html
// http://api.haxe.org/sys/db/ResultSet.html

/***********************************************************
	
	SQL of table "sdttbl":
	
'CREATE TABLE `idtbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idtbl_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8'
	
************************************************************/

import sys.db.*;

class Main {
	public static function main () {
		var connData = {
			host: "localhost",
			port: 3306,
			user: "root",
			pass: "root",
			database: "testdb"
		};
		
		var conn = null;
		
		try {
			conn = Mysql.connect(connData);
		}
		catch (e:Dynamic) {
			trace('Connection failed with error: $e');
		}
		
		if (conn != null) {
			trace('Connected to database ${conn.dbName()}');
			
			conn.request('INSERT INTO sdttbl (intcol, dblcol, strcol, datecol) VALUES (123, 3.14, "test string", "${Date.now()}")'); // insert row with columns: int, double, string and date.
			
			var dbRes = conn.request('SELECT * FROM sdttbl');
			
			trace('Read records count: ${dbRes.length}');
			trace('Read columns count: ${dbRes.nfields}');
			trace('Read field names: ${dbRes.getFieldsNames()}');
			
			var results = dbRes.results();
			
			trace('Display results v1:');
			
			for (res in results) {
				for (fld in dbRes.getFieldsNames())
					Sys.print('$fld: ${Reflect.field(res, fld)}, ');
				
				Sys.println('');
			}
			
			trace('Display results v2:');
			
			for (res in results) {
				Sys.print('intcol: ${res.intcol}, ');
				Sys.print('dblcol: ${res.dbcol}, ');
				Sys.print('strcol: ${res.strcol}, ');
				Sys.println('datecol: ${res.datecol}, ');
			}
			
			conn.close();
		}
	}
}
