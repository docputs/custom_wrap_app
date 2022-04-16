import 'package:custom_wrap_app/app/overflowed_wrap.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                overflowWidget: _buildOverflowWidget(),
                children: const [
                  WrapItem(
                    text: 'this is a big widget',
                    height: 100,
                    color: Colors.red,
                  ),
                  WrapItem(
                    text: 'kind of small',
                    height: 100,
                    color: Colors.green,
                  ),
                  WrapItem(
                    text: 'a little big bigger',
                    height: 100,
                    color: Colors.yellow,
                  ),
                  WrapItem(
                    text: 'this is the biggest widget',
                    height: 100,
                    color: Colors.grey,
                  ),
                  WrapItem(
                    text: 'this fits the screen',
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
                    text: 'this is a big widget',
                    height: 100,
                    color: Colors.red,
                  ),
                  WrapItem(
                    text: 'kind of small',
                    height: 100,
                    color: Colors.green,
                  ),
                  WrapItem(
                    text: 'a little big bigger',
                    height: 100,
                    color: Colors.yellow,
                  ),
                  WrapItem(
                    text: 'this is the biggest widget that we have',
                    height: 100,
                    color: Colors.grey,
                  ),
                  WrapItem(
                    text: 'this is bigger than the screen width',
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
  final double? width;
  final double? height;
  final Color color;

  const WrapItem({
    Key? key,
    required this.text,
    this.width,
    this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('$text tapped');
      },
      child: Container(
        width: width,
        height: height,
        color: color,
        child: SizedBox(child: Text(text, maxLines: 1)),
      ),
    );
  }
}
