package com.quantom.audition.dto;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Artwork {
	private int id;
	private String regDate;
	private String updateDate;
	private String startDate;
	private String endDate;
	private String title;
	private String genre;
	private String investor;
	private String productionName;
	private String directorName;
	private String leadActor;
	private String actingRole;
	private String actingRoleGender;
	private String actingRoleAge;
	private String etc;

	private Map<String, Object> extra;

	public String getDetailLink() {
		return "./detailArtwork?id=" + id;
	}

	@JsonIgnore
	public String getForPrintGenUrlForArtwork() {
		if (extra != null) {
			if (extra.get("fileIdForArtwork") != null) {
				return "/gen" + "/" + extra.get("fileRelTypeCodeForArtwork") + "/" + extra.get("fileDirForArtwork")
						+ "/" + extra.get("fileIdForArtwork") + "." + extra.get("fileExtForArtwork") + "?updateDate="
						+ extra.get("fileUpdateDateForArtwork");
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
