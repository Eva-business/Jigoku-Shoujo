import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // ✅ 引入音樂套件
import 'screens/splash_screen.dart'; // 確保這裡的路徑正確指向你的開場頁面

void main() {
  // 確保 Flutter 核心初始化完成，這對全域播放器很重要
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// 把 MyApp 改成 StatefulWidget，這樣才能管理音樂的播放與銷毀
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 建立一個音樂播放器實例
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playBGM(); // App 一啟動就呼叫播放函數
  }

  Future<void> _playBGM() async {
    try {
      // 1. 設定為無限循環播放模式
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);

      // 2. 播放你的 mp3 檔案
      // 注意：AssetSource 預設會自動去 'assets/' 資料夾底下找，
      // 所以這裡只要寫 'audio/bgm.mp3' 就可以了！
      // ⚠️ 請確保檔名跟你放入的一模一樣！
      await _audioPlayer.play(AssetSource('audio/music.mp3'));

      // (可選) 如果覺得音樂太大聲，可以調整音量，0.0 ~ 1.0
      await _audioPlayer.setVolume(0.5);
    } catch (e) {
      debugPrint("音樂播放失敗: $e");
    }
  }

  @override
  void dispose() {
    // 當 App 被關閉時，釋放播放器資源
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hell Girl',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // 預設背景全黑
      ),
      home: const SplashScreen(), // 你的第一頁
    );
  }
}
