class RegisterFoam {
  String name;
  String phonenumber;
  String jobtype;
  String jobscope;
  String address;

  RegisterFoam(this.name, this.phonenumber, this.jobtype, this.jobscope, this.address);

  factory RegisterFoam.fromJson(dynamic json) {
    return RegisterFoam("${json['name']}", "${json['phonenumber']}",
        "${json['jobtype']}", "${json['jobscope']}", "${json['address']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'phonenumber': phonenumber,
        'jobtype': jobtype,
        'jobscope': jobscope,
        'address' : address,
      };
}