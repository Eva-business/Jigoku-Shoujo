class QuoteItem {
  final String text;
  final String speaker;
  final String videoUrl; // ✅ 新增這個欄位來放影片網址

  const QuoteItem({
    required this.text,
    required this.speaker,
    required this.videoUrl, // ✅ 記得加進建構子
  });
}
