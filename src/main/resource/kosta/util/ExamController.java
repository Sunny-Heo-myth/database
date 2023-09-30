package kosta.util;

import java.util.Scanner;

public class ExamController {

	static ExamService service = new ExamService();
	
	
	public static void main(String[] args) {
		//����ڿ��� �Է¹ޱ�(���蹮����ȣ)
		Scanner sc = new Scanner(System.in);
		while(true) {
			System.out.print("1~10������ȣ�Է�(exit)>>");
			String inputStr = sc.next();
			if(inputStr.equals("exit")) break;
			switch (inputStr) {
			case "1":f1();break;
			case "2":f2();break;
			case "3":f3();break;
			default: System.out.println("���������ʴ� ��ȣ��");break;
			}
			
		}
		System.out.println("���α׷�����");
	}

	private static void f3() {
		System.out.println("3������Ǯ��");
		
	}

	private static void f2() {
		System.out.println("2������Ǯ��");
		ExamView.print2(service.test2());
		
	}

	private static void f1() {
		System.out.println("1������Ǯ��");
		ExamView.print1(service.test1());
	}

}



