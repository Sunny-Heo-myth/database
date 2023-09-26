package org.alan.database.kosta.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.alan.database.kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;
import com.kosta.util.DBUtil;

public class ExamDAO {

	/*
	 * EMPLOYEES ���̺� ����Ǿ��ִ� �������� EMPLOYEE_ID�� EMAIL�� ������ ��°���� ���� ���·� ��Ÿ����,
	 *  EMPLOYEE_ID ������������ �����Ͻÿ�. 
	 *  �̸��� �ּҴ� �ҹ��ڿ� �ڿ� '@samsung.com' �� �ٰ�, �÷����� e-mail �� �Ѵ�.
	 */
	public List<EmployeeVO> test2() {
		// ����2��
		String sql=
				"select EMPLOYEE_ID, lower(EMAIL)||'@samsung.com' \"e-mail\" "+
				"from EMPLOYEES "+
				"order by 1";
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		List<EmployeeVO> emplist = new ArrayList<>();
		try {
			st = conn.prepareStatement(sql);
			rs = st.executeQuery();
			while(rs.next()) {
				EmployeeVO emp = new EmployeeVO();
				emp.setEmployee_id(rs.getInt(1));
				emp.setEmail(rs.getString("e-mail"));
				emplist.add(emp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return emplist;
	}
	
	
	public List<EmpDTO5> test1() {
		// ����1��
		String sql = " select employee_id, first_name, last_name, job_id, salary " 
				+ " from  EMPLOYEES "
				+ " where SALARY >= 10000" 
				+ " order by JOB_ID, EMPLOYEE_ID";
		Connection conn = DBUtil.dbConnect();
		PreparedStatement st = null;
		ResultSet rs = null;
		List<EmpDTO5> emplist = new ArrayList<>();
		try {
			st = conn.prepareStatement(sql);
			rs = st.executeQuery();
			while(rs.next()) {
				EmpDTO5 emp = new EmpDTO5(rs.getInt("employee_id"), rs.getInt("salary"), 
						rs.getString("first_name"), rs.getString("last_name"), rs.getString("job_id"))	;
				emplist.add(emp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return emplist;
	}

}







