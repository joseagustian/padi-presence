import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EmployeeDigitalIDDialog extends ConsumerWidget {
  const EmployeeDigitalIDDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(employeeDataProvider);
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.employeeDigitalId,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 150,
              height: 150,
              child: QrImageView(
                version: QrVersions.auto,
                size: 100,
                data: 'BEGIN:VCARD\n'
                    'N:${data.value?['name']}\n'
                    'FN:${data.value?['name']}\n'
                    'ORG:${Strings.companyName}\n'
                    'TITLE:${data.value?['jobPosition']}\n'
                    'ADR:;;${data.value?['address']}\n'
                    'EMAIL;WORK;INTERNET:${data.value?['email']}\n'
                    'END:VCARD',
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.blueGrey.shade600,
                ),
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.blueGrey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              data.value?['employeeId']?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data.value?['name']?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              data.value?['jobPosition']?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showEmployeeDigitalIdDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const EmployeeDigitalIDDialog(),
  );
}
