import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/character_card.dart';
import '../widgets/info_card.dart';
import '../widgets/quote_card.dart';
import '../widgets/section_title.dart';
import '../widgets/top_notice_bar.dart';

class HomeScreen extends StatelessWidget {
  final String targetName;

  const HomeScreen({super.key, required this.targetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.45)),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red.withOpacity(0.12),
                    Colors.transparent,
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              TopNoticeBar(targetName: targetName),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IntroHeaderCard(),
                      const SizedBox(height: 28),

                      // 1. 角色介紹區 (預設展開)
                      CollapsibleSection(
                        title: '角色',
                        initiallyExpanded: false,
                        children: characters
                            .map(
                              (character) =>
                                  CharacterCard(character: character),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),

                      // 2. 世界觀／故事背景區
                      CollapsibleSection(
                        title: '世界觀',
                        children: worldInfoList
                            .map(
                              (item) => InfoCard(
                                imagePath: item.imagePath,
                                title: item.title,
                                content: item.content,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),

                      // 4. 經典台詞區
                      CollapsibleSection(
                        title: '經典台詞',
                        children: quotes
                            .map(
                              (quote) => QuoteCard(
                                text: quote.text,
                                speaker: quote.speaker,
                                videoUrl: quote.videoUrl, // ✅ 補上這一行
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 新增的收合區塊 Widget ---
class CollapsibleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const CollapsibleSection({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    // 使用 Theme 來隱藏 ExpansionTile 預設的上下分隔線
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: EdgeInsets.zero, // 移除預設內距，對齊你原本的排版
        iconColor: Colors.red.shade700, // 展開時的箭頭顏色
        collapsedIconColor: Colors.white70, // 收合時的箭頭顏色
        title: SectionTitle(title: title), // 完美融入你寫的 SectionTitle
        childrenPadding: const EdgeInsets.only(top: 16), // 內容與標題的間距
        children: children,
      ),
    );
  }
}

class IntroHeaderCard extends StatelessWidget {
  const IntroHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade700),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.shade900.withOpacity(0.45),
            Colors.black.withOpacity(0.88),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.33), // 修正了原本 withValues 的報錯可能
            blurRadius: 10,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: const Color.fromARGB(255, 217, 76, 66).withOpacity(0.1),
            blurRadius: 12,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '地獄少女',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '午夜零時才能連上的地獄通信，承載著人們最深沉的怨恨。\n只要輸入名字，地獄少女便會現身，替你實現復仇。',
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.7),
          ),
        ],
      ),
    );
  }
}
