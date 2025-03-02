import 'package:flutter/material.dart';
import 'package:foodi1/core/constant/color.dart';

class ProductCountRollCircle extends StatefulWidget {
  final int initialCount;
  final int minCount;
  final int maxCount;
  final ValueChanged<int> onCountChanged;

  const ProductCountRollCircle({
    super.key,
    required this.initialCount,
    this.minCount =0,
    this.maxCount = 5000,
    required this.onCountChanged,
  });

  @override
  State<ProductCountRollCircle> createState() => _ProductCountRollCircleState();
}

class _ProductCountRollCircleState extends State<ProductCountRollCircle> {
  late FixedExtentScrollController _scrollController;
  int _currentCount = 1;

  @override
  void initState() {
    super.initState();
    _currentCount = widget.initialCount;
    _scrollController = FixedExtentScrollController(
      initialItem: widget.initialCount - widget.minCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            controller: _scrollController,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 40,
            diameterRatio: 1.2,
            perspective: 0.005,
            magnification: 1.2,
            overAndUnderCenterOpacity: 0.99,
            onSelectedItemChanged: (index) {
              final newCount = index + widget.minCount;
              setState(() => _currentCount = newCount);
              widget.onCountChanged(newCount);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final count = index + widget.minCount;
                return Center(
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: _currentCount == count ? 24 : 18,
                      fontWeight: _currentCount == count
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _currentCount == count
                          ? AppColor.primaryColor
                          : Colors.grey[600],
                    ),
                  ),
                );
              },
              childCount: widget.maxCount - widget.minCount + 1,
            ),
          ),
          // Middle indicator line
          Center(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border(
                  // top: BorderSide(color: AppColor.primaryColor, width: 1.5),
                  // bottom: BorderSide(color: AppColor.primaryColor, width: 1.5),
                ),
              ),
            ),
          ),
          // Top gradient overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.white.withOpacity(0.9),
                    ],
                    stops: const [0.0, 0.0, 0.99, 0.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}