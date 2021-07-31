package com.quantom.audition.dto;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.quantom.audition.util.Util;

@XmlRootElement(name = "personalName")
@XmlAccessorType(XmlAccessType.FIELD)
public class PersonalName {

  @XmlElement(name = "forename")
  public String forename;

  @XmlElement(name = "surname")
  public String surname;

  @XmlElement(name = "nameUse")
  public String nameUse;

  @XmlElement(name = "marcDate")
  public String marcDate;

  @XmlElement(name = "source")
  public List<String> sources;

  @XmlElement(name = "subsourceIdentifier")
  public String subsourceIdentifier;


  public String getBirthYear() {
    if (marcDate == null || marcDate.isEmpty()) return null;

    // if death is BC, also birth is
    boolean isBC = Util.isBC(marcDate);

    String d = marcDate.split("-", 2)[0];
    if (isBC && !d.startsWith("-")) d = "-" + d;
    return Util.cleanDate(d);
  }

  public String getDeathYear() {
    if (marcDate == null || marcDate.isEmpty()) return null;
    String d = marcDate.split("-", 2)[1];
    return Util.cleanDate(d);
  }

  public String getFullName() {
    if (this.forename != null && this.surname != null)
      return this.forename + " " + this.surname;
    else if (this.surname != null) return this.surname;
    else return this.forename;
  }
}