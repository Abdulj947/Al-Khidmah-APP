import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:mcnd_mobile/ui/shared/styles/app_colors.dart';

import './prayer_times_model.dart';

class PrayerTimesWidget extends HookWidget {
  final PrayerTimesModelData viewData;

  const PrayerTimesWidget(this.viewData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = useProvider(prayerTimesViewModelProvider);
    useEffect(() {
      vm.startTicker();
      return () => vm.stopTicker();
    }, []);
    final rows = [
      buildItemRow(
        PrayerTimesModelItem(
            prayerName: "Prayer", begins: "Begins", iqamah: "Iqamah"),
        color: AppColors.prayerTimeHerderColor,
        topRow: true,
      ),
      ...viewData.times.map(
        (time) => buildItemRow(
          time,
          color: !time.highlight ? null : AppColors.upcomingPrayerColor,
          bottomRow: time == viewData.times.last,
        ),
      )
    ];
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              "PRAYER TIME",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.prayerTimeHerderColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(viewData.date),
                    SizedBox(height: 10),
                    Text(
                      viewData.hijriDate,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 10),
                    Text(
                      viewData.upcommingSalah,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(viewData.timeToUpcommingSalah),
                    SizedBox(height: 15),
                    DefaultTextStyle.merge(
                      textAlign: TextAlign.center,
                      child: Column(
                        children: rows,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemRow(
    PrayerTimesModelItem item, {
    Color? color,
    bool topRow = false,
    bool bottomRow = false,
  }) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: color == null ? Colors.black : Colors.white),
      child: Container(
        color: color,
        child: Row(
          children: [
            buildCell(
              item.prayerName,
              topRow: topRow,
              bottomRow: bottomRow,
              firstCol: true,
            ),
            buildCell(
              item.begins,
              twoCols: item.iqamah == null,
              topRow: topRow,
              bottomRow: bottomRow,
              lastCol: item.iqamah == null,
            ),
            if (item.iqamah != null)
              buildCell(
                item.iqamah!,
                topRow: topRow,
                bottomRow: bottomRow,
                lastCol: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCell(
    String text, {
    bool twoCols = false,
    bool topRow = false,
    bool bottomRow = false,
    bool firstCol = false,
    bool lastCol = false,
  }) {
    final border = BorderSide(color: AppColors.prayerTimeHerderColor);
    return Expanded(
      flex: twoCols ? 2 : 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            left: firstCol ? BorderSide.none : border,
            top: border,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
