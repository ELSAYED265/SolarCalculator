import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../Model/SolarSystemModel.dart';
import '../../../core/const/appRoute.dart';
import '../../../core/const/factory.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
part 'area_input_state.dart';

class AreaInputCubit extends Cubit<AreaInputState> {
  AreaInputCubit() : super(AreaInputInitial()) {
    Controller = TextEditingController();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // bool selected = false; // false = No obstacles, true = Yes obstacles
  late TextEditingController Controller;
  late SolarSystemModel solarSystemModel;
  double panelPowerWp = 380;
  double panelAreaM2 = 1.95;
  double costPerWp = 0.8;
  double area = 0.0;
  String selectedSolarType = 'Rooftop System';
  final List<String> solarCellTypes = [
    'Rooftop System',
    'Ground-Mounted System',
  ];

  void changeSolarType(String newType) {
    selectedSolarType = newType;
    emit(AreaInputInitial()); // او اعمل emit لحاجة أنسب لو عندك
  }
  // void changeSelection(bool value) {
  //   selected = value;
  //   print('selected = $selected');
  //   emit(AreaInputSelectionChanged(selected));
  // }

  void getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        emit(AreaInputLoading());

        double area = double.parse(Controller.text);

        // // لو في عوائق (Yes)
        // if (selected == true) {
        //   area = area * 0.95; // تقليل 5% بسبب العوائق
        // }
        if (selectedSolarType == 'Rooftop System') {
          panelPowerWp = (area / 10);
        } else {
          panelPowerWp = (area / 20);
        }

        final numberOfPanels = (panelPowerWp / .550).ceil();
        final initialCost = panelPowerWp * 1100;

        solarSystemModel = SolarSystemModel(
          actualSystemCapacityKwp: panelPowerWp,
          numberOfPanels: numberOfPanels,
          requiredArea: area,
          initialCost: initialCost,
        );
        emit(AreaInputSuccess(solarSystemModel));
      } catch (e) {
        emit(AreaInputFailer());
      }
    }
  }

  Recalculate(BuildContext context) {
    Controller.clear();
    context.pop();
    emit(AreaInputInitial());
  }
  // في AreaInputCubit

  Future<void> generateAreaResultPdf() async {
    if (solarSystemModel == null) return;

    final pdf = pw.Document();

    final model = solarSystemModel!;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Result of Area Calculation',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Summary',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),

                // Number of Panels
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Number of Panels:'),
                    pw.Text('${model.numberOfPanels}'),
                  ],
                ),
                pw.SizedBox(height: 8),

                // Required Plant Capacity
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Required Plant Capacity:'),
                    pw.Text(
                      '${model.actualSystemCapacityKwp.toStringAsFixed(3)} kW',
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),

                // Estimated Cost
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Estimated Cost:'),
                    pw.Text('\$${model.initialCost.toStringAsFixed(2)}'),
                  ],
                ),

                pw.SizedBox(height: 24),
                pw.Text(
                  'Notes:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'These numbers are estimates and may vary based on panel type, site conditions, and installation details.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 12),
                // إضافة الجملة الجديدة
                pw.Text(
                  'All calculations are based on N-type mono-crystalline (550–580 W each).',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // فتح شاشة الطباعة / الحفظ كـ PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Future<void> close() {
    Controller.dispose();
    return super.close();
  }
}
