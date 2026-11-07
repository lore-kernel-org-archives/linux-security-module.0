Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025464;
	b=kBu8YQgEckcib0NVDXDFOWxzKeF6trvyy05LnA7FttjFF/uGIp/23SNG2L3/5W4yxYe6
	 PqY8zZ1GfBe9MuuLkZczwOZ31Sf1Vr0pcAcevblNR73S5f3+lGP2oPJCscSTJbmTac+Kv
	 RmwU1UTqHoSYhs6pe+FaDEdl/uADzU67drquYRup3JZaVScXX/m/1TYFdysAZNEfyvGAT
	 r3/wkCBZXiVGHqre9qDomeNCImtpqd0IGBHYcKjgNVCtQX92Uq/ta992PsXHqYxbkWoE8
	 3Z65G50N6XmGETeuTaZIqEK+pp/KJxcUT4RqyAnporcfiFodXlUj90ch5+t/G7oiigA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025464;
	h=DMARC-Filter:DKIM-Signature:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-QQ-SSF:
	 X-QQ-FEAT:X-QQ-BUSINESS-ORIGIN:X-QQ-Originating-IP:X-Originating-IP:
	 X-QQ-STYLE:X-QQ-mid:From:To:Cc:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:X-BIZMAIL-ID:X-Address-Ticket:X-QQ-SENDSIZE:
	 Received:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9YqqDQ4nWUJGjuvRRPj7Hy0iZQgCFYzVepuwUpP5aZM=;
	b=p0PKnCJY++8Mr6yaw2LxTC9vsbqykngyPLTngj55/HmfEdiCxgW2lio3t5eaW1sdrOaT
	 /QypXtO8j6IWLuTBnBsDAMMcsTGM3NBr1REnJwfye4jlRioOYBuZ6kTce7t0J6k6ZRzbE
	 sAx4pawQs4IgLrYr/wuw1QfKDBChWbk6jplmkzD8Dm1xAY46Llr8G7djhELfCVyaOzM+J
	 uDF/2SmU0F7ygtWEqb1h29IAi0lCc1r83mkhcbg0NejTaSf7gkYzvCCPpuU/FzAjA/tx9
	 b0jiVVZntRXgPRPQMHqJxjpZ1w/RoR8LBPPCl7fTQEOi+kGyuCtTmqjP4vKBQFQFQ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sustech.edu.cn;
	spf=pass smtp.mailfrom=mail.sustech.edu.cn;
	dkim=pass header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b="nRQ86W//";
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B9606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 04:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sustech.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sustech.edu.cn header.i=@mail.sustech.edu.cn header.a=rsa-sha256 header.s=oemc2211 header.b=nRQ86W//
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.sustech.edu.cn;
	s=oemc2211; t=1794025419;
	bh=9YqqDQ4nWUJGjuvRRPj7Hy0iZQgCFYzVepuwUpP5aZM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=nRQ86W//E4xtZHJxRgDdeIVoDFlQlFtDW/52367SQqNuTjXPad0luQCcYN4IJ3+f9
	 bEkezTPV9yNkbtII1/R7uGcEOOKP6keLFx2u/zSFZnkejnlHNeE8xIqaUDeR62tpkK
	 x75yA2Wd2pBwWVd3kNC4VInPzhnwXP+4vyXAghW8=
EX-QQ-RecipientCnt: 4
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT5O6woayF/e4a5Q3Hc6xeqNi5U4KBjHQ0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: y1pTrWaXJ69znddeVKamNwrUL+VqHCdqoBGJ+BsxnInf1C1HUVfqvSfmyn6SfXJH
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-0t1794025415tdbfbd338
From: "=?utf-8?B?U2hpIExlY3Vu?=" <shilc2025@mail.sustech.edu.cn>
To: "=?utf-8?B?bWlj?=" <mic@digikod.net>, "=?utf-8?B?Z25vYWNr?=" <gnoack@google.com>
Cc: "=?utf-8?B?bGludXgtc2VjdXJpdHktbW9kdWxl?=" <linux-security-module@vger.kernel.org>, "=?utf-8?B?5byg6ZSL5beNKFpIQU5HIEZlbmd3ZWkp?=" <zhangfw@sustech.edu.cn>
Subject: [RFC] landlock: clarify signal scoping for pre-existing f_owner registrations
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 7 Nov 2026 12:23:35 +0800
X-Priority: 3
Message-ID: <tencent_1D938EDA50BCDB080CFADC6A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 13196135461290695597
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 07 Nov 2026 12:23:36 +0800 (CST)
Feedback-ID: lv:mail.sustech.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NDtUtlvFer7voKt1JAR4yK7T6t7qbkoLeph77xdGmz/N08vXfot1gKop
	2v2jOiFgiidWADsTg6a6EAhMvc+DUI7eFPDCZZz4XZYyJD7IZjepXWEqaRbHvHa2+M/n2kA
	1Z0CHtMojzIyTFtn5sx+jcWBfEOnoFVL5oFGIiRLydnZ37yS0A1wIjDXHlOwqcpEkRHy/ZK
	ZLDksCCt1PMmFlgx4VrJ3SkjYt2HMgDX8eBsx2HSGW6Xyp6Dm26XRrH6PoNyIf7uk9EaFtW
	CQVc6jehjKOqEgy7juKQyqhK6/QXbuoIeHE5Ke60PLwyFj4aFxWcWzH9FCX5nCiZkGUydj1
	Y30XtHKFNBfAd8shgsnYGU+/1qmRyDGjE7hCeCdLfCh+YVeAxFrYgbodAgQMPh+7YVSIlJj
	/WZwp9BPVEHj3KS2nUUotqKw3sHaszGjaQPLQZX2unx/vl95jUzaEsdbbO3Vh6lou7M4YJK
	YYynTv+noA5XSH1eoRNj7IG4aCjm1BCmSSUVFjGrASHLEiV4zhSmOegKM4rpUq7R4mDhUjH
	KS6lSBbMktzDDiQ4mA/y6zdnqqkJftFInY8QrD9FRd8umbOBFe3Wtt0Q5fJ5ufE5HmHLedp
	6dMHKjAnw4PHbNHjp3oVCigaO5CprldE4Yrw4n0KSQTJkpQTmBFhYbVbykY7h+5qEu5Ldw4
	C1yy7V7pAPvRgZZz4UB1wSZH8Ml0iXEYBIUlvMW+n/1nNBhAJNsCv5MWsnSqrTDwIh+DMwD
	4Z3kgOiH2ASFqG8mxKk1fqR9pu0Rr+Rc/J9iXC1IGgE+jMJznMuJKP4WWEMfu33dV6VF0S0
	mUh8UOT7ePDpcaLsvk0v70tOek1GB/oDsEnQ/2vXH5vUjvfx/Jk63TiiSrybwovN0wv0ogt
	85Fujar6L7xcwzUCDgJhForjZI1ZzK0n2dMZFO6a426k1nFVLVYfgiPQ5O6gLtiG0fkPNwG
	zGgL7zYLOnh5jrbZ5t2qmuOB15HN10c9pWaKNGG1eP8KF/SRN70mioKZIFW2WpvFeXXE=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

SGkgTWlja2HDq2wgYW5kIEfDvG50aGVyLA0KDQpXaGlsZSBpbnZlc3RpZ2F0aW5nIExBTkRM
T0NLX1NDT1BFX1NJR05BTCwgSSBub3RpY2VkIHRoYXQgdGhlIGN1cnJlbnQNCmRvY3VtZW50
YXRpb24gZG9lcyBub3QgZGVzY3JpYmUgaG93IHNpZ25hbCBzY29waW5nIGludGVyYWN0cyB3
aXRoDQphc3luY2hyb25vdXMgbm90aWZpY2F0aW9ucyByZWdpc3RlcmVkIGJlZm9yZSB0aGUg
c2NvcGUgaXMgZW5mb3JjZWQuDQoNCkEgbWluaW1hbCByZXByb2R1Y2VyIHBlcmZvcm1zIHRo
ZSBmb2xsb3dpbmcgc3RlcHMgYXMgYW4gdW5wcml2aWxlZ2VkIHVzZXI6DQoNCjEuIENyZWF0
ZSBhIHBpcGUgYW5kIHVzZSBmY250bChGX1NFVE9XTikgdG8gc2VsZWN0IGEgc2FtZS1VSUQg
cHJvY2Vzcw0KICAgb3V0c2lkZSB0aGUgZnV0dXJlIExhbmRsb2NrIGRvbWFpbiBhcyB0aGUg
bm90aWZpY2F0aW9uIHJlY2lwaWVudC4NCjIuIENvbmZpZ3VyZSBGX1NFVFNJRyBhbmQgT19B
U1lOQy4NCjMuIEFkZCBhIExhbmRsb2NrIGxheWVyIGhhbmRsaW5nIExBTkRMT0NLX1NDT1BF
X1NJR05BTC4NCjQuIFdyaXRlIHRvIHRoZSBwaXBlLg0KDQpUaGUgY29uZmlndXJlZCBzaWdu
YWwgaXMgc3RpbGwgZGVsaXZlcmVkIHRvIHRoZSBvdXQtb2YtZG9tYWluIHByb2Nlc3MuDQpV
c2luZyBGX1NFVFNJRyhTSUdLSUxMKSBtYWtlcyB0aGlzIGVzcGVjaWFsbHkgdmlzaWJsZSBi
eSB0ZXJtaW5hdGluZyB0aGUNCnJlY2lwaWVudC4gIEluIGNvbnRyYXN0Og0KDQotIGtpbGwo
MikgYWZ0ZXIgZW5mb3JjaW5nIExBTkRMT0NLX1NDT1BFX1NJR05BTCBmYWlscyB3aXRoIEVQ
RVJNOw0KLSByZWdpc3RlcmluZyBmX293bmVyIGFmdGVyIGVuZm9yY2luZyB0aGUgc2NvcGUg
ZG9lcyBub3QgcmVzdWx0IGluDQogIG91dC1vZi1kb21haW4gc2lnbmFsIGRlbGl2ZXJ5Lg0K
DQpJIHJlcHJvZHVjZWQgdGhpcyBtYXRyaXggb24gNy4yLjE0LWFyY2gxLTEgd2l0aCBMYW5k
bG9jayBBQkkgMTAgYXMgVUlEDQoxMDAwOg0KDQogIGRpcmVjdCBraWxsIGFmdGVyIHNjb3Bl
ICAgICAgdmljdGltIHN1cnZpdmVzDQogIHBvc3Qtc2NvcGUgRl9TRVRPV04gICAgICAgICAg
dmljdGltIHN1cnZpdmVzDQogIHByZS1zY29wZSBGX1NFVE9XTiAgICAgICAgICAgdmljdGlt
IHJlY2VpdmVzIFNJR0tJTEwNCiAgRlMgbGF5ZXIsIEZfU0VUT1dOLCBzY29wZSAgICB2aWN0
aW0gcmVjZWl2ZXMgU0lHS0lMTA0KDQpJIGFsc28gaW5zcGVjdGVkIGEgbG9jYWwga2VybmVs
IHRyZWUgYXQgY29tbWl0IGQ2OGNlNGU3MTI0OC4NCkZyb20gc2VjdXJpdHkvbGFuZGxvY2sv
ZnMuYyBhbmQgc2VjdXJpdHkvbGFuZGxvY2svdGFzay5jLCBteQ0KdW5kZXJzdGFuZGluZyBp
cyB0aGF0IGhvb2tfZmlsZV9zZXRfZm93bmVyKCkgc2F2ZXMgdGhlIGFwcGxpY2FibGUNCkxh
bmRsb2NrIHN1YmplY3Qgd2hlbiBGX1NFVE9XTiBpcyBjYWxsZWQsIGFuZA0KaG9va19maWxl
X3NlbmRfc2lnaW90YXNrKCkgbGF0ZXIgY2hlY2tzIGRlbGl2ZXJ5IHVzaW5nIHRoYXQgc2F2
ZWQNCnN1YmplY3QuICBJZiBubyBzaWduYWwtc2NvcGVkIGRvbWFpbiBhcHBsaWVkIGF0IHJl
Z2lzdHJhdGlvbiB0aW1lLCB0aGUNCnNhdmVkIGRvbWFpbiBpcyBOVUxMIGFuZCBsYXRlciBk
ZWxpdmVyeSBpcyBub3QgY2hlY2tlZCBhZ2FpbnN0IHRoZQ0KdHJpZ2dlcmluZyB0YXNrJ3Mg
bmV3bHkgYWRkZWQgZG9tYWluLiAgVGhlIHVzdWFsIFVJRC9FVUlEIGNoZWNrcyBpbg0Kc2ln
aW9fcGVybSgpIHN0aWxsIGFwcGx5Lg0KDQpUaGlzIGFsc28gYXBwZWFycyB0byBiZSBpbnRl
bnRpb25hbCBhbmQgY292ZXJlZCBieSB0aGUgZXhpc3RpbmcNCmZvd24vc2FuZGJveF9hZnRl
cl9zZXRvd24gdmFyaWFudCBpbg0KdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGFuZGxvY2sv
c2NvcGVkX3NpZ25hbF90ZXN0LmMsIHdoaWNoIGV4cGVjdHMgYQ0Kc2lnbmFsIHRvIGJlIHJl
Y2VpdmVkIHdoZW4gRl9TRVRPV04gaGFwcGVuZWQgYmVmb3JlIHNhbmRib3hpbmcuICBJDQp0
aGVyZWZvcmUgZG8gbm90IGNvbnNpZGVyIHRoaXMgYmVoYXZpb3IgaXRzZWxmIHRvIGJlIGEg
c2lnbmFsLXNjb3BlDQpieXBhc3MuDQoNCkhvd2V2ZXIsIERvY3VtZW50YXRpb24vdXNlcnNw
YWNlLWFwaS9sYW5kbG9jay5yc3QgY3VycmVudGx5IHNheXM6DQoNCiAgIlRoaXMgbGltaXRz
IHRoZSBzZW5kaW5nIG9mIHNpZ25hbHMgdG8gdGFyZ2V0IHByb2Nlc3NlcyB3aGljaCBydW4N
CiAgd2l0aGluIHRoZSBzYW1lIG9yIGEgbmVzdGVkIExhbmRsb2NrIGRvbWFpbi4iDQoNCldp
dGhvdXQgYSBsaWZlY3ljbGUgcXVhbGlmaWNhdGlvbiwgdGhpcyBjYW4gYmUgcmVhZCBhcyBj
b3ZlcmluZyBldmVyeQ0Kc2lnbmFsIGRlbGl2ZXJlZCBhZnRlciB0aGUgc2NvcGUgaXMgZW5m
b3JjZWQsIGluY2x1ZGluZyBub3RpZmljYXRpb25zDQp3aG9zZSBmX293bmVyIHdhcyByZWdp
c3RlcmVkIGVhcmxpZXIuICBUaGUgc2FtZSBzZWN0aW9uIGV4cGxpY2l0bHkNCmRvY3VtZW50
cyB0aGUgbGlmZXRpbWUgZXhjZXB0aW9uIGZvciBwcmV2aW91c2x5IGNvbm5lY3RlZCBVTklY
IHNvY2tldHMsDQpidXQgdGhlcmUgaXMgbm8gY29ycmVzcG9uZGluZyBleHBsYW5hdGlvbiBm
b3IgYXN5bmNocm9ub3VzIHNpZ25hbHMuDQoNCldvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYWRk
IGEgcGFyYWdyYXBoIGFsb25nIHRoZXNlIGxpbmVzPw0KDQogIEFzeW5jaHJvbm91cyBzaWdu
YWwgbm90aWZpY2F0aW9ucyBhc3NvY2lhdGVkIHdpdGggYSBmaWxlIG93bmVyLCBzdWNoDQog
IGFzIFNJR0lPIGFuZCBTSUdVUkcsIGFyZSBjaGVja2VkIHVzaW5nIHRoZSBMYW5kbG9jayBj
b250ZXh0IHNhdmVkDQogIHdoZW4gZmNudGwoRl9TRVRPV04pIHNldHMgdGhlIG5vdGlmaWNh
dGlvbiByZWNpcGllbnQuIEFkZGluZyBhDQogIExBTkRMT0NLX1NDT1BFX1NJR05BTCByZXN0
cmljdGlvbiBsYXRlciBkb2VzIG5vdCBhcHBseSB0aGF0IG5ldw0KICByZXN0cmljdGlvbiB0
byBub3RpZmljYXRpb25zIHVzaW5nIHRoZSBwcmV2aW91c2x5IHNhdmVkIGNvbnRleHQuDQog
IFNhbmRib3hlcyB0aGF0IHJlcXVpcmUgc2lnbmFsIGlzb2xhdGlvbiBzaG91bGQgdGhlcmVm
b3JlIGVuZm9yY2UNCiAgdGhlIHNjb3BlIGJlZm9yZSB1bnRydXN0ZWQgY29kZSBjYW4gcmVn
aXN0ZXIgYXN5bmNocm9ub3VzDQogIG5vdGlmaWNhdGlvbiByZWNpcGllbnRzLCBhbmQgYWNj
b3VudCBmb3IgYW55IHByZS1leGlzdGluZw0KICByZWdpc3RyYXRpb25zIG9uIHJldGFpbmVk
IGZpbGUgZGVzY3JpcHRvcnMuDQoNCkRvZXMgdGhpcyBhY2N1cmF0ZWx5IGRlc2NyaWJlIHRo
ZSBpbnRlbmRlZCB1c2Vyc3BhY2Ugc2VtYW50aWNzPw0KSWYgc28sIEkgd291bGQgYmUgaGFw
cHkgdG8gc2VuZCBhIGRvY3VtZW50YXRpb24gcGF0Y2ggZm9yIHRoZSBJUEMNCnNjb3Bpbmcg
c2VjdGlvbi4NCg0KVGhhbmtzLA0KU2hpIExlY3Vu

