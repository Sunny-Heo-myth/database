package org.alan.database.kosta.day20;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBTest {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		//1. jdbc driver load
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("1. jdbc Driver load ---success");
		
		//2. connect db
		String url = "jdbc:oracle:thin:@localhost:1521:xe", userId = "hr", password = "hr";
		Connection conn = DriverManager.getConnection(url, userId, password);
		System.out.println("2. DB connect ---success");
		
		//3. sql execute
		String sql = "select * from employees";
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
		System.out.println("3. sql execute ---success");
		
		while(rs.next()) {
			System.out.print(rs.getInt(1));
			System.out.println("\t" + rs.getString("first_name"));
		}
		
		//4. return resource
		conn.close();
		System.out.println("4. DB connect canceled ---success");
	}

}
