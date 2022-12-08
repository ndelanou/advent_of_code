import 'package:flutter/material.dart';

class ALErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final Function()? onRetry;
  const ALErrorWidget(this.error, {this.onRetry, this.stackTrace, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Error', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(error.toString()),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
