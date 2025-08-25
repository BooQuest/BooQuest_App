/// 부퀘스트 엔티티
class SubQuestEntity {
  final int id;
  final String title;
  final int seq;
  final String status;
  final String detail;

  const SubQuestEntity({
    required this.id,
    required this.title,
    required this.seq,
    required this.status,
    required this.detail,
  });

  @override
  String toString() {
    return 'SubQuestEntity(id: $id, title: $title, seq: $seq, status: $status, detail: $detail)';
  }
}
