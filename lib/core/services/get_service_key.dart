import 'package:googleapis_auth/auth_io.dart';

class GetServerKey{
  Future<String> getServerKeyToken()async{
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "ecommerce-5ae51",
        "private_key_id": "3a25aaca86f49810db14a7c45590bbe56c327ac0",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDP8uh9uxy9e4RG\nVne6kXoZbsnz5RDoOBV4VOYpz2rbf03tN20QxFqSk+0w0fQdlBcbVJ2SRNyElXuh\nzNZPqL7BQE7Y8CMl4xhtoTvgkN4F3X62HBQg+8MZkY/2T3QU2Id/NPdkVpWzM/Xx\nglXyIK1VmEfgHbW1X1ruCUR/ob1XuCkUHs7VibDc8YFZ5qRCz19mvUtlP4ZAOwsR\nT4U+S89dSRYmE379duUD+ZgGb+JPYqZl6myi9VDXaBJyzQv8Kd0P/lM4r6jTw0cO\nLSr62K31hHd/K5YSVdnXi0oVXbBJMBJRvkysmglg6P/iiR/4FRBX9DlRccuTNcno\nueRl/LMZAgMBAAECggEARJjZztgRpAQB334YoufogklEv3r599DAbGB9SJ+OnXfC\nShV1mglb42x+2xL3V2aJtM9V53Fl2SrCjN5YeBCvVGqVWATnY1EltsxwRyUiyIaH\njSV4EmVat62H8vXE0jeXgwQC9AuH+ISUhiW7mlLjOxAv7aN/VKRvB4TxHrVJE40o\n3JFgRB3iEb1v4uTNGGv1fAMF9mob1TeSHXubnr5EHTf7cIAg7A9OF4K+O9twurwM\nRD9n+I1gXTccRPnu6Z3UfH94RCsPRr6w/huAgPu0C0mU9FiMgI2z9u58UKcP2CSj\nMS5sNcVeL1sa1/HVWsVXh5GFO+p9VS8ijspw730P3QKBgQD7k2jNXDSYIfOKjKn5\njPgBoGkoOL7erHZF1hDhQSoDduQCBicIvbhiM5W+V1+Sdyfca0YRMP3PvTZg/90O\nCUwJ50jriggGQJ4SzCTvm9BAkkWn5iGVcUq/0VXGRLGuw6+MyiBWcIhTr1QYlqjo\n5ahnr+y6ahfnMMmwkXnFdifc7wKBgQDTmxdC7XWoiYxNdBMdiLmJ8ZFMeLmb5dAr\neEFKtkk662cScAAmMtumpfzhVpCPPdsA63odwHWm8MdsINCQ7g/ai1ARnHNfoCjR\nogxqovDr9f0ltadjhwyKSQ96L7f4xKue1kjFGiwRvYzHJXRG4o2ZHxglqVc/oGgZ\ngepJF9sAdwKBgQC1AmEbsUYeV/9VJtR9u5IOCY7f48RhjxEiOl221R4XlAmF80tO\nnML31UnexBr91UIW9BBb+jYErI1dyXsRyFqvnXv4DT6s0P1rZPsGc8OpUhVQMuLj\nFbrEvSfMGk0GA8JhuGUADMPqAnKtpmkt+V/sCsZ3cjJ0o8PaiTFmhBc2fQKBgAu7\nw9RwOl/4EJGS6CRxGmitvnLRFumwGpTufCBab0EXIIYDM97qXwekmJseI7HtqiEo\n7YKM03lITKaQQ0BmEvb5Vp1DYZph1SGarLmVA2ryHvFiWz/Hk0hvuK37y2W98g5C\nr5JOWzc4nX/FceckVNmywbIE69OZX2xaqdUXv4sNAoGBAJcDW50gu+VfQae0V38s\n2g+jl+g95I6lhC0ozXmq30j8PqHVZ5uKAEMu18e6Z/hKbUnIRpXdcUrMFcqEr47R\nqh2aKdC3CTlSYELVtcjKUv0YJv+/LchGcrNvxmyBKhAuqNxHIsuHgal3Du2A+0We\nkNSda58hiSTxzO5ZwHPQnD3w\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-zg40w@ecommerce-5ae51.iam.gserviceaccount.com",
        "client_id": "108544714216202537625",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zg40w%40ecommerce-5ae51.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"},),
      scopes,
    );
    final accessServerKey= client.credentials.accessToken.data;
    print("accessServerKey>>>>>>>>>>$accessServerKey");
    return accessServerKey;
  }

}