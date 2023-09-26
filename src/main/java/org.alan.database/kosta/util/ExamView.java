package org.alan.database.kosta.util;

import java.util.List;

import org.alan.database.kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;

public class ExamView {

	public static void print1(List<EmpDTO5> emplist) {
		System.out.println("-----------1���� ���-------------");
	    for(EmpDTO5 emp:emplist) {
	    	System.out.println(emp);
	    }
	}

	public static void print2(List<EmployeeVO> emplist) {
		System.out.println("-----------2���� ���-------------");
		System.out.println("������ȣ\t e-mail");
	    for(EmployeeVO emp:emplist) {
	    	System.out.println(emp.getEmployee_id() +"\t" + emp.getEmail());
	    }
	}

}
