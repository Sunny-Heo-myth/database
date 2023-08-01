package com.kosta.day26;

import java.util.List;

import com.kosta.day25.EmpDTO5;
import com.kosta.day25.EmployeeVO;

public class ExamView {

	public static void print1(List<EmpDTO5> emplist) {
		System.out.println("-----------1번의 결과-------------");
	    for(EmpDTO5 emp:emplist) {
	    	System.out.println(emp);
	    }
	}

	public static void print2(List<EmployeeVO> emplist) {
		System.out.println("-----------2번의 결과-------------");
		System.out.println("직원번호\t e-mail");
	    for(EmployeeVO emp:emplist) {
	    	System.out.println(emp.getEmployee_id() +"\t" + emp.getEmail());
	    }
	}

}
