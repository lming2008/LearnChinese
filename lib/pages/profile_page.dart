import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';
import 'package:learn_chinese/pages/settings/notification_settings_page.dart';
import 'package:learn_chinese/pages/settings/language_settings_page.dart';
import 'package:learn_chinese/pages/settings/theme_settings_page.dart';
import 'package:learn_chinese/pages/settings/privacy_settings_page.dart';
import 'package:learn_chinese/pages/settings/help_center_page.dart';
import 'package:learn_chinese/pages/settings/about_page.dart';
import 'package:flutter/rendering.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // 加载用户数据
    Future.microtask(
      () => context.read<UserProvider>().loadUserData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userProvider.user;
          if (user == null) {
            return const Center(child: Text('请先登录'));
          }

          return CustomScrollView(
            slivers: [
              // 顶部用户信息卡片
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: Theme.of(context).primaryColor,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 头像
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          const SizedBox(height: 8),
                          // 用户名
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // 邮箱
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  // 设置按钮
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      // TODO: 打开设置页面
                    },
                  ),
                ],
              ),
              // 学习统计
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '学习统计',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            context,
                            FontAwesomeIcons.fire,
                            '${user.learningDays}天',
                            '连续学习',
                          ),
                          _buildStatItem(
                            context,
                            FontAwesomeIcons.clock,
                            '${user.totalStudyHours}小时',
                            '总学习时长',
                          ),
                          _buildStatItem(
                            context,
                            FontAwesomeIcons.star,
                            '${user.stars}',
                            '获得星星',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 成就系统
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '我的成就',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: user.achievements.length,
                        itemBuilder: (context, index) {
                          final achievement = user.achievements[index];
                          return _buildAchievementCard(context, achievement);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // 课程进度
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '课程进度',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: user.courseProgress.length,
                        itemBuilder: (context, index) {
                          final progress = user.courseProgress[index];
                          return _buildCourseProgressCard(context, progress);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // 设置选项
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '设置',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.bell,
                        '通知设置',
                        user.settings.notificationsEnabled,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationSettingsPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.language,
                        '语言设置',
                        false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LanguageSettingsPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.moon,
                        '深色模式',
                        user.settings.darkMode,
                        onTap: () {
                          // TODO: 切换深色模式
                        },
                      ),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.shield,
                        '隐私设置',
                        user.settings.privacyMode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacySettingsPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.questionCircle,
                        '帮助中心',
                        false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpCenterPage(),
                            ),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        FontAwesomeIcons.infoCircle,
                        '关于我们',
                        false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // 退出登录按钮
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<UserProvider>().logout();
                      // TODO: 导航到登录页面
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('退出登录'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            icon,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    BuildContext context,
    Achievement achievement,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: achievement.isUnlocked
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achievement.isUnlocked
              ? Theme.of(context).primaryColor
              : Colors.grey[300]!,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            _getAchievementIcon(achievement.icon),
            size: 32,
            color: achievement.isUnlocked
                ? Theme.of(context).primaryColor
                : Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: achievement.isUnlocked ? Colors.black : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseProgressCard(
    BuildContext context,
    CourseProgress progress,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progress.courseName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress.progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress.progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '已完成 ${progress.completedLessons}/${progress.totalLessons} 课时',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    bool value,
    {VoidCallback? onTap}
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FaIcon(
                icon,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Switch(
              value: value,
              onChanged: (newValue) {
                onTap?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAchievementIcon(IconData icon) {
    return icon;
  }
} 