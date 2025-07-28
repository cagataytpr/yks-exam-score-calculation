class ExamResult {
  final String examType;
  final double puan;
  final int dogru;
  final int yanlis;
  final int net;

  ExamResult({
    required this.examType,
    required this.puan,
    required this.dogru,
    required this.yanlis,
    required this.net,
  });

  @override
  String toString() {
    return '$examType: ${puan.toStringAsFixed(2)} (D: $dogru, Y: $yanlis, Net: $net)';
  }
}

class YKSResults {
  final ExamResult? tyt;
  final ExamResult? sayisal;
  final ExamResult? sozel;
  final ExamResult? ea;
  final ExamResult? dil;

  YKSResults({
    this.tyt,
    this.sayisal,
    this.sozel,
    this.ea,
    this.dil,
  });

  bool get hasResults => tyt != null || sayisal != null || sozel != null || ea != null || dil != null;
}
