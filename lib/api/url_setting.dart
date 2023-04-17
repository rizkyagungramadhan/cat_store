class UrlSetting {
  const UrlSetting._();

  static const baseUrl = 'https://dummyjson.com';

  ///TimeOut in second unit
  static const _defaultMaxTimeOut = Duration(seconds: 10);
  static const maxReceiveTimeOut = _defaultMaxTimeOut;
  static const maxSendTimeOut = _defaultMaxTimeOut;
  static const maxConnectTimeOut = _defaultMaxTimeOut;
}