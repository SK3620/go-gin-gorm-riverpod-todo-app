import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class  CommonProgress extends StatelessWidget {
  const CommonProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: 150.w,
          height: 150.w,
          child: const CircularProgressIndicator(
            color: Colors.green,
            strokeWidth: 15,
          ),
        )
    );
  }
}