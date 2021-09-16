class Profile {
  String name;
  String email;
  String phoneNo;
  String? role;
  String image;
  bool isBloodDonor;
  String? bloodGroup;
  String? address;

  Profile(
    this.name,
    this.email,
    this.phoneNo,
    this.role,
    this.image, {
    this.isBloodDonor = false,
    this.bloodGroup,
    this.address,
  });
}
