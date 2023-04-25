import 'package:chopper/chopper.dart';

part 'service_frequent_questions.chopper.dart';

@ChopperApi()
abstract class ServiceFrequentQuestions extends ChopperService {
  static ServiceFrequentQuestions create([ChopperClient? client]) =>
      _$ServiceFrequentQuestions(client);

  @Get(path: 'general/faqs')
  Future<Response> frequentQuestions();
}
