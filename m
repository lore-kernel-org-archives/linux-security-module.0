Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692F79C7
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203106; cv=none; b=ewLCZvQh6+bDNbtY53g5FBpJSlVt0rhdzCAamftrNpO4HoBFEsUfnesF23kNGnR8yPH2MgqVlwDu1QFciQ8zUsrUOtpd7KdBn+rZDK9yUsUjhpEIaBPQUwglaOYDLSR/BLqXhtrdMVYW7KPa4Zr7Vn0zs89MM2uJbdgHUCN1JDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203106; c=relaxed/simple;
	bh=ivpfqfPKE/dD4qmKDbWWDAPNdwiuBQDWb7oafKy6oao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tLhehXw2TNfBE5Nf8XYuO/jbrgjNXA/ghr5PqyIEwyfPXd0VmMlV0u52tWt0sgNF6FiTUiV+jb6XPgSpvt5VIdqkNobsij/M1gCbP3mgVxKRe9et9GKW4KYZ520PAkxkr37wYSMaACXT7mB7pQgc1Agd/XQ0LPC472ARdYVljyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=visxMqKP; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="visxMqKP"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P6YAWd028341;
	Thu, 25 Jan 2024 17:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=default; bh=NQZv1iZdr8iLtV/IUqZ26A
	BVvFyHym9PhwcFrXVGkW8=; b=visxMqKPdyCEjmpEO3DfuuBvidH6aHGFaBjjkn
	z9vkpMlOR0b3VMNQquukAgRBP+IZaH04Utx5OXi0YrHmMkEGeFFmuK65KBSQr7Ko
	o0Dlc3dtvAMfNOYTw2sTBurljBXDaufPZT1qn7JGN+RV/OK4yiZKKS+CwRh446gk
	a/HovrV2Dktk+EXpPF5mDY603sftWbBAzPf/5vfGwVeXdVrO+l0hMmFJDvUitWcS
	7N5HDiYw7DZwJ6HHaj0B2FmfrDu1Q3PAawtIr2FzMbLdKyMcq6TLLQXqetkebG3a
	VUwPjrGQjmGGzS0l1WUva1fNsNmAyZ9SRmQzOreyBc63Z5sQ==
Received: from 04wpexch09.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3vujfahhtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 17:18:21 +0000 (GMT)
Received: from 04WPEXCH10.crowdstrike.sys (10.100.11.114) by
 04WPEXCH09.crowdstrike.sys (10.100.11.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 25 Jan 2024 17:18:20 +0000
Received: from 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a]) by
 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a%18]) with mapi id
 15.02.1258.027; Thu, 25 Jan 2024 17:18:20 +0000
From: Ben Smith <ben.smith@crowdstrike.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [External] Re: security_file_free contract/expectations
Thread-Topic: [External] Re: security_file_free contract/expectations
Thread-Index: AQHaTx+CJtwzlPzBJkmVkqGorohTxbDqpYiA//+bF4A=
Date: Thu, 25 Jan 2024 17:18:20 +0000
Message-ID: <66582C41-D44E-4270-9091-C153541D7311@crowdstrike.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
 <a8868907-91bb-4125-8f7a-79acd9c01f08@I-love.SAKURA.ne.jp>
In-Reply-To: <a8868907-91bb-4125-8f7a-79acd9c01f08@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-disclaimer: USA
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha256; boundary="B_3789019099_1149296389"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: P7qcLqeNYaPPxUj2BkDi1jml4MTQlmFC
X-Proofpoint-GUID: P7qcLqeNYaPPxUj2BkDi1jml4MTQlmFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250123

--B_3789019099_1149296389
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable



=EF=BB=BFOn 1/25/24, 7:19 AM, "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp =
<mailto:penguin-kernel@I-love.SAKURA.ne.jp>> wrote:

> I guess the out-of-tree filesystems are used by CrowdStrike products and
> therefore the source code etc. cannot be shared. (It took me 2 years to p=
rove
> that an out-of-tree filesystem used by TrendMicro products was the culpri=
t.)
> But are you sure that the location that triggered panic is at reading cur=
rent->fs ?

Yes, unfortunately the source can't be shared. From the stack I can see tha=
t the NULL dereference does
not happen in crowdstrike code, it happens in mvfs (Clearcase MVFS), which =
I do
not have sources for. From crash analysis I'm pretty confident that mvfs ac=
cessing
current->fs led to the crash.

> security_file_free() is not meant for reading files. But if the location =
were
> really at reading current->fs, whether an LSM shouldn't try to read a fil=
e from
> security_file_free() is a bogus question.

The underlying filesystem, as part of reading files appears to use current-=
>fs
(I assume it's looking up something about the calling process since it's a
versioned file system). So, my question was who is doing something unusual =
here?=20
Is it the LSM in opening a file in the context of a partially freed task or=
 the=20
filesystem in blindly using a field of the task struct without checking whe=
ther it's NULL.=20

> security_file_release() proposed by Roberto Sassu would be OK. But I gues=
s that
> the kernel version you want to load the out-of-tree filesystems is not th=
e latest...

> Without more details, we can't give you appropriate suggestions.

My feeling was that reading a file from security_file_free() was not a good=
 idea
but I wanted to clarify expectations and make sure I wasn't making an incor=
rect assumption.
Casey's reply cleared that up for me, so I've got what I need and have a pa=
th forward.




--B_3789019099_1149296389
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
bGdPAPEAAAAATD0tHTANBglghkgBZQMEAgEFAKBpMC8GCSqGSIb3DQEJBDEiBCCNpToXCESh
bfDaIJqsS/z3z2dMYqaFOqiwCnMxpkjIPDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNDAxMjUxNzE4MTlaMA0GCSqGSIb3DQEBAQUABIIBAG+EQzboCLyw
Rzqf4YJ5XVlaUoqk6/w/62W+zuXqq4mxRmOGXvjycl6qonhXaaIEz5bzTquug7N+z7fDbqGY
NlIfiJMXqp2G3lwezO76RBS6kdreX5U7qEqV347gthPNpIX2JZqE5HInBUWICaA4j0/VNMBI
zUPfrlOQwYEGP5DWkKHSl1eFl+lvmxlSL5V+PaT8fNFnrxRWjos9f55cyzYnXfyU/u3ihqVP
6/RhWJZSPjlRMZZRnElIGSx+zh8BP5GKQ6TBjV+8IZrZ6IIb9NhRcv25OFsaIhUBOlkbqq4/
ovdNPZe2pJeqtq3y8cD2wsLva9mXs2CNdNWOh0Ny16o=

--B_3789019099_1149296389--
