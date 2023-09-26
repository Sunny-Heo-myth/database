package org.alan.database.kosta.day25;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kosta.util.DBUtil;

public class DeptDAO {

	static final String SQL_SELECT_ALL = "select * from departments";
	static final String SQL_SELECT_BY_ID = "select * from departments where department_id = ?";
	static final String SQL_SELECT_BY_NAME = "select * from departments where department_name = ?";
	static final String SQL_SELECT_BY_LOC = "select * from departments where location_id = ?";
	
	public List<DeptDTO> selectAll() {
		
		List<DeptDTO> deptList = new ArrayList<>();
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			st = conn.prepareStatement(SQL_SELECT_ALL);
			rs = st.executeQuery();
			while(rs.next()){
				DeptDTO dept = new DeptDTO(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4));
				deptList.add(dept);
			}
			
		} catch (SQLException e) {e.printStackTrace();
		} finally {DBUtil.dbClose(conn, st, rs);
		}
		return deptList;
	}
	
	public DeptDTO selectById(int deptID) {
		
		DeptDTO dept = null;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			st = conn.prepareStatement(SQL_SELECT_BY_ID);
			st.setInt(1,  deptID);
			rs = st.executeQuery();
			while(rs.next()){
				DeptDTO dept = new DeptDTO(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4));
			}
			
		} catch (SQLException e) {e.printStackTrace();
		} finally {DBUtil.dbClose(conn, st, rs);
		}
		return deptList;
	}
	
	public DeptDTO selectByName(String dname) {
		
		DeptDTO deptList = null;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			st = conn.prepareStatement(SQL_SELECT_BY_ID);
			st.setString(1,  "%" + dname + "%");
			rs = st.executeQuery();
			while(rs.next()){
				DeptDTO dept = new DeptDTO(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4));
				deptList.add(dept);
			}
			
		} catch (SQLException e) {e.printStackTrace();
		} finally {DBUtil.dbClose(conn, st, rs);
		}
		return deptList;
	}
	
	public ArrayList<DeptDTO> selectByName(int locID) {
		
		ArrayList<DeptDTO> deptList = null;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			st = conn.prepareStatement(SQL_SELECT_BY_ID);
			st.setInt(1,  locID);
			rs = st.executeQuery();
			while(rs.next()){
				DeptDTO dept = new DeptDTO(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4));
				deptList.add(dept);
			}
		} catch (SQLException e) {e.printStackTrace();
		} finally {DBUtil.dbClose(conn, st, rs);
		}
		return deptList;
	}
}
