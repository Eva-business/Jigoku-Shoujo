import 'package:flutter/material.dart';
import '../screens/info_detail_screen.dart';

class InfoCard extends StatelessWidget {
  final String imagePath; // 1. 把 IconData 改成 String 來接收圖片路徑
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.imagePath, // 2. 更新建構子
    required this.title,
    required this.content,
  });

  // 自訂轉場動畫：從右側滑入 (Slide in from right)
  Route _createRoute() {
    return PageRouteBuilder(
      // 3. 配合你新版的 InfoDetailScreen，這裡只傳入 title 和 content
      pageBuilder: (context, animation, secondaryAnimation) =>
          InfoDetailScreen(title: title, content: content),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade800),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 4. 把原本的 Icon 改成圖片，並加上圓角讓它更好看
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 50, // 圖片的寬度
                    height: 50, // 圖片的高度
                    fit: BoxFit.cover, // 確保圖片填滿正方形，不會變形
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white30,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
