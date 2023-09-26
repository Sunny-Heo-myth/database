package org.alan.database.kosta.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kosta.util.DBUtil;
import org.alan.database.kosta.util.DateUtil;

//DAO(Data Access Object)
//Repository 
public class EmpDAO {

	// ���������ȸ
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

	// Ư���μ��� ������ȸ
	public List<EmployeeVO> selectById(int deptid) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where department_id=?" ;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql);//sql�� �غ��Ѵ�. 
			st.setInt(1, deptid); //ù��°?�� �μ���ȣ�� �־��~
			rs = st.executeQuery();//����
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

	// salary�� Ư���ݾ� �̻��� ������ ��ȸ
	public List<EmployeeVO> selectBySalary(int sal) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where salary >= ?" ;
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql); //sql���� ?���־�
			st.setInt(1, sal);//ù��° ?�� sal�� �Ҵ�  
			rs = st.executeQuery(); //sql�� ���� 
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

	//job_id�� Ư������ ������ ��ȸ 
	public List<EmployeeVO> selectByJob(String jobid) {
		List<EmployeeVO> emplist = new ArrayList<>();
		String sql = "select * from Employees where job_id = ? ";
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			st = conn.prepareStatement(sql); //sql���� ?���ִ�. 
			st.setString(1, jobid); //ù��° ?�� jobid�� setting 
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
	// �μ��ڵ�, ��å, �޿�, �Ի��� 
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
			st = conn.prepareStatement(sql); //sql���� ?���ִ�. 
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
		// DB�� ����ϴ� ��ü�� JAVA�� ��밡 ����ϴ� ��ü�� �ٸ���. �ڵ����� setting�Ұ�
		// �����ڰ� ResultSet�� �о �ڹ��� ��ü�� setting�ؾ��Ѵ�.
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

	// Ư���μ������� ��ȸ

}
