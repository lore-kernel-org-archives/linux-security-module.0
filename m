Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA10C04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D7320989
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeLFIyr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:54:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:41764 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFIyr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 03:54:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 00:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="107745055"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2018 00:54:44 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.79]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 08:54:42 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 10/13] keys/mktme: Add the MKTME Key Service type for
 memory encryption
Thread-Topic: [RFC v2 10/13] keys/mktme: Add the MKTME Key Service type for
 memory encryption
Thread-Index: AQHUi6Q5JnWIrpZPbkiPRmUuwjKRWKVxanuAgAAA4QA=
Date:   Thu, 6 Dec 2018 08:54:42 +0000
Message-ID: <e73fc3886a4a954bbc06b85e2da7728159cea9a7.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <42d44fb5ddbbf7241a2494fc688e274ade641965.1543903910.git.alison.schofield@intel.com>
         <a19a48ae1d6434a1764b02c2376a99130ce15174.camel@intel.com>
In-Reply-To: <a19a48ae1d6434a1764b02c2376a99130ce15174.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.207.188]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A158F3A3734834F8EAA294A3119720E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDAwOjUxIC0wODAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIE1vbiwgMjAxOC0xMi0wMyBhdCAyMzozOSAtMDgwMCwgQWxpc29uIFNjaG9maWVsZCB3
cm90ZToNCj4gPiBNS1RNRSAoTXVsdGktS2V5IFRvdGFsIE1lbW9yeSBFbmNyeXB0aW9uKSBpcyBh
IHRlY2hub2xvZ3kgdGhhdCBhbGxvd3MNCj4gPiB0cmFuc3BhcmVudCBtZW1vcnkgZW5jcnlwdGlv
biBpbiB1cGNvbWluZyBJbnRlbCBwbGF0Zm9ybXMuIE1LVE1FIHdpbGwNCj4gPiBzdXBwb3J0IG11
bGl0cGxlIGVuY3J5cHRpb24gZG9tYWlucywgZWFjaCBoYXZpbmcgdGhlaXIgb3duIGtleS4gVGhl
IG1haW4NCj4gPiB1c2UgY2FzZSBmb3IgdGhlIGZlYXR1cmUgaXMgdmlydHVhbCBtYWNoaW5lIGlz
b2xhdGlvbi4gVGhlIEFQSSBuZWVkcyB0aGUNCj4gPiBmbGV4aWJpbGl0eSB0byB3b3JrIGZvciBh
IHdpZGUgcmFuZ2Ugb2YgdXNlcy4NCj4gDQo+IFNvbWUsIG1heWJlIGJydXRhbCwgaG9uZXN0eSAo
YXBvbG9naWVzKS4uLg0KPiANCj4gSGF2ZSBuZXZlciByZWFsbHkgZ290IHRoZSBncmlwIHdoeSBl
aXRoZXIgU01FIG9yIFRNRSB3b3VsZCBtYWtlDQo+IGlzb2xhdGlvbiBhbnkgYmV0dGVyLiBJZiB5
b3UgY2FuIGJyZWFrIGludG8gaHlwZXJ2aXNvciwgeW91J2xsDQo+IGhhdmUgdGhlc2UgdG9vbHMg
YXZhaWxhYmU6DQo+IA0KPiAxLiBSZWFkIHBhZ2UgKGluIGVuY3J5cHRlZCBmb3JtKS4NCj4gMi4g
V3JpdGUgcGFnZSAoZm9yIGV4YW1wbGUgcmVwbGF5IGFzIHBhZ2VzIGFyZSBub3QgdmVyc2lvbmVk
KS4NCj4gDQo+IHdpdGggYWxsIHRoZSBzaWRlLWNoYW5uZWwgcG9zc2liaWxpdGllcyBvZiBjb3Vy
c2Ugc2luY2UgeW91IGNhbg0KPiBjb250cm9sIHRoZSBWTXMgKGluIHdoaWNoIGNvcmUgdGhleSBl
eGVjdXRlIGV0Yy4pLg0KPiANCj4gSSd2ZSBzZWVuIG5vdyBTTUUgcHJlc2VudGF0aW9uIHRocmVl
IHRpbWVzIGFuZCBpdCBhbHdheXMgbGVhdmVzDQo+IG1lIGFuIGVtcHR5IGZlZWxpbmcuIFRoaXMg
ZmVlbHMgdGhlIHNhbWUgc2FtZS4NCg0KSS5lLiBuZWVkIHRvIHRlbGwgdmVyeSBleHBsaWNpdGx5
IHRoZSBzY2VuYXJpbyB3aGVyZSB0aGlzIHdpbGwNCmhlbHAuIE5vdCBzYXlpbmcgdGhhdCB0aGlz
IHNob3VsZCByZXNvbHZlIGV2ZXJ5dGhpbmcgYnV0IGl0IG11c3QNCnJlc29sdmUgc29tZXRoaW5n
Lg0KDQovSmFya2tvDQo=
