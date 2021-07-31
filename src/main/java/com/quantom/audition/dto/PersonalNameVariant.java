package com.quantom.audition.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonProperty;

@XmlRootElement(name = "personalNameVariant")
@XmlAccessorType(XmlAccessType.FIELD)
public class PersonalNameVariant {
	
	@XmlElement(name = "surname")
	@JsonProperty("surname")
	private String surname;
	
	@XmlElement(name = "nameUse")
	@JsonProperty("nameUse")
	private String nameUse;
	
	@XmlElement(name = "source")
	@JsonProperty("source")
	private String source;
}
