String getFormattedDate(DateTime date) {
  var year = date.year;
  var month = date.month;
  var day = date.day;

  return '$day/$month/$year';
}