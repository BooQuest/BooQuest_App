class MissionCreateRequest {
  final int userId;
  final int sideJobId;
  final String sideJobTitle;
  final String sideJobDesignNotes;

  const MissionCreateRequest({
    required this.userId,
    required this.sideJobId,
    required this.sideJobTitle,
    required this.sideJobDesignNotes,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sideJobId': sideJobId,
        'sideJobTitle': sideJobTitle,
        'sideJobDesignNotes': sideJobDesignNotes,
      };
}

class MissionStepEntity {
  final int id;
  final String title;
  final int order;
  final String designNotes;
  final List<Map<String, dynamic>>? missionSteps; // 부퀘스트 데이터

  const MissionStepEntity({
    required this.id,
    required this.title,
    required this.order,
    required this.designNotes,
    this.missionSteps,
  });
}


