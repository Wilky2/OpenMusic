import 'package:flutter/material.dart';

class PaginationBar extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageSelected;

  PaginationBar({required this.currentPage, required this.totalPages, required this.onPageSelected});

  @override
  State<StatefulWidget> createState() => _PaginationBarState();
}

class _PaginationBarState extends State<PaginationBar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(widget.totalPages, (index) {
          final page = index + 1;
          final isSelected = page == widget.currentPage;

          return GestureDetector(
            onTap: () {
              widget.onPageSelected(page);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '$page',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}