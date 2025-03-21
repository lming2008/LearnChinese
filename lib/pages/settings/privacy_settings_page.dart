import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _showProfile = true;
  bool _showProgress = true;
  bool _showAchievements = true;
  bool _allowFriendRequests = true;
  bool _showOnlineStatus = true;
  bool _dataCollection = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            '个人资料',
            [
              _buildSwitchItem(
                '显示个人资料',
                '其他用户可以看到你的基本信息',
                _showProfile,
                (value) => setState(() => _showProfile = value),
              ),
              _buildSwitchItem(
                '显示学习进度',
                '其他用户可以看到你的学习进度',
                _showProgress,
                (value) => setState(() => _showProgress = value),
              ),
              _buildSwitchItem(
                '显示成就',
                '其他用户可以看到你获得的成就',
                _showAchievements,
                (value) => setState(() => _showAchievements = value),
              ),
            ],
          ),
          _buildSection(
            '社交设置',
            [
              _buildSwitchItem(
                '允许好友请求',
                '其他用户可以向你发送好友请求',
                _allowFriendRequests,
                (value) => setState(() => _allowFriendRequests = value),
              ),
              _buildSwitchItem(
                '显示在线状态',
                '其他用户可以看到你是否在线',
                _showOnlineStatus,
                (value) => setState(() => _showOnlineStatus = value),
              ),
            ],
          ),
          _buildSection(
            '数据收集',
            [
              _buildSwitchItem(
                '数据收集',
                '允许收集使用数据以改进应用',
                _dataCollection,
                (value) => setState(() => _dataCollection = value),
              ),
            ],
          ),
          _buildSection(
            '账号安全',
            [
              _buildButtonItem(
                '修改密码',
                '定期更改密码以提高安全性',
                () {
                  // TODO: 实现修改密码功能
                },
              ),
              _buildButtonItem(
                '账号注销',
                '永久删除你的账号',
                () {
                  // TODO: 实现账号注销功能
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildButtonItem(
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 