import 'package:flutter/material.dart';

class FeatureItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;

  const FeatureItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imagePath,
  });
}