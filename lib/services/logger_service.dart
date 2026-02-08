import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // Metot isimlerini gizle
    errorMethodCount: 3, // Hata durumunda sadece 3 satır göster
    lineLength: 80, // Satır uzunluğunu sınırla
    colors: true, // Renkli çıktı
    printEmojis: true, // Emojileri göster
    dateTimeFormat: DateTimeFormat.none, // Zaman damgasını gizle
    noBoxingByDefault: true, // Kutuları kaldır
  ),
);
