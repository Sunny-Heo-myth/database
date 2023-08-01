package com.kosta.day25;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosta.util.DBUtil;
import com.kosta.util.DateUtil;

//DAO(Data Access Object)
//Repository 
public class EmpDAO {

	// 모든직원조회
	public List<EmployeeVO> selectAll() {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees";
		Connection conn = DBUtil.dbConnect();
		Statement st = null;
		ResultSet rs = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while (rs.next()) {
				emplist.add(makeEmp(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		return emplist;
	}

	// 특정부서의 직원조회
	public List<EmployeeVO> selectById(int deptid) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where department_id=?" ;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql);//sql문 준비한다. 
			st.setInt(1, deptid); //첫번째?에 부서번호를 넣어라~
			rs = st.executeQuery();//실행
			while (rs.next()) {
				emplist.add(makeEmp(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		return emplist;
	}

	// salary가 특정금액 이상인 직원들 조회
	public List<EmployeeVO> selectBySalary(int sal) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where salary >= ?" ;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql); //sql문에 ?도있어
			st.setInt(1, sal);//첫번째 ?에 sal를 할당  
			rs = st.executeQuery(); //sql문 실행 
			while (rs.next()) {
				emplist.add(makeEmp(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		return emplist;
	}

	//job_id가 특정값인 직원들 조회 
	public List<EmployeeVO> selectByJob(String jobid) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where job_id = ? ";
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql); //sql문에 ?가있다. 
			st.setString(1, jobid); //첫번째 ?에 jobid가 setting 
			rs = st.executeQuery();
			while (rs.next()) {
				emplist.add(makeEmp(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		return emplist;
	}
	// 부서코드, 직책, 급여, 입사일 
	public List<EmployeeVO> selectByCondition(int deptid, String jobid, int sal, String hdate) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees "
				+ " where department_id=? "
				+ " and job_id = ? "
				+ " and salary>=? "
				+ " and hire_date>=? ";
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql); //sql문에 ?가있다. 
			st.setInt(1, deptid);  
			st.setString(2, jobid);
			st.setInt(3, sal);  
			st.setDate(4, DateUtil.convertToDate(hdate));
			rs = st.executeQuery();
			while (rs.next()) {
				emplist.add(makeEmp(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbClose(conn, st, rs);
		}
		return emplist;
	}
	private EmployeeVO makeEmp(ResultSet rs) throws SQLException {
		// DB가 사용하는 객체와 JAVA가 사용가 사용하는 객체가 다르다. 자동으로 setting불가
		// 개발자가 ResultSet를 읽어서 자바의 객체에 setting해야한다.
		EmployeeVO emp = new EmployeeVO();
		emp.setCommission_pct(rs.getDouble("Commission_pct"));
		emp.setDepartment_id(rs.getInt("Department_id"));
		emp.setEmail(rs.getString("Email"));
		emp.setEmployee_id(rs.getInt("Employee_id"));
		emp.setFirst_name(rs.getString("First_name"));
		emp.setHire_date(rs.getDate("Hire_date"));
		emp.setJob_id(rs.getString("Job_id"));
		emp.setLast_name(rs.getString("Last_name"));
		emp.setManager_id(rs.getInt("Manager_id"));
		emp.setPhone_number(rs.getString("Phone_number"));
		emp.setSalary(rs.getInt("Salary"));
		return emp;
	}

	// 특정부서직원들 조회

}
