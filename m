Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9AC04EBF
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154A720989
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154A720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeLEUc5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:32:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:5055 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLEUc5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 15:32:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 12:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,319,1539673200"; 
   d="scan'208";a="299643404"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2018 12:32:53 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.134]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.253]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 20:32:52 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "jmorris@namei.org" <jmorris@namei.org>,
        "Huang, Kai" <kai.huang@intel.com>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVuT2gAgAAF2oCAAkbYgA==
Date:   Wed, 5 Dec 2018 20:32:52 +0000
Message-ID: <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <20181204092550.GT11614@hirez.programming.kicks-ass.net>
         <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
In-Reply-To: <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.241.224.239]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B43E6359905644D87CDFB12A5AC1B5F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDEyOjQ2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgRGVjIDA0LCAyMDE4IGF0IDA5OjI1OjUwQU0gKzAwMDAsIFBldGVyIFpp
amxzdHJhIHdyb3RlOg0KPiA+IE9uIE1vbiwgRGVjIDAzLCAyMDE4IGF0IDExOjM5OjQ3UE0gLTA4
MDAsIEFsaXNvbiBTY2hvZmllbGQgd3JvdGU6DQo+ID4gPiAoTXVsdGktS2V5IFRvdGFsIE1lbW9y
eSBFbmNyeXB0aW9uKQ0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBNS1RNRSBpcyBhIGhvcnJpYmxl
IG5hbWUsIGFuZCBkb2Vzbid0IGFwcGVhciB0byBhY2N1cmF0ZWx5DQo+ID4gZGVzY3JpYmUgd2hh
dCBpdCBkb2VzIGVpdGhlci4gU3BlY2lmaWNhbGx5IHRoZSAndG90YWwnIHNlZW1zIG91dCBvZg0K
PiA+IHBsYWNlLCBpdCBkb2Vzbid0IHJlcXVpcmUgYWxsIG1lbW9yeSB0byBiZSBlbmNyeXB0ZWQu
DQo+IA0KPiBNS1RNRSBpbXBsaWVzIFRNRS4gVE1FIGlzIGVuYWJsZWQgYnkgQklPUyBhbmQgaXQg
ZW5jcnlwdHMgYWxsIG1lbW9yeSB3aXRoDQo+IENQVS1nZW5lcmF0ZWQga2V5LiBNS1RNRSBhbGxv
d3MgdG8gdXNlIG90aGVyIGtleXMgb3IgZGlzYWJsZSBlbmNyeXB0aW9uDQo+IGZvciBhIHBhZ2Uu
DQoNCldoZW4geW91IHNheSAiZGlzYWJsZSBlbmNyeXB0aW9uIHRvIGEgcGFnZSIgZG9lcyB0aGUg
ZW5jcnlwdGlvbiBnZXQNCmFjdHVhbGx5IGRpc2FibGVkIG9yIGRvZXMgdGhlIENQVSBqdXN0IGRl
Y3J5cHQgaXQgdHJhbnNwYXJlbnRseSBpLmUuDQp3aGF0IGhhcHBlbnMgcGh5c2ljYWxseT8NCg0K
PiBCdXQsIHllcywgbmFtZSBpcyBub3QgZ29vZC4NCg0KL0phcmtrbw0K
