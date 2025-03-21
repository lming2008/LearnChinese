import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帮助中心'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSearchBar(),
          _buildSection(
            '常见问题',
            [
              _buildHelpItem(
                '如何开始学习？',
                '了解学习流程和课程选择',
                () => _showHelpContent(context, '如何开始学习？'),
              ),
              _buildHelpItem(
                '如何提高学习效率？',
                '学习技巧和方法建议',
                () => _showHelpContent(context, '如何提高学习效率？'),
              ),
              _buildHelpItem(
                '如何查看学习进度？',
                '了解进度追踪功能',
                () => _showHelpContent(context, '如何查看学习进度？'),
              ),
            ],
          ),
          _buildSection(
            '账号相关',
            [
              _buildHelpItem(
                '如何修改密码？',
                '密码修改和账号安全',
                () => _showHelpContent(context, '如何修改密码？'),
              ),
              _buildHelpItem(
                '如何绑定手机号？',
                '手机号绑定和验证',
                () => _showHelpContent(context, '如何绑定手机号？'),
              ),
            ],
          ),
          _buildSection(
            '联系支持',
            [
              _buildHelpItem(
                '在线客服',
                '实时解答您的问题',
                () => _showHelpContent(context, '在线客服'),
              ),
              _buildHelpItem(
                '反馈建议',
                '帮助我们改进产品',
                () => _showHelpContent(context, '反馈建议'),
              ),
              _buildHelpItem(
                '邮件支持',
                'support@learnchinese.com',
                () => _showHelpContent(context, '邮件支持'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: '搜索帮助内容',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
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

  Widget _buildHelpItem(
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

  void _showHelpContent(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      _getHelpContent(title),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getHelpContent(String title) {
    switch (title) {
      case '如何开始学习？':
        return '''
1. 选择适合你的课程
   - 根据你的中文水平选择合适的课程
   - 从基础课程开始，循序渐进
   - 可以同时学习多个课程

2. 制定学习计划
   - 设置每日学习目标
   - 安排固定的学习时间
   - 保持学习的连续性

3. 开始学习
   - 按照课程顺序学习
   - 完成每个课程的学习任务
   - 及时复习和练习
''';
      case '如何提高学习效率？':
        return '''
1. 制定合理的学习计划
   - 每天固定时间学习
   - 循序渐进，不要急于求成
   - 合理安排复习时间

2. 使用学习工具
   - 使用拼音标注
   - 开启发音练习
   - 使用生词本功能

3. 多听多说
   - 反复听音频
   - 模仿发音
   - 多进行口语练习
''';
      case '如何查看学习进度？':
        return '''
1. 在首页查看
   - 查看每日学习目标完成情况
   - 查看课程完成进度
   - 查看学习时长统计

2. 在个人中心查看
   - 查看总体学习进度
   - 查看获得的成就
   - 查看学习统计

3. 在课程详情页查看
   - 查看具体课程进度
   - 查看已完成的课时
   - 查看学习记录
''';
      case '如何修改密码？':
        return '''
1. 进入个人中心
2. 点击"设置"
3. 选择"账号安全"
4. 点击"修改密码"
5. 输入原密码和新密码
6. 确认修改
''';
      case '如何绑定手机号？':
        return '''
1. 进入个人中心
2. 点击"设置"
3. 选择"账号安全"
4. 点击"绑定手机号"
5. 输入手机号
6. 获取验证码
7. 输入验证码
8. 确认绑定
''';
      case '在线客服':
        return '''
工作时间：周一至周日 9:00-22:00

您可以通过以下方式联系在线客服：
1. 点击"在线客服"按钮
2. 描述您的问题
3. 等待客服回复

如果当前客服繁忙，您也可以：
1. 留下您的联系方式
2. 客服会在工作时间内回复您
''';
      case '反馈建议':
        return '''
感谢您的反馈，这将帮助我们改进产品！

您可以通过以下方式提供反馈：
1. 点击"反馈建议"
2. 选择反馈类型
3. 详细描述您的建议
4. 提交反馈

我们会认真对待每一条反馈，并在后续版本中持续改进。
''';
      case '邮件支持':
        return '''
如果您遇到问题，可以通过邮件联系我们：

邮箱地址：support@learnchinese.com

请在邮件中提供：
1. 您的账号信息
2. 问题描述
3. 相关截图（如果有）

我们会在收到邮件后的24小时内回复您。
''';
      default:
        return '暂无相关内容';
    }
  }
} 