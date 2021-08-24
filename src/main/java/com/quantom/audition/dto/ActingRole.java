package com.quantom.audition.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	private boolean thumbnailStatus;
	private String name;
	private String pay;
	private String age;
	private String gender;
	private String job;
	private String feature;
	private String region;
	private String schedule;
	private String shotAngle;
	private String guideVideoUrl;
	private boolean scriptStatus;
	private String scenesCount;
	private String shootingsCount;

	private List<File> files;

	private Map<String, Object> extra;

	public String getTitle() {
		String artworkName = extra != null ? (String) extra.get("artworkName") : "";
		String directorName = extra != null ? (String) extra.get("directorName") : "";

		String title = id + "번," + artworkName + "(" + directorName + "감독), " + name + "역";

		return title;
	}

	public String getDetailLink() {
		return "./detail?id=" + id;
	}

	public String getForPrintTitle() {
		return getTitle();
	}

	public String getForPrintGenUrlForActingRole() {
		if (files.isEmpty() == false) {
			for (File file : files) {
				return "/gen" + "/" + file.getRelTypeCode() + "/" + file.getFileDir() + "/" + file.getId() + "."
						+ file.getFileExt() + "?updateDate=" + file.getUpdateDate();
			}
		}

		return null;
	}

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
