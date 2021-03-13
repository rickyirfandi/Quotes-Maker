class QuoteModel {
  late String caption;
  late String url;
  late int textSize;
  late bool isBold;
  late bool isItalic;
  late bool isGrayscale;
  late bool isBlur;

  QuoteModel({
    required this.url,
    required this.caption,
    required this.textSize,
    required this.isBold,
    required this.isItalic,
    required this.isGrayscale,
    required this.isBlur,
  });
}
