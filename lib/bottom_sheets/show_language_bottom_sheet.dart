import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/styles/theming.dart';
import '../providers/settings_provider.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeLanguage("en");
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: pro.local == "en"
                            ? pro.theme == ThemeMode.light
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary
                            : pro.theme == ThemeMode.light
                                ? Colors.black
                                : Theme.of(context).colorScheme.onPrimary)),
                pro.local == "en"
                    ? Icon(Icons.done, color: primary)
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              pro.changeLanguage("ar");
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: pro.local == "ar"
                            ? pro.theme == ThemeMode.light
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary
                            : pro.theme == ThemeMode.light
                                ? Colors.black
                                : Theme.of(context).colorScheme.onPrimary)),
                pro.local == "ar"
                    ? Icon(Icons.done, color: primary)
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
