Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70931C04EB8
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 02:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A13C20659
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 02:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A13C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLGCOJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:14:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:32141 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 21:14:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 18:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="116350598"
Received: from pgsmsx103.gar.corp.intel.com ([10.221.44.82])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2018 18:14:04 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 PGSMSX103.gar.corp.intel.com ([169.254.2.155]) with mapi id 14.03.0415.000;
 Fri, 7 Dec 2018 10:14:03 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Thread-Topic: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline
 parameter allows
Thread-Index: AQHUi6Q+FLcfipNfvkq872i9E2VWC6VyB6KA
Date:   Fri, 7 Dec 2018 02:14:03 +0000
Message-ID: <1544148839.28511.28.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.4.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB6E020131D58E41934D899480F57993@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDIzOjM5IC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBNS1RNRSAoTXVsdGktS2V5IFRvdGFsIE1lbW9yeSBFbmNyeXB0aW9uKSBrZXkgcGF5bG9h
ZHMgbWF5IGluY2x1ZGUNCj4gZGF0YSBlbmNyeXB0aW9uIGtleXMsIHR3ZWFrIGtleXMsIGFuZCBh
ZGRpdGlvbmFsIGVudHJvcHkgYml0cy4gVGhlc2UNCj4gYXJlIHVzZWQgdG8gcHJvZ3JhbSB0aGUg
TUtUTUUgZW5jcnlwdGlvbiBoYXJkd2FyZS4gQnkgZGVmYXVsdCwgdGhlDQo+IGtlcm5lbCBkZXN0
cm95cyB0aGlzIHBheWxvYWQgZGF0YSBvbmNlIHRoZSBoYXJkd2FyZSBpcyBwcm9ncmFtbWVkLg0K
PiANCj4gSG93ZXZlciwgaW4gb3JkZXIgdG8gZnVsbHkgc3VwcG9ydCBDUFUgSG90cGx1Zywgc2F2
aW5nIHRoZSBrZXkgZGF0YQ0KPiBiZWNvbWVzIGltcG9ydGFudC4gVGhlIE1LVE1FIEtleSBTZXJ2
aWNlIGNhbm5vdCBhbGxvdyBhIG5ldyBwaHlzaWNhbA0KPiBwYWNrYWdlIHRvIGNvbWUgb25saW5l
IHVubGVzcyBpdCBjYW4gcHJvZ3JhbSB0aGUgbmV3IHBhY2thZ2VzIEtleSBUYWJsZQ0KPiB0byBt
YXRjaCB0aGUgS2V5IFRhYmxlcyBvZiBhbGwgZXhpc3RpbmcgcGh5c2ljYWwgcGFja2FnZXMuDQo+
IA0KPiBXaXRoIENQVSBnZW5lcmF0ZWQga2V5cyAoYS5rLmEuIHJhbmRvbSBrZXlzIG9yIGVwaGVt
ZXJhbCBrZXlzKSB0aGUNCj4gc2F2aW5nIG9mIHVzZXIga2V5IGRhdGEgaXMgbm90IGFuIGlzc3Vl
LiBUaGUga2VybmVsIGFuZCBNS1RNRSBoYXJkd2FyZQ0KPiBjYW4gZ2VuZXJhdGUgc3Ryb25nIGVu
Y3J5cHRpb24ga2V5cyB3aXRob3V0IHJlY2FsbGluZyBhbnkgdXNlciBzdXBwbGllZA0KPiBkYXRh
Lg0KPiANCj4gV2l0aCBVU0VSIGRpcmVjdGVkIGtleXMgKGEuay5hLiB1c2VyIHR5cGUpIHNhdmlu
ZyB0aGUga2V5IHByb2dyYW1taW5nDQo+IGRhdGEgKGRhdGEgYW5kIHR3ZWFrIGtleSkgYmVjb21l
cyBhbiBpc3N1ZS4gVGhlIGRhdGEgYW5kIHR3ZWFrIGtleXMNCj4gYXJlIHJlcXVpcmVkIHRvIHBy
b2dyYW0gdGhvc2Uga2V5cyBvbiBhIG5ldyBwaHlzaWNhbCBwYWNrYWdlLg0KPiANCj4gSW4gcHJl
cGFyYXRpb24gZm9yIGFkZGluZyBDUFUgaG90cGx1ZyBzdXBwb3J0Og0KPiANCj4gICAgQWRkIGFu
ICdta3RtZV92YXVsdCcgd2hlcmUga2V5IGRhdGEgaXMgc3RvcmVkLg0KPiANCj4gICAgQWRkICdt
a3RtZV9zYXZla2V5cycga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgdGhhdCBkaXJlY3Rz
DQo+ICAgIHdoYXQga2V5IGRhdGEgY2FuIGJlIHN0b3JlZC4gSWYgaXQgaXMgbm90IHNldCwga2Vy
bmVsIGRvZXMgbm90DQo+ICAgIHN0b3JlIHVzZXJzIGRhdGEga2V5IG9yIHR3ZWFrIGtleS4NCj4g
DQo+ICAgIEFkZCAnbWt0bWVfYml0bWFwX3VzZXJfdHlwZScgdG8gdHJhY2sgd2hlbiBVU0VSIHR5
cGUga2V5cyBhcmUgaW4NCj4gICAgdXNlLiBJZiBubyBVU0VSIHR5cGUga2V5cyBhcmUgY3VycmVu
dGx5IGluIHVzZSwgYSBwaHlzaWNhbCBwYWNrYWdlDQo+ICAgIG1heSBiZSBicm91Z2h0IG9ubGlu
ZSwgZGVzcGl0ZSB0aGUgYWJzZW5jZSBvZiAnbWt0bWVfc2F2ZWtleXMnLg0KDQpPdmVyYWxsLCBJ
IGFtIG5vdCBzdXJlIHdoZXRoZXIgc2F2aW5nIGtleSBpcyBnb29kIGlkZWEsIHNpbmNlIGl0IGJy
ZWFrcyBjb2xkYm9vdCBhdHRhY2sgSU1ITy4gV2UNCm5lZWQgdG8gdHJhZGVvZmYgYmV0d2VlbiBz
dXBwb3J0aW5nIENQVSBob3RwbHVnIGFuZCBzZWN1cml0eS4gSSBhbSBub3Qgc3VyZSB3aGV0aGVy
IHN1cHBvcnRpbmcgQ1BVDQpob3RwbHVnIGlzIHRoYXQgaW1wb3J0YW50LCBzaW5jZSBmb3Igc29t
ZSBvdGhlciBmZWF0dXJlcyBzdWNoIGFzIFNHWCwgd2UgZG9uJ3Qgc3VwcG9ydCBDUFUgaG90cGx1
Zw0KYW55d2F5Lg0KDQpBbHRlcm5hdGl2ZWx5LCB3ZSBjYW4gY2hvb3NlIHRvIHVzZSBwZXItc29j
a2V0IGtleUlELCBidXQgbm90IHRvIHByb2dyYW0ga2V5SUQgZ2xvYmFsbHkgYWNyb3NzIGFsbA0K
c29ja2V0cywgc28geW91IGRvbid0IGhhdmUgdG8gc2F2ZSBrZXkgd2hpbGUgc3RpbGwgc3VwcG9y
dGluZyBDUFUgaG90cGx1Zy4NCg0KVGhhbmtzLA0KLUthaQ==
