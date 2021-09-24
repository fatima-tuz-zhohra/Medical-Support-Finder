class BloodRequest {
  String docId = '';
  String uid;
  String name;
  String picture;

  String phoneNo;
  String bloodGroup;
  String description;

  BloodRequest({
    required this.uid,
    required this.name,
    required this.picture,
    required this.phoneNo,
    required this.bloodGroup,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': this.docId,
      'uid': this.uid,
      'name': this.name,
      'picture': this.picture,
      'phoneNo': this.phoneNo,
      'bloodGroup': this.bloodGroup,
      'description': this.description,
    };
  }

  factory BloodRequest.fromMap(Map<String, dynamic> map) {
    return BloodRequest(
      uid: map['uid'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      phoneNo: map['phoneNo'] as String,
      bloodGroup: map['bloodGroup'] as String,
      description: map['description'] as String,
    )..docId = map['docId'] as String;
  }
}
