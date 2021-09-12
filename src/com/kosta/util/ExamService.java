package com.kosta.day26;

import java.util.List;

import com.kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;


//1~10번 문제풀이 서비스 제공한다.
//Controller->Service->DAO->DB
public class ExamService {

	ExamDAO dao = new ExamDAO();
	
	public List<EmpDTO5> test1() {
		return dao.test1();
	}
	public List<EmployeeVO> test2() {
		return dao.test2();
	}
}





