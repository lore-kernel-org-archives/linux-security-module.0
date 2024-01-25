Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677E13A245
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201020; cv=none; b=nYZDz23Vs173hovhoUZtDH6IvBCFgfckEXJ57ERVNoI8TPPIjhZYvYiyqI49G5FX9o/rQ3iIBUVIcWwOQEkNtw7JJRPJ9hdLk7Zg3GmFcQ4uHoSR8E3rR5p54ldWPIV4gwCJQjwYBRz3HMYtqoBCn61qrYX/XDDGJq08ngUrKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201020; c=relaxed/simple;
	bh=X+r/q3tFBJg2vcJqBzYYFRiiLkmwUengnwCl0Fpo6CI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRv/6CfC7H4fiZp5irEvTtZCBseFft9NZviyjklW1A0kVGWPKDkDCfa2gTFP8Z0RLHUdiSGWN4mify5Mq1bHbM0KehaxTUuTlJa/pK28jQ3YKsC8uqAU6egkOHxAl9+qX0rplbiHZ97cJk/M7fgQcF8yhtNKECrCwH0PsaLATTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EWjDTVrE; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EWjDTVrE"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P6Wg40025319;
	Thu, 25 Jan 2024 16:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=default; bh=Ge8IV08osH0ypHo0MgOJkj
	h8ZapN3uR6xiIKaL1wDkU=; b=EWjDTVrEGYRPXJ2TD1yY4m3U8Kypy5aYn4ptX4
	v5FfGL+aiiYYdO+UBPgqjZDo1tHd9MFoU08xS19uSRGRzyLiTKyPKe0metQLctNr
	lHe2/A83+4OjmI/3x8IgdwLCeRawa4HOXeAZq6BuMwkUu/QDZ12fM3mm32WlqzvX
	y9PIyp1hkxT9HsIh03fNgmlbnuqGXofIebP2pGtBvOjsc1JAq5dz1QE1FyYVbMhp
	3HV9mi8MkaJBWvJz4TIF+ahBqYidPTIdKn48owszpW/qRd8cUda0PCj3r+O40Umx
	kDQBPNkcK6/beunCSMzpalz5RlxliPu3PcLlySZJZFuMmjoA==
Received: from 04wpexch09.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3vujfahe89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 16:43:28 +0000 (GMT)
Received: from 04WPEXCH10.crowdstrike.sys (10.100.11.114) by
 04WPEXCH09.crowdstrike.sys (10.100.11.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 25 Jan 2024 16:43:27 +0000
Received: from 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a]) by
 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a%18]) with mapi id
 15.02.1258.027; Thu, 25 Jan 2024 16:43:27 +0000
From: Ben Smith <ben.smith@crowdstrike.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Casey Schaufler
	<casey@schaufler-ca.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [External] Re: security_file_free contract/expectations
Thread-Topic: [External] Re: security_file_free contract/expectations
Thread-Index: AQHaTx+CJtwzlPzBJkmVkqGorohTxbDpuZEAgAB+YQD///7uAA==
Date: Thu, 25 Jan 2024 16:43:27 +0000
Message-ID: <035B34CB-2511-415B-BDC7-71306FE7C9AE@crowdstrike.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
 <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
 <41a855ac576119ec9cb614cfaeb68c0fe8c5ffc0.camel@huaweicloud.com>
In-Reply-To: <41a855ac576119ec9cb614cfaeb68c0fe8c5ffc0.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-disclaimer: USA
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha256; boundary="B_3789017006_1934067362"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: K7FGjy61guYX8Vn0I0u0ydamXbTso5d_
X-Proofpoint-GUID: K7FGjy61guYX8Vn0I0u0ydamXbTso5d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=754
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250118

--B_3789017006_1934067362
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable


=EF=BB=BFOn 1/25/24, 12:47 AM, "Roberto Sassu" <roberto.sassu@huaweicloud.com <ma=
ilto:roberto.sassu@huaweicloud.com>> wrote:

> I'm introducing a new LSM called file_release, that can be suitable for
> reading the file (actually IMA will use this functionality).

Good to know, Roberto, that looks like just what we need, maybe we can swit=
ch to that on newer kernels.




--B_3789017006_1934067362
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIRMgYJKoZIhvcNAQcCoIIRIzCCER8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGggg6kMIIFWTCCBEGgAwIBAgIRALSummxnTwDxAAAAAEw9LR0wDQYJKoZIhvcNAQELBQAw
gaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cu
ZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsT
FihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGll
bnQgQ0EwHhcNMjMwNjIyMTcxMzUzWhcNMjQwNjIyMTc0MzUyWjCBmzELMAkGA1UEBhMCVVMx
EzARBgNVBAgTCkNhbGlmb3JuaWExDzANBgNVBAcTBklydmluZTEaMBgGA1UEChMRQ3Jvd2RT
dHJpa2UsIEluYy4xSjAgBgNVBAMMGWJlbi5zbWl0aEBjcm93ZHN0cmlrZS5jb20wJgYJKoZI
hvcNAQkBFhliZW4uc21pdGhAY3Jvd2RzdHJpa2UuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAr/RUPuS2wHmZCQW/hC23wY+E+6K7QfYHYe0I3/wuTWlXUukp9RHsNR1i
zMBUAHX2Zsdvvq/fn2jU+jX4EpO7p2HkMcW64ymTPDWxxq+Pf2gmC0iZN6sizC85VrlMrY6N
UXr4Q93XrM6YCvmkZep9/12oPF9iMA2nIXgzXYkPWEqyA0RKraioSBlsXAUTGGTJ1VJAr1hp
ujNv5IGWzM9bwOviXZFvr2zU9VNTmiDNF26nvQRPTmZ31kQ8SaYBCkCKWusLTmUQTaBq/EZv
mrnWEb9AeZceaqeUufqMmFpgZ9h9U1XS8GmVrsqZbpxVqC696x9ThSWlATeQhtaOLp73fQID
AQABo4IBijCCAYYwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly93
d3cuZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQv
MjA0OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVz
dC5uZXQvY2xhc3MyY2EuY3JsMCQGA1UdEQQdMBuBGWJlbi5zbWl0aEBjcm93ZHN0cmlrZS5j
b20wHwYDVR0jBBgwFoAUCZGluunyLip1381+/nfK8t5rmyQwHQYDVR0OBBYEFN6zXtraAlPc
cURfbvDGvcAWC5GvMAkGA1UdEwQCMAAwDQYJKoZIhvcNAQELBQADggEBAByCxZ7R5TEhI8yq
KAy8jWOuF0/I04PmPOvLSzUwBxu1fCgdpCqimKxWnxVmc/GEAKDN7+xpbx7diPUfCjSwIUHM
6X67WVPSwg0Y8+GgGeVlvJKEN3kfkyxU4QSQYDc0Z9yrGIbji7t/FGLU1jKMdLpPrkfWvYIC
LkmxIldOQl+Vs1MOZKOIbwABSu4EQx4cKuNmVVFi4Z+WNwEduxNeOmC2Nv52+f9lSgvHPZ9j
n5K/M2tWxZRzYQMw745wyKafzDGqGTNkM4v80soLi4iRgAwy6S8rbwWotPtpHu5cYR6D4wPk
atw96g7ZiHa1VXjhzcd7+CU8JN/hf9ejYcdmacgwggUVMIID/aADAgECAhEArxwEsqyM/5sA
AAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEUMBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNV
BAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBs
aWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVudHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMT
KkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24gQXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3Mjkx
NTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVz
dCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQg
YnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQD
ExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0jerm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH9
8GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOsV7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9
X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhk
NJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIMLWAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5p
AjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9ZUdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IB
LTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAS
BgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUFBwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCswKTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0
Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIwMAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRw
Oi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNVHQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQw
HwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmhJAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+9
6RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9Ck6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYF
NSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+hAPANSxRRRvRocbL+YKE3DyX87yBaM8aph8nq
UvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+
zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYKW8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW
6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4xELH2l47+IIO9TUowggQqMIIDEqADAgECAgQ4
Y974MA0GCSqGSIb3DQEBBQUAMIG0MRQwEgYDVQQKEwtFbnRydXN0Lm5ldDFAMD4GA1UECxQ3
d3d3LmVudHJ1c3QubmV0L0NQU18yMDQ4IGluY29ycC4gYnkgcmVmLiAobGltaXRzIGxpYWIu
KTElMCMGA1UECxMcKGMpIDE5OTkgRW50cnVzdC5uZXQgTGltaXRlZDEzMDEGA1UEAxMqRW50
cnVzdC5uZXQgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgKDIwNDgpMB4XDTk5MTIyNDE3NTA1
MVoXDTI5MDcyNDE0MTUxMlowgbQxFDASBgNVBAoTC0VudHJ1c3QubmV0MUAwPgYDVQQLFDd3
d3cuZW50cnVzdC5uZXQvQ1BTXzIwNDggaW5jb3JwLiBieSByZWYuIChsaW1pdHMgbGlhYi4p
MSUwIwYDVQQLExwoYykgMTk5OSBFbnRydXN0Lm5ldCBMaW1pdGVkMTMwMQYDVQQDEypFbnRy
dXN0Lm5ldCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAoMjA0OCkwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCtTUupEoay6qMgBxUWZCorS9G/C0pNju2AdqVnt3hAwHNCyGjA
21Mr3V64dpg1k4sanXwTOg4fW7cez+UkFB6xgamNfbjMa0sD8QIM3KulQCQAf3SUoZ0IKbOI
C/WHd51VzeTDftdqZKuFFIaVW5cyUG89yLpmDOP8vbhJwXaJSRn9wKi9iaNnL8afvHEZYLgt
6SzJkHZme5Tir3jWZVNdPNacss8pA/kvpFCy1EjOBTJViv2yZEwO5JgHddt/37kIVWCFMCn5
e0ikaYbjNT8ehl16ehW97wCOFSJUFwCQJpO8Dklokb/4R9OdlULBDk3fbybPwxghYmZDcNbV
wAfhAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQW
BBRV5IHREYC+2Im5CKMx+aEkCRa5cDANBgkqhkiG9w0BAQUFAAOCAQEAO5uPVpsw51OZfHp5
p02X1xmVkPsGH8ozfEZjj5ZmJPpAGyEnyuZyc/JP/jGZ/cgMTGhTxoCCE5j6tq3aXT3xzm72
FRGUggzuP5WvEasP1y/eHwOPVyweybuaGkSV6xhPph/NfVcQL5sECVqEtW7YHTrh1p7RbHle
eRwUxePQTJM7ZTzt3z2+puWVGsO1GcO9Xlu7/yPvaBnLEpMnXAMtbzDQHrYarN5a99GqqCem
/nmBxHmZM1e6ErCp4EJsk8pW3v5thAsIi36N6teYIcbz5zx5L16c0UwVjeHsIjfMmkMLl9yA
kI2zZ5tvSAgVVs+/8St8Xpp26VmQxXyDNRFlUTGCAlIwggJOAgEBMIG7MIGlMQswCQYDVQQG
EwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0
L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAxMCBF
bnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENBAhEAtK6a
bGdPAPEAAAAATD0tHTANBglghkgBZQMEAgEFAKBpMC8GCSqGSIb3DQEJBDEiBCBErExEYe96
vrn1OR2z7WSvustUzZWEQ1szCLrLS+CH+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNDAxMjUxNjQzMjZaMA0GCSqGSIb3DQEBAQUABIIBAHihl52hB65b
x+3IypDfB6bAjvlk5nt03G0/nn6bfMpv1/cUcJtJ0626m6A2hgYKkuzIT5ivt7Jy1hPnYGQO
LuiWN2sp67zvIfXx6sROvS8IoQvdKJz0LtYnw0u3ygT2JN600wIZ5y8d8299XRVmJLZ0bArL
+MwhSALYjiE7Qyq6bwKA5RS994MQvANRClRD3OoLCG9RKw5+C0U/6T0B/zKyoZ/fQ2fAkI8p
LnbRt8uTJs6FFq/wFy5SMcVpZNdQGHJj00O28K3n7ywF1XQSbHZ39x3DXND1WQ29gBhFQFX5
7C8bVwQ62bK7oEmwOggvyWeflojTEi3KPBezbyolFsI=

--B_3789017006_1934067362--
