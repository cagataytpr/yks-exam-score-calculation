class YKSCoefficients {
  // TYT Katsayıları
  static const double TYT_TURKCE = 3.3;
  static const double TYT_SOSYAL = 3.4;
  static const double TYT_MATEMATIK = 3.3;
  static const double TYT_FEN = 3.4;
  
  // AYT Katsayıları
  static const double AYT_TURKCE = 1.8;
  static const double AYT_SOSYAL = 2.5;
  static const double AYT_MATEMATIK = 2.5;
  static const double AYT_FEN = 2.5;
  static const double AYT_DIL = 3.0;
  
  // Taban Puanlar
  static const double TYT_TABAN_PUAN = 100.0;
  static const double AYT_TABAN_CARPAN = 0.4;
}

class ExamLimits {
  // Maksimum soru sayıları
  static const int MAX_TURKCE = 40;
  static const int MAX_SOSYAL = 20;
  static const int MAX_MATEMATIK = 40;
  static const int MAX_FEN = 20;
  static const int MAX_DIL = 80;
  
  // Minimum geçerli puan
  static const double MIN_PASSING_SCORE = 150.0;
}
