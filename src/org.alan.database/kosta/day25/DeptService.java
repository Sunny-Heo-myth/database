package com.kosta.day25;

import java.util.List;

public class DeptService {
	
	DeptDAO dao = new DeptDAO();
	
	public List<DeptDTO> selectALLService() {
		return dao.selectAll();
	}
	
	public DeptDTO selectByID(int deptID) {
		return dao.selectById(deptID);
	}
	
	public List<DeptDTO> selectByNameService(String dname) {
		return dao.selectByName(dname);
	}
}
