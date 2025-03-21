import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String _selectedLanguage = '简体中文';
  String _selectedRegion = '中国';
  bool _showPinyin = true;
  bool _showTranslation = true;

  final List<String> _languages = [
    '简体中文',
    '繁体中文',
    'English',
    '日本語',
    '한국어',
  ];

  final List<String> _regions = [
    '中国',
    '香港',
    '台湾',
    '新加坡',
    '马来西亚',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('语言设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            '界面语言',
            [
              _buildDropdownItem(
                '选择语言',
                _selectedLanguage,
                _languages,
                (value) => setState(() => _selectedLanguage = value!),
              ),
            ],
          ),
          _buildSection(
            '地区设置',
            [
              _buildDropdownItem(
                '选择地区',
                _selectedRegion,
                _regions,
                (value) => setState(() => _selectedRegion = value!),
              ),
            ],
          ),
          _buildSection(
            '学习设置',
            [
              _buildSwitchItem(
                '显示拼音',
                '在汉字上方显示拼音',
                _showPinyin,
                (value) => setState(() => _showPinyin = value),
              ),
              _buildSwitchItem(
                '显示翻译',
                '显示中文翻译',
                _showTranslation,
                (value) => setState(() => _showTranslation = value),
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

  Widget _buildDropdownItem(
    String title,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
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
} 