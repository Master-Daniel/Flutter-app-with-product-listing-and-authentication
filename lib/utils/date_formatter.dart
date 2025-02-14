import 'package:intl/intl.dart';

String formatDateTime(String dateString, {bool? hideTime}) {
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime.parse(dateString).toLocal(); // Parse and convert to local time
  Duration difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    // Today
    if (hideTime == true) {
      return 'Today';
    }
    return 'Today at ${DateFormat('h:mm a').format(dateTime)}'; // e.g., "Today at 3:05 PM"
  } else if (difference.inDays == 1) {
    // Yesterday
    if (hideTime == true) {
      return 'Yesterday';
    }
    return 'Yesterday at ${DateFormat('h:mm a').format(dateTime)}'; // e.g., "Yesterday at 2:02 AM"
  } else {
    // More than 1 day ago
    return DateFormat('d MMMM y').format(dateTime); // e.g., "29 September 2023"
  }
}

String formatTimeStamp(int timestamp) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp)
      .toLocal(); // Convert milliseconds to DateTime and convert to local time
  Duration difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    // Today
    return DateFormat('h:mm a').format(dateTime); // e.g., "3:05 PM"
  } else if (difference.inDays == 1) {
    // Yesterday
    return 'Yesterday at ${DateFormat('h:mm a').format(dateTime)}'; // e.g., "Yesterday at 2:02 AM"
  } else {
    // More than 1 day ago
    return DateFormat('MMMM y').format(dateTime); // e.g., "November 2023"
  }
}
