Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C71F60A
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210771; cv=none; b=RiGWC5WTw77FELkznwVutP5YOM1LQcWwmJFkibGQXA59afwcJwpCWVy+ITGfe1DLMvZEXjaQkkEj3sWpSky0PmQ0zRLA7KYNF/6C6ros1uCZvoJoHJxv+m29AWkM0AEaDg8mCJ1cZhv533EIhyEJj3NjulJbSYt+4j2bkKA6N2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210771; c=relaxed/simple;
	bh=3Q/ZcHDrWyAzzv1RLYX9nWZ46WtY2ZEJSYuoevJer9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cpxjBmJ+h16QLvfmd6wkySfqkbJLPU3CMHwAPQeO/tteAovEVStgR05XAh4PA42sMWahzqJS2OdS8xDqkeqCzal8QkQfrN4BVLtRLCpuFvAZsi8Pcribb7vB4u5FiVoOCqgoX0n6yfWAR2J39uKuoxOv4IbYmQPtnnRlodBmekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gIogrE0W; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gIogrE0W"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PCWdRu009198;
	Thu, 25 Jan 2024 19:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=default; bh=7min9UJHTn36eInOdoUNpM
	ifJKbn1RIgo2bZS5t7bus=; b=gIogrE0WQEIEFus55n1UrpQ5ojdjVLH6dgrVV5
	nmNFGFAEKLX4RXuCWhj2kcb8iYj8bstANwgToguB1tyoP71efuL/x+N0CdgY4SP5
	0an3Rziw47vAMnRnttucSKW0Bw9Wwcn7BSIYEG7F6BVyHP6ez4MGVzxcIkS8YPiX
	UJoNzgQiA8772XgIEcOk5AnlJ+duniMZMXJS5GhAHFQwzRx3jRH9Fi+bVCE0EcLN
	LFmCGor7vKB0VspZ3b21yjS+uDYncPnR+lysPYKIcbXHk1dv8jYFPB32kgVEVaXW
	SYFtwl6zHdLpOqSsBPEliqFELLcmMw4DCD0RDS7qcDxEv2HQ==
Received: from 04wpexch09.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3vtmfs65ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 19:26:05 +0000 (GMT)
Received: from 04WPEXCH10.crowdstrike.sys (10.100.11.114) by
 04WPEXCH09.crowdstrike.sys (10.100.11.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 25 Jan 2024 19:26:04 +0000
Received: from 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a]) by
 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a%18]) with mapi id
 15.02.1258.027; Thu, 25 Jan 2024 19:26:04 +0000
From: Ben Smith <ben.smith@crowdstrike.com>
To: Paul Moore <paul@paul-moore.com>
CC: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: Re: [External] Re: security_file_free contract/expectations
Thread-Topic: [External] Re: security_file_free contract/expectations
Thread-Index: AQHaTx+CJtwzlPzBJkmVkqGorohTxbDqpYiA//+bF4CAAKOCAP//gC+A
Date: Thu, 25 Jan 2024 19:26:04 +0000
Message-ID: <1286AF3E-772D-4666-93DC-F9D4A57DF77C@crowdstrike.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
 <a8868907-91bb-4125-8f7a-79acd9c01f08@I-love.SAKURA.ne.jp>
 <66582C41-D44E-4270-9091-C153541D7311@crowdstrike.com>
 <CAHC9VhQo7NLqyPSacjVpwtFaW-_3YaHn=-N4qaik+z+9rY-ejA@mail.gmail.com>
In-Reply-To: <CAHC9VhQo7NLqyPSacjVpwtFaW-_3YaHn=-N4qaik+z+9rY-ejA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-disclaimer: USA
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha256; boundary="B_3789026763_4037289358"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: cIa_BMXwEJfro6Q6o1wT6Ags0MIAVo11
X-Proofpoint-ORIG-GUID: cIa_BMXwEJfro6Q6o1wT6Ags0MIAVo11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxlogscore=956 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250140

--B_3789026763_4037289358
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable


=EF=BB=BFOn 1/25/24, 11:03 AM, "Paul Moore" <paul@paul-moore.com <mailto:paul@pau=
l-moore.com>> wrote:

> I also want to make it clear that there are no guarantees that the LSM
> hooks you're concerned about won't change tomorrow; the kernel's
> stable ABI guarantee does not extend to the LSM hooks. If you, or
> your company, make the decision to support out-of-tree kernel code
> that relies on the LSM hooks, the expectation is that you will be
> shouldering the support burden yourself.

Yes, we're aware that this is not guaranteed to be stable. The question was=
 mainly=20
about existing kernels, which is what we have to support.
Unfortunately, it'll be a little while before we get to use any new hooks.


--B_3789026763_4037289358
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
bGdPAPEAAAAATD0tHTANBglghkgBZQMEAgEFAKBpMC8GCSqGSIb3DQEJBDEiBCC5LJlz/Vgb
ZaXNTt6/NjmCOqSmWtg8SOpdPaFCo4mLwjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNDAxMjUxOTI2MDNaMA0GCSqGSIb3DQEBAQUABIIBAAIJrxoF3rWY
SkjVHRIC6JZorkzbHxoBJkRyet2f8vKaoN6EtUQu0SJoPvHYLhl0mUMYbhVrwlSsGXRCL6et
PRwaC+DYK3zTONUjgqY1Ms9DOO9n5QLNP9VbZv56P0EH1C7f0z95agu65F7ev1bIRv4zWQty
WHK3N0p8BkHrEU84XVCrTNdgXlavsM0/yhGX1RlqfKzC4AMIb7Sv1PJPALLYOJyEmdk0T+Ly
0MADlsy5blbfr6EkhL+zDORBZBboGPS2diqcQszKDBP6ybmvP2K1Q+QxVreYdCpImSpaNTmm
Ea6LJKZyPDolpGsLwKOla47/mnaGdiVb1VeEUF2mbfI=

--B_3789026763_4037289358--
