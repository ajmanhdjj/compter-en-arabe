class NumberUtils {
  static String toArabicNumeral(int number) {
    const arabicNumerals = '٠١٢٣٤٥٦٧٨٩';
    return number.toString().split('').map((digit) => arabicNumerals[int.parse(digit)]).join();
  }

  static String getArabicName(int number) {
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

  static String getTransliteration(int number) {
    const units = [
      '', 'Wahid', 'Ithnayn', 'Thalatha', 'Arbaa', 'Khamsa', 'Sitta', 'Sabaa', 'Thamaniya', 'Tisa'
    ];
    const teens = [
      'Ashara', 'Ahada ashar', 'Ithna ashar', 'Thalatha ashar', 'Arbaa ashar',
      'Khamsa ashar', 'Sitta ashar', 'Sabaa ashar', 'Thamaniya ashar', 'Tisa ashar'
    ];
    const tens = [
      '', '', 'Ishrun', 'Thalathun', 'Arbaun', 'Khamsun', 'Sittun', 'Sabun', 'Thamanun', 'Tisun'
    ];

    if (number == 100) return 'Miat';
    if (number <= 9) return units[number];
    if (number <= 19) return teens[number - 10];
    int ten = (number ~/ 10) * 10;
    int unit = number % 10;
    if (unit == 0) return tens[ten ~/ 10];
    return '${units[unit]} wa ${tens[ten ~/ 10]}';
  }

  static String getFrenchName(int number) {
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
}