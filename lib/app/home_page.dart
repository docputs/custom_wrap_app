import 'package:custom_wrap_app/app/overflowed_wrap.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Without overflow',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              OverflowedWrap(
                maxLines: 2,
                spacing: 10,
                runSpacing: 10,
                overflowWidget: Container(
                  key: const ValueKey('overflow'),
                  color: Colors.blueAccent,
                  height: 100,
                  width: 100,
                  child: const Center(child: Text('More')),
                ),
                children: const [
                  WrapItem(
                    text: '1',
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  WrapItem(
                    text: '2',
                    width: 150,
                    height: 100,
                    color: Colors.green,
                  ),
                  WrapItem(
                    text: '3',
                    width: 50,
                    height: 100,
                    color: Colors.yellow,
                  ),
                  WrapItem(
                    text: '4',
                    width: 200,
                    height: 100,
                    color: Colors.grey,
                  ),
                  WrapItem(
                    text: '5',
                    width: 160,
                    height: 100,
                    color: Colors.brown,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'With overflow',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              OverflowedWrap(
                maxLines: 2,
                spacing: 10,
                runSpacing: 10,
                overflowWidget: _buildOverflowWidget(),
                children: const [
                  WrapItem(
                    text: '1',
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  WrapItem(
                    text: '2',
                    width: 150,
                    height: 100,
                    color: Colors.green,
                  ),
                  WrapItem(
                    text: '3',
                    width: 50,
                    height: 100,
                    color: Colors.yellow,
                  ),
                  WrapItem(
                    text: '4',
                    width: 200,
                    height: 100,
                    color: Colors.grey,
                  ),
                  WrapItem(
                    text: '5',
                    width: 200,
                    height: 100,
                    color: Colors.brown,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverflowWidget() {
    return Container(
      key: const ValueKey('overflow'),
      height: 100,
      width: 100,
      child: const Center(
        child: Text(
          'More',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 5),
      ),
    );
  }
}

class WrapItem extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;

  const WrapItem({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$text tapped');
      },
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Center(child: Text(text)),
      ),
    );
  }
}
