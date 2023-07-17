List<String> keywordsBuilder(String convertName) {
  //build keywords
  List<String> keywordsList = [];
  String splitString = "";
  final smallLetterNmae = convertName;
  List wordsList = smallLetterNmae.split("");

  for (String element in wordsList) {
    keywordsList.add(splitString += element.replaceAll(" ", "").toLowerCase());
  }
  return keywordsList;
}
