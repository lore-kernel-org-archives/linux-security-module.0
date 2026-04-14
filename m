Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A9179A3;
	Tue, 14 Apr 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181391; cv=none; b=WEyJKlUILQtiQ20UNrMGudd3Emf9qBCY5dH6IZQ5JYWEeEPGrf+JRL4VoXeYR1by6Adc6lwA5WB9wldGSgXqlnkH1KWJH1aDVpvK6Z4abxpAn2xquTewI4oIv2GjMiAH+dW9uD8dRudUOCiIf7M49QBtpt5iMriTU9Rh5pzuzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181391; c=relaxed/simple;
	bh=z70qOMwuFxY3BwhXdchW8kRNmOXxYHs9eRgPA/MoY0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A1XG5isBEJyG0iRHSkh3QaSpZjCWDhgI8Ibh2FYo4A6CmL3sflelQGPXg+odxtDHvrJGuP4+KBdE1UtB61RvCoHBwUVORo4iaD5NMGPts7TGwAuMWThi7rUUXZHo7NkJ48+dgNG2E8+OId0uUbHdRJi3q8SB9lje3FjLQkl0WCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fw7nx1tGszHnGhg;
	Tue, 14 Apr 2026 23:42:45 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A3A340571;
	Tue, 14 Apr 2026 23:42:59 +0800 (CST)
Received: from frapema500004.china.huawei.com (7.182.19.21) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 17:42:59 +0200
Received: from frapema500004.china.huawei.com ([7.182.19.21]) by
 frapema500004.china.huawei.com ([7.182.19.21]) with mapi id 15.02.1544.011;
 Tue, 14 Apr 2026 17:42:59 +0200
From: Roberto Sassu <roberto.sassu@huawei.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, syzbot
	<syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Subject: RE: [syzbot] Monthly lsm report (Apr 2026)
Thread-Topic: [syzbot] Monthly lsm report (Apr 2026)
Thread-Index: AQHczBbzYqG+p95dxkOg8D2q5hWY4LXer2CQ
Date: Tue, 14 Apr 2026 15:42:59 +0000
Message-ID: <515c2f60debe4d8c9122774b0125a8b2@huawei.com>
References: <69dde155.050a0220.3030df.004d.GAE@google.com>
 <CAHC9VhTO4z1oPnNK748oTU6H7FcnxL2yzbuqkEKAfsrDV2Rcig@mail.gmail.com>
In-Reply-To: <CAHC9VhTO4z1oPnNK748oTU6H7FcnxL2yzbuqkEKAfsrDV2Rcig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBGcm9tOiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBBcHJpbCAxNCwgMjAyNiAzOjU5IFBNDQo+IE9uIFR1ZSwgQXByIDE0LCAyMDI2IGF0IDI6NDji
gK9BTSBzeXpib3QNCj4gPHN5emJvdCtsaXN0ZTUwMDRlMDJkYWUxMzdiYmQzMzlAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbyBsc20gbWFpbnRhaW5lcnMv
ZGV2ZWxvcGVycywNCj4gPg0KPiA+IFRoaXMgaXMgYSAzMS1kYXkgc3l6Ym90IHJlcG9ydCBmb3Ig
dGhlIGxzbSBzdWJzeXN0ZW0uDQo+ID4gQWxsIHJlbGF0ZWQgcmVwb3J0cy9pbmZvcm1hdGlvbiBj
YW4gYmUgZm91bmQgYXQ6DQo+ID4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vdXBzdHJl
YW0vcy9sc20NCj4gPg0KPiA+IER1cmluZyB0aGUgcGVyaW9kLCAwIG5ldyBpc3N1ZXMgd2VyZSBk
ZXRlY3RlZCBhbmQgMCB3ZXJlIGZpeGVkLg0KPiA+IEluIHRvdGFsLCAzIGlzc3VlcyBhcmUgc3Rp
bGwgb3BlbiBhbmQgNDUgaGF2ZSBhbHJlYWR5IGJlZW4gZml4ZWQuDQo+ID4NCj4gPiBTb21lIG9m
IHRoZSBzdGlsbCBoYXBwZW5pbmcgaXNzdWVzOg0KPiA+DQo+ID4gUmVmIENyYXNoZXMgUmVwcm8g
VGl0bGUNCj4gPiA8MT4gOTUgICAgICBZZXMgICBJTkZPOiB0YXNrIGh1bmcgaW4gcHJvY2Vzc19t
ZWFzdXJlbWVudCAoMykNCj4gPg0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/
ZXh0aWQ9Y2I5ZTY2ODA3YmNiODgyY2QwYzUNCj4gPiA8Mj4gNjggICAgICBZZXMgICBwb3NzaWJs
ZSBkZWFkbG9jayBpbiBrZXlyaW5nX2NsZWFyICgzKQ0KPiA+DQo+IGh0dHBzOi8vc3l6a2FsbGVy
LmFwcHNwb3QuY29tL2J1Zz9leHRpZD1mNTViMDQzZGFjZjQzNzc2YjUwYw0KPiA+IDwzPiAzMSAg
ICAgIFllcyAgIElORk86IHRhc2sgaHVuZyBpbiBpbWFfZmlsZV9mcmVlICg0KQ0KPiA+DQo+ID4g
aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTgwMzYzMjZlZWJlN2QwMTQw
OTQ0DQo+IA0KPiBNaW1pLCBSb2JlcnRvLA0KPiANCj4gSWYgSSByZWNhbGwgY29ycmVjdGx5LCB3
ZSd2ZSBkaXNjdXNzZWQgdGhlIHByb2Nlc3MgbWVhc3VyZW1lbnQgaXNzdWUgYmVmb3JlLA0KPiBh
bmQgSSB0aG91Z2h0IGl0IHdhcyBiZWluZyByZXNvbHZlZC4gIFdoYXQgaXMgdGhlIGN1cnJlbnQg
c3RhdHVzIG9uIGEgZml4Pw0KPiANCj4gSSBkb24ndCByZWNhbGwgZGlzY3Vzc2luZyB0aGUgaW1h
X2ZpbGVfZnJlZSgpIGlzc3VlLCBidXQgaXQgbG9va3MgbGlrZSB0aGUgc3l6Ym90DQo+IHJlcG9y
dHMgZ28gYmFjayB0byAyMDI0OyBpcyB0aGVyZSBhIGZpeCB1bmRlciBkZXZlbG9wbWVudCBmb3Ig
dGhhdD8NCg0KSSBsb29rZWQgYXQgc29tZSBvZiB0aGUgcmVwb3J0cy4gTXkgaW1wcmVzc2lvbiAo
Y2FuIGJlIHdyb25nKSBpcyB0aGF0IHRoZQ0Kc3l6Ym90IHJlcG9ydCBpbnZvbHZlcyB1cyBhbHNv
IHdoZW4gYSBmaWxlc3lzdGVtIGdldHMgc3R1Y2suDQoNCkZvciBleGFtcGxlLCBpZiB5b3Ugc2Vl
Og0KDQpodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS90ZXh0P3RhZz1DcmFzaFJlcG9ydCZ4
PTE2MGRkYjAyNTgwMDAwDQoNClBJRCA2ODg3IGNhbm5vdCBwcm9ncmVzcyBiZWNhdXNlIGlpbnQt
Pm11dGV4IGlzIGxpa2VseSBoZWxkIGJ5IFBJRCA2ODk1Lg0KVGhlIGxhc3QgZnVuY3Rpb24gSSBz
ZWUgaW4gUElEIDY4OTUgaXMgaW9fc2NoZWR1bGUoKSB3aGljaCBzdWdnZXN0cyBtZQ0KdGhhdCB0
aGVyZSBpcyBhbiBJL08gd2FpdCB0aGF0IGNvdWxkIG5vdCBiZSBzYXRpc2ZpZWQuIFBJRCA2ODg4
IGNhbm5vdCBwcm9ncmVzcw0KYXMgd2VsbCBiZWNhdXNlIGlzIHdhaXRpbmcgZm9yIGpmc19nZXRf
YmxvY2soKSwgYnV0IFBJRCA2ODk1IGlzIHBhc3QgdGhhdA0KKHBvc3NpYmx5IGhvbGRpbmcgdGhl
IG5lZWRlZCBsb2NrKS4NCg0KU3VyZSwgaXQgaXMgcG9zc2libGUgdGhhdCB0aGVyZSBpcyBhIGxv
Y2sgaW52ZXJzaW9uIHRoYXQgSSBtaXNzZWQsIGJ1dCBJIGRpZG4ndA0KZmluZCBpdCB5ZXQuDQoN
ClJvYmVydG8NCg0KPiBUaGFua3MuDQo+IA0KPiA+IC0tLQ0KPiA+IFRoaXMgcmVwb3J0IGlzIGdl
bmVyYXRlZCBieSBhIGJvdC4gSXQgbWF5IGNvbnRhaW4gZXJyb3JzLg0KPiA+IFNlZSBodHRwczov
L2dvby5nbC90cHNtRUogZm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgc3l6Ym90Lg0KPiA+IHN5
emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5j
b20uDQo+ID4NCj4gPiBUbyBkaXNhYmxlIHJlbWluZGVycyBmb3IgaW5kaXZpZHVhbCBidWdzLCBy
ZXBseSB3aXRoIHRoZSBmb2xsb3dpbmcNCj4gY29tbWFuZDoNCj4gPiAjc3l6IHNldCA8UmVmPiBu
by1yZW1pbmRlcnMNCj4gPg0KPiA+IFRvIGNoYW5nZSBidWcncyBzdWJzeXN0ZW1zLCByZXBseSB3
aXRoOg0KPiA+ICNzeXogc2V0IDxSZWY+IHN1YnN5c3RlbXM6IG5ldy1zdWJzeXN0ZW0NCj4gPg0K
PiA+IFlvdSBtYXkgc2VuZCBtdWx0aXBsZSBjb21tYW5kcyBpbiBhIHNpbmdsZSBlbWFpbCBtZXNz
YWdlLg0KPiANCj4gLS0NCj4gcGF1bC1tb29yZS5jb20NCg==
