import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // 獲取螢幕高度，用來設定上方大圖的比例
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF070B16), // 延續暗色調背景
      body: Stack(
        children: [
          // 1. 背景大圖 (佔據螢幕上半部)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.55, // 佔螢幕高度的 55%
            child: Image.asset(
              character.bannerImagePath,
              fit: BoxFit.cover,
              // 如果圖片偏亮，可以加上 alignment 調整
              alignment: Alignment.topCenter,
            ),
          ),

          // 2. 圖片下方的漸層遮罩 (讓圖片底部完美融合進黑色背景)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.55 + 10, // 比圖片稍微高一點點
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.6, 0.95, 1.0], // 控制漸層的位置
                  colors: [
                    Colors.black.withOpacity(0.0), // 頂部透明
                    const Color(0xFF070B16).withOpacity(0.9), // 中間開始變暗
                    const Color(0xFF070B16), // 底部完全變黑
                  ],
                ),
              ),
            ),
          ),

          // 3. 內容區域 (使用 SingleChildScrollView 確保文字過長時可捲動)
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  // 自訂的透明 AppBar (只放一個返回鍵)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  // 佔位空間，把內容推到圖片下方
                  SizedBox(height: screenHeight * 0.45),

                  // 角色資訊內容
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(28, 0, 28, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 姓名
                          Text(
                            character.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 職位 / 身分
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade900.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red.shade700),
                            ),
                            child: Text(
                              character.role,
                              style: TextStyle(
                                color: Colors.red.shade200,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // 裝飾用的一條長紅線
                          Container(
                            width: 80,
                            height: 4,
                            color: Colors.red.shade700,
                          ),
                          const SizedBox(height: 32),

                          // 詳細描述文字
                          Text(
                            character.description,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              height: 1.8,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
