package com.quantom.audition.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "titleOfWork")
@XmlAccessorType(XmlAccessType.FIELD)
public class TitleOfWork {

	@XmlElement(name = "title")
	public String title;
}
