import 'dart:ui';

import 'package:intl/intl.dart';

const Color primaryColor = Color.fromARGB(255, 1, 84, 186);
const String fontFamily = 'montserrat';
const Color headerColor = Color.fromARGB(255, 242, 242, 242);
const Color greenish = Color.fromARGB(255, 0, 236, 182);

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
