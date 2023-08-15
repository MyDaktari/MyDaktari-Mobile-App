import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../models/supplier.dart';
import '../presentations/doctor_side/schedule/models/dayschedule.dart';

String userId = '';
String userPhoneNumber = '';
ClientModel client = ClientModel();
DoctorModel doctor = DoctorModel();
SupplierModel supplier = SupplierModel();
var index = 0;
List<DaySchedule> schedulesConstant = daysOfWeek.map((day) {
  // var id = '${day}-$index';
  index++;
  return DaySchedule(
      id: UniqueKey().toString(),
      day: day,
      isEnabled: true,
      startTime: timeIntervals.first,
      endTime: timeIntervals.last);
}).toList();

// String convertTo12HourFormat(String time24Hr) {
//   final dateFormat = DateFormat('HH:mm');
//   final parsedTime = dateFormat.parse(time24Hr);
//   final format12Hr = DateFormat('h:mm a');

//   return format12Hr.format(parsedTime);
// }
//09:00:00
String convertTo12HourFormat(String time24Hr) {
  try {
    final dateFormat = DateFormat('HH:mm');
    final dateTime = dateFormat.parse(time24Hr);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  } on Exception {
    return time24Hr;
  }
}

String convertTo24HourFormat(String time12Hr) {
  try {
    final dateFormat = DateFormat('h:mm a');
    final parsedTime = dateFormat.parse(time12Hr);
    final format24Hr = DateFormat('HH:mm');
    return format24Hr.format(parsedTime);
  } on Exception {
    return time12Hr;
  }
}

String formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 21) {
    // Return the formatted date if the difference is more than 3 weeks
    final format = DateFormat('yyyy-MM-dd');
    return format.format(dateTime);
  } else {
    final weeks = difference.inDays ~/ 7;
    final days = difference.inDays % 7;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (weeks > 0) {
      // Display the relative time in terms of weeks
      return '${weeks == 1 ? '1 week' : '$weeks weeks'} ago';
    } else if (days > 0) {
      // Display the relative time in terms of days
      return '${days == 1 ? '1 day' : '$days days'} ago';
    } else if (hours > 0) {
      // Display the relative time in terms of hours
      return '${hours == 1 ? '1 hour' : '$hours hours'} ago';
    } else if (minutes > 0) {
      // Display the relative time in terms of minutes
      return '${minutes == 1 ? '1 minute' : '$minutes minutes'} ago';
    } else {
      // Return 'Just now' for very recent events
      return 'Just now';
    }
  }
}

final List<String> daysOfWeek = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

final List<String> timeIntervals = [
  '9:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
  '1:00 PM',
  '2:00 PM',
  '3:00 PM',
  '4:00 PM',
  '5:00 PM'
];

final dayFullNameMap = {
  'Mon': 'Monday',
  'Tue': 'Tuesday',
  'Wed': 'Wednesday',
  'Thur': 'Thursday',
  'Fri': 'Friday',
  'Sat': 'Saturday',
  'Sun': 'Sunday',
};

const String doctorWelcomeMessage =
    "We're delighted to have you as part of our medical community. With My Daktari, you now have the power to streamline your practice, enhance patient care, and embrace the future of healthcare.\nOur intuitive platform allows you to effortlessly connect with your patients, access their medical records securely, schedule appointments with ease, and even provide remote consultations through our telehealth feature.\nHowever, we may encounter occasional bugs or functionality issues as we continue to refine and improve our platform. Rest assured, we are dedicated to delivering the best user experience possible, and our team is working diligently to address any issues that arise. We value your feedback and encourage you to reach out to our support team if you have any questions or encounter any challenges.\nThank you for your understanding and for partnering with us on our journey to improving patient outcomes and access to care.\nWishing you a successful and fulfilling experience with My Daktari.\nBest regards,\nThe Dream team,\nMy Daktari";
