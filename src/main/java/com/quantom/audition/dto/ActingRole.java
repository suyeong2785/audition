package com.quantom.audition.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ActingRole {
	private int id;
	private String regDate;
	private String updateDate;
	private String startDate;
	private String endDate;
	private boolean completeStatus;
	private int memberId;
	private int artworkId;
	private String role;
	private String pay;
	private String age;
	private String gender;
	private String job;
	private String feature;
	private String region;
	private String schedule;
	private String shotAngle;
	private String guideVideoUrl;
	private int scriptStatus;
	private String scenesCount;
	private String shootingsCount;

	private List<File> files;

	private Map<String, Object> extra;

	public String getTitle() {
		String artworkName = extra != null ? (String) extra.get("artworkName") : "";
		String directorName = extra != null ? (String) extra.get("directorName") : "";

		String title = id + "번," + artworkName + "(" + directorName + "감독), " + role + "역";

		return title;
	}

	public String getDetailLink() {
		return "./detailArtworkForAuditions?id=" + artworkId;
	}

	public String getForPrintTitle() {
		return getTitle();
	}

	@JsonIgnore
	public String getForPrintGenUrlForActingRole() {
		if (files.isEmpty() == false) {
			for (File file : files) {
				return "/gen" + "/" + file.getRelTypeCode() + "/" + file.getFileDir() + "/" + file.getId() + "."
						+ file.getFileExt() + "?updateDate=" + file.getUpdateDate();
			}
		}

		return null;
	}

	@JsonIgnore
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

}
