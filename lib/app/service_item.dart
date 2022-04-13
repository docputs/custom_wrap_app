import 'package:flutter/material.dart';

import 'service.dart';

class ServiceItem extends StatelessWidget {
  final Service service;

  const ServiceItem(
    this.service, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(service.icon),
          Text(service.name),
        ],
      ),
    );
  }
}
