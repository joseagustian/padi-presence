import 'package:padi/modules/shared/domains/job_division/entities/job_division_entity.dart';
import 'package:padi/modules/shared/infra/sources/job_division_service.dart';

class JobDivisionUseCase {
  final JobDivisionServices jobDivisionServices;

  JobDivisionUseCase(this.jobDivisionServices);

  Future<JobDivisions> getJobDivisions() async {
    final jobDivisionData = await jobDivisionServices.getJobDivisions();

    final jobDivision = JobDivisions(
      status: jobDivisionData.status,
      data: jobDivisionData.data.map((e) => DivisionData(
        id: e.id,
        divisionName: e.divisionName,
      )).toList(),
      message: jobDivisionData.message,
    );

    return jobDivision;
  }
}