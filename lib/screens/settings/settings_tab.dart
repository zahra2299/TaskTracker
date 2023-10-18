import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/bottom_sheets/show_language_bottom_sheet.dart';
import 'package:todo/shared/styles/colors.dart';
import '../../bottom_sheets/show_theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/settings_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: pro.theme == ThemeMode.light
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: black)
                  : Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(height: 18),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 18),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primary)),
                child: Text(
                    pro.local == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 25)),
              ),
            ),
            SizedBox(height: 18),
            Text(
              AppLocalizations.of(context)!.mode,
              style: pro.theme == ThemeMode.light
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: black)
                  : Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(height: 18),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 18),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primary)),
                child: Text(AppLocalizations.of(context)!.mode,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showBottomSheet(
      context: context,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (context) {
        return LanguageBottomSheet();
      },
    );
  }

  void showThemeBottomSheet() {
    showBottomSheet(
      context: context,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (context) {
        return ThemeBottomSheet();
      },
    );
  }
}
