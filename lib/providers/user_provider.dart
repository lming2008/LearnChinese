import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  // 模拟用户数据
  Future<void> loadUserData() async {
    _isLoading = true;
    notifyListeners();

    // 模拟加载延迟
    await Future.delayed(const Duration(seconds: 1));

    // 模拟用户数据
    _user = UserModel(
      id: '1',
      username: '测试用户',
      avatar: 'https://ui-avatars.com/api/?name=测试用户&background=random',
      email: 'test@example.com',
      learningDays: 7,
      totalStudyHours: 12,
      stars: 150,
      achievements: [
        Achievement(
          id: '1',
          title: '初学乍练',
          description: '完成第一课',
          icon: Icons.star,
          isUnlocked: true,
          unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Achievement(
          id: '2',
          title: '坚持不懈',
          description: '连续学习7天',
          icon: Icons.local_fire_department,
          isUnlocked: true,
          unlockedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Achievement(
          id: '3',
          title: '词汇达人',
          description: '掌握100个单词',
          icon: Icons.auto_awesome,
          isUnlocked: false,
          unlockedAt: null,
        ),
      ],
      courseProgress: [
        CourseProgress(
          courseId: '1',
          courseName: '基础会话',
          completedLessons: 5,
          totalLessons: 10,
          progress: 0.5,
        ),
        CourseProgress(
          courseId: '2',
          courseName: '商务中文',
          completedLessons: 2,
          totalLessons: 8,
          progress: 0.25,
        ),
      ],
      settings: UserSettings(
        notificationsEnabled: true,
        language: 'zh_CN',
        darkMode: false,
        privacyMode: false,
        themeColor: '#2196F3',
      ),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserSettings(UserSettings newSettings) async {
    if (_user == null) return;

    _user = UserModel(
      id: _user!.id,
      username: _user!.username,
      avatar: _user!.avatar,
      email: _user!.email,
      learningDays: _user!.learningDays,
      totalStudyHours: _user!.totalStudyHours,
      stars: _user!.stars,
      achievements: _user!.achievements,
      courseProgress: _user!.courseProgress,
      settings: newSettings,
    );

    notifyListeners();
  }

  Future<void> updateUserProfile({
    String? username,
    String? avatar,
    String? email,
  }) async {
    if (_user == null) return;

    _user = UserModel(
      id: _user!.id,
      username: username ?? _user!.username,
      avatar: avatar ?? _user!.avatar,
      email: email ?? _user!.email,
      learningDays: _user!.learningDays,
      totalStudyHours: _user!.totalStudyHours,
      stars: _user!.stars,
      achievements: _user!.achievements,
      courseProgress: _user!.courseProgress,
      settings: _user!.settings,
    );

    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }
} 