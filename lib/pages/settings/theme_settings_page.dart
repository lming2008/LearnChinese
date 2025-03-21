import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  String _themeMode = '跟随系统';
  Color _primaryColor = Colors.blue;
  bool _useSystemFont = true;
  double _fontSize = 16.0;

  final List<String> _themeModes = [
    '跟随系统',
    '浅色模式',
    '深色模式',
  ];

  final List<Color> _themeColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection(
            '主题模式',
            [
              _buildDropdownItem(
                '选择主题模式',
                _themeMode,
                _themeModes,
                (value) => setState(() => _themeMode = value!),
              ),
            ],
          ),
          _buildSection(
            '主题颜色',
            [
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _themeColors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() => _primaryColor = _themeColors[index]),
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _themeColors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _primaryColor == _themeColors[index]
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _buildSection(
            '字体设置',
            [
              _buildSwitchItem(
                '使用系统字体',
                '使用系统默认字体',
                _useSystemFont,
                (value) => setState(() => _useSystemFont = value),
              ),
              _buildSliderItem(
                '字体大小',
                _fontSize,
                (value) => setState(() => _fontSize = value),
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

  Widget _buildSliderItem(
    String title,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Slider(
            value: value,
            min: 12,
            max: 24,
            divisions: 12,
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
} 