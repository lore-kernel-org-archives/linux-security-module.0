Return-Path: <SRS0=+AtZ=WZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7FC3A5A3
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 14:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500F4233FF
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Aug 2019 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfH2O31 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:29:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbfH2O31 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Aug 2019 10:29:27 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5553D511E178AA7A3BC6;
        Thu, 29 Aug 2019 15:29:25 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 29 Aug 2019 15:29:22 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 29 Aug 2019 16:29:21 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 29 Aug 2019 16:29:22 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "Silviu Vlasceanu" <Silviu.Vlasceanu@huawei.com>
Subject: RE: [WIP][RFC][PATCH 1/3] security: introduce call_int_hook_and()
 macro
Thread-Topic: [WIP][RFC][PATCH 1/3] security: introduce call_int_hook_and()
 macro
Thread-Index: AQHVViDW5YMRZteMuEOBUyjsXXPlMKcCbYeAgA/QF/A=
Date:   Thu, 29 Aug 2019 14:29:22 +0000
Message-ID: <55aad0d1c30f455ca34229ee71855d20@huawei.com>
References: <20190818235745.1417-1-roberto.sassu@huawei.com>
 <20190818235745.1417-2-roberto.sassu@huawei.com>
 <4c13c8a7-e255-a3a8-c19a-cae85a71cae9@schaufler-ca.com>
In-Reply-To: <4c13c8a7-e255-a3a8-c19a-cae85a71cae9@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDYXNleSBTY2hhdWZsZXIgW21h
aWx0bzpjYXNleUBzY2hhdWZsZXItY2EuY29tXQ0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxOSwg
MjAxOSA0OjUyIFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5j
b20+OyBsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtc2Vj
dXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsgem9oYXJAbGludXguaWJtLmNvbTsgRG1pdHJ5
DQo+IEthc2F0a2luIDxkbWl0cnkua2FzYXRraW5AaHVhd2VpLmNvbT47IFNpbHZpdSBWbGFzY2Vh
bnUNCj4gPFNpbHZpdS5WbGFzY2VhbnVAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtXSVBd
W1JGQ11bUEFUQ0ggMS8zXSBzZWN1cml0eTogaW50cm9kdWNlIGNhbGxfaW50X2hvb2tfYW5kKCkN
Cj4gbWFjcm8NCj4gDQo+IE9uIDgvMTgvMjAxOSA0OjU3IFBNLCBSb2JlcnRvIFNhc3N1IHdyb3Rl
Og0KPiA+IFRoZSBMU00gaG9va3MgYXVkaXRfcnVsZV9rbm93bigpIGFuZCBhdWRpdF9ydWxlX21h
dGNoKCkgZGVmaW5lIDEgYXMNCj4gPiByZXN1bHQgZm9yIHN1Y2Nlc3NmdWwgb3BlcmF0aW9uLiBI
b3dldmVyLCB0aGUgc2VjdXJpdHlfIGZ1bmN0aW9ucyB1c2UNCj4gPiBjYWxsX2ludF9ob29rKCkg
d2hpY2ggc3RvcHMgaXRlcmF0aW5nIG92ZXIgTFNNcyBpZiB0aGUgcmVzdWx0IGlzIG5vdA0KPiA+
IHplcm8uDQo+ID4NCj4gPiBJbnRyb2R1Y2UgY2FsbF9pbnRfaG9va19hbmQoKSwgc28gdGhhdCB0
aGUgZmluYWwgcmVzdWx0IHJldHVybmVkIGJ5DQo+ID4gdGhlIHNlY3VyaXR5XyBmdW5jdGlvbnMg
aXMgMSBpZiBhbGwgTFNNcyByZXR1cm4gMS4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB3
aGF0IHlvdSB3YW50LiBZb3Ugd2FudCBhbiBhdWRpdCByZWNvcmQgZ2VuZXJhdGVkIGlmDQo+IGFu
eSBvZiB0aGUgc2VjdXJpdHkgbW9kdWxlcyB3YW50IG9uZSwgbm90IG9ubHkgaWYgYWxsIG9mIHRo
ZSBzZWN1cml0eSBtb2R1bGVzDQo+IHdhbnQgb25lLg0KDQpSaWdodCwgaXQgd291bGQgYmUgYmV0
dGVyIGlmIEkgY2FuIHNwZWNpZnkgdGhlIHByZWZpeCBvZiB0aGUgTFNNIHRoYXQgc2hvdWxkDQpl
eGVjdXRlIHRoZSBhdWRpdF9ydWxlX21hdGNoKCkgaG9vay4NCg0KRm9yIGV4YW1wbGUsIEkgd291
bGQgbGlrZSB0byBzcGVjaWZ5IGluIHRoZSBJTUEgcG9saWN5Og0KDQptZWFzdXJlIHN1YmpfdHlw
ZT1pbmZvZmxvdzp0Y2INCg0KJ2luZm9mbG93OnRjYicgd291bGQgYmUgdGhlIHZhbHVlIG9mIHRo
ZSAnbHNtcnVsZScgcGFyYW1ldGVyIG9mDQpzZWN1cml0eV9hdWRpdF9ydWxlX21hdGNoKCkuDQoN
ClRoZSBydWxlIHdvdWxkIGJlIGV2YWx1YXRlZCBvbmx5IGJ5IEluZm9mbG93IExTTSwgYW5kIG5v
dCBTRUxpbnV4Lg0KDQpSb2JlcnRvDQo=
