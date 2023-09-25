class Ledger{
  int? id;
  int? accountId;
  int? categoryId;
  String? transactionType;
  int? transferToId;
  double? amount;
  String? currency;
  double? exchangeRate = 4000.0;
  String? note;
  String? description;
  String? attach;
  DateTime? date = DateTime.now();
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();

  Ledger({
    this.id,
    this.accountId,
    this.categoryId,
    this.transactionType,
    this.transferToId,
    this.amount,
    this.currency,
    this.exchangeRate,
    this.note,
    this.description,
    this.attach,
    this.date,
    this.createdAt,
    this.updatedAt
  });

  Ledger.map(Map<String, dynamic> map){
    id              = map['id'];
    accountId       = map['account_id'];
    categoryId      = map['category_id'];
    transactionType = map['transaction_type'];
    transferToId    = map['transfer_to_id'];
    amount          = map['amount'];
    currency        = map['currency'];
    exchangeRate    = map['exchange_rate'];
    note            = map['note'];
    description     = map['description'];
    attach          = map['attach'];
    date            = map['date'];
    createdAt       = map['created_at'];
    updatedAt       = map['updated_at'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id'              : id,
      'account_id'      : accountId,
      'category_id'     : categoryId,
      'transaction_type': transactionType,
      'transfer_to_id'  : transferToId,
      'amount'          : amount,
      'currency'        : currency,
      'exchange_rate'   : exchangeRate,
      'note'            : note,
      'description'     : description,
      'attach'          : attach,
      'date'            : date,
      'updated_at'      : updatedAt
    };
  }
}