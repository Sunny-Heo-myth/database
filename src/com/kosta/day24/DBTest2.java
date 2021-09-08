package com.kosta.day24;

import java.sql.*;

public class DBTest2 {

	public static void main(String[] args) {

		String sql = "";
		Connection conn = DBUtil.dbConnect();
		Statement st = null;
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				int did = rs.getInt(0);
				String dname = rs.getString(2);
				System.out.println(did + "\t + dname");
			}
			
		}catch (SQLException e) {
			e.printStackTrace();
			
		}finally {
			DBUtil.dbClose(conn, st, rs);
		}
	}

}
