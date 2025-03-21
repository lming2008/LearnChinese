import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _dailyReminder = true;
  bool _courseUpdates = true;
  bool _achievementAlerts = true;
  bool _systemNotifications = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            '每日提醒',
            [
              _buildSwitchItem(
                '每日学习提醒',
                '每天提醒你完成学习任务',
                _dailyReminder,
                (value) => setState(() => _dailyReminder = value),
              ),
              _buildTimePickerItem(
                '提醒时间',
                _reminderTime,
                () => _selectTime(context),
              ),
            ],
          ),
          _buildSection(
            '课程通知',
            [
              _buildSwitchItem(
                '课程更新提醒',
                '新课程和课程更新通知',
                _courseUpdates,
                (value) => setState(() => _courseUpdates = value),
              ),
            ],
          ),
          _buildSection(
            '成就通知',
            [
              _buildSwitchItem(
                '成就解锁提醒',
                '获得新成就时通知',
                _achievementAlerts,
                (value) => setState(() => _achievementAlerts = value),
              ),
            ],
          ),
          _buildSection(
            '系统通知',
            [
              _buildSwitchItem(
                '系统消息',
                '系统维护和更新通知',
                _systemNotifications,
                (value) => setState(() => _systemNotifications = value),
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

  Widget _buildTimePickerItem(
    String title,
    TimeOfDay time,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text('${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }
} 