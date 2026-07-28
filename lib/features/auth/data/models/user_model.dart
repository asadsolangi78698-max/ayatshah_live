class UserModel {
  const UserModel({
    required this.id,
    required this.phone,
    this.name,
    this.avatarUrl,
    this.bio,
    this.gender,
    this.country,
    this.language,
    this.followersCount = 0,
    this.followingCount = 0,
    this.isVip = false,
    this.isVerified = false,
    this.diamonds = 0,
    this.coins = 0,
  });

  final String id;
  final String phone;
  final String? name;
  final String? avatarUrl;
  final String? bio;
  final String? gender;
  final String? country;
  final String? language;
  final int followersCount;
  final int followingCount;
  final bool isVip;
  final bool isVerified;
  final int diamonds;
  final int coins;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        phone: json['phone'] as String? ?? '',
        name: json['name'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        bio: json['bio'] as String?,
        gender: json['gender'] as String?,
        country: json['country'] as String?,
        language: json['language'] as String?,
        followersCount: json['followersCount'] as int? ?? 0,
        followingCount: json['followingCount'] as int? ?? 0,
        isVip: json['isVip'] as bool? ?? false,
        isVerified: json['isVerified'] as bool? ?? false,
        diamonds: json['diamonds'] as int? ?? 0,
        coins: json['coins'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'name': name,
        'avatarUrl': avatarUrl,
        'bio': bio,
        'gender': gender,
        'country': country,
        'language': language,
        'followersCount': followersCount,
        'followingCount': followingCount,
        'isVip': isVip,
        'isVerified': isVerified,
        'diamonds': diamonds,
        'coins': coins,
      };

  UserModel copyWith({
    String? name,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? country,
    String? language,
    int? followersCount,
    int? followingCount,
    bool? isVip,
    bool? isVerified,
    int? diamonds,
    int? coins,
  }) {
    return UserModel(
      id: id,
      phone: phone,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      language: language ?? this.language,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      isVip: isVip ?? this.isVip,
      isVerified: isVerified ?? this.isVerified,
      diamonds: diamonds ?? this.diamonds,
      coins: coins ?? this.coins,
    );
  }
}
