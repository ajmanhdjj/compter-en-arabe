import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumberCard extends StatefulWidget {
  final String digit;
  final String name;
  final String translit;
  final String french;

  const NumberCard({
    super.key,
    required this.digit,
    required this.name,
    required this.translit,
    required this.french,
  });

  @override
  State<NumberCard> createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound() async {
    const arabicNumerals = '٠١٢٣٤٥٦٧٨٩';
    String numberStr = widget.digit.split('').map((char) {
      return arabicNumerals.indexOf(char).toString();
    }).join();
    int number = int.parse(numberStr);
    await _audioPlayer.play(AssetSource('sounds/$number.mp3'));
  }

  void _showDetails() {
    _playSound();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text(widget.digit, style: const TextStyle(fontSize: 40, fontFamily: 'ArabicFont')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(widget.translit, style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('Français : ${widget.french}', style: const TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer', style: TextStyle(color: Color(0xFFFF6F61))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        _showDetails();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.digit,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'ArabicFont',
                    color: Color(0xFF1A2A44),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}