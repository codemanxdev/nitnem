import 'package:flutter/material.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:url_launcher/url_launcher.dart';

class NitnemIcon extends StatelessWidget {
  const NitnemIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/images/khanda.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontFamily: AppConstants.ROBOTO_SLAB_FONT,
    );
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontFamily: AppConstants.ROBOTO_SLAB_FONT,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Nitnem'),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        iconTheme: theme.primaryIconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          const SizedBox(height: 10),
          const Center(child: NitnemIcon()),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Nitnem',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: AppConstants.ROBOTO_SLAB_FONT,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Waheguruji ka Khalsa, Waheguruji ki Fateh',
            textAlign: TextAlign.center,
            style: titleStyle?.copyWith(color: theme.primaryColor),
          ),
          const SizedBox(height: 12),
          Text(
            'Sangat Ji, this application is designed for your daily discipline and spiritual practice. If you find any mistakes, please let us know so they can be corrected.',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          const SizedBox(height: 24),
          _buildActionCard(
            context,
            icon: Icons.email_outlined,
            title: 'Report a Mistake',
            subtitle: AppConstants.CONTACT_EMAIL,
            onTap: () => _launchEmail(context),
          ),
          const SizedBox(height: 32),
          Text(
            'Attributions',
            style: titleStyle?.copyWith(fontSize: 18),
          ),
          const Divider(),
          const SizedBox(height: 12),
          _buildCreditGroup(
            context,
            source: 'flaticon.com',
            items: [
              _CreditItem('Khanda Icon', Icons.image_outlined),
            ],
          ),
          const SizedBox(height: 16),
          _buildCreditGroup(
            context,
            source: 'freepik.com',
            items: [
              _CreditItem('Forest Theme', Icons.landscape_outlined, 'kotkoa'),
              _CreditItem('Stars Theme', Icons.star_outline, '0melapics'),
              _CreditItem('Wood Theme', Icons.texture_outlined, 'Olga_spb'),
              _CreditItem('Floral Theme', Icons.local_florist_outlined, 'visnezh'),
              _CreditItem('Ethnic Theme', Icons.palette_outlined, 'visnezh'),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.primaryColor.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.primaryColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right, size: 20),
      ),
    );
  }

  Widget _buildCreditGroup(
    BuildContext context, {
    required String source,
    required List<_CreditItem> items,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            source,
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.primaryColor.withValues(alpha: 0.05)),
          ),
          child: Column(
            children: items.map((item) {
              final isLast = items.last == item;
              return Column(
                children: [
                  ListTile(
                    dense: true,
                    leading: Icon(item.icon, color: theme.primaryColor, size: 18),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    subtitle: item.author != null 
                        ? Text(item.author!, style: const TextStyle(fontSize: 11))
                        : null,
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 50,
                      endIndent: 16,
                      color: theme.primaryColor.withValues(alpha: 0.05),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    try {
      final String subject = Uri.encodeComponent('Nitnem App Feedback');
      final Uri mailtoUri = Uri.parse(
        'mailto:${AppConstants.CONTACT_EMAIL}?subject=$subject',
      );

      bool launched = await launchUrl(
        mailtoUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        throw 'Could not launch email client';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open email client. Please email us at ${AppConstants.CONTACT_EMAIL}',
            ),
          ),
        );
      }
    }
  }
}

class _CreditItem {
  final String title;
  final IconData icon;
  final String? author;

  _CreditItem(this.title, this.icon, [this.author]);
}
