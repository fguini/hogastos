enum IncomeExpenseType {
  income,
  expense,
}

class IncomeExpense {
  final IncomeExpenseType type;

  IncomeExpense(this.type);

  double getAmount(double amount) {
    if(amount == 0) {
      return amount;
    }

    if(type == IncomeExpenseType.income) {
      return amount < 0
        ? amount * -1
        : amount;
    }

    return amount > 0
      ? amount * -1
      : amount;
  }
}