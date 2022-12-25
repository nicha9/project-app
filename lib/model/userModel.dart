class Users {
  final String id;
  final String email;
  final String password;
  final String name;
  final String role;
  final int x_score;
  final int trial_pattern1;
  final int trial_pattern2;

  Users({
    required this.trial_pattern1,
    required this.trial_pattern2,
    required this.id,
    required this.password,
    required this.email,
    required this.name,
    required this.role,
    required this.x_score
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name': name,
    'role': role,
    'x_score': x_score,
    'trial_pattern1': trial_pattern1,
    'trial_pattern2': trial_pattern2,
  };

  static Users fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      role: json['role'],
      x_score: json['x_score'],
      id: json['id'],
    trial_pattern1: json['trial_pattern1'],
    trial_pattern2: json['trial_pattern2'],
  );
}