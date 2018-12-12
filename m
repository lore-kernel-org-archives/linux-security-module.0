Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048DC65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159512080F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 15:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159512080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLLPbs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:31:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:36531 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLLPbs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 10:31:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 07:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="109813373"
Received: from irsmsx108.ger.corp.intel.com ([163.33.3.3])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2018 07:31:44 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX108.ger.corp.intel.com ([169.254.11.26]) with mapi id 14.03.0415.000;
 Wed, 12 Dec 2018 15:31:42 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgCAB1HFgA==
Date:   Wed, 12 Dec 2018 15:31:41 +0000
Message-ID: <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
In-Reply-To: <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.254.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6454B892ACB3F249A8B4ED5C50148AB2@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gRnJpLCAyMDE4LTEyLTA3IGF0IDE1OjQ1IC0wODAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IFRoZSBicnV0YWwgZmFjdCBpcyB0aGF0IGEgcGh5c2ljYWwgYWRkcmVzcyBpcyBhbiBhc3Ry
b25vbWljYWwgc3RyZXRjaA0KPiBmcm9tIGEgcmFuZG9tIHZhbHVlIG9yIGluY3JlYXNpbmcgY291
bnRlci4gVGh1cywgaXQgaXMgZmFpciB0byBzYXkgdGhhdA0KPiBNS1RNRSBwcm92aWRlcyBvbmx5
IG5haXZlIG1lYXN1cmVzIGFnYWluc3QgcmVwbGF5IGF0dGFja3MuLi4NCg0KSSdsbCB0cnkgdG8g
c3VtbWFyaXplIGhvdyBJIHVuZGVyc3RhbmQgdGhlIGhpZ2ggbGV2ZWwgc2VjdXJpdHkNCm1vZGVs
IG9mIE1LVE1FIGJlY2F1c2UgKHdvdWxkIGJlIGdvb2QgaWRlYSB0byBkb2N1bWVudCBpdCkuDQoN
CkFzc3VtcHRpb25zOg0KDQoxLiBUaGUgaHlwZXJ2aXNvciBoYXMgbm90IGJlZW4gaW5maWx0cmF0
ZWQuDQoyLiBUaGUgaHlwZXJ2aXNvciBkb2VzIG5vdCBsZWFrIHNlY3JldHMuDQoNCldoZW4gKDEp
IGFuZCAoMikgaG9sZCBbMV0sIHdlIGhhcmRlbiBWTXMgaW4gdHdvIGRpZmZlcmVudCB3YXlzOg0K
DQpBLiBWTXMgY2Fubm90IGxlYWsgZGF0YSB0byBlYWNoIG90aGVyIG9yIGNhbiB0aGV5IHdpdGgg
TDFURiB3aGVuIEhUDQogICBpcyBlbmFibGVkPw0KQi4gUHJvdGVjdHMgYWdhaW5zdCBjb2xkIGJv
b3QgYXR0YWNrcy4NCg0KSXNuJ3QgdGhpcyB3aGF0IHRoaXMgYWJvdXQgaW4gdGhlIG51dHNoZWxs
IHJvdWdobHk/DQoNClsxXSBYUEZPIGNvdWxkIHBvdGVudGlhbGx5IGJlIGFuIG9wdC1pbiBmZWF0
dXJlIHRoYXQgcmVkdWNlcyB0aGUNCiAgICBkYW1hZ2Ugd2hlbiBlaXRoZXIgb2YgdGhlc2UgYXNz
dW1wdGlvbnMgaGFzIGJlZW4gYnJva2VuLg0KDQovSmFya2tvDQo=
