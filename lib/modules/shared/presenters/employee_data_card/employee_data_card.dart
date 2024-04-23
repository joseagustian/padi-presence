import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';

class EmployeeDataCard extends ConsumerWidget {
  const EmployeeDataCard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ]
      ),
      child: ref.watch(employeeDataProvider).when(
        data: (data) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade700,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.blueGrey.shade400,
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                    Text(
                      data['employeeId'],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade500
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data['jobPosition'],
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700
                      ),
                    ),
                    Text(
                      data['email'],
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        loading: () => Shimmer(
          linearGradient: shimmerGradient,
          child: ShimmerLoading(
            isLoading: true,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 100,
                minWidth: 100,
                maxWidth: 100,
                maxHeight: 100
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
            )
            ),
          ),
        error: (e, s) => ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 100,
            minWidth: 100,
            maxWidth: 100,
            maxHeight: 100
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        )
      )
    );
  }
}
