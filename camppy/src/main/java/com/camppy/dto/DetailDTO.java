package com.camppy.dto;

public class DetailDTO {
	private int camp_id; //캠핑장 아이디
	private String camp_name; //캠핑장 이름
	private String short_intro; // 한 줄 소개
	// private String addr; 주소 보류
	private String tel; //문의처(전화번호)
	private String environment; //캠핑장 환경
	private String camp_type; //캠핑장 유형
	private String season; //운영 기간
	private String runtime; //운영일
	private String homepage; //홈페이지
	private String facility; //주변이용시설
	private String review_like_id; //별점
	private String intro; //상세 소개
	
	
	public int getCamp_id() {
		return camp_id;
	}
	public void setCamp_id(int camp_id) {
		this.camp_id = camp_id;
	}
	
	
	public String getCamp_name() {
		return camp_name;
	}
	public void setCamp_name(String camp_name) {
		this.camp_name = camp_name;
	}
	
	
	public String getShort_intro() {
		return short_intro;
	}
	public void setShort_intro(String short_intro) {
		this.short_intro = short_intro;
	}
	
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	
	public String getEnvironment() {
		return environment;
	}
	public void setEnvironment(String environment) {
		this.environment = environment;
	}
	
	
	public String getCamp_type() {
		return camp_type;
	}
	public void setCamp_type(String camp_type) {
		this.camp_type = camp_type;
	}
	
	
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	
	
	public String getRuntime() {
		return runtime;
	}
	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}
	
	
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	
	
	public String getFacility() {
		return facility;
	}
	public void setFacility(String facility) {
		this.facility = facility;
	}
	
	
	public String getReview_like_id() {
		return review_like_id;
	}
	public void setReview_like_id(String review_like_id) {
		this.review_like_id = review_like_id;
	}
	
	
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}