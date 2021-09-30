package com.quantom.audition.dto;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Applyment {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String relTypeCode;
	private int relId;
	private int artworkId;
	private String artworkType;
	private String artworkFileUrl;
	private String artworkTitle;
	private String actingRole;
	private String actingRoleGender;
	private String actingRoleAge;
	private String actingRoleStartDate;
	private String actingRoleEndDate;
	private int result;
	private boolean delStatus;
	private String delDate;
	private boolean displayStatus;
	private boolean hideStatus;
	
	private List<File> files;
	
	private Map<String, Object> extra;

	/*
	@JsonProperty("forPrintBody")
	public String getForPrintBody() {
		String bodyForPrint = HtmlUtils.htmlEscape(body);
		bodyForPrint = bodyForPrint.replace("\n", "<br>");

		return bodyForPrint;
	}
	*/

	/*
	@JsonProperty("forPrintApplymentResult")
	public String getForPrintApplymentResult() {

		StringBuilder sb = new StringBuilder();

		sb.append("[" + extra.get("ProductionName") + "으로 부터 답변" + "]</br>");
		sb.append(" <div style='font-weight:bold;'>");
		sb.append("지원하신 " + extra.get("actingName") + " 역할에 대해서 ");
		if (result != 0) {
			if (result == 2) {
				sb.append("안타깝지만 저희가 찾는 이미지와는 맞지않는 관계로 떨어지셨습니다.</br> 지원해주셔서 감사합니다.");
			} else if (result == 1) {
				sb.append("저희가 찾는 이미지와는 맞는 관계로 1차 합격되었습니다.</br> 2차 면접관련해서 추후 연락드리겠습니다.");
			}
		} else {
			sb.append("아직 답변이 없습니다.");
		}
		sb.append("</div>");
		sb.append("<div>FROM :" + extra.get("ProductionName") + "</div>");
		return sb.toString();
	}
		
	*/
	
	public String getForPrintGenUrlForMember() {
		if (extra != null) {
			if (extra.get("fileIdForMember") != null) {
				return "/gen" + "/" + extra.get("fileRelTypeCodeForMember") + "/" + extra.get("fileDirForMember") + "/"
						+ extra.get("fileIdForMember") + "." + extra.get("fileExtForMember") + "?updateDate="
						+ extra.get("fileUpdateDateForMember");
			}
		}
		return null;
	}


	public String getForPrintGenUrlForApplyment() {
		if (extra != null) {
			if (extra.get("fileIdForApplyment") != null) {
				return "/gen" + "/" + extra.get("fileRelTypeCodeForApplyment") + "/" + extra.get("fileDirForApplyment")
						+ "/" + extra.get("fileIdForApplyment") + "." + extra.get("fileExtForApplyment") + "?updateDate="
						+ extra.get("fileUpdateDateForApplyment");
			}

		}

		return null;
	}
}
