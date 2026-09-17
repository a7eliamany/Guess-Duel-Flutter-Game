import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SegmentedSelector<T> extends StatelessWidget {
  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T item)? labelBuilder;

  const SegmentedSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: items.map((item) {
          final isSelected = item == selectedItem;
          final displayText = labelBuilder != null
              ? labelBuilder!(item)
              : item.toString();

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(item),
              child: AnimatedContainer(
                duration: 200.milliseconds,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF8F00FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFFCFC2D9),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
