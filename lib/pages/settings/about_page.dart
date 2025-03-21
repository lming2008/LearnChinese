import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '1.0.0';
  String _buildNumber = '1';

  @override
  void initState() {
    super.initState();
    _getAppInfo();
  }

  Future<void> _getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildHeader(),
          _buildSection(
            '应用信息',
            [
              _buildInfoItem(
                '版本',
                '$_version ($_buildNumber)',
              ),
              _buildInfoItem(
                '更新日期',
                '2024-03-20',
              ),
              _buildInfoItem(
                '开发者',
                'Learn Chinese Team',
              ),
            ],
          ),
          _buildSection(
            '联系我们',
            [
              _buildLinkItem(
                '官方网站',
                'www.learnchinese.com',
                () => _launchUrl('https://www.learnchinese.com'),
              ),
              _buildLinkItem(
                '微信公众号',
                'LearnChinese',
                () => _launchUrl('https://weixin.qq.com/learnchinese'),
              ),
              _buildLinkItem(
                '新浪微博',
                '@LearnChinese',
                () => _launchUrl('https://weibo.com/learnchinese'),
              ),
            ],
          ),
          _buildSection(
            '法律信息',
            [
              _buildLinkItem(
                '用户协议',
                '请仔细阅读用户协议',
                () => _showAgreement(context, '用户协议'),
              ),
              _buildLinkItem(
                '隐私政策',
                '了解我们的隐私政策',
                () => _showAgreement(context, '隐私政策'),
              ),
              _buildLinkItem(
                '免责声明',
                '了解免责声明内容',
                () => _showAgreement(context, '免责声明'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.school,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Learn Chinese',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '让学习中文变得简单有趣',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
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

  Widget _buildInfoItem(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildLinkItem(
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

  void _launchUrl(String url) {
    // TODO: 实现URL打开功能
  }

  void _showAgreement(BuildContext context, String title) {
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
                      _getAgreementContent(title),
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

  String _getAgreementContent(String title) {
    switch (title) {
      case '用户协议':
        return '''
欢迎使用 Learn Chinese 应用！

1. 服务说明
   - Learn Chinese 是一个在线中文学习平台
   - 我们提供课程学习、练习、测试等服务
   - 用户需要注册账号才能使用完整功能

2. 账号规则
   - 用户需要提供真实、准确的个人信息
   - 账号密码需要妥善保管
   - 禁止将账号转让或授权他人使用

3. 使用规则
   - 遵守相关法律法规
   - 尊重知识产权
   - 不得发布违法违规内容

4. 服务变更
   - 我们保留随时修改服务的权利
   - 重大变更会提前通知用户
   - 用户可以选择接受或终止服务
''';
      case '隐私政策':
        return '''
我们重视您的隐私，承诺保护您的个人信息。

1. 信息收集
   - 账号信息：用户名、邮箱、手机号等
   - 学习数据：学习记录、进度、成绩等
   - 设备信息：设备型号、系统版本等

2. 信息使用
   - 提供和改进服务
   - 个性化学习体验
   - 发送通知和更新

3. 信息保护
   - 采用加密技术保护数据
   - 定期安全审计
   - 严格控制数据访问

4. 信息共享
   - 不会出售您的个人信息
   - 仅在必要时与合作伙伴共享
   - 遵守相关法律法规
''';
      case '免责声明':
        return '''
1. 服务可用性
   - 我们努力保证服务的稳定性
   - 但不对服务中断负责
   - 建议定期备份学习数据

2. 内容准确性
   - 课程内容经过专业审核
   - 但可能存在个别错误
   - 欢迎用户反馈问题

3. 学习效果
   - 学习效果因人而异
   - 不保证具体的学习成果
   - 建议制定合理的学习计划

4. 第三方服务
   - 可能包含第三方链接
   - 不对第三方服务负责
   - 建议谨慎使用第三方服务
''';
      default:
        return '暂无相关内容';
    }
  }
} 