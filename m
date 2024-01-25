Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990D130E26
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200580; cv=none; b=V+e5uOJBJ/gA9FrZgUTB7FiS9nNVyuANusgvuWx6bSV7606drjH1Z3vvtiDw1Og7IM0sW06Xn77MibkHuEIKRBDjZ+bfeNpJ/T4RGffEejtWNE/to2WkR5/dMCOSbOZpAC4xpgWuqYFBXCEJuAnxpBm/Ijq0jRsgxVHEg80ZDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200580; c=relaxed/simple;
	bh=gj9QyVwLACPKUapJSB0hQ3GEdA6HJuWrtLZLV4WRNcs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWwfmWD/8FarGDcmG+NMO111CbHr61ZIdx24mbtY8uHUt46pN/AnWT2V5zru+xw3z1hSx2C4eGToVCO9ZIgTCv9VXfweIn2pWpkrh80P5NEvFqNHgqRwAM52153pGcugdtQwxMrxc7c/vS2Co5x6wC69ej1nKUj3XoZE8TDE3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=wunyVlqM; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="wunyVlqM"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PB4ukP024441;
	Thu, 25 Jan 2024 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=default; bh=/f/OxV1EUemcYTr/SSdou4
	uIaSmZQLHC13MwLnXWydY=; b=wunyVlqM9Ci7cMddM6kvdQfkZDFQ3o9W3hHB+5
	mTG/3d5uqquJkCIIBm0lziwPkmlgt51KcjRwgnENj92ff1T5Wi7rTKy/TUS5ZNWv
	mWVGEOnn7tvTHSZBHVRthOHs07DINTnFnj7gAibkZaI/AzNfltGu5c9uocnHVXSU
	nBG/uWEbxSw6DqWNUEKgnRqy8agSokfRWb5I65GxDXpziARBDZPiklZ8z/0tLqdC
	zgXnZVOxExBosdsxds8Q45S3XJH9arcWw/a5I0UWzikEgVMAPqSn97sHzc5TLoAN
	lU1fGqTJDLw7ZgdFhaWxstdSIs+piSW4a328wkCkUHO3f7kg==
Received: from 04wpexch09.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3vtmgbwvwq-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 16:36:15 +0000 (GMT)
Received: from 04WPEXCH10.crowdstrike.sys (10.100.11.114) by
 04WPEXCH09.crowdstrike.sys (10.100.11.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 25 Jan 2024 16:36:14 +0000
Received: from 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a]) by
 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a%18]) with mapi id
 15.02.1258.027; Thu, 25 Jan 2024 16:36:14 +0000
From: Ben Smith <ben.smith@crowdstrike.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [External] Re: security_file_free contract/expectations
Thread-Topic: [External] Re: security_file_free contract/expectations
Thread-Index: AQHaTx+CJtwzlPzBJkmVkqGorohTxbDpuZEAgAB7S4A=
Date: Thu, 25 Jan 2024 16:36:14 +0000
Message-ID: <7AB8E172-B359-4A3E-80E3-CCF225FECACB@crowdstrike.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
 <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
In-Reply-To: <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-disclaimer: USA
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha256; boundary="B_3789016573_478913554"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: QkMZdUEWXM3FLTeSXsMnFoeFuGoJN3Kn
X-Proofpoint-GUID: QkMZdUEWXM3FLTeSXsMnFoeFuGoJN3Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=798
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250117

--B_3789016573_478913554
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

Hi Casey,
Thanks for the clarification, that's very helpful.

=EF=BB=BFOn 1/24/24, 5:15 PM, "Casey Schaufler" <casey@schaufler-ca.com <mailto:c=
asey@schaufler-ca.com>> wrote:

> The only action that should take place in a _file_free() hook is to manag=
e
> resources used by the LSM. That could involve a kfree() of the module's
> blob, or some other memory management operation. Trying to access a file
> from this hook is a bad idea.

Yes, based on where it's called in do_exit(), makes sense. It didn't seem r=
easonable to me that a process=20
should do anything complicated after several fields of the task struct have=
 been freed.


--B_3789016573_478913554
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
bGdPAPEAAAAATD0tHTANBglghkgBZQMEAgEFAKBpMC8GCSqGSIb3DQEJBDEiBCDTYKb6QLdG
k2n/UHVGD8I+JeUSbelKs0/mcc/Z5GulVjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNDAxMjUxNjM2MTNaMA0GCSqGSIb3DQEBAQUABIIBAJKa03G144On
WowyHDJhyopAUyOB+5JV4IMf+wJrI5JTfATtYq2iu0KbGjGhSYWGbXuMsyW97kKaLkHV6x/M
1euIDA8cYDMTv7eYFA9uUp1c1QNeywXh4IV8IRzDuGVNVvBEQSl5CSk9Tdpo6RTxCRYvGLau
LCeyglkOLQy3sWoeBvSxsLnG8ruMJW4HOOT2pVD7BSD33fN4CCBbs8QNgo5gTr+fneGuPhTq
s/DbHAIUZLflqCFBx3OHQy7Qz6lLKSEp6utHfKrN/yOoMStdVkvdDTpcGSjl3AY5SnYQMlcN
EJ6so/88McwwiB9ZBulEFKSFAEIlpb/xp1Gj1EBmnbM=

--B_3789016573_478913554--
