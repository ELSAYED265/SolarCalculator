import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:solar_calculator_app/Model/SolarSystemModel.dart';

import '../../../core/const/appRoute.dart';
import '../../../core/const/factory.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

part 'consumption_state.dart';

class ConsumptionCubit extends Cubit<ConsumptionState> {
  ConsumptionCubit() : super(ConsumptionInitial()) {
    controller = TextEditingController();
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> solarCellTypes = [
    'Rooftop System',
    'Ground-Mounted System',
  ];
  String selectedSolarType = 'Rooftop System';

  late TextEditingController controller;
  late SolarSystemModel solarSystemModel;
  double panelPowerWp = 380;
  double panelAreaM2 = 1.95;
  double costPerWp = 0.8;
  double requiredArea = 0.0;
  getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        emit(ConsumptionLoading());
        final consumption = double.tryParse(controller.text);
        if (consumption != null) {
          final actualSystemCapacityKwp =
              (consumption * Factory.systemLossFactor) / Factory.sunHoursPerDay;

          if (selectedSolarType == "Rooftop System") {
            requiredArea = (actualSystemCapacityKwp * 10).toDouble();
          } else {
            requiredArea = (actualSystemCapacityKwp * 20).toDouble();
          }

          final numberOfPanels =
              (actualSystemCapacityKwp *
                      Factory.capacityToPanelRatio /
                      (panelPowerWp / 1000))
                  .ceil();

          final initialCost =
              actualSystemCapacityKwp * Factory.initialCostMultiplier;

          solarSystemModel = SolarSystemModel(
            actualSystemCapacityKwp: actualSystemCapacityKwp,
            numberOfPanels: numberOfPanels,
            requiredArea: requiredArea,
            initialCost: initialCost,
          );
          emit(ConsumptionSuccess(solarSystemModel));
        }
      } catch (e) {
        emit(ConsumptionFailer());
      }
    }
  }

  void changeSolarType(String newType) {
    selectedSolarType = newType;
    emit(ConsumptionInitial()); // او اعمل emit لحاجة أنسب لو عندك
  }

  Recalculate(BuildContext context) {
    controller.clear();
    context.pop();
    emit(ConsumptionInitial());
  }

  Future<void> generateConsumptionResultPdf() async {
    if (solarSystemModel == null) return;

    final pdf = pw.Document();
    final model = solarSystemModel;

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
                  'Solar System Calculation Result',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Based on your daily energy consumption, here are your solar system requirements:',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 20),

                // Required Plant Capacity
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Required Plant Capacity:'),
                    pw.Text(
                      '${model.actualSystemCapacityKwp.toStringAsFixed(3)} kWp',
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),

                // Required Area
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Required Area for Panels:'),
                    pw.Text('${model.requiredArea.toStringAsFixed(2)} m²'),
                  ],
                ),
                pw.SizedBox(height: 8),

                // Number of Panels
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Number of Panels Needed:'),
                    pw.Text('${model.numberOfPanels}'),
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
                  'These numbers are estimates and may vary based on system components, installation conditions, and market prices.',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 12),
                // الجملة الإضافية
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

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
