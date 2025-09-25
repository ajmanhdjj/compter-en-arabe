import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '/widget/number_card.dart';
import '/utils/number_utils.dart';

class NumberLearningScreen extends StatefulWidget {
  const NumberLearningScreen({super.key});

  @override
  State<NumberLearningScreen> createState() => _NumberLearningScreenState();
}

class _NumberLearningScreenState extends State<NumberLearningScreen> {
  final TextEditingController _controller = TextEditingController();
  String _arabicResult = '';
  String _translitResult = '';
  String _frenchResult = '';

  final List<Map<String, dynamic>> numbers = List.generate(
    100,
    (index) => {
      'digit': NumberUtils.toArabicNumeral(index + 1),
      'name': NumberUtils.getArabicName(index + 1),
      'translit': NumberUtils.getTransliteration(index + 1),
      'french': NumberUtils.getFrenchName(index + 1),
    },
  );

  void _updateNumber(String value) {
    setState(() {
      int? number = int.tryParse(value);
      if (number != null && number >= 1 && number <= 100) {
        _arabicResult = NumberUtils.getArabicName(number);
        _translitResult = NumberUtils.getTransliteration(number);
        _frenchResult = NumberUtils.getFrenchName(number);
      } else {
        _arabicResult = 'غير صالح';
        _translitResult = 'Ghyr salih';
        _frenchResult = 'Non valide';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F5),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [Colors.white, Color(0xFF1A2A44)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Champ de saisie et résultats
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Entrez un nombre (1-100)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                          ),
                          onChanged: _updateNumber,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Arabe : $_arabicResult',
                          style: const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Translittération : $_translitResult',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Français : $_frenchResult',
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // Grille des nombres
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: numbers.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: 5,
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: NumberCard(
                                  digit: numbers[index]['digit'],
                                  name: numbers[index]['name'],
                                  translit: numbers[index]['translit'],
                                  french: numbers[index]['french'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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