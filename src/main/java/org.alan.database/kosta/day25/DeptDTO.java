package org.alan.database.kosta.day25;

public class DeptDTO {
	private int department_id;
	private String department_name;
	private int manager_id;
	private int location_id;
	
	public DeptDTO(int department_id, String department_name, int manager_id, int location_id) {
		super();
		this.department_id = department_id;
		this.department_name = department_name;
		this.manager_id = manager_id;
		this.location_id = location_id;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DeptDTO [department_id=").append(department_id).append(", department_name=")
				.append(department_name).append(", manager_id=").append(manager_id).append(", location_id=")
				.append(location_id).append("]");
		return builder.toString();
	}

	public int getDepartment_id() {
		return department_id;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public int getManager_id() {
		return manager_id;
	}

	public int getLocation_id() {
		return location_id;
	}

	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public void setManager_id(int manager_id) {
		this.manager_id = manager_id;
	}

	public void setLocation_id(int location_id) {
		this.location_id = location_id;
	}
	
	
	
}

