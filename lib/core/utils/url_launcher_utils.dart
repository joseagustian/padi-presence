
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<void> phoneCall(String phoneNumber) async {
    final Uri phoneCall = Uri(
      scheme: 'tel',
      path: phoneNumber
    );

    await launchUrl(phoneCall);
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> email(String email, String subject) async {
    final Uri emailLaunch = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
      }),
    );

    await launchUrl(emailLaunch);
  }

  static Future<void> openUrl(String url) async {
    final Uri openUrl = Uri(
      scheme: 'https',
      path: url
    );

    await launchUrl(openUrl);
  }
}