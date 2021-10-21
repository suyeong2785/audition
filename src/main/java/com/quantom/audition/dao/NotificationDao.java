package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Applyment;
import com.quantom.audition.dto.Notification;

@Mapper
public interface NotificationDao {

	public void insertNotificationMessage(Map<String, Object> param);

	public List<Notification> getNotificationsRelatedToUser(Map<String, Object> param);

	public void changeNotificationAlarmStatus(Map<String, Object> param);

	public List<Notification> getNotificationsRelatedToGetterIdAndRelIdAndRelTypeCode(Map<String, Object> param);

	public void changeNotificationCheckStatus(Map<String, Object> param);

	public List<Notification> getApplymentNotificationsRelatedToUser(@Param("getterId") int getterId,@Param("applymentsIds") List<Integer> applymentsIds);

	public void insertBulkNotificationMessages(Map<String, Object> param);

}
