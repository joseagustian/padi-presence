import 'package:padi/modules/attendance/record/domains/entities/padi_scheduler_entity.dart';
import 'package:padi/modules/attendance/record/infra/sources/padi_scheduler_services.dart';

class PadiSchedulerUseCase {

  final PadiSchedulerServices padiSchedulerServices;
  PadiSchedulerUseCase(this.padiSchedulerServices);

  Future<PadiScheduler> runScheduler() async {
    final response = await padiSchedulerServices.runScheduler();

    final responses = PadiScheduler(
      status: response.status,
      message: response.message,
    );

    return responses;
  }

}