import 'package:flutter/material.dart';
import 'hell_mail_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _goToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HellMailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _goToNextPage(context),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/images/pg.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.35)),
            ),
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 3), // ✅ 彈性留白
                  // 開場白文字區塊
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: FadeInStaticText(
                      // ✅ 更新文字內容為四句
                      text: '闇に惑いし哀れな影よ\n人を傷つけ貶めて\n罪に溺れし業の魂\nイッペン死ンデミル？',
                    ),
                  ),

                  const SizedBox(height: 250),

                  const FloatingTriangle(), // 保留原有的浮動三角形
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 🌟 依次顯現，且最後一句變形純紅的直式文字元件 ---
class FadeInStaticText extends StatefulWidget {
  final String text;

  const FadeInStaticText({super.key, required this.text});

  @override
  State<FadeInStaticText> createState() => _FadeInStaticTextState();
}

class _FadeInStaticTextState extends State<FadeInStaticText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late Animation<double> _lastLineEffectAnimation; // 🌟 新增：控制最後一句放大跟變色的動畫
  late List<String> _lines;

  @override
  void initState() {
    super.initState();

    // 1. 處理文字，根據 \n 拆分成行
    _lines = widget.text.split('\n');
    final int lineCount = _lines.length;

    // 2. 初始化單一控制器，總時間拉長到 7 秒 (為了戲劇張力)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    );

    // 🌟 3. 計算依序淡入動畫的區間 (0s ~ 4s 之間依序淡入)
    // 時間分配大約是：每一句用 1 秒淡入，總共 4 秒完成所有句子顯現。
    _fadeAnimations = List.generate(lineCount, (index) {
      double start = index * 0.14; // 例如：0.0, 0.14, 0.28, 0.42
      double end = (index + 1) * 0.14; // 例如：0.14, 0.28, 0.42, 0.56

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeIn),
        ),
      );
    });

    // 🌟 4. 計算最後一句「放大且變純紅」的動畫區間 (4.5s ~ 6s 之間執行)
    // 在 Interval 中使用 0.64 (大約 4.5秒) 到 0.85 (大約 6秒)
    _lastLineEffectAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        // 使用 elasticOut 曲線，讓最後一句放大時有衝擊感
        curve: const Interval(0.64, 0.85, curve: Curves.elasticOut),
      ),
    );

    // 5. 開始播放總控制器
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 修改排版邏輯：將直式排版與複雜的交錯/變形動畫結合
  Widget _buildVerticalText() {
    // 文字反轉，Row 由左向右排版時，第一句會擠到最右邊
    List<String> rtlLines = _lines.reversed.toList();
    final int lineCount = rtlLines.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Iterable<int>.generate(lineCount).map((index) {
        final line = rtlLines[index];
        // 修正後的索引對應 (index 0 是畫面上最左邊，也是原始陣列的最後一句)
        final originalIndex = lineCount - 1 - index;
        final fadeAnimation = _fadeAnimations[originalIndex];

        // 🌟 判斷是否為「原本的最後一句」 (イッペン死ンデミル？)
        final bool isLastOriginalLine = (originalIndex == _lines.length - 1);

        Widget lineWidget;

        if (!isLastOriginalLine) {
          // --- Case A: 前三句文字 (使用原本的 ShaderMask 漸層設計) ---
          lineWidget = Column(
            mainAxisSize: MainAxisSize.min,
            children: line.split('').map((char) {
              return Text(
                char,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              );
            }).toList(),
          );

          // 套用個別句子的淡入動畫和 ShaderMask
          lineWidget = ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromARGB(255, 145, 9, 9),
                Color.fromARGB(255, 202, 194, 208),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: FadeTransition(opacity: fadeAnimation, child: lineWidget),
          );
        } else {
          // --- Case B: 最後一句文字 (イッペン死ンデミル？) - 🌟 核心魔改魔法就在這 ---

          // 1. 先用 Column 排出版面，但這裡不套用顏色，顏色交給底下的 Stack 控制
          Widget rawLastLineWidget = Column(
            mainAxisSize: MainAxisSize.min,
            children: line.split('').map((char) {
              return Text(
                char,
                style: const TextStyle(
                  // 顏色跟漸層在底下的 Stack 處理，這裡設為 white 用於 ShaderMask
                  color: Colors.white,
                  fontSize: 22, // 初始字體大小
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              );
            }).toList(),
          );

          // 2. 🌟 複雜渲染魔法：利用 AnimatedBuilder 控制放大跟顏色的無縫轉變
          lineWidget = AnimatedBuilder(
            animation: _lastLineEffectAnimation,
            builder: (context, child) {
              final effectValue = _lastLineEffectAnimation.value;
              // 🌟 加上 .clamp(0.0, 1.0) 強制把數值限制在 0~1 之間，避免彈性動畫超標報錯！
              final finalRedOpacity = effectValue.clamp(0.0, 1.0);

              return Stack(
                alignment: Alignment.center,
                children: [
                  // 底層：ShaderMask 包裹的白色文字 (隨著時間淡出漸層)
                  Opacity(
                    opacity: (1.0 - finalRedOpacity).clamp(0.0, 1.0),
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 145, 9, 9),
                          Color.fromARGB(255, 202, 194, 208),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: rawLastLineWidget,
                    ),
                  ),

                  // 頂層：純紅色文字 (隨著時間淡入純紅)
                  Opacity(
                    opacity: finalRedOpacity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: line.split('').map((char) {
                        return Text(
                          char,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 183, 18, 18), // ✅ 純亮紅色
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                            // 純紅字加上強烈的發光陰影
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );

          // 3. 🌟 套用放大動畫 (Scale 1.0 -> 1.4)
          final scaleAnimation = Tween<double>(
            begin: 1.0,
            end: 1.4,
          ).animate(_lastLineEffectAnimation);
          lineWidget = ScaleTransition(
            scale: scaleAnimation,
            child: lineWidget,
          );

          // 4. 最後套用該行原本依序出現的淡入動畫
          lineWidget = FadeTransition(
            opacity: fadeAnimation,
            child: lineWidget,
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: lineWidget,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build 方法只需要包裹 AnimatedBuilder 確保所有交錯動畫正確渲染即可
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildVerticalText();
      },
    );
  }
}

// --- FloatingTriangle 元件和 TrianglePainter 保持不變 ---
class FloatingTriangle extends StatefulWidget {
  const FloatingTriangle({super.key});

  @override
  State<FloatingTriangle> createState() => _FloatingTriangleState();
}

class _FloatingTriangleState extends State<FloatingTriangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _offsetAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offsetAnimation.value),
          child: child,
        );
      },
      child: CustomPaint(size: const Size(50, 40), painter: TrianglePainter()),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = const Color(0xFFB30000)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = const Color(0xFF5A0000)
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = const Color(0xFFFF4D4D)
      ..style = PaintingStyle.fill;

    final shadowPath = Path();
    shadowPath.moveTo(size.width / 2, size.height);
    shadowPath.lineTo(0, 8);
    shadowPath.lineTo(size.width / 2, 18);
    shadowPath.close();

    canvas.drawPath(shadowPath, shadowPaint);

    final mainPath = Path();
    mainPath.moveTo(size.width / 2, size.height);
    mainPath.lineTo(size.width, 0);
    mainPath.lineTo(0, 0);
    mainPath.close();

    canvas.drawPath(mainPath, mainPaint);

    final highlightPath = Path();
    highlightPath.moveTo(size.width / 2, size.height);
    highlightPath.lineTo(size.width / 2 + 6, 10);
    highlightPath.lineTo(size.width / 2 - 6, 10);
    highlightPath.close();

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
