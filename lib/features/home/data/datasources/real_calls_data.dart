// data/datasource/real_calls_data.dart
class RealCallItem {
  final String location;
  final String service;
  final String timeAgo;
  final String duration;
  final String status;
  final bool isResolved;

  const RealCallItem({
    required this.location,
    required this.service,
    required this.timeAgo,
    required this.duration,
    required this.status,
    required this.isResolved,
  });
}

class RealCallsData {
  static const String sectionTitle = 'Live Customer Calls';

  static const String sectionDescription =
      'See how our AI handles real customer inquiries in real-time,\nautomating responses and improving satisfaction.';

  static const List<RealCallItem> callData = [
    RealCallItem(
      location: 'Phoenix',
      service: 'Oil Change',
      timeAgo: '2 hours ago',
      duration: '2m 42s',
      status: 'pending',
      isResolved: false,
    ),
    RealCallItem(
      location: 'Miami',
      service: 'Brake Inspection',
      timeAgo: '45 minutes ago',
      duration: '3m 12s',
      status: 'resolved',
      isResolved: true,
    ),
    RealCallItem(
      location: 'Boston',
      service: 'Tire Rotation',
      timeAgo: '1 hour ago',
      duration: '1m 55s',
      status: 'resolved',
      isResolved: true,
    ),
    RealCallItem(
      location: 'Seattle',
      service: 'Engine Diagnostic',
      timeAgo: '30 minutes ago',
      duration: '4m 18s',
      status: 'resolved',
      isResolved: true,
    ),
    RealCallItem(
      location: 'Denver',
      service: 'Battery Check',
      timeAgo: '3 hours ago',
      duration: '1m 38s',
      status: 'resolved',
      isResolved: true,
    ),
  ];
}