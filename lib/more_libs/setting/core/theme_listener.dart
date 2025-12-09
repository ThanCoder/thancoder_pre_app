import 'dart:async';

import 'package:t_widgets/t_widgets.dart';
import 'package:thancoder_pre_app/more_libs/setting/setting.dart';
import 'package:flutter/material.dart';

class ThemeListener extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeMode themeMode) builder;
  const ThemeListener({super.key, required this.builder});

  @override
  State<ThemeListener> createState() => _ThemeListenerState();
}

class _ThemeListenerState extends State<ThemeListener> {
  late StreamSubscription<Brightness> _streamSubscription;
  @override
  void initState() {
    init(BrightnessServices.instance.currentBrightness);
    _streamSubscription = BrightnessServices.instance.onBrightnessChanged
        .listen(init);
    BrightnessServices.instance.init();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void init(Brightness brightness) {
    final config = Setting.getAppConfig;
    if (config.themeMode == ThemeMode.system) {
      Setting.getAppConfigNotifier.value = config.copyWith(
        isDarkTheme: brightness.isDark,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Setting.getAppConfigNotifier,
      builder: (context, config, child) {
        return widget.builder(
          context,
          config.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}

class BrightnessServices with WidgetsBindingObserver {
  // singleton
  static final BrightnessServices instance = BrightnessServices._();
  BrightnessServices._();
  factory BrightnessServices() => instance;

  final _controller = StreamController<Brightness>.broadcast();
  Stream<Brightness> get onBrightnessChanged => _controller.stream;
  Brightness currentBrightness = Brightness.light;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    // initial checkThemeEvent
    checkCurrentTheme();
  }

  @override
  void didChangePlatformBrightness() {
    checkCurrentTheme();
    super.didChangePlatformBrightness();
  }

  void checkCurrentTheme() {
    // Android <10, Linux မှာ အမြဲ light ဖြစ်နိုင်တယ်
    currentBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _controller.add(currentBrightness);
  }
}
