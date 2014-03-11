package zpy.util;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;

public class DbHelper {
	public static QueryRunner getQueryRunner() {
		//数据源对象可以理解为连接池的管理者，通过他可以获取数据库的连接
		DataSource ds = null;
		try {
			//通过在context.xml文件，设定的数据源对象的名字，获取数据源对象
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:/comp/env/jdbc/mysqlds");
		} catch (Exception e) {
			System.out.println("获取数据源时出错");
		}

		QueryRunner qr = new QueryRunner(ds);
		return qr;
	}
}
