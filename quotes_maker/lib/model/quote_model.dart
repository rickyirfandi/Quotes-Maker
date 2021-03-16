class QuoteModel {
  late String caption;
  late String url;
  late int textSize;
  late int footerSize;
  late bool isBold;
  late bool isItalic;
  late bool isGrayscale;
  late bool isBlur;
  late bool isShadow;
  late bool isCredit;
  late String image_author;

  QuoteModel({
    required this.url,
    required this.caption,
    required this.textSize,
    required this.footerSize,
    required this.isBold,
    required this.isItalic,
    required this.isGrayscale,
    required this.isBlur,
    required this.isShadow,
    required this.isCredit,
    required this.image_author,
  });
}
