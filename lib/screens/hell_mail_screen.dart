import 'package:flutter/material.dart';
import 'home_screen.dart';

class HellMailScreen extends StatefulWidget {
  const HellMailScreen({super.key});

  @override
  State<HellMailScreen> createState() => _HellMailScreenState();
}

class _HellMailScreenState extends State<HellMailScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool _hasStartedSequence = false;
  bool _showTimer = false;
  bool _showMidnightText = false;
  bool _showForm = false;

  String _timeText = '23:50';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _startSequence() async {
    if (_hasStartedSequence) return;

    setState(() {
      _hasStartedSequence = true;
      _showTimer = true;
      _timeText = '23:50';
    });

    final List<String> timeSteps = [
      '23:50',
      '23:51',
      '23:52',
      '23:53',
      '23:54',
      '23:55',
      '23:56',
      '23:57',
      '23:58',
      '23:59',
      '00:00',
    ];

    for (int i = 0; i < timeSteps.length; i++) {
      if (!mounted) return;

      setState(() {
        _timeText = timeSteps[i];
      });

      await Future.delayed(
        Duration(milliseconds: i == timeSteps.length - 1 ? 1200 : 140),
      );
    }

    if (!mounted) return;
    setState(() {
      _showTimer = false;
    });

    await Future.delayed(const Duration(milliseconds: 250));

    if (!mounted) return;
    setState(() {
      _showMidnightText = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() {
      _showForm = true;
    });
  }

  void _sendMail() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('請輸入怨恨之人的名字'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(targetName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B16),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.15,
                  colors: [
                    Color(0xFF1A2740),
                    Color(0xFF0A1120),
                    Color(0xFF03050A),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.28)),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_hasStartedSequence)
                      GestureDetector(
                        onTap: _startSequence,
                        child: GlowingText(text: '午前零時にだけアクセスできます'),
                      ),

                    AnimatedOpacity(
                      opacity: _showTimer ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: _showTimer
                          ? _DigitalTimeText(timeText: _timeText)
                          : const SizedBox.shrink(),
                    ),

                    if (_showTimer) const SizedBox(height: 36),

                    AnimatedOpacity(
                      opacity: _showMidnightText ? 1 : 0,
                      duration: const Duration(milliseconds: 700),
                      child: _showMidnightText
                          ? const Text(
                              'あなたの恨み、晴らします',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 22,
                                letterSpacing: 2,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    if (_showMidnightText) const SizedBox(height: 34),

                    AnimatedOpacity(
                      opacity: _showForm ? 1 : 0,
                      duration: const Duration(milliseconds: 700),
                      child: IgnorePointer(
                        ignoring: !_showForm,
                        child: _showForm
                            ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.35),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      controller: _nameController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '怨恨之人的名字',
                                        hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  ElevatedButton(
                                    onPressed: _sendMail,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFD9D9D9),
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      shape: const RoundedRectangleBorder(),
                                      elevation: 6,
                                    ),
                                    child: const Text(
                                      '送信',
                                      style: TextStyle(
                                        color: Color.fromARGB(135, 69, 48, 48),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DigitalTimeText extends StatelessWidget {
  final String timeText;

  const _DigitalTimeText({required this.timeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.18),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        timeText,
        style: const TextStyle(
          color: Color(0xFFFF1A1A),
          fontSize: 56,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
          fontFamily: 'monospace',
          shadows: [
            Shadow(color: Color(0x99FF0000), blurRadius: 12),
            Shadow(color: Color(0x66FF0000), blurRadius: 24),
          ],
        ),
      ),
    );
  }
}

class GlowingText extends StatefulWidget {
  final String text;

  const GlowingText({super.key, required this.text});

  @override
  State<GlowingText> createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _glow = Tween<double>(
      begin: 0.3,
      end: 1.0,
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
      animation: _glow,
      builder: (context, child) {
        return Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8 + _glow.value * 0.2),
            fontSize: 18,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Color(0x99FF0000).withOpacity(_glow.value),
                blurRadius: 10 + (_glow.value * 10),
              ),
              Shadow(
                color: Colors.black,
                blurRadius: 6,
                offset: const Offset(1, 1),
              ),
            ],
          ),
        );
      },
    );
  }
}
