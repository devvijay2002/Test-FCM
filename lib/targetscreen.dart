import 'package:flutter/material.dart';

class TargetScreen extends StatefulWidget {
  final String? payload;

  const TargetScreen({super.key, this.payload});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Target Screen'),
      ),
      body: Center(
        child: Text('Payload: ${widget.payload}'),
      ),
    );
  }
}
