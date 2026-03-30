import 'package:flutter/material.dart';

class InfoDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const InfoDetailScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B16), // 後備暗色背景
      body: Stack(
        children: [
          // 1. 背景圖片 ( assets/images/torii_bg.jpg) - 提供深度和主題
          Positioned.fill(
            child: Opacity(
              opacity: 0.8, // 融合背景，避免圖片過亮
              child: Image.asset(
                'assets/images/worldbg.jpg', // ✅ 圖片路徑，用戶需要修改
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. 徑向漸層遮罩 (突出標題區域，增加地獄般的鮮紅氛圍)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.6), // 集中在標題位置
                  radius: 1.2,
                  colors: [
                    const Color(0xFFFF1A1A).withOpacity(0.18), // 亮紅
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3. 線性漸層遮罩 (使整體變暗，提高底部文字可讀性)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 0.8, 1.0],
                  colors: [
                    Colors.transparent,
                    const Color(0xFF070B16).withOpacity(0.8), // 深暗紅藍
                    const Color(0xFF070B16), // 底部完全變黑
                  ],
                ),
              ),
            ),
          ),

          // 4. 內容 SafeArea
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ), // 移除垂直 Padding
              child: Column(
                children: [
                  // 4.1 自定義簡潔的 AppBar Container (只有返回鍵)
                  Container(
                    height: 56, // 標準 AppBar 高度
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.zero, // 移除內部 Padding
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFFEE0000),
                      ), // 鮮紅
                      onPressed: () => Navigator.pop(context), // 返回上一頁
                    ),
                  ),

                  // 4.2 內容 Expanded Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // 內容佔滿水平
                      children: [
                        const SizedBox(height: 12), // 與 AppBar 分離
                        // 標題 Text (靠左對齊)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xFFEE0000), // 鮮紅
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              // fontFamily: 'He地獄othic', // 如果有的話，可以加入主題字體
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 裝飾用的一條紅線 (靠左對齊)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 60,
                            height: 4,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // 內容文字 (包裹在 SingleChildScrollView 和 Expanded 中)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              content,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                height: 1.8,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
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
