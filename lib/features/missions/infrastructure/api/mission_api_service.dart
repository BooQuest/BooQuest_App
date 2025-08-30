import 'package:dartz/dartz.dart';
import 'package:booquest/core/network/network_client.dart';
import 'package:booquest/features/auth/infrastructure/auth_storage_service.dart';
import '../../domain/entities/mission_entity.dart';
import '../../domain/failures/mission_failure.dart';
import '../../domain/entities/subquest_entity.dart';
import '../../domain/entities/subquest_request_data.dart';
import '../../domain/entities/subquest_regenerate_request_data.dart';

class MissionApiService {
  static MissionApiService? _instance;
  static MissionApiService get instance => _instance ??= MissionApiService._();
  MissionApiService._();

  Future<Either<MissionFailure, List<MissionStepEntity>>> createMissions(MissionCreateRequest request) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      final response = await client.post<Map<String, dynamic>>(
        '/api/missions',
        data: request.toJson(),
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(MissionFailure.server('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(MissionFailure.server(body['message']?.toString() ?? 'API 실패'));
      }

      final list = (body['data'] as List<dynamic>).map((item) {
        final m = item as Map<String, dynamic>;
        return MissionStepEntity(
          id: (m['id'] ?? 0) as int,
          title: (m['title'] ?? '').toString(),
          order: (m['order'] ?? 0) as int,
          designNotes: (m['designNotes'] ?? '').toString(),
        );
      }).toList();

      return Right(list);
    } catch (e) {
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(MissionFailure.network(message));
      }
      return Left(MissionFailure.unknown(message));
    }
  }

  /// 선택된 부업의 미션 데이터 조회
  /// GET /api/onboarding/{sideJobId}
  Future<Either<MissionFailure, List<MissionStepEntity>>> getMissionsBySideJobId(int sideJobId) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      print('🚀 미션 데이터 API 호출 시작... sideJobId: $sideJobId');
      
      final response = await client.get<Map<String, dynamic>>(
        '/api/onboarding/$sideJobId',
      );

      print('📥 API 응답:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode != 200 || response.data == null) {
        return Left(MissionFailure.server('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(MissionFailure.server(body['message']?.toString() ?? 'API 실패'));
      }

      final data = body['data'] as Map<String, dynamic>;
      final missions = data['missions'] as List<dynamic>?;
      
      if (missions == null || missions.isEmpty) {
        print('❌ 미션 데이터가 없습니다');
        return Left(MissionFailure.server('미션 데이터가 없습니다'));
      }

      // missions 배열에서 missionSteps도 함께 파싱
      final list = missions.map((mission) {
        final m = mission as Map<String, dynamic>;
        final missionSteps = m['missionSteps'] as List<dynamic>?;
        
        return MissionStepEntity(
          id: (m['id'] ?? 0) as int,
          title: (m['title'] ?? '').toString(),
          order: (m['order'] ?? 0) as int,
          designNotes: (m['designNotes'] ?? '').toString(),
          missionSteps: missionSteps?.map((step) => step as Map<String, dynamic>).toList(),
        );
      }).toList();

      // order 순으로 정렬
      list.sort((a, b) => a.order.compareTo(b.order));

      print('✅ 미션 데이터 파싱 완료: ${list.length}개 스텝');
      return Right(list);
      
    } catch (e) {
      print('❌ 미션 데이터 로드 중 예외 발생: $e');
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(MissionFailure.network(message));
      }
      return Left(MissionFailure.unknown(message));
    }
  }

  /// 부퀘스트 생성 API 호출
  /// POST /api/missions/steps
  Future<Either<MissionFailure, List<SubQuestEntity>>> getSubQuests(SubQuestRequestData request) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      print('🚀 부퀘스트 생성 API 호출 시작...');
      print('  - userId: ${request.userId}');
      print('  - missionId: ${request.missionId}');
      print('  - missionTitle: ${request.missionTitle}');
      print('  - missionDesignNotes: ${request.missionDesignNotes}');

      final response = await client.post<Map<String, dynamic>>(
        '/api/missions/steps',
        data: request.toJson(),
      );

      print('📥 부퀘스트 생성 API 응답:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode != 200 || response.data == null) {
        return Left(MissionFailure.server('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(MissionFailure.server(body['message']?.toString() ?? 'API 실패'));
      }

      final list = (body['data'] as List<dynamic>).map((item) {
        final q = item as Map<String, dynamic>;
        return SubQuestEntity(
          id: (q['id'] ?? 0) as int,
          title: (q['title'] ?? '').toString(),
          seq: (q['seq'] ?? 0) as int,
          status: (q['status'] ?? '').toString(),
          detail: (q['detail'] ?? '').toString(),
        );
      }).toList();

      print('✅ 부퀘스트 데이터 파싱 완료: ${list.length}개');
      return Right(list);
      
    } catch (e) {
      print('❌ 부퀘스트 API 호출 중 예외 발생: $e');
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(MissionFailure.network(message));
      }
      return Left(MissionFailure.unknown(message));
    }
  }

  /// 미션 시작 API 호출
  /// POST /api/missions/{missionId}/start
  Future<Either<MissionFailure, bool>> startMission(int missionId) async {
    try {
      print('🚀 미션 시작 API 호출 시작... missionId: $missionId');
      
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      final response = await client.post<Map<String, dynamic>>(
        '/api/missions/$missionId/start',
        data: {}, // 빈 데이터 (요청 바디가 필요 없는 경우)
      );

      print('📥 미션 시작 API 응답:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode != 200 || response.data == null) {
        return Left(MissionFailure.server('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true) {
        final message = body['message']?.toString();
        print('❌ API 실패 응답: $message');
        return Left(MissionFailure.server(message ?? 'API 실패'));
      }

      print('✅ 미션 시작 API 성공');
      return const Right(true);
      
    } catch (e) {
      print('❌ 미션 시작 API 호출 중 예외 발생: $e');
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(MissionFailure.network(message));
      }
      return Left(MissionFailure.unknown(message));
    }
  }

  /// 부퀘스트 재생성 API 호출
  /// POST /api/missions/steps/regenerate
  Future<Either<MissionFailure, List<SubQuestEntity>>> regenerateSubQuests(SubQuestRegenerateRequestData request) async {
    try {
      final authStorage = await AuthStorageService.getInstance();
      final client = NetworkClient(authStorage);

      print('🚀 부퀘스트 재생성 API 호출 시작...');
      print('  - userId: ${request.generateMissionStep.userId}');
      print('  - missionId: ${request.generateMissionStep.missionId}');
      print('  - reasons: ${request.feedbackData.reasons}');
      print('  - etcFeedback: ${request.feedbackData.etcFeedback}');

      final response = await client.post<Map<String, dynamic>>(
        '/api/missions/steps/regenerate',
        data: request.toJson(),
      );

      print('📥 부퀘스트 재생성 API 응답:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Response Data: ${response.data}');

      if (response.statusCode != 200 || response.data == null) {
        return Left(MissionFailure.server('서버 오류 (${response.statusCode})'));
      }

      final body = response.data!;
      if (body['success'] != true || body['data'] == null) {
        return Left(MissionFailure.server(body['message']?.toString() ?? 'API 실패'));
      }

      final list = (body['data'] as List<dynamic>).map((item) {
        final q = item as Map<String, dynamic>;
        return SubQuestEntity(
          id: (q['id'] ?? 0) as int,
          title: (q['title'] ?? '').toString(),
          seq: (q['seq'] ?? 0) as int,
          status: (q['status'] ?? '').toString(),
          detail: (q['detail'] ?? '').toString(),
        );
      }).toList();

      print('✅ 부퀘스트 재생성 데이터 파싱 완료: ${list.length}개');
      return Right(list);
      
    } catch (e) {
      print('❌ 부퀘스트 재생성 API 호출 중 예외 발생: $e');
      final message = e.toString();
      if (message.contains('SocketException') || message.contains('TimeoutException')) {
        return Left(MissionFailure.network(message));
      }
      return Left(MissionFailure.unknown(message));
    }
  }
}


