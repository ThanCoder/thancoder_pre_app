import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_pre_app/more_libs/setting/setting.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Setting.instance.appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TLoader.random(isDarkMode: Setting.getAppConfig.isDarkTheme),
            Text(
              'Is Dark Theme: ${Setting.getAppConfig.isDarkTheme}',
              style: TextTheme.of(context).headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
