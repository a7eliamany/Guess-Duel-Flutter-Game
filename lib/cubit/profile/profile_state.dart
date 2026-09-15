class ProfileState {
  final bool isEditing;
  final bool isLoading;
  final String username;
  final String avatarID;
  final int createdAt;
  final String firebaseID;
  final String id;
  final bool isErorr;
  ProfileState({
    this.isEditing = false,
    this.username = '',
    this.avatarID = '',
    required this.createdAt,
    this.firebaseID = '',
    this.isLoading = false,
    this.isErorr = false,
    this.id = '',
  });
  ProfileState copyWith({
    bool? isEditing,
    String? username,
    String? avatarID,
    int? createdAt,
    String? firebaseID,
    bool? isLoading,
    bool? isErorr,
    String? id,
  }) {
    return ProfileState(
      isEditing: isEditing ?? this.isEditing,
      username: username ?? this.username,
      avatarID: avatarID ?? this.avatarID,
      createdAt: createdAt ?? this.createdAt,
      firebaseID: firebaseID ?? this.firebaseID,
      isLoading: isLoading ?? this.isLoading,
      isErorr: isErorr ?? this.isErorr,
      id: id ?? this.id,
    );
  }
}
