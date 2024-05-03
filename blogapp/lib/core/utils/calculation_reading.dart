int calculatereadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  final readingTime =  wordCount/255 ;

  return readingTime.ceil();
}
