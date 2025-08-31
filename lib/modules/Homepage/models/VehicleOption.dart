class VehicleOption {
  final String type;
  final String price;
  final String eta;
  final int seats;
  final int availableDrivers;
  final bool isPopular;

  VehicleOption({
    required this.type,
    required this.price,
    required this.eta,
    required this.seats,
    required this.availableDrivers,
    required this.isPopular,
  });

  factory VehicleOption.fromJson(Map<String, dynamic> json) {
    return VehicleOption(
      type: json['type'],
      price: json['price'],
      eta: json['eta'],
      seats: json['seats'],
      availableDrivers: json['availableDrivers'],
      isPopular: json['isPopular'],
    );
  }
}
