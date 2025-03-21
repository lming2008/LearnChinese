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

    // 模拟API调用延迟
    await Future.delayed(const Duration(seconds: 1));

    // 模拟用户数据
    _user = UserModel(
      id: '1',
      username: '测试用户',
      avatar: 'https://picsum.photos/200',
      email: 'test@example.com',
      learningDays: 7,
      totalStudyHours: 15,
      stars: 120,
      achievements: [
        Achievement(
          id: '1',
          title: '初出茅庐',
          description: '完成第一课',
          icon: 'trophy',
          isUnlocked: true,
          unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Achievement(
          id: '2',
          title: '坚持不懈',
          description: '连续学习7天',
          icon: 'fire',
          isUnlocked: true,
          unlockedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Achievement(
          id: '3',
          title: '学霸',
          description: '获得100颗星',
          icon: 'crown',
          isUnlocked: true,
          unlockedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Achievement(
          id: '4',
          title: '语言大师',
          description: '完成所有课程',
          icon: 'award',
          isUnlocked: false,
        ),
      ],
      courseProgress: [
        CourseProgress(
          courseId: '1',
          courseName: '基础发音',
          completedLessons: 5,
          totalLessons: 10,
          progress: 0.5,
        ),
        CourseProgress(
          courseId: '2',
          courseName: '日常对话',
          completedLessons: 3,
          totalLessons: 15,
          progress: 0.2,
        ),
      ],
      settings: UserSettings(
        notificationsEnabled: true,
        language: 'zh',
        darkMode: false,
        privacyMode: false,
        themeColor: '#4CAF50',
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