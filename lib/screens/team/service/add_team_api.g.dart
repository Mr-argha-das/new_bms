// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_team_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAddModel _$TeamAddModelFromJson(Map<String, dynamic> json) => TeamAddModel(
      name: json['name'] as String,
      type: json['type'] as String,
      vId: json['vId'] as String,
    );

Map<String, dynamic> _$TeamAddModelToJson(TeamAddModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'vId': instance.vId,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AddTeamApi implements AddTeamApi {
  _AddTeamApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://squid-app-3-s689g.ondigitalocean.app';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<TeamResponse> login(TeamAddModel teamAddModel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(teamAddModel.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TeamResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/team-create',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TeamResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TeamListModel> getTeamList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TeamListModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/teams',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TeamListModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
