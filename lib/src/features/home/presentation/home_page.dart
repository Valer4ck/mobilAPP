import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/presentation/profile_page.dart';
import '../application/home_cubit.dart';
import '../domain/feature_item.dart';
import 'widgets/feature_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'ПЛАНИРОВЩИК МЕРОПРИЯТИЙ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.black,
          ),
          body: IndexedStack(
            index: selectedIndex,
            children: const [
              _HomeTab(),
              ProfilePage(embedded: true),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.lightGreen.shade50,
            indicatorColor: Colors.lightGreen.shade200,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              context.read<HomeCubit>().selectTab(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Главная',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Профиль',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  static const List<FeatureItem> features = [
    FeatureItem(
      title: 'Создание события',
      subtitle: 'Добавление нового мероприятия с датой и местом',
      icon: Icons.add_circle_outline,
      imagePath: 'assets/images/event1.png',
    ),
    FeatureItem(
      title: 'Календарь',
      subtitle: 'Просмотр всех запланированных событий',
      icon: Icons.calendar_today,
      imagePath: 'assets/images/event2.png',
    ),
    FeatureItem(
      title: 'Напоминания',
      subtitle: 'Уведомления о предстоящих мероприятиях',
      icon: Icons.notifications_none,
      imagePath: 'assets/images/event3.png',
    ),
    FeatureItem(
      title: 'Категории',
      subtitle: 'Группировка событий по темам',
      icon: Icons.label_outline,
      imagePath: 'assets/images/event4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 600;
    final isDesktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
    final verticalPadding = isDesktop ? 32.0 : 16.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'Event Planner — приложение для планирования мероприятий',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: verticalPadding),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/event${index + 1}.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 40),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: verticalPadding),
          isWide
              ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.8,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) =>
                FeatureCard(feature: features[index]),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: isDesktop ? 16 : 8),
            itemBuilder: (context, index) =>
                FeatureCard(feature: features[index]),
          ),
        ],
      ),
    );
  }
}