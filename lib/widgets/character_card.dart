import 'package:flutter/material.dart';
import '../models/character.dart';
import '../screens/character_detail_screen.dart'; // 記得引入新建立的詳細頁

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  // 自訂轉場動畫：從右側滑入 (Slide in from right)
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CharacterDetailScreen(character: character),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // 從最右側開始
        const end = Offset.zero; // 回到原本位置
        const curve = Curves.easeOutCubic; // 平滑減速曲線

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
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      // 使用 Material 包裝，為了讓 InkWell 的點擊水波紋效果能顯示
      child: Material(
        color: const Color(0xFF161010),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias, // 確保水波紋不會超出圓角
        child: InkWell(
          onTap: () {
            // 點擊時，觸發側邊滑入動畫進入詳細頁
            Navigator.of(context).push(_createRoute());
          },
          child: Container(
            // 把 border 移到這裡，確保它在 InkWell 之外
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade900),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 角色頭像
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      character.imagePath,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 姓名
                        Text(
                          character.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 職位
                        Text(
                          character.role,
                          style: TextStyle(
                            color: Colors.red.shade200,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12), // 稍微增加一點間距
                        // 描述 (在卡片上只顯示兩行，超出就變成 ...)
                        Text(
                          character.description,
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
                  // 加上一個小箭頭，暗示可點擊
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
      ),
    );
  }
}
