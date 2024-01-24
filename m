Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFC7F
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141297; cv=none; b=Bwz1d1V5vipHn/oKt2gIYoq5mCfiWKWpEWrzBK11laSJzMmlD1JCx/qObSJWUtedkVdFSy8pzkHbAvZaiWbYqnMohBidWOaS5U53JVWJZAcouL4ceKqgLUT82fRjqK0Yg6J4RNZLLE+Ig3jDFfNZ1rT/H+jrUTCDBFQQlfLxBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141297; c=relaxed/simple;
	bh=obpX7lAVvPIt0JqJcEimGeThHjCjr1ohRGnXcRFcfWI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CuBZ/8+RS2YQ8krGpj5MEmCdb6l2pYS7WhCP7uqXMXP2YTyYEJ3iHC/A0qum9ohFJjQ2VWrQolFkWoJKF9Lr18lGqj7GYka8FMXfQR//QEE5VMvL2xExj9EzNrJSE3a/8GtFt8TI57T/XtSja0n+6T4bu8w3v9z9ZRCKkwE4Y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=n/kz1L0z; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="n/kz1L0z"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OKrTEG009106
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 23:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=default; bh=obpX7lAVv
	PIt0JqJcEimGeThHjCjr1ohRGnXcRFcfWI=; b=n/kz1L0zDu2v9Ty198lFx5jPD
	Y1CtIM8S3poO+fMnQBW0BvqxSDKK96bKFkePnBxClgu0bEEXfTcV8yTMB+Uh5e3A
	4i1RL9NI29FFKIFXShwK9P+yKA7fZ93VjNM5mh2wwRFyh8nHVeEW2aAlUnMceeez
	og4xwhjXqo02d/HiRDuGDTpgBgDqc5W7FCazPqhuJcw2vGGHKivWffNkUA2AfDhd
	c4qK3sPqOyTwmcpNYQthkxU2OMcamjariABltNNNij3UobT9+fekEGx2VnbvCKfx
	dil/0JAzY4fyFH/2WGQPmRo8VIwWkZ9dW56nSWeb1AcDcFmtRx1i7YqsADlbg==
Received: from 04wpexch09.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3vtmfs3hvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 23:46:13 +0000 (GMT)
Received: from 04WPEXCH10.crowdstrike.sys (10.100.11.114) by
 04WPEXCH09.crowdstrike.sys (10.100.11.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 24 Jan 2024 23:46:12 +0000
Received: from 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a]) by
 04WPEXCH10.crowdstrike.sys ([fe80::e1dd:44ef:2c43:70a%18]) with mapi id
 15.02.1258.027; Wed, 24 Jan 2024 23:46:12 +0000
From: Ben Smith <ben.smith@crowdstrike.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: security_file_free contract/expectations
Thread-Topic: security_file_free contract/expectations
Thread-Index: AQHaTx+CJtwzlPzBJkmVkqGorohTxQ==
Date: Wed, 24 Jan 2024 23:46:11 +0000
Message-ID: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75323AD4F45B646B3477B07E116FD02@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: prCtjp1Bb1BjHu8blBbLgoP7LqgI9nib
X-Proofpoint-ORIG-GUID: prCtjp1Bb1BjHu8blBbLgoP7LqgI9nib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxlogscore=657 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240172

SGksIEknbSBsb29raW5nIGF0IGEga2VybmVsIHBhbmljIGFuZCBJJ20gdHJ5aW5nIHRvIGZpZ3Vy
ZSBvdXQgd2hldGhlciB0aGUgY29kZSBpbiBxdWVzdGlvbiBpcyBkb2luZyBzb21ldGhpbmcgdGhh
dCBicmVha3MgdGhlIGNvbnRyYWN0IGZvciB0aGUgc2VjdXJpdHlfZmlsZV9mcmVlIGhvb2suIEkn
bSBzcGVjaWZpY2FsbHkgd29uZGVyaW5nIHdoZXRoZXIgaXQncyBleHBlY3RlZC9zYWZlIGZvciBj
b2RlIGNhbGxlZCBmcm9tIHNlY3VyaXR5X2ZpbGVfZnJlZSB0byBvcGVuIGFuZCByZWFkIGZyb20g
YSBmaWxlLiBJbiB0aGUgY2FzZSBJJ20gbG9va2luZyBhdCB3aGF0IGhhcHBlbnMgaXM6DQoNCi0g
UHJvY2VzcyBleGl0DQotIGV4aXRfZnMoKSBzZXRzIGN1cnJlbnQtPmZzIHRvIE5VTEwNCi0gZXhp
dF90YXNrX3dvcmsoKSBjYWxscyBfX2ZwdXQoKSBvbiBmaWxlcyB3aGljaCB3ZXJlIGNsb3NlZCBp
biBleGl0X2ZpbGVzKCkNCi0gX19mcHV0KCkgY2FsbHMgc2VjdXJpdHlfZmlsZV9mcmVlKCkNCi0g
c2VjdXJpdHlfZmlsZV9mcmVlKCkgdGhlbiByZWFkcyB0aGUgZmlsZSB0aGF0IHdhcyBqdXN0IGNs
b3NlZCBpbiBvcmRlciB0byBnYXRoZXIgaW5mb3JtYXRpb24gYWJvdXQgaXQuDQotIGEgZmlsZXN5
c3RlbSBkcml2ZXIgKEkndmUgc2VlbiB0aGlzIHdpdGggdHdvIG91dC1vZi10cmVlIGZpbGVzeXN0
ZW1zKSB0aGVuIGFjY2Vzc2VzIGN1cnJlbnQtPmZzIGFuZCBwYW5pY3MuDQoNClNvIEknbSB3b25k
ZXJpbmcgaWYgdGhlIGV4cGVjdGF0aW9uIGhlcmUgaXMgdGhhdCBmaWxlc3lzdGVtIGNvZGUgc2hv
dWxkIE5VTEwgY2hlY2sgY3VycmVudC0+ZnMgYmVmb3JlIHVzaW5nIGl0IG9yIHRoYXQgYW4gTFNN
IHNob3VsZG4ndCB0cnkgdG8gcmVhZCBhIGZpbGUgZnJvbSBzZWN1cml0eV9maWxlX2ZyZWUoKS4N
Cg0KDQo=
