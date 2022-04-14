import 'package:custom_wrap_app/app/overflowed_wrap.dart';
import 'package:flutter/material.dart';

import 'service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom wrap'),
      ),
      body: Column(
        children: [
          const Text('Services'),
          OverflowedWrap(
            maxLines: 2,
            spacing: 10,
            runSpacing: 10,
            overflowWidget: Container(
              color: Colors.blueAccent,
              height: 100,
              width: 160,
              child: const Center(child: Text('More')),
            ),
            children: [
              Container(
                key: const ValueKey(1),
                color: Colors.red,
                height: 100,
                width: 100,
                child: const Center(child: Text('1')),
              ),
              Container(
                key: const ValueKey(2),
                color: Colors.green,
                height: 100,
                width: 100,
                child: const Center(child: Text('2')),
              ),
              Container(
                key: const ValueKey(3),
                color: Colors.yellow,
                height: 100,
                width: 100,
                child: const Center(child: Text('3')),
              ),
              Container(
                key: const ValueKey(4),
                color: Colors.grey,
                height: 100,
                width: 300,
                child: const Center(child: Text('4')),
              ),
              Container(
                key: const ValueKey(5),
                color: Colors.grey,
                height: 100,
                width: 130,
                child: const Center(child: Text('5')),
              ),
            ],
          ),
          const Text('joao'),
        ],
      ),
    );
  }
}

const services = [
  Service(name: 'this', icon: Icons.alarm),
  Service(name: 'is', icon: Icons.lock_clock_outlined),
  Service(name: 'a', icon: Icons.add_comment_rounded),
  Service(name: 'testing', icon: Icons.addchart_outlined),
  Service(name: 'a long service', icon: Icons.air),
  Service(name: 'this', icon: Icons.alarm),
  Service(name: 'is', icon: Icons.lock_clock_outlined),
  Service(name: 'a', icon: Icons.add_comment_rounded),
  Service(name: 'testing', icon: Icons.addchart_outlined),
  Service(name: 'a long service', icon: Icons.air),
];
