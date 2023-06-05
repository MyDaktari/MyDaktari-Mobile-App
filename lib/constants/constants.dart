import 'dart:ui';

import 'package:intl/intl.dart';

const Color primaryColor = Color(0xff0154BA);
const String fontFamily = 'montserrat';
const Color headerColor = Color(0xFFF2F2F2); // Hex: #F2F2F2
const Color greenish = Color(0xFF00ECB6); // Hex: #00ECB6

String userId = '';
String userPhoneNumber = '';

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
