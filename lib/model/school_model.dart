class School {
  final String npsn;
  final String name;
  final String address;
  final String province;
  final String city;
  final String district;
  final String type;

  School({
    required this.npsn,
    required this.name,
    required this.address,
    required this.province,
    required this.city,
    required this.district,
    required this.type,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      npsn: json['npsn'] ?? 'Tidak Diketahui',
      name: json['sekolah'] ?? 'Tidak Diketahui',
      address: json['alamat_jalan'] ?? 'Tidak Diketahui',
      province: json['propinsi'] ?? 'Tidak Diketahui',
      city: json['kabupaten_kota'] ?? 'Tidak Diketahui',
      district: json['kecamatan'] ?? 'Tidak Diketahui',
      type: json['bentuk'] ?? 'Tidak Diketahui',
    );
  }
}
