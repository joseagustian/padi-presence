import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/url_launcher_utils.dart';
import 'package:padi/modules/shared/presenters/maps/google_map_launcher.dart';

class AppHelpContent extends StatelessWidget {
  const AppHelpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(Strings.pathLogoPadi),
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                GoogleMapLauncher.launch(
                    -7.832287,
                    110.378936,
                    Strings.companyName,
                );
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  Strings.companyAddress,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_in_talk,
                  size: 16,
                  color: Colors.blueGrey.shade800,
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    UrlLauncherUtils.phoneCall(Strings.companyPhone);
                  },
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    Strings.companyPhone,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade800
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_email,
                  size: 16,
                  color: Colors.blueGrey.shade800,
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    UrlLauncherUtils.email(Strings.companyEmail, Strings.padiAppProblem);
                  },
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    Strings.companyEmail,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade800
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.travel_explore_rounded,
                  size: 16,
                  color: Colors.blueGrey.shade800,
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    UrlLauncherUtils.openUrl(Strings.companyWebsite);
                  },
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    Strings.companyWebsite,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade800
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
