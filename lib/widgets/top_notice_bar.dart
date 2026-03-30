import 'package:flutter/material.dart';

class TopNoticeBar extends StatelessWidget {
  final String targetName;

  const TopNoticeBar({super.key, required this.targetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF7A0000).withValues(alpha: 245),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 115), blurRadius: 10),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '將 $targetName 流放至地獄',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
