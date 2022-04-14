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
            ],
          ),
        ],
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
