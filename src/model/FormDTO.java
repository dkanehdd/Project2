package model;

public class FormDTO {
	private String num;
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	private String compony;
	private String address;
	private String telephone;
	private String cellphone;
	private String email;
	private String sort; //청소 종류
	private String acre; //평수
	private String seleteDate; //원하는날짜
	private String postdate; // 작성날짜
	private String register; // 접수종류
	private String other; //기타특이사항
	private String flag; // 클리닝 / 체험학습 구분
	private String handicap; //장애 유무 및 유형
	private String assistingdevices; // 보장구 유무 및 명칭
	private String experience; //체험학습 신청종류 및 인원수
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getHandicap() {
		return handicap;
	}
	public void setHandicap(String handicap) {
		this.handicap = handicap;
	}
	public String getAssistingdevices() {
		return assistingdevices;
	}
	public void setAssistingdevices(String assistingdevices) {
		this.assistingdevices = assistingdevices;
	}
	public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
	public String getCompony() {
		return compony;
	}
	public void setCompony(String compony) {
		this.compony = compony;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getAcre() {
		return acre;
	}
	public void setAcre(String acre) {
		this.acre = acre;
	}
	public String getSeleteDate() {
		return seleteDate;
	}
	public void setSeleteDate(String seleteDate) {
		this.seleteDate = seleteDate;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
}
