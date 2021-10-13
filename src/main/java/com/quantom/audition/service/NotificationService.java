package com.quantom.audition.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.NotificationDao;
import com.quantom.audition.dto.Notification;

@Service
public class NotificationService {
	@Autowired
	NotificationDao notificationDao;

	public void insertNotificationMessage(Map<String, Object> param) {
		notificationDao.insertNotificationMessage(param) ;
	}

	public List<Notification> getNotificationsRelatedToUser(Map<String, Object> param) {
		return notificationDao.getNotificationsRelatedToUser(param);
	}

	public void changeNotificationAlarmStatus(Map<String, Object> param) {
		notificationDao.changeNotificationAlarmStatus(param);
	}

	public List<Notification> getNotificationsRelatedToGetterIdAndRelIdAndRelTypeCode(Map<String, Object> param) {
		return notificationDao.getNotificationsRelatedToGetterIdAndRelIdAndRelTypeCode(param);
	}

	public void changeNotificationCheckStatus(Map<String, Object> param) {
		notificationDao.changeNotificationCheckStatus(param);
	}

	public List<Notification> getApplymentNotificationsRelatedToUser(int getterId, List<Integer> applymentsIds) {
		return notificationDao.getApplymentNotificationsRelatedToUser(getterId, applymentsIds);
	}

}
