// lib/solar_sizer_screen.dart
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:math';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// شاشة تقدير حجم محطة الطاقة الشمسية
/// كل النصوص بالعربية الفصحى المبسطة
/// ملاحظة: يوجد متغير بسيط لتفعيل اللهجة العامية المصرية في الواجهة.
class SolarSizerScreen extends StatefulWidget {
  const SolarSizerScreen({Key? key}) : super(key: key);

  @override
  State<SolarSizerScreen> createState() => _SolarSizerScreenState();
}

enum Mode { byConsumption, byArea }

class _SolarSizerScreenState extends State<SolarSizerScreen> {
  // ====== تغيير اللغة بين فصحى / عامية ======
  // اجعل هذه القيمة true لو أحببت لهجة عامية مصرية في الواجهة.
  bool useEgyptianDialect = false;

  // دالة مساعدة لاختيار النص حسب النمط
  String t({required String fusha, required String masri}) {
    return useEgyptianDialect ? masri : fusha;
  }

  // ====== الافتراضات والقيم الافتراضية ======
  double panelPowerKw = 0.4; // 400 W -> 0.4 kW لكل لوح
  double panelAreaM2 = 1.7; // م² لكل لوح
  double systemPerformanceFactor = 0.80; // خسائر النظام
  double obstacleCorrectionFactorDefault = 0.75;
  double _obstacleCorrectionFactor = 0.75;

  Mode _mode = Mode.byConsumption;

  // مدخلات المستخدم
  final TextEditingController _dailyConsumptionController =
      TextEditingController(); // kWh/اليوم
  final TextEditingController _availableAreaController =
      TextEditingController(); // م²
  bool _hasObstacles = false;

  // نتائج الحساب (حسب الاستهلاك)
  double? requiredSystemKw;
  double? requiredAreaM2;
  int? requiredPanelsCount;

  // نتائج الحساب (حسب المساحة)
  double? possiblePanelsCountFromArea;
  double? possibleSystemKwFromArea;
  double? effectiveArea;

  // ساعات ذروة الشمس الافتراضية
  double peakSunHours = 5.0;

  // ====== وظائف الحساب ======
  void calculateByConsumption() {
    final input = double.tryParse(
      _dailyConsumptionController.text.replaceAll(',', '.'),
    );
    if (input == null || input <= 0) {
      _showSnack(
        t(
          fusha: 'يرجى إدخال متوسط الاستهلاك اليومي بصيغة رقمية صحيحة (kWh).',
          masri: 'اكتب استهلاكك اليومي رقم صحيح (kWh).',
        ),
      );
      return;
    }

    final double systemKw = input / (peakSunHours * systemPerformanceFactor);

    final int panels = (systemKw / panelPowerKw).ceil();

    final double area = panels * panelAreaM2;

    setState(() {
      requiredSystemKw = _round(systemKw, 3);
      requiredPanelsCount = panels;
      requiredAreaM2 = _round(area, 2);

      possiblePanelsCountFromArea = null;
      possibleSystemKwFromArea = null;
      effectiveArea = null;
    });
  }

  void calculateByArea() {
    final inputArea = double.tryParse(
      _availableAreaController.text.replaceAll(',', '.'),
    );
    if (inputArea == null || inputArea <= 0) {
      _showSnack(
        t(
          fusha: 'يرجى إدخال المساحة المتاحة بصيغة رقمية صحيحة (متر مربع).',
          masri: 'اكتب المساحة رقم صحيح (متر مربع).',
        ),
      );
      return;
    }

    final double actualArea = _hasObstacles
        ? inputArea * _obstacleCorrectionFactor
        : inputArea;

    final int panelsPossible = (actualArea / panelAreaM2).floor();

    final double totalKw = panelsPossible * panelPowerKw;

    setState(() {
      effectiveArea = _round(actualArea, 2);
      possiblePanelsCountFromArea = panelsPossible.toDouble();
      possibleSystemKwFromArea = _round(totalKw, 3);

      requiredSystemKw = null;
      requiredPanelsCount = null;
      requiredAreaM2 = null;
    });
  }

  double _round(double value, int decimals) {
    final p = pow(10, decimals);
    return (value * p).roundToDouble() / p;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // رسم تخطيطي بسيط لترتيب الألواح
  Widget _buildSimpleLayout(int panels) {
    if (panels <= 0) {
      return Center(
        child: Text(
          t(fusha: 'لا توجد ألواح لعرضها.', masri: 'مافيش ألواح تتعرض.'),
        ),
      );
    }

    int cols = 4;
    if (panels <= 4)
      cols = panels;
    else if (panels <= 8)
      cols = 4;
    else if (panels <= 12)
      cols = 4;
    else if (panels <= 20)
      cols = 5;
    else
      cols = 6;

    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: panels,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          childAspectRatio: 1.6,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blueGrey.shade50,
              border: Border.all(color: Colors.blueGrey.shade200),
            ),
            child: Text(
              '${t(fusha: "لوح", masri: "لوح")}\n#${index + 1}',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ====== إنشاء PDF حقيقي للطباعة/الحفظ ======
  Future<void> _exportToPdf() async {
    // نتأكد أن هناك نتائج لعرضها
    final bool hasConsumptionResults = requiredSystemKw != null;
    final bool hasAreaResults = possiblePanelsCountFromArea != null;

    if (!hasConsumptionResults && !hasAreaResults) {
      _showSnack(
        t(
          fusha: 'لا توجد نتائج لحفظها في تقرير. يرجى إجراء الحساب أولاً.',
          masri: 'مافيش نتائج تتطبع في تقرير، احسب الأول.',
        ),
      );
      return;
    }

    final pdf = pw.Document();

    // عنوان الوضع الحالي
    final String modeTitle = _mode == Mode.byConsumption
        ? t(
            fusha: 'تقدير محطة شمسية حسب الاستهلاك اليومي',
            masri: 'تقدير المحطة حسب الاستهلاك اليومي',
          )
        : t(
            fusha: 'تقدير محطة شمسية حسب المساحة المتاحة',
            masri: 'تقدير المحطة حسب المساحة المتاحة',
          );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                modeTitle,
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              t(
                fusha:
                    'تقرير تقديري غير نهائي. الأرقام تقريبية وتعتمد على افتراضات النظام.',
                masri:
                    'ده تقرير تقريبي، الأرقام تقريبية وتعتمد على افتراضات النظام.',
              ),
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.SizedBox(height: 15),

            // بيانات عامة للنظام
            pw.Text(
              t(
                fusha: '١. بيانات افتراضية للنظام',
                masri: '١. بيانات افتراضية للنظام',
              ),
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                _pdfRow(
                  t(fusha: 'قدرة اللوح الافتراضية', masri: 'قدرة اللوح'),
                  '${(panelPowerKw * 1000).toStringAsFixed(0)} W',
                ),
                _pdfRow(
                  t(fusha: 'مساحة اللوح التقريبية', masri: 'مساحة اللوح'),
                  '${panelAreaM2.toStringAsFixed(2)} m²',
                ),
                _pdfRow(
                  t(
                    fusha: 'عامل أداء النظام (الخسائر)',
                    masri: 'عامل أداء النظام',
                  ),
                  (systemPerformanceFactor).toStringAsFixed(2),
                ),
                _pdfRow(
                  t(fusha: 'ساعات ذروة شمسية يومية', masri: 'ساعات ذروة الشمس'),
                  '${peakSunHours.toStringAsFixed(2)} h/day',
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // نتائج حسب الاستهلاك
            if (hasConsumptionResults) ...[
              pw.Text(
                t(
                  fusha: '٢. نتائج التقدير حسب الاستهلاك اليومي',
                  masri: '٢. نتائج حسب الاستهلاك اليومي',
                ),
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                children: [
                  _pdfRow(
                    t(
                      fusha: 'متوسط الاستهلاك اليومي',
                      masri: 'متوسط الاستهلاك اليومي',
                    ),
                    '${_dailyConsumptionController.text} kWh/يوم',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'القدرة المطلوبة للمحطة',
                      masri: 'القدرة المطلوبة للمحطة',
                    ),
                    '${requiredSystemKw?.toStringAsFixed(3)} kW',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'عدد الألواح المطلوبة',
                      masri: 'عدد الألواح المطلوبة',
                    ),
                    '${requiredPanelsCount ?? '-'}',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'المساحة التقريبية المطلوبة',
                      masri: 'المساحة المطلوبة تقريباً',
                    ),
                    '${requiredAreaM2?.toStringAsFixed(2)} m²',
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
            ],

            // نتائج حسب المساحة
            if (hasAreaResults) ...[
              pw.Text(
                t(
                  fusha: '٣. نتائج التقدير حسب المساحة المتاحة',
                  masri: '٣. نتائج حسب المساحة',
                ),
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                children: [
                  _pdfRow(
                    t(
                      fusha: 'المساحة التي أدخلها المستخدم',
                      masri: 'المساحة اللي المستخدم كتبها',
                    ),
                    '${_availableAreaController.text} m²',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'وجود عوائق أو أسوار',
                      masri: 'فيه عوائق أو أسوار؟',
                    ),
                    _hasObstacles
                        ? t(fusha: 'نعم', masri: 'أيوه')
                        : t(fusha: 'لا', masri: 'لأ'),
                  ),
                  _pdfRow(
                    t(
                      fusha: 'عامل التصحيح للمساحة',
                      masri: 'عامل تصحيح المساحة',
                    ),
                    _hasObstacles
                        ? _obstacleCorrectionFactor.toStringAsFixed(2)
                        : '1.00',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'المساحة الفعلية بعد التصحيح',
                      masri: 'المساحة الفعلية بعد التصحيح',
                    ),
                    effectiveArea != null
                        ? '${effectiveArea?.toStringAsFixed(2)} m²'
                        : '-',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'عدد الألواح الممكن تركيبها',
                      masri: 'عدد الألواح الممكن تركيبها',
                    ),
                    possiblePanelsCountFromArea != null
                        ? '${possiblePanelsCountFromArea?.toStringAsFixed(0)}'
                        : '-',
                  ),
                  _pdfRow(
                    t(
                      fusha: 'القدرة الكلية الممكن تركيبها',
                      masri: 'القدرة الكلية الممكن تركيبها',
                    ),
                    possibleSystemKwFromArea != null
                        ? '${possibleSystemKwFromArea?.toStringAsFixed(3)} kW'
                        : '-',
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
            ],

            pw.Text(
              t(
                fusha:
                    'هذه النتائج تقديرية، ويُنصح بمراجعتها مع مهندس متخصص قبل تنفيذ أي مشروع فعلي.',
                masri:
                    'النتائج دي تقريبية، والأفضل تراجعها مع مهندس متخصص قبل التنفيذ.',
              ),
              style: const pw.TextStyle(fontSize: 11),
            ),
          ];
        },
      ),
    );

    // طباعة / حفظ PDF
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.TableRow _pdfRow(String key, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(key, style: pw.TextStyle(fontSize: 11)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // أزرار إضافية: تقدير تكلفة + PDF حقيقي
  Widget _additionalButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              _showSnack(
                t(
                  fusha:
                      'يمكن إضافة تقدير تكلفة تقريبية هنا بناءً على سعر الكيلو واط أو سعر اللوح.',
                  masri:
                      'ممكن بعدين تضيف هنا حساب تكلفة تقريبية حسب سعر الكيلو واط أو سعر اللوح.',
                ),
              );
            },
            icon: const Icon(Icons.attach_money),
            label: Text(
              t(fusha: 'تقدير تكلفة تقريبية', masri: 'تقدير تكلفة تقريبية'),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _exportToPdf,
            icon: const Icon(Icons.picture_as_pdf),
            label: Text(t(fusha: 'تصدير تقرير PDF', masri: 'تصدير تقرير PDF')),
          ),
        ),
      ],
    );
  }

  // ====== واجهة المستخدم ======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(
            fusha: 'مساعد تقدير محطة شمسية',
            masri: 'مساعد تقدير المحطة الشمسية',
          ),
        ),
        actions: [
          // زر بسيط لتبديل اللغة فصحى/عامية أثناء التشغيل
          IconButton(
            onPressed: () {
              setState(() {
                useEgyptianDialect = !useEgyptianDialect;
              });
            },
            icon: const Icon(Icons.translate),
            tooltip: t(
              fusha: 'تبديل بين الفصحى والعامية',
              masri: 'تبديل بين الفصحى والعامية',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t(
                        fusha: 'اختر طريقة التقدير:',
                        masri: 'اختار طريقة التقدير:',
                      ),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Flexible(
                          child: RadioListTile<Mode>(
                            value: Mode.byConsumption,
                            groupValue: _mode,
                            title: Text(
                              t(
                                fusha: 'حسب الاستهلاك اليومي',
                                masri: 'حسب الاستهلاك اليومي',
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                _mode = v!;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<Mode>(
                            value: Mode.byArea,
                            groupValue: _mode,
                            title: Text(
                              t(
                                fusha: 'حسب المساحة المتاحة',
                                masri: 'حسب المساحة المتاحة',
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                _mode = v!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),

                    // محتوى المدخلات حسب الوضع
                    if (_mode == Mode.byConsumption) ...[
                      Text(
                        t(
                          fusha: 'الإدخال (حسب الاستهلاك):',
                          masri: 'الإدخال (حسب الاستهلاك):',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _dailyConsumptionController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: t(
                            fusha: 'متوسط الاستهلاك اليومي (kWh)',
                            masri: 'متوسط الاستهلاك اليومي (kWh)',
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _infoRow(
                        t(
                          fusha: 'ساعات ذروة شمسية افتراضية:',
                          masri: 'ساعات ذروة شمسية افتراضية:',
                        ),
                        '$peakSunHours ${t(fusha: "ساعة/يوم", masri: "ساعة/يوم")} ',
                      ),
                      _infoRow(
                        t(
                          fusha: 'عامل أداء النظام (الخسائر):',
                          masri: 'عامل أداء النظام (الخسائر):',
                        ),
                        '${(systemPerformanceFactor * 100).toInt()} %',
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: calculateByConsumption,
                        child: Text(t(fusha: 'حساب', masri: 'احسب')),
                      ),
                    ] else ...[
                      Text(
                        t(
                          fusha: 'الإدخال (حسب المساحة):',
                          masri: 'الإدخال (حسب المساحة):',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _availableAreaController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: t(
                            fusha: 'المساحة المتاحة (متر مربع)',
                            masri: 'المساحة المتاحة (متر مربع)',
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: _hasObstacles,
                            onChanged: (v) {
                              setState(() {
                                _hasObstacles = v ?? false;
                                if (!_hasObstacles) {
                                  _obstacleCorrectionFactor =
                                      obstacleCorrectionFactorDefault;
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              t(
                                fusha: 'هل توجد أسوار أو عوائق على السطح؟',
                                masri: 'فيه أسوار أو عوائق على السطح؟',
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_hasObstacles) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              t(
                                fusha: 'عامل التصحيح (0.5 إلى 1.0):',
                                masri: 'عامل التصحيح (0.5 لحد 1.0):',
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: _obstacleCorrectionFactor,
                                min: 0.5,
                                max: 1.0,
                                divisions: 50,
                                onChanged: (v) {
                                  setState(() {
                                    _obstacleCorrectionFactor = v;
                                  });
                                },
                              ),
                            ),
                            Text(_obstacleCorrectionFactor.toStringAsFixed(2)),
                          ],
                        ),
                      ],
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: calculateByArea,
                        child: Text(t(fusha: 'حساب', masri: 'احسب')),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // بطاقة النتائج
            _buildResultsCard(),

            const SizedBox(height: 8),
            _buildSettingsCard(),

            const SizedBox(height: 24),
            Text(
              t(
                fusha:
                    'ملاحظة: هذه النتائج تقريبية وتعتمد على الافتراضات، ويُفضّل مراجعتها مع متخصص قبل التنفيذ.',
                masri:
                    'ملاحظة: النتائج تقريبية وتعتمد على افتراضات، والأفضل تراجعها مع متخصص قبل التنفيذ.',
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard() {
    if (_mode == Mode.byConsumption) {
      if (requiredSystemKw == null) return const SizedBox.shrink();

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t(
                  fusha: 'نتائج التقدير (حسب الاستهلاك اليومي)',
                  masri: 'نتائج التقدير (حسب الاستهلاك اليومي)',
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _resultRow(
                t(
                  fusha: 'القدرة المطلوبة للمحطة (kW):',
                  masri: 'القدرة المطلوبة للمحطة (kW):',
                ),
                '${requiredSystemKw} kW',
              ),
              _resultRow(
                t(
                  fusha: 'عدد الألواح المطلوبة:',
                  masri: 'عدد الألواح المطلوبة:',
                ),
                '${requiredPanelsCount} ${t(fusha: "لوح", masri: "لوح")}',
              ),
              _resultRow(
                t(
                  fusha: 'المساحة التقريبية المطلوبة (متر مربع):',
                  masri: 'المساحة المطلوبة تقريباً (متر مربع):',
                ),
                '${requiredAreaM2} m²',
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                t(
                  fusha: 'رسم تخطيطي تقريبي لترتيب الألواح:',
                  masri: 'رسم تقريبي لترتيب الألواح:',
                ),
              ),
              _buildSimpleLayout(requiredPanelsCount ?? 0),
              const SizedBox(height: 8),
              _additionalButtons(),
            ],
          ),
        ),
      );
    } else {
      if (possiblePanelsCountFromArea == null) return const SizedBox.shrink();

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t(
                  fusha: 'نتائج التقدير (حسب المساحة المتاحة)',
                  masri: 'نتائج التقدير (حسب المساحة المتاحة)',
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _resultRow(
                t(
                  fusha: 'المساحة الفعلية بعد التصحيح (متر مربع):',
                  masri: 'المساحة الفعلية بعد التصحيح (متر مربع):',
                ),
                effectiveArea != null
                    ? '${effectiveArea} m²'
                    : t(fusha: 'غير متوفر', masri: 'مش متوفر'),
              ),
              _resultRow(
                t(
                  fusha: 'عدد الألواح الممكن تركيبها:',
                  masri: 'عدد الألواح الممكن تركيبها:',
                ),
                '${possiblePanelsCountFromArea?.toStringAsFixed(0)} ${t(fusha: "لوح", masri: "لوح")}',
              ),
              _resultRow(
                t(
                  fusha: 'القدرة الكلية الممكن تركيبها (kW):',
                  masri: 'القدرة الكلية الممكن تركيبها (kW):',
                ),
                '${possibleSystemKwFromArea} kW',
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                t(
                  fusha: 'رسم تخطيطي تقريبي لترتيب الألواح:',
                  masri: 'رسم تقريبي لترتيب الألواح:',
                ),
              ),
              _buildSimpleLayout((possiblePanelsCountFromArea ?? 0).toInt()),
              const SizedBox(height: 8),
              _additionalButtons(),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildSettingsCard() {
    return Card(
      child: ExpansionTile(
        title: Text(
          t(
            fusha: 'إعدادات الافتراضات (يمكن تعديلها)',
            masri: 'إعدادات الافتراضات (ممكن تعدّلها)',
          ),
        ),
        children: [
          ListTile(
            title: Text(
              t(
                fusha: 'قدرة اللوح الافتراضية (واط)',
                masri: 'قدرة اللوح الافتراضية (واط)',
              ),
            ),
            subtitle: Text('${(panelPowerKw * 1000).toInt()} W'),
            trailing: SizedBox(
              width: 120,
              child: Slider(
                value: panelPowerKw * 1000,
                min: 250,
                max: 600,
                divisions: 35,
                label: '${(panelPowerKw * 1000).toInt()} W',
                onChanged: (v) {
                  setState(() {
                    panelPowerKw = v / 1000.0;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              t(
                fusha: 'مساحة اللوح التقريبية (متر مربع)',
                masri: 'مساحة اللوح التقريبية (متر مربع)',
              ),
            ),
            subtitle: Text('${panelAreaM2.toStringAsFixed(2)} m²'),
            trailing: SizedBox(
              width: 120,
              child: Slider(
                value: panelAreaM2,
                min: 1.0,
                max: 3.0,
                divisions: 20,
                onChanged: (v) {
                  setState(() {
                    panelAreaM2 = v;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              t(
                fusha: 'عامل أداء النظام (خسائر)',
                masri: 'عامل أداء النظام (خسائر)',
              ),
            ),
            subtitle: Text(systemPerformanceFactor.toStringAsFixed(2)),
            trailing: SizedBox(
              width: 120,
              child: Slider(
                value: systemPerformanceFactor,
                min: 0.5,
                max: 1.0,
                divisions: 50,
                onChanged: (v) {
                  setState(() {
                    systemPerformanceFactor = v;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              t(
                fusha: 'ساعات ذروة شمسية في اليوم',
                masri: 'ساعات ذروة الشمس في اليوم',
              ),
            ),
            subtitle: Text('${peakSunHours.toStringAsFixed(2)} h/day'),
            trailing: SizedBox(
              width: 120,
              child: Slider(
                value: peakSunHours,
                min: 3.0,
                max: 7.0,
                divisions: 40,
                onChanged: (v) {
                  setState(() {
                    peakSunHours = v;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dailyConsumptionController.dispose();
    _availableAreaController.dispose();
    super.dispose();
  }
}
