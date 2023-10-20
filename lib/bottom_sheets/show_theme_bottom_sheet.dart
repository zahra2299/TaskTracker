import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/shared/styles/colors.dart';
import '../providers/settings_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: pro.theme == ThemeMode.light
                      ? Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primary)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: white),
                ),
                pro.theme == ThemeMode.light
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
              pro.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.dark,
                    style: pro.theme == ThemeMode.dark
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primary)
                        : Theme.of(context).textTheme.bodyLarge),
                pro.theme == ThemeMode.dark
                    ? Icon(
                        Icons.done,
                        color: primary,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
