import 'package:flutter/material.dart';
import 'package:carimangan/provider/preferences_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.brown,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.brown,
        ),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Material(
            child: ListTile(
              title: const Text('Penjadwalan Berita'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyNewsActive,
                    onChanged: (value) async {
                      scheduled.scheduledNews(value);
                      provider.enableDailyNews(value);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
