package com.kosta.day26;

import java.util.Scanner;

public class ExamController {

	static ExamService service = new ExamService();
	
	
	public static void main(String[] args) {
		//사용자에게 입력받기(시험문제번호)
		Scanner sc = new Scanner(System.in);
		while(true) {
			System.out.print("1~10까지번호입력(exit)>>");
			String inputStr = sc.next();
			if(inputStr.equals("exit")) break;
			switch (inputStr) {
			case "1":f1();break;
			case "2":f2();break;
			case "3":f3();break;
			default: System.out.println("제공되지않는 번호임");break;
			}
			
		}
		System.out.println("프로그램종료");
	}

	private static void f3() {
		System.out.println("3번문제풀이");
		
	}

	private static void f2() {
		System.out.println("2번문제풀이");
		ExamView.print2(service.test2());
		
	}

	private static void f1() {
		System.out.println("1번문제풀이");
		ExamView.print1(service.test1());
	}

}



