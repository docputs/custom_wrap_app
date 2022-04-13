import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomWrap extends MultiChildRenderObjectWidget {
  final int maxLines;
  final double spacing;
  final double runSpacing;

  CustomWrap({
    Key? key,
    List<Widget> children = const [],
    required this.maxLines,
    this.spacing = 0,
    this.runSpacing = 0,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomWrap(
      maxLines: maxLines,
      runSpacing: runSpacing,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomWrap renderObject) {
    renderObject
      ..maxLines = maxLines
      ..spacing = spacing
      ..lineSpacing = runSpacing;
  }
}

class RenderCustomWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomWrapParentData> {
  RenderCustomWrap({
    required int maxLines,
    double spacing = 0,
    double runSpacing = 0,
  })  : _maxLines = maxLines,
        _spacing = spacing,
        _runSpacing = runSpacing;

  int get maxLines => _maxLines;
  int _maxLines;
  set maxLines(int value) {
    if (value == _maxLines) {
      return;
    }
    _maxLines = value;
    markNeedsLayout();
  }

  double get spacing => _spacing;
  double _spacing;
  set spacing(double value) {
    if (value == _spacing) {
      return;
    }
    _spacing = value;
    markNeedsLayout();
  }

  double get lineSpacing => _runSpacing;
  double _runSpacing;
  set lineSpacing(double value) {
    if (value == _runSpacing) {
      return;
    }
    _runSpacing = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    final childConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
    final List<_LineMetrics> lineMetrics = <_LineMetrics>[];
    final widthLimit = constraints.maxWidth;
    double wrapHeight = 0.0;
    double lineWidth = 0.0;
    double lineHeight = 0.0;
    int childCount = 0;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);

      final childWidth = _getMainAxisExtent(child.size);
      final childHeight = _getCrossAxisExtent(child.size);

      if (childCount > 0 && lineWidth + childWidth > widthLimit) {
        wrapHeight += lineHeight;
        if (lineMetrics.isNotEmpty) wrapHeight += lineSpacing;
        lineMetrics.add(
          _LineMetrics(lineWidth, lineHeight, childCount),
        );
        lineWidth = 0.0;
        lineHeight = 0.0;
        childCount = 0;
      }

      lineWidth += childWidth;
      if (childCount > 0) lineWidth += spacing;
      lineHeight = math.max(lineHeight, childHeight);
      childCount += 1;

      final childParentData = child.parentData! as CustomWrapParentData;
      childParentData._runIndex = lineMetrics.length;
      child = childParentData.nextSibling;
    }
    if (childCount > 0) {
      wrapHeight += lineHeight;
      if (lineMetrics.isNotEmpty) {
        wrapHeight += lineSpacing;
      }
      lineMetrics.add(
        _LineMetrics(lineWidth, lineHeight, childCount),
      );
    }

    child = lastChild;
    final difference = lineMetrics.length - maxLines;
    for (var j = 0; j < difference; ++j) {
      final childCount = lineMetrics.reversed.elementAt(j).childCount;
      for (var k = 0; k < childCount; k++) {
        final childParentData = child!.parentData! as CustomWrapParentData;
        childParentData._shouldBePainted = false;
        child = childParentData.previousSibling;
      }
    }

    final runCount = lineMetrics.length;
    assert(runCount > 0);

    // Set CustomWrap widget size
    size = constraints.constrain(Size(constraints.maxWidth, wrapHeight));
    final containerWidth = size.width;
    final containerHeight = size.height;

    final heightFreeSpace = math.max(0.0, containerHeight - wrapHeight);

    double lineVerticalOffset = 0;
    child = firstChild;
    for (var i = 0; i < runCount; ++i) {
      final metrics = lineMetrics[i];
      print('i: $i, metrics: $metrics');
      final lineWidth = metrics.mainAxisExtent;
      final lineHeight = metrics.crossAxisExtent;
      final childCount = metrics.childCount;

      final widthFreeSpace = math.max(0.0, containerWidth - lineWidth);
      double childLeadingSpace = 0.0;
      double childBetweenSpace = 0.0;

      childBetweenSpace += spacing;

      double childHorizontalOffset = 0;
      while (child != null) {
        final childParentData = child.parentData! as CustomWrapParentData;
        if (childParentData._runIndex != i) {
          break;
        }
        final childWidth = _getMainAxisExtent(child.size);
        final childHeight = _getCrossAxisExtent(child.size);

        childParentData.offset = Offset(
          childHorizontalOffset,
          lineVerticalOffset,
        );
        childHorizontalOffset += childWidth + childBetweenSpace;
        child = childParentData.nextSibling;
      }
      lineVerticalOffset += lineHeight + lineSpacing;
    }
  }

  double _getMainAxisExtent(Size childSize) => childSize.width;
  double _getCrossAxisExtent(Size childSize) => childSize.height;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! CustomWrapParentData) {
      child.parentData = CustomWrapParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as CustomWrapParentData;
      if (childParentData._shouldBePainted) {
        context.paintChild(child, childParentData.offset + offset);
      }
      child = childParentData.nextSibling;
    }
  }
}

class CustomWrapParentData extends ContainerBoxParentData<RenderBox> {
  int _runIndex = 0;
  bool _shouldBePainted = true;
}

class _LineMetrics {
  final double mainAxisExtent;
  final double crossAxisExtent;
  final int childCount;

  const _LineMetrics(
    this.mainAxisExtent,
    this.crossAxisExtent,
    this.childCount,
  );

  @override
  String toString() =>
      '_LineMetrics(mainAxisExtent: $mainAxisExtent, crossAxisExtent: $crossAxisExtent, childCount: $childCount)';
}
