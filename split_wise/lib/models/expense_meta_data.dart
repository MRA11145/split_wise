class ExpenseMetaData {
  late String _name;
  late String _imgUrl;
  late String _notes;

  ExpenseMetaData(String name, String imgUrl, String notes) {
    _name = name;
    _imgUrl = imgUrl;
    _notes = notes;
  }

  ExpenseMetaData.empty();

  String getName() {
    return _name;
  }

  String getImgUrl() {
    return _imgUrl;
  }

  String getNotes() {
    return _notes;
  }
}