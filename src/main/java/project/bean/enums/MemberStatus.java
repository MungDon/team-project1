package project.bean.enums;

public enum MemberStatus {
	MEMBERSHIP("1","가입"),
	MEMBERSHIP_WITHDRAWAL("2", "탈퇴");
	
	private String code;
	private String name;
	
	private MemberStatus(String code, String name) {
		this.code = code;
		this.name = name;
	};
	
	public String getCode() {
		return code;
	}
	public String getName() {
		return name;
	}
	
	public static String getNameByStatus(String statusCode) {
		for(MemberStatus enumValue : MemberStatus.values()) {
			if(enumValue.getCode().equals(statusCode)) {
				return enumValue.getName();
			}
		}
		return "없음";
	}
}
