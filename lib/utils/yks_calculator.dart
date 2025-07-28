import '../models/exam_result.dart';
import 'constants.dart';

class YKSCalculator {
  // Net hesaplama
  static double _calculateNet(int dogru, int yanlis) {
    return dogru - (yanlis / 4);
  }

  // TYT puan hesaplama
  static ExamResult calculateTYT({
    required int turkceDogru,
    required int turkceYanlis,
    required int sosyalDogru,
    required int sosyalYanlis,
    required int matematikDogru,
    required int matematikYanlis,
    required int fenDogru,
    required int fenYanlis,
  }) {
    final turkceNet = _calculateNet(turkceDogru, turkceYanlis);
    final sosyalNet = _calculateNet(sosyalDogru, sosyalYanlis);
    final matematikNet = _calculateNet(matematikDogru, matematikYanlis);
    final fenNet = _calculateNet(fenDogru, fenYanlis);

    final puan = YKSCoefficients.TYT_TABAN_PUAN +
        (turkceNet * YKSCoefficients.TYT_TURKCE) +
        (sosyalNet * YKSCoefficients.TYT_SOSYAL) +
        (matematikNet * YKSCoefficients.TYT_MATEMATIK) +
        (fenNet * YKSCoefficients.TYT_FEN);

    return ExamResult(
      examType: 'TYT',
      puan: puan,
      dogru: turkceDogru + sosyalDogru + matematikDogru + fenDogru,
      yanlis: turkceYanlis + sosyalYanlis + matematikYanlis + fenYanlis,
      net: (turkceNet + sosyalNet + matematikNet + fenNet).toInt(),
    );
  }

  // AYT Sözel puan hesaplama
  static ExamResult calculateSozel({
    required ExamResult tytResult,
    required int turkceDogru,
    required int turkceYanlis,
    required int sosyalDogru,
    required int sosyalYanlis,
  }) {
    final turkceNet = _calculateNet(turkceDogru, turkceYanlis);
    final sosyalNet = _calculateNet(sosyalDogru, sosyalYanlis);

    final puan = (tytResult.puan * YKSCoefficients.AYT_TABAN_CARPAN) +
        (turkceNet * YKSCoefficients.AYT_TURKCE) +
        (sosyalNet * YKSCoefficients.AYT_SOSYAL);

    return ExamResult(
      examType: 'SÖZEL',
      puan: puan,
      dogru: turkceDogru + sosyalDogru,
      yanlis: turkceYanlis + sosyalYanlis,
      net: (turkceNet + sosyalNet).toInt(),
    );
  }

  // AYT Sayısal puan hesaplama
  static ExamResult calculateSayisal({
    required ExamResult tytResult,
    required int matematikDogru,
    required int matematikYanlis,
    required int fenDogru,
    required int fenYanlis,
  }) {
    final matematikNet = _calculateNet(matematikDogru, matematikYanlis);
    final fenNet = _calculateNet(fenDogru, fenYanlis);

    final puan = (tytResult.puan * YKSCoefficients.AYT_TABAN_CARPAN) +
        (matematikNet * YKSCoefficients.AYT_MATEMATIK) +
        (fenNet * YKSCoefficients.AYT_FEN);

    return ExamResult(
      examType: 'SAYISAL',
      puan: puan,
      dogru: matematikDogru + fenDogru,
      yanlis: matematikYanlis + fenYanlis,
      net: (matematikNet + fenNet).toInt(),
    );
  }

  // AYT Eşit Ağırlık puan hesaplama
  static ExamResult calculateEA({
    required ExamResult tytResult,
    required int turkceDogru,
    required int turkceYanlis,
    required int matematikDogru,
    required int matematikYanlis,
  }) {
    final turkceNet = _calculateNet(turkceDogru, turkceYanlis);
    final matematikNet = _calculateNet(matematikDogru, matematikYanlis);

    final puan = (tytResult.puan * YKSCoefficients.AYT_TABAN_CARPAN) +
        (turkceNet * YKSCoefficients.AYT_TURKCE) +
        (matematikNet * YKSCoefficients.AYT_MATEMATIK);

    return ExamResult(
      examType: 'EŞİT AĞIRLIK',
      puan: puan,
      dogru: turkceDogru + matematikDogru,
      yanlis: turkceYanlis + matematikYanlis,
      net: (turkceNet + matematikNet).toInt(),
    );
  }

  // YDT (Yabancı Dil Testi) puan hesaplama
  static ExamResult calculateDil({
    required ExamResult tytResult,
    required int dilDogru,
    required int dilYanlis,
  }) {
    final dilNet = _calculateNet(dilDogru, dilYanlis);

    final puan = (tytResult.puan * YKSCoefficients.AYT_TABAN_CARPAN) +
        (dilNet * YKSCoefficients.AYT_DIL);

    return ExamResult(
      examType: 'DİL',
      puan: puan,
      dogru: dilDogru,
      yanlis: dilYanlis,
      net: dilNet.toInt(),
    );
  }

  // Tüm YKS puanlarını hesapla
  static YKSResults calculateAll({
    // TYT bilgileri
    required int tytTurkceDogru,
    required int tytTurkceYanlis,
    required int tytSosyalDogru,
    required int tytSosyalYanlis,
    required int tytMatematikDogru,
    required int tytMatematikYanlis,
    required int tytFenDogru,
    required int tytFenYanlis,
    
    // AYT bilgileri (opsiyonel)
    int? aytTurkceDogru,
    int? aytTurkceYanlis,
    int? aytSosyalDogru,
    int? aytSosyalYanlis,
    int? aytMatematikDogru,
    int? aytMatematikYanlis,
    int? aytFenDogru,
    int? aytFenYanlis,
    
    // YDT bilgileri (opsiyonel)
    int? ydtDogru,
    int? ydtYanlis,
  }) {
    // TYT puanını hesapla
    final tytResult = calculateTYT(
      turkceDogru: tytTurkceDogru,
      turkceYanlis: tytTurkceYanlis,
      sosyalDogru: tytSosyalDogru,
      sosyalYanlis: tytSosyalYanlis,
      matematikDogru: tytMatematikDogru,
      matematikYanlis: tytMatematikYanlis,
      fenDogru: tytFenDogru,
      fenYanlis: tytFenYanlis,
    );

    // Diğer puanları hesapla
    ExamResult? sayisalResult;
    ExamResult? sozelResult;
    ExamResult? eaResult;
    ExamResult? dilResult;

    // AYT puanlarını hesapla (eğer gerekli bilgiler verilmişse)
    if (aytMatematikDogru != null &&
        aytFenDogru != null &&
        aytTurkceDogru != null &&
        aytSosyalDogru != null) {
      sayisalResult = calculateSayisal(
        tytResult: tytResult,
        matematikDogru: aytMatematikDogru,
        matematikYanlis: aytMatematikYanlis ?? 0,
        fenDogru: aytFenDogru,
        fenYanlis: aytFenYanlis ?? 0,
      );

      sozelResult = calculateSozel(
        tytResult: tytResult,
        turkceDogru: aytTurkceDogru,
        turkceYanlis: aytTurkceYanlis ?? 0,
        sosyalDogru: aytSosyalDogru,
        sosyalYanlis: aytSosyalYanlis ?? 0,
      );

      eaResult = calculateEA(
        tytResult: tytResult,
        turkceDogru: aytTurkceDogru,
        turkceYanlis: aytTurkceYanlis ?? 0,
        matematikDogru: aytMatematikDogru,
        matematikYanlis: aytMatematikYanlis ?? 0,
      );
    }

    // YDT puanını hesapla (eğer gerekli bilgiler verilmişse)
    if (ydtDogru != null) {
      dilResult = calculateDil(
        tytResult: tytResult,
        dilDogru: ydtDogru,
        dilYanlis: ydtYanlis ?? 0,
      );
    }

    return YKSResults(
      tyt: tytResult,
      sayisal: sayisalResult,
      sozel: sozelResult,
      ea: eaResult,
      dil: dilResult,
    );
  }
}
