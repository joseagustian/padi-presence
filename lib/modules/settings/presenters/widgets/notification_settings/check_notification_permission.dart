
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> checkNotificationPermission() async {
  PermissionStatus permissionStatus = await Permission.notification.status;
  return permissionStatus;

}