import 'package:flutter/material.dart';

import 'package:project/src/app/routes.dart';
import '../../domain/feature_item.dart';

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black12),
      ),
      child: ListTile(
        leading: Icon(feature.icon, color: Colors.lightGreen.shade700),
        title: Text(
          feature.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          feature.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detail,
            arguments: {
              'title': feature.title,
              'description': feature.subtitle,
              'imagePath': feature.imagePath,
            },
          );
        },
      ),
    );
  }
}