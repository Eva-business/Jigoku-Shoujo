class Character {
  final String name;
  final String role;
  final String description;
  final String imagePath; // ➡️ 用作首頁卡片的方形縮圖
  final String bannerImagePath; // ➡️ 新增：用作詳細頁面的直式海報大圖

  const Character({
    required this.name,
    required this.role,
    required this.description,
    required this.imagePath,
    required this.bannerImagePath, // 記得這裡要加上
  });
}
