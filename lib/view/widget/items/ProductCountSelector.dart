import 'package:flutter/material.dart';
import 'package:foodi1/core/constant/color.dart';

class ProductCountRollCircle extends StatefulWidget {
  final int initialCount;
  final int minCount;
  final int maxCount;
  final ValueChanged<int> onCountChanged;

  ProductCountRollCircle({
    required this.initialCount,
    this.minCount = 1,
    this.maxCount = 2000,
    required this.onCountChanged,
  });

  @override
  _ProductCountRollCircleState createState() => _ProductCountRollCircleState();
}

class _ProductCountRollCircleState extends State<ProductCountRollCircle> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: widget.initialCount );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Height of the scrollable area
      width:  70, // Width of the scrollable area
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        physics: FixedExtentScrollPhysics(),
        itemExtent: 90, // Height of each number item
        onSelectedItemChanged: (selectedCount) {
          widget.onCountChanged(selectedCount);
          print("selectedCount: $selectedCount");
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$index',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: index == widget.initialCount ? AppColor.primaryColor : Colors.black,
                    ),
                  ),
                ],
              );
          },
          childCount: widget.maxCount - widget.minCount + 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
