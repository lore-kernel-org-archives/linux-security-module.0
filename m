Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA353C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68914208E7
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68914208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeLEWTZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:19:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:45357 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLEWTZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 17:19:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 14:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,319,1539673200"; 
   d="scan'208";a="125429911"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2018 14:19:22 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.134]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.79]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 22:19:21 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4A=
Date:   Wed, 5 Dec 2018 22:19:20 +0000
Message-ID: <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
In-Reply-To: <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.104]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0A385B248C0EA4EA1FC987E003E176F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDExOjE5IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IEknbSBub3QgVGhvbWFzLCBidXQgSSB0aGluayBpdCdzIHRoZSB3cm9uZyBkaXJlY3Rpb24u
ICBBcyBpdCBzdGFuZHMsDQo+IGVuY3J5cHRfbXByb3RlY3QoKSBpcyBhbiBpbmNvbXBsZXRlIHZl
cnNpb24gb2YgbXByb3RlY3QoKSAoc2luY2UgaXQncw0KPiBtaXNzaW5nIHRoZSBwcm90ZWN0aW9u
IGtleSBzdXBwb3J0KSwgYW5kIGl0J3MgYWxzbyBmdW5jdGlvbmFsbHkganVzdA0KPiBNQURWX0RP
TlRORUVELiAgSW4gb3RoZXIgd29yZHMsIHRoZSBzb2xlIHVzZXItdmlzaWJsZSBlZmZlY3QgYXBw
ZWFycw0KPiB0byBiZSB0aGF0IHRoZSBleGlzdGluZyBwYWdlcyBhcmUgYmxvd24gYXdheS4gIFRo
ZSBmYWN0IHRoYXQgaXQNCj4gY2hhbmdlcyB0aGUga2V5IGluIHVzZSBkb2Vzbid0IHNlZW0gdGVy
cmlibHkgdXNlZnVsLCBzaW5jZSBpdCdzDQo+IGFub255bW91cyBtZW1vcnksIGFuZCB0aGUgbW9z
dCBzZWN1cmUgY2hvaWNlIGlzIHRvIHVzZSBDUFUtbWFuYWdlZA0KPiBrZXlpbmcsIHdoaWNoIGFw
cGVhcnMgdG8gYmUgdGhlIGRlZmF1bHQgYW55d2F5IG9uIFRNRSBzeXN0ZW1zLiAgSXQNCj4gYWxz
byBoYXMgdG90YWxseSB1bmNsZWFyIHNlbWFudGljcyBXUlQgc3dhcCwgYW5kLCBvZmYgdGhlIHRv
cCBvZiBteQ0KPiBoZWFkLCBpdCBsb29rcyBsaWtlIGl0IG1heSBoYXZlIHNlcmlvdXMgY2FjaGUt
Y29oZXJlbmN5IGlzc3VlcyBhbmQNCj4gbGlrZSBzd2FwcGluZyB0aGUgcGFnZXMgbWlnaHQgY29y
cnVwdCB0aGVtLCBib3RoIGJlY2F1c2UgdGhlcmUgYXJlIG5vDQo+IGZsdXNoZXMgYW5kIGJlY2F1
c2UgdGhlIGRpcmVjdC1tYXAgYWxpYXMgbG9va3MgbGlrZSBpdCB3aWxsIHVzZSB0aGUNCj4gZGVm
YXVsdCBrZXkgYW5kIHRoZXJlZm9yZSBhcHBlYXIgdG8gY29udGFpbiB0aGUgd3JvbmcgZGF0YS4N
Cj4gDQo+IEkgd291bGQgcHJvcG9zZSBhIHZlcnkgZGlmZmVyZW50IGRpcmVjdGlvbjogZG9uJ3Qg
dHJ5IHRvIHN1cHBvcnQgTUtUTUUNCj4gYXQgYWxsIGZvciBhbm9ueW1vdXMgbWVtb3J5LCBhbmQg
aW5zdGVhZCBmaWd1cmUgb3V0IHRoZSBpbXBvcnRhbnQgdXNlDQo+IGNhc2VzIGFuZCBzdXBwb3J0
IHRoZW0gZGlyZWN0bHkuICBUaGUgdXNlIGNhc2VzIHRoYXQgSSBjYW4gdGhpbmsgb2YNCj4gb2Zm
IHRoZSB0b3Agb2YgbXkgaGVhZCBhcmU6DQo+IA0KPiAxLiBwbWVtLiAgVGhpcyBzaG91bGQgcHJv
YmFibHkgdXNlIGEgdmVyeSBkaWZmZXJlbnQgQVBJLg0KPiANCj4gMi4gU29tZSBraW5kIG9mIFZN
IGhhcmRlbmluZywgd2hlcmUgYSBWTSdzIG1lbW9yeSBjYW4gYmUgcHJvdGVjdGVkIGENCj4gbGl0
dGxlIHRpbnkgYml0IGZyb20gdGhlIG1haW4ga2VybmVsLiAgQnV0IEkgZG9uJ3Qgc2VlIHdoeSB0
aGlzIGlzIGFueQ0KPiBiZXR0ZXIgdGhhbiBYUE8gKGVYY2x1c2l2ZSBQYWdlLWZyYW1lIE93bmVy
c2hpcCksIHdoaWNoIGJyaW5ncyB0bw0KPiBtaW5kOg0KDQpXaGF0IGlzIHRoZSB0aHJlYXQgbW9k
ZWwgYW55d2F5IGZvciBBTUQgYW5kIEludGVsIHRlY2hub2xvZ2llcz8NCg0KRm9yIG1lIGl0IGxv
b2tzIGxpa2UgdGhhdCB5b3UgY2FuIHJlYWQsIHdyaXRlIGFuZCBldmVuIHJlcGxheSANCmVuY3J5
cHRlZCBwYWdlcyBib3RoIGluIFNNRSBhbmQgVE1FLiANCg0KL0phcmtrbw0K
