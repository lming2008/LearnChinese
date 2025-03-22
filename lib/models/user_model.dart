import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final String avatar;
  final String email;
  final int learningDays;
  final int totalStudyHours;
  final int stars;
  final List<Achievement> achievements;
  final List<CourseProgress> courseProgress;
  final UserSettings settings;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.email,
    required this.learningDays,
    required this.totalStudyHours,
    required this.stars,
    required this.achievements,
    required this.courseProgress,
    required this.settings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      avatar: json['avatar'],
      email: json['email'],
      learningDays: json['learningDays'],
      totalStudyHours: json['totalStudyHours'],
      stars: json['stars'],
      achievements: (json['achievements'] as List)
          .map((e) => Achievement.fromJson(e))
          .toList(),
      courseProgress: (json['courseProgress'] as List)
          .map((e) => CourseProgress.fromJson(e))
          .toList(),
      settings: UserSettings.fromJson(json['settings']),
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    this.unlockedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      isUnlocked: json['isUnlocked'],
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'])
          : null,
    );
  }
}

class CourseProgress {
  final String courseId;
  final String courseName;
  final int completedLessons;
  final int totalLessons;
  final double progress;

  CourseProgress({
    required this.courseId,
    required this.courseName,
    required this.completedLessons,
    required this.totalLessons,
    required this.progress,
  });

  factory CourseProgress.fromJson(Map<String, dynamic> json) {
    return CourseProgress(
      courseId: json['courseId'],
      courseName: json['courseName'],
      completedLessons: json['completedLessons'],
      totalLessons: json['totalLessons'],
      progress: json['progress'].toDouble(),
    );
  }
}

class UserSettings {
  final bool notificationsEnabled;
  final String language;
  final bool darkMode;
  final bool privacyMode;
  final String themeColor;

  UserSettings({
    required this.notificationsEnabled,
    required this.language,
    required this.darkMode,
    required this.privacyMode,
    required this.themeColor,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      notificationsEnabled: json['notificationsEnabled'],
      language: json['language'],
      darkMode: json['darkMode'],
      privacyMode: json['privacyMode'],
      themeColor: json['themeColor'],
    );
  }
} 