import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/modules/settings/presenters/widgets/application_log/app_log_filter_state_provider.dart';

class AppLogAppBar extends ConsumerWidget {
  const AppLogAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    router.pop(context);
                  },
                  splashFactory: NoSplash.splashFactory,
                  child: Icon(
                      EvaIcons.arrow_back_outline,
                      color: Colors.blueGrey.shade700,
                      size: 24
                  ),
                ),
                Expanded(
                  child: Text(
                    Strings.applicationLog,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                MenuAnchor(
                  alignmentOffset: const Offset(-95, 20),
                  style: MenuStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    surfaceTintColor: WidgetStateProperty.all(Colors.white),
                  ),
                  builder: (context, MenuController controller, Widget? child) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Icon(
                          Icons.filter_list_sharp,
                          color: Colors.blueGrey.shade700,
                          size: 24
                      ),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        ref.watch(appLogFilterProvider.notifier).setFilterType(AppLogFilterType.info);
                      },
                      child: Text(
                        Strings.informationAppLog,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        ref.watch(appLogFilterProvider.notifier).setFilterType(AppLogFilterType.warning);
                      },
                      child: Text(
                        Strings.warningAppLog,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        ref.watch(appLogFilterProvider.notifier).setFilterType(AppLogFilterType.error);
                      },
                      child: Text(
                        Strings.errorAppLog,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        ref.watch(appLogFilterProvider.notifier).setFilterType(AppLogFilterType.all);
                      },
                      child: Text(
                        Strings.clearAppLogFilter,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
              height: 0.5,
              color: Colors.blueGrey.shade100
          )
        ],
      ),
    );
  }
}
