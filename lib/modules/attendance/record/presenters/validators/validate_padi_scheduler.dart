
import 'package:flutter/material.dart';
import 'package:padi/modules/attendance/record/padi_scheduler_provider.dart';

void validatePadiScheduler(
    BuildContext context,
    PadiSchedulerProvider padiSchedulerProvider,
    ) {

  padiSchedulerProvider.runScheduler().then((value) => {

  }).catchError((e) {
    return <dynamic, dynamic>{};
  });

}