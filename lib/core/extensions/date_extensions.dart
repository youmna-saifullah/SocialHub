import 'package:intl/intl.dart';

/// Extension methods on DateTime for common operations
extension DateExtensions on DateTime {
  /// Format date as 'MMM dd, yyyy' (e.g., 'Jan 01, 2024')
  String get formattedDate => DateFormat('MMM dd, yyyy').format(this);
  
  /// Format date as 'MMM yyyy' (e.g., 'Jan 2024')
  String get monthYear => DateFormat('MMM yyyy').format(this);
  
  /// Format date as 'dd/MM/yyyy' (e.g., '01/01/2024')
  String get shortDate => DateFormat('dd/MM/yyyy').format(this);
  
  /// Format time as 'HH:mm' (e.g., '14:30')
  String get formattedTime => DateFormat('HH:mm').format(this);
  
  /// Format time as 'hh:mm a' (e.g., '02:30 PM')
  String get formattedTime12h => DateFormat('hh:mm a').format(this);
  
  /// Format datetime as 'MMM dd, yyyy at HH:mm'
  String get formattedDateTime => '$formattedDate at $formattedTime';
  
  /// Get relative time string (e.g., '2 hours ago', 'Yesterday')
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
  
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}
