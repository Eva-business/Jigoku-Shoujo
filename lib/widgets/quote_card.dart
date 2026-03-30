import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteCard extends StatelessWidget {
  final String text;
  final String speaker;
  final String videoUrl;

  const QuoteCard({
    super.key,
    required this.text,
    required this.speaker,
    required this.videoUrl,
  });

  // 執行跳轉 YouTube 的非同步函數
  Future<void> _launchVideo(BuildContext context) async {
    final Uri url = Uri.parse(videoUrl);

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('無法開啟影片連結'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 改用 GestureDetector，完全不會影響你原本的顏色跟排版！
    return GestureDetector(
      onTap: () => _launchVideo(context), // 點擊卡片任何地方都會觸發播放
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        // 這裡完全還原你最初始的設計
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade700),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 229, 24, 24).withValues(alpha: 2),
              Colors.black,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.format_quote, color: Colors.white70, size: 28),
                // 右上角的小播放鍵，提示教授這張卡片可以點
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.red.shade400,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '—— $speaker',
                style: TextStyle(color: Colors.red.shade200, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
