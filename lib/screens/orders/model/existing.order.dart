class ExistingOrderModel {
    ExistingOrderModel({
        required this.clientAmmount,
        required this.clientPaidAmmountInr,
    });

    final int? clientAmmount;
    final int? clientPaidAmmountInr;

    factory ExistingOrderModel.fromJson(Map<String, dynamic> json){ 
        return ExistingOrderModel(
            clientAmmount: json["clientAmmount"],
            clientPaidAmmountInr: json["clientPaidAmmountInr"],
        );
    }

    Map<String, dynamic> toJson() => {
        "clientAmmount": clientAmmount,
        "clientPaidAmmountInr": clientPaidAmmountInr,
    };

}
