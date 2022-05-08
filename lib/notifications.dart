import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/bath.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/utilities.dart';

Future<void> createVaccinationNotification(
    Vaccination vaccination, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.medical_syringe} Vaccination Reminder',
        body:
            'Remined you - ${vaccination.vaccination} vaccination\ntoday to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: vaccination.date.year,
        month: vaccination.date.month,
        day: vaccination.date.day,
        hour: vaccination.hour,
        minute: vaccination.minutes,
        second: 0,
        millisecond: 0,
      ));
}

Future<void> createBathNotificationEveryMonth(
    NotificationWeekAndTime notificationWeekAndTime, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.household_bathtub} Bath Reminder',
        body: 'Remined you - It\'s time for bath\ntoday to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          weekday: notificationWeekAndTime.dayOfTheWeek,
          hour: notificationWeekAndTime.timeOfDay.hour,
          minute: notificationWeekAndTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true
          // year: DateTime.now().year,
          // month: DateTime.now().month,
          // day: DateTime.now().day,
          // hour: DateTime.now().hour,
          // minute: DateTime.now().minute + 1,
          // second: 0,
          // millisecond: 0,
          ));
}

Future<void> createTeethNotificationEveryDay(
    NotificationEveryDayAtTime notificationEveryDayAtTime, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.household_toothbrush} Brush Teeth Reminder',
        body: 'Remined you - It\'s time for brush\n${pet.name} teeth',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          hour: notificationEveryDayAtTime.timeOfDay.hour,
          minute: notificationEveryDayAtTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}
