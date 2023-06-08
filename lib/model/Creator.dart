class Creator {
  final String id;
  final String? thumbnail;
  final String creator;

  Creator({required this.id, required this.thumbnail, required this.creator,});

  @override
  bool operator ==(Object other) {
    return other is Creator && other.creator == creator;
  }

  @override
  int get hashCode => creator.hashCode;



}