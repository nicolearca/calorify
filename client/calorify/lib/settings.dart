import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Text(
      "Settings",
      style: theme.bodyLarge,
    );
  }
}
