package com.kosta.day25;

import java.sql.*;

import com.kosta.util.DBUtil;

public class DBExample {

	public static void main(String[] args) {
		f1();
	}

	private static void f1() {
		String sql = " select employee_id, first_name, last_name, job_id, salary" +
	" from employees" +
				" where salary > 10000" +
	" order by job_id, employee_id";
				
		Connection conn = DBUtil.dbConnect();
		Statement st = null;
		ResultSet rs = null;
		
		try { // To defend unexpected halt.
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				int employee_id = rs.getInt(1);
				String fname = rs.getString(2);
				String lname = rs.getString(3);
				String job = rs.getString(4);
				int salary = rs.getInt(5);
				System.out.println("done!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		
	}

}
