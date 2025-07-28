import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/exam_result.dart';
import 'utils/constants.dart';
import 'utils/yks_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YKS Puan Hesaplama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
          home: const YKSCalculatorApp(),
    );
  }
}

class YKSCalculatorApp extends StatefulWidget {
  const YKSCalculatorApp({super.key});

  @override
  State<YKSCalculatorApp> createState() => _YKSCalculatorAppState();
}

class _YKSCalculatorAppState extends State<YKSCalculatorApp> {
  final _formKey = GlobalKey<FormState>();
  
  // TYT Controllers
  final TextEditingController _tytTurkceDogru = TextEditingController();
  final TextEditingController _tytTurkceYanlis = TextEditingController();
  final TextEditingController _tytSosyalDogru = TextEditingController();
  final TextEditingController _tytSosyalYanlis = TextEditingController();
  final TextEditingController _tytMatematikDogru = TextEditingController();
  final TextEditingController _tytMatematikYanlis = TextEditingController();
  final TextEditingController _tytFenDogru = TextEditingController();
  final TextEditingController _tytFenYanlis = TextEditingController();
  
  // AYT Controllers
  final TextEditingController _aytTurkceDogru = TextEditingController();
  final TextEditingController _aytTurkceYanlis = TextEditingController();
  final TextEditingController _aytSosyalDogru = TextEditingController();
  final TextEditingController _aytSosyalYanlis = TextEditingController();
  final TextEditingController _aytMatematikDogru = TextEditingController();
  final TextEditingController _aytMatematikYanlis = TextEditingController();
  final TextEditingController _aytFenDogru = TextEditingController();
  final TextEditingController _aytFenYanlis = TextEditingController();
  
  // YDT Controllers
  final TextEditingController _ydtDogru = TextEditingController();
  final TextEditingController _ydtYanlis = TextEditingController();
  
  YKSResults? _results;
  bool _showAYTFields = false;
  bool _showYDTFields = false;

  @override
  void dispose() {
    // TYT Controllers
    _tytTurkceDogru.dispose();
    _tytTurkceYanlis.dispose();
    _tytSosyalDogru.dispose();
    _tytSosyalYanlis.dispose();
    _tytMatematikDogru.dispose();
    _tytMatematikYanlis.dispose();
    _tytFenDogru.dispose();
    _tytFenYanlis.dispose();
    
    // AYT Controllers
    _aytTurkceDogru.dispose();
    _aytTurkceYanlis.dispose();
    _aytSosyalDogru.dispose();
    _aytSosyalYanlis.dispose();
    _aytMatematikDogru.dispose();
    _aytMatematikYanlis.dispose();
    _aytFenDogru.dispose();
    _aytFenYanlis.dispose();
    
    // YDT Controllers
    _ydtDogru.dispose();
    _ydtYanlis.dispose();
    
    super.dispose();
  }
  
  int? _parseIntOrZero(String? value) {
    if (value == null || value.isEmpty) return 0;
    return int.tryParse(value) ?? 0;
  }
  
  void _calculateScores() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _results = YKSCalculator.calculateAll(
          // TYT bilgileri
          tytTurkceDogru: _parseIntOrZero(_tytTurkceDogru.text)!,
          tytTurkceYanlis: _parseIntOrZero(_tytTurkceYanlis.text)!,
          tytSosyalDogru: _parseIntOrZero(_tytSosyalDogru.text)!,
          tytSosyalYanlis: _parseIntOrZero(_tytSosyalYanlis.text)!,
          tytMatematikDogru: _parseIntOrZero(_tytMatematikDogru.text)!,
          tytMatematikYanlis: _parseIntOrZero(_tytMatematikYanlis.text)!,
          tytFenDogru: _parseIntOrZero(_tytFenDogru.text)!,
          tytFenYanlis: _parseIntOrZero(_tytFenYanlis.text)!,
          
          // AYT bilgileri (eğer gösteriliyorsa)
          aytTurkceDogru: _showAYTFields ? _parseIntOrZero(_aytTurkceDogru.text) : null,
          aytTurkceYanlis: _showAYTFields ? _parseIntOrZero(_aytTurkceYanlis.text) : null,
          aytSosyalDogru: _showAYTFields ? _parseIntOrZero(_aytSosyalDogru.text) : null,
          aytSosyalYanlis: _showAYTFields ? _parseIntOrZero(_aytSosyalYanlis.text) : null,
          aytMatematikDogru: _showAYTFields ? _parseIntOrZero(_aytMatematikDogru.text) : null,
          aytMatematikYanlis: _showAYTFields ? _parseIntOrZero(_aytMatematikYanlis.text) : null,
          aytFenDogru: _showAYTFields ? _parseIntOrZero(_aytFenDogru.text) : null,
          aytFenYanlis: _showAYTFields ? _parseIntOrZero(_aytFenYanlis.text) : null,
          
          // YDT bilgileri (eğer gösteriliyorsa)
          ydtDogru: _showYDTFields ? _parseIntOrZero(_ydtDogru.text) : null,
          ydtYanlis: _showYDTFields ? _parseIntOrZero(_ydtYanlis.text) : null,
        );
      });
    }
  }
  
  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _results = null;
      _showAYTFields = false;
      _showYDTFields = false;
    });
  }
  
  Widget _buildNetInput({
    required String label,
    required TextEditingController dogruController,
    required TextEditingController yanlisController,
    int? maxDogru,
    int? maxYanlis,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: enabled ? null : Colors.grey),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: dogruController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                if (maxDogru != null)
                  LengthLimitingTextInputFormatter(maxDogru.toString().length),
              ],
              enabled: enabled,
              decoration: const InputDecoration(
                labelText: 'D',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Gerekli';
                final val = int.tryParse(value);
                if (val == null || val < 0) return 'Geçersiz';
                if (maxDogru != null && val > maxDogru) return 'Max $maxDogru';
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: yanlisController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                if (maxYanlis != null)
                  LengthLimitingTextInputFormatter(maxYanlis.toString().length),
              ],
              enabled: enabled,
              decoration: const InputDecoration(
                labelText: 'Y',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                isDense: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Gerekli';
                final val = int.tryParse(value);
                if (val == null || val < 0) return 'Geçersiz';
                if (maxYanlis != null && val > maxYanlis) return 'Max $maxYanlis';
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultCard(ExamResult? result) {
    if (result == null) return const SizedBox.shrink();
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              result.examType,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              result.puan.toStringAsFixed(2),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 4),
            Text(
              'Net: ${result.net} (D: ${result.dogru}, Y: ${result.yanlis})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YKS Puan Hesaplama'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TYT Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TYT (Temel Yeterlilik Testi)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _buildNetInput(
                        label: 'Türkçe (40):',
                        dogruController: _tytTurkceDogru,
                        yanlisController: _tytTurkceYanlis,
                        maxDogru: 40,
                        maxYanlis: 40,
                      ),
                      _buildNetInput(
                        label: 'Sosyal Bilimler (20):',
                        dogruController: _tytSosyalDogru,
                        yanlisController: _tytSosyalYanlis,
                        maxDogru: 20,
                        maxYanlis: 20,
                      ),
                      _buildNetInput(
                        label: 'Temel Matematik (40):',
                        dogruController: _tytMatematikDogru,
                        yanlisController: _tytMatematikYanlis,
                        maxDogru: 40,
                        maxYanlis: 40,
                      ),
                      _buildNetInput(
                        label: 'Fen Bilimleri (20):',
                        dogruController: _tytFenDogru,
                        yanlisController: _tytFenYanlis,
                        maxDogru: 20,
                        maxYanlis: 20,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // AYT Toggle
              Card(
                child: SwitchListTile(
                  title: const Text('AYT (Alan Yeterlilik Testi)'),
                  value: _showAYTFields,
                  onChanged: (value) {
                    setState(() {
                      _showAYTFields = value;
                      if (!value) _results = null;
                    });
                  },
                ),
              ),
              
              // AYT Fields
              if (_showAYTFields) Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AYT (Alan Yeterlilik Testi)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _buildNetInput(
                        label: 'Türk Dili ve Edebiyatı (24):',
                        dogruController: _aytTurkceDogru,
                        yanlisController: _aytTurkceYanlis,
                        maxDogru: 24,
                        maxYanlis: 24,
                      ),
                      _buildNetInput(
                        label: 'Sosyal Bilimler (40):',
                        dogruController: _aytSosyalDogru,
                        yanlisController: _aytSosyalYanlis,
                        maxDogru: 40,
                        maxYanlis: 40,
                      ),
                      _buildNetInput(
                        label: 'Matematik (40):',
                        dogruController: _aytMatematikDogru,
                        yanlisController: _aytMatematikYanlis,
                        maxDogru: 40,
                        maxYanlis: 40,
                      ),
                      _buildNetInput(
                        label: 'Fen Bilimleri (40):',
                        dogruController: _aytFenDogru,
                        yanlisController: _aytFenYanlis,
                        maxDogru: 40,
                        maxYanlis: 40,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // YDT Toggle
              Card(
                child: SwitchListTile(
                  title: const Text('YDT (Yabancı Dil Testi)'),
                  value: _showYDTFields,
                  onChanged: (value) {
                    setState(() {
                      _showYDTFields = value;
                      if (!value) _results = null;
                    });
                  },
                ),
              ),
              
              // YDT Fields
              if (_showYDTFields) Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YDT (Yabancı Dil Testi)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _buildNetInput(
                        label: 'Yabancı Dil (80):',
                        dogruController: _ydtDogru,
                        yanlisController: _ydtYanlis,
                        maxDogru: 80,
                        maxYanlis: 80,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calculate, size: 20),
                      label: const Text('HESAPLA'),
                      onPressed: _calculateScores,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.refresh, size: 20),
                      label: const Text('TEMİZLE'),
                      onPressed: _resetForm,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Results Section
              if (_results != null) ...[
                const SizedBox(height: 24),
                const Text(
                  'HESAPLANAN PUANLAR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  childAspectRatio: 2.5,
                  children: [
                    _buildResultCard(_results?.tyt),
                    _buildResultCard(_results?.sayisal),
                    _buildResultCard(_results?.sozel),
                    _buildResultCard(_results?.ea),
                    if (_showYDTFields) _buildResultCard(_results?.dil),
                  ].where((widget) => widget != const SizedBox.shrink()).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
