/// 부퀘스트 요청 데이터
class SubQuestRequestData {
  final int userId;
  final int missionId;
  final String missionTitle;
  final String missionDesignNotes;

  const SubQuestRequestData({
    required this.userId,
    required this.missionId,
    required this.missionTitle,
    required this.missionDesignNotes,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'missionId': missionId,
      'missionTitle': missionTitle,
      'missionDesignNotes': missionDesignNotes,
    };
  }

  @override
  String toString() {
    return 'SubQuestRequestData(userId: $userId, missionId: $missionId, missionTitle: $missionTitle, missionDesignNotes: $missionDesignNotes)';
  }
}
