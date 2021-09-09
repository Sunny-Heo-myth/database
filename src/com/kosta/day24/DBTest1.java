package com.kosta.day24;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class DBTest1 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		f1();
	}

	private static void f2() {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		String url, id, pass;
		String sql = "select employee_id, first_name, salary, commission_pct, hire_date " +
				"from employees " +
				"where department_id = 60 ";
		Properties pro = new Properties();
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			pro.load(new FileReader("C:\\KOSTA\\JdbcProject\\src\\com\\kosta\\day24\\dbinfo.properties"));
			url = pro.getProperty("url");
			id = pro.getProperty("userid");
			pass = pro.getProperty("password");
			conn = DriverManager.getConnection(url, id, pass);
			System.out.println("1. connection sucess.");
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				int employee_id = rs.getInt(1);
				String first_name = rs.getString(2);
				int salary = rs.getInt(3);
				double commission_pct = rs.getDouble(4);
				Date hire_date = rs.getDate(5);
				System.out.println(employee_id + " done.");
			}
			
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
			System.out.println("ClassNotFoundExeption.");
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} finally {
			try {
				if(rs != null) rs.close();
				if(st != null) st.close();
				if(conn != null) conn.close();
			}catch(SQLException e) {
				System.out.println("Resource return fail.");
			}
		}
	}

	private static void f1() throws ClassNotFoundException, SQLException {
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("1. Class load success");
		
		Connection conn = null; // connect
		Statement st = null; // sql to db
		ResultSet rs = null; // receive query
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		conn = DriverManager.getConnection(url, "hr", "hr");
		System.out.println("2. Connection success");
		
		String sql = "select employee_id, first_name, salary, commission_pct, hire_date " +
				"from employees " +
				"where department_id = 60 ";
		st = conn.createStatement();
		rs = st.executeQuery(sql);
		
		while(rs.next()) {
			int employee_id = rs.getInt(1);
			String first_name = rs.getString(2);
			int salary = rs.getInt(3);
			double commission_pct = rs.getDouble(4);
			Date hire_date = rs.getDate(5);
			System.out.println(employee_id + " done.");
		}
		
		rs.close();
		st.close();
		conn.close();
		System.out.println("3. resource returned");
				
	}

}
