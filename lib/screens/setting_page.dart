import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/color_setting.dart';
import 'lock_settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Settings', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSettingOption(
            context,
            title: 'Set Lock Pattern',
            icon: Icons.lock,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LockSettings()),
              );
            },
          ),
          _buildSettingOption(
            context,
            title: 'Volume controller',
            icon: Icons.volume_up,
            onTap: () {
              // Future: Add Notification settings navigation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Volume Settings Coming Soon!')),
              );
            },
          ),
          _buildSettingOption(
            context,
            title: ' Settings',
            icon: Icons.privacy_tip,
            onTap: () {
              // Future: Add Privacy settings navigation
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>RotatingBar()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}