import 'package:custom_wrap_app/app/custom_wrap.dart';
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
          // Wrap(
          //   children: [
          //     Container(
          //       height: 100,
          //       width: double.infinity,
          //       color: Colors.red,
          //     ),
          //     Container(
          //       height: 100,
          //       width: double.infinity,
          //       color: Colors.yellow,
          //     ),
          //   ],
          // ),
          CustomWrap(
            maxLines: 2,
            overflowWidget: Container(
              color: Colors.blueAccent,
              height: 100,
              width: 170,
              child: const Center(child: Text('More')),
            ),
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
                child: const Center(child: Text('1')),
              ),
              Container(
                color: Colors.green,
                height: 100,
                width: 100,
                child: const Center(child: Text('2')),
              ),
              Container(
                color: Colors.yellow,
                height: 100,
                width: 100,
                child: const Center(child: Text('3')),
              ),
              Container(
                color: Colors.grey,
                height: 100,
                width: 130,
                child: const Center(child: Text('4')),
              ),
              Container(
                color: Colors.grey,
                height: 100,
                width: 130,
                child: const Center(child: Text('4')),
              ),
              Container(
                color: Colors.grey,
                height: 100,
                width: 130,
                child: const Center(child: Text('4')),
              ),
            ],
          ),
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
