package com.kosta.day26;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;
import com.kosta.util.DBUtil;

public class ExamDAO {

	/*
	 * EMPLOYEES 테이블에 저장되어있는 직원들의 EMPLOYEE_ID와 EMAIL을 다음의 출력결과와 같은 형태로 나타내고,
	 *  EMPLOYEE_ID 오름차순으로 정렬하시오. 
	 *  이메일 주소는 소문자에 뒤에 '@samsung.com' 이 붙고, 컬럼명은 e-mail 로 한다.
	 */
	public List<EmployeeVO> test2() {
		// 시험2번
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
		// 시험1번
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







