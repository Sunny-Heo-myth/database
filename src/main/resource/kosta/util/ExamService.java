package kosta.util;

import java.util.List;

import kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;


//1~10�� ����Ǯ�� ���� �����Ѵ�.
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





