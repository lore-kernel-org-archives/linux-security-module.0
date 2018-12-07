Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA9C07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 10:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92322083D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 10:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92322083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGKMx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:12:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:47106 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGKMx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 05:12:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 02:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="107729537"
Received: from pgsmsx113.gar.corp.intel.com ([10.108.55.202])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2018 02:12:48 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 pgsmsx113.gar.corp.intel.com ([169.254.6.24]) with mapi id 14.03.0415.000;
 Fri, 7 Dec 2018 18:12:47 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q2qOY85E2yP0iMCMEcgHQzx6VtyUwAgAAF2oCAAkbYAIAA+K6AgAA8awCAAUJNgA==
Date:   Fri, 7 Dec 2018 10:12:47 +0000
Message-ID: <1544177563.28511.34.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <20181204092550.GT11614@hirez.programming.kicks-ass.net>
         <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
         <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
         <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
         <a0a1e0d2-ef32-8378-5363-b730afc99c03@intel.com>
In-Reply-To: <a0a1e0d2-ef32-8378-5363-b730afc99c03@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.4.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <264AF63BF61AEB4393D5F647FD78AFC8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDA2OjU5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvNi8xOCAzOjIyIEFNLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiBXaGVu
IHlvdSBzYXkgImRpc2FibGUgZW5jcnlwdGlvbiB0byBhIHBhZ2UiIGRvZXMgdGhlIGVuY3J5cHRp
b24gZ2V0DQo+ID4gPiBhY3R1YWxseSBkaXNhYmxlZCBvciBkb2VzIHRoZSBDUFUganVzdCBkZWNy
eXB0IGl0IHRyYW5zcGFyZW50bHkgaS5lLg0KPiA+ID4gd2hhdCBoYXBwZW5zIHBoeXNpY2FsbHk/
DQo+ID4gDQo+ID4gWWVzLCBpdCBnZXRzIGRpc2FibGVkLiBQaHlzaWNhbGx5LiBJdCBvdmVycmlk
ZXMgVE1FIGVuY3J5cHRpb24uDQo+IA0KPiBJIGtub3cgTUtUTUUgaXRzZWxmIGhhcyBhIHJ1bnRp
bWUgb3ZlcmhlYWQgYW5kIHdlIGV4cGVjdCBpdCB0byBoYXZlIGENCj4gcGVyZm9ybWFuY2UgaW1w
YWN0IGluIHRoZSBsb3cgc2luZ2xlIGRpZ2l0cy4gIERvZXMgVE1FIGhhdmUgdGhhdA0KPiBvdmVy
aGVhZD8gIFByZXN1bWFibHkgTUtUTUUgcGx1cyBuby1lbmNyeXB0aW9uIGlzIG5vdCBleHBlY3Rl
ZCB0byBoYXZlDQo+IHRoZSBvdmVyaGVhZC4NCj4gDQo+IFdlIHNob3VsZCBwcm9iYWJseSBtZW50
aW9uIHRoYXQgaW4gdGhlIGNoYW5nZWxvZ3MgdG9vLg0KPiANCg0KSSBiZWxpZXZlIGluIHRlcm1z
IG9mIGhhcmR3YXJlIGNyeXB0byBvdmVyaGVhZCBNS1RNRSBhbmQgVE1FIHNob3VsZCBoYXZlIHRo
ZSBzYW1lIChleGNlcHQgTUtUTUUgbm8tDQplbmNyeXB0IGNhc2U/KS4gQnV0IE1LVE1FIG1pZ2h0
IGhhdmUgYWRkaXRpb25hbCBvdmVyaGVhZCBmcm9tIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uIGlu
IGtlcm5lbD8NCg0KVGhhbmtzLA0KLUthaQ==
