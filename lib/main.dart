import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F5),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [Colors.white, Color(0xFF1A2A44)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenue',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberLearningScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F61),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberLearningScreen extends StatefulWidget {
  @override
  _NumberLearningScreenState createState() => _NumberLearningScreenState();
}

class _NumberLearningScreenState extends State<NumberLearningScreen> {
  final List<Map<String, dynamic>> numbers = List.generate(
    100,
        (index) => {
      'digit': _toArabicNumeral(index + 1),
      'name': _getArabicName(index + 1),
      'translit': _getTransliteration(index + 1),
      'french': _getFrenchName(index + 1),
    },
  );

  final TextEditingController _controller = TextEditingController();
  String _arabicResult = '';
  String _translitResult = '';
  String _frenchResult = '';

  static String _toArabicNumeral(int number) {
    const arabicNumerals = '٠١٢٣٤٥٦٧٨٩';
    return number.toString().split('').map((digit) => arabicNumerals[int.parse(digit)]).join();
  }

  static String _getArabicName(int number) {
    const units = [
      '', 'واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة', 'ثمانية', 'تسعة'
    ];
    const teens = [
      'عشرة', 'أحد عشر', 'اثنا عشر', 'ثلاثة عشر', 'أربعة عشر', 'خمسة عشر', 'ستة عشر',
      'سبعة عشر', 'ثمانية عشر', 'تسعة عشر'
    ];
    const tens = [
      '', '', 'عشرون', 'ثلاثون', 'أربعون', 'خمسون', 'ستون', 'سبعون', 'ثمانون', 'تسعون'
    ];

    if (number == 100) return 'مائة';
    if (number <= 9) return units[number];
    if (number <= 19) return teens[number - 10];
    int ten = (number ~/ 10) * 10;
    int unit = number % 10;
    if (unit == 0) return tens[ten ~/ 10];
    return '${units[unit]} و${tens[ten ~/ 10]}';
  }

  static String _getTransliteration(int number) {
    const units = [
      '', 'Wahid', 'Ithnayn', 'Thalatha', 'Arbaa', 'Khamsa', 'Sitta', 'Sabaa', 'Thamaniya', 'Tisa'
    ];
    const teens = [
      'Ashara', 'Ahada ‘ashar', 'Ithna ‘ashar', 'Thalatha ‘ashar', 'Arbaa ‘ashar',
      'Khamsa ‘ashar', 'Sitta ‘ashar', 'Sabaa ‘ashar', 'Thamaniya ‘ashar', 'Tisa ‘ashar'
    ];
    const tens = [
      '', '', '‘Ishrun', 'Thalathun', 'Arba‘un', 'Khamsun', 'Sittun', 'Sab‘un', 'Thamanun', 'Tis‘un'
    ];

    if (number == 100) return 'Miat';
    if (number <= 9) return units[number];
    if (number <= 19) return teens[number - 10];
    int ten = (number ~/ 10) * 10;
    int unit = number % 10;
    if (unit == 0) return tens[ten ~/ 10];
    return '${units[unit]} wa ${tens[ten ~/ 10]}';
  }

  static String _getFrenchName(int number) {
    const units = [
      '', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf'
    ];
    const teens = [
      'dix', 'onze', 'douze', 'treize', 'quatorze', 'quinze', 'seize',
      'dix-sept', 'dix-huit', 'dix-neuf'
    ];
    const tens = [
      '', '', 'vingt', 'trente', 'quarante', 'cinquante', 'soixante', 'soixante-dix',
      'quatre-vingt', 'quatre-vingt-dix'
    ];

    if (number == 100) return 'cent';
    if (number <= 9) return units[number];
    if (number <= 19) return teens[number - 10];
    int ten = (number ~/ 10) * 10;
    int unit = number % 10;
    if (unit == 0) return tens[ten ~/ 10];
    if (ten == 70 || ten == 90) {
      return '${tens[ten ~/ 10 - 1]}-${unit == 1 ? "et-" : ""}${teens[unit]}';
    }
    if (ten == 80) return unit == 1 ? 'quatre-vingt-un' : 'quatre-vingt-${units[unit]}';
    return unit == 1 ? '${tens[ten ~/ 10]}-et-${units[unit]}' : '${tens[ten ~/ 10]}-${units[unit]}';
  }

  void _updateNumber(String value) {
    setState(() {
      int? number = int.tryParse(value);
      if (number != null && number >= 1 && number <= 100) {
        _arabicResult = _getArabicName(number);
        _translitResult = _getTransliteration(number);
        _frenchResult = _getFrenchName(number);
      } else {
        _arabicResult = 'غير صالح'; // "Non valide" en arabe
        _translitResult = 'Ghyr salih';
        _frenchResult = 'Non valide';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F5),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [Colors.white, Color(0xFF1A2A44)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Champ de saisie et résultat
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
                      SizedBox(height: 20),
                      Text(
                        'Arabe : $_arabicResult',
                        style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Translittération : $_translitResult',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Français : $_frenchResult',
                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Espacement supplémentaire pour la lisibilité
                // Grille des nombres
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
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
    );
  }
}

class NumberCard extends StatefulWidget {
  final String digit;
  final String name;
  final String translit;
  final String french;

  NumberCard({
    required this.digit,
    required this.name,
    required this.translit,
    required this.french,
  });

  @override
  _NumberCardState createState() => _NumberCardState();
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
    // Convertir le chiffre arabe en nombre décimal
    const arabicNumerals = '٠١٢٣٤٥٦٧٨٩';
    String numberStr = widget.digit.split('').map((char) {
      return arabicNumerals.indexOf(char).toString();
    }).join();
    int number = int.parse(numberStr);
    // Jouer le fichier audio correspondant
    await _audioPlayer.play(AssetSource('sounds/$number.mp3'));
  }

  void _showDetails() {
    _playSound(); // Jouer le son avant d'afficher la boîte de dialogue
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text(widget.digit, style: TextStyle(fontSize: 40, fontFamily: 'ArabicFont')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(widget.translit, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Text('Français : ${widget.french}', style: TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fermer', style: TextStyle(color: Color(0xFFFF6F61))),
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
                boxShadow: [
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
                  style: TextStyle(
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