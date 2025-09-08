// data/datasource/integration_data.dart
import 'package:flutter/material.dart';

class IntegrationData {
  static const String sectionTitle = 'Integrates with Your Dealership Software';

  static List<List<Map<String, dynamic>>> getIntegrationLogos() {
    return [
      // Row 1
      [
        {
          'name': 'CDK',
          'color': Colors.black,
          'isCircle': true,
          'fontSize': 14.0,
        },
        {
          'name': 'Dealertrack',
          'color': const Color(0xFF1E3A8A),
          'subtitle': 'by Cox Automotive',
          'fontSize': 14.0,
        },
        {
          'name': 'myHoorma',
          'color': const Color(0xFFFF6B35),
          'hasIcon': true,
          'iconType': 'dot',
          'fontSize': 16.0,
        },
        {
          'name': 'xtime',
          'color': const Color(0xFFFF8C00),
          'hasSymbol': true,
          'fontSize': 18.0,
        },
        {
          'name': 'DCC',
          'color': Colors.black,
          'subtitle': 'CUSTOMER CONNECT',
          'fontSize': 14.0,
        },
      ],
      // Row 2
      [
        {
          'name': 'DEALER-FX',
          'color': const Color(0xFF8BC34A),
          'hasArrow': true,
          'fontSize': 12.0,
        },
        {
          'name': 'Reynolds',
          'color': const Color(0xFF1565C0),
          'subtitle': '&Reynolds.',
          'fontSize': 16.0,
        },
        {
          'name': 'PBS',
          'color': const Color(0xFF1565C0),
          'isOval': true,
          'fontSize': 18.0,
        },
        {
          'name': 'DEALER VAULT',
          'color': const Color(0xFF8BC34A),
          'hasIcon': true,
          'iconType': 'security',
          'fontSize': 11.0,
        },
        {
          'name': 'HOMENET',
          'color': const Color(0xFF00BCD4),
          'subtitle': 'AUTOMOTIVE',
          'fontSize': 14.0,
        },
      ],
    ];
  }
}