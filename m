Return-Path: <SRS0=lHsL=OR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F823C07E85
	for <linux-security-module@archiver.kernel.org>; Sat,  8 Dec 2018 01:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7CA2082D
	for <linux-security-module@archiver.kernel.org>; Sat,  8 Dec 2018 01:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7CA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLHBdp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:33:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:12489 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeLHBdp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 20:33:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 17:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,328,1539673200"; 
   d="scan'208";a="105831969"
Received: from pgsmsx103.gar.corp.intel.com ([10.221.44.82])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2018 17:33:41 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 PGSMSX103.gar.corp.intel.com ([169.254.2.64]) with mapi id 14.03.0415.000;
 Sat, 8 Dec 2018 09:33:40 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
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
Thread-Index: AQHUi6Q2qOY85E2yP0iMCMEcgHQzx6VubwyAgAHEsgCAAnbYgIAAqEOAgAAdjgCAAB5CAA==
Date:   Sat, 8 Dec 2018 01:33:39 +0000
Message-ID: <1544232812.28511.39.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
In-Reply-To: <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.4.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46E7BAFAD6900E49A15D0F2333E48D4E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gRnJpLCAyMDE4LTEyLTA3IGF0IDIzOjQ1ICswMDAwLCBTYWtraW5lbiwgSmFya2tvIHdyb3Rl
Og0KPiBPbiBGcmksIDIwMTgtMTItMDcgYXQgMTM6NTkgLTA4MDAsIEphcmtrbyBTYWtraW5lbiB3
cm90ZToNCj4gPiBPbiBGcmksIDIwMTgtMTItMDcgYXQgMTQ6NTcgKzAzMDAsIEtpcmlsbCBBLiBT
aHV0ZW1vdiB3cm90ZToNCj4gPiA+ID4gV2hhdCBpcyB0aGUgdGhyZWF0IG1vZGVsIGFueXdheSBm
b3IgQU1EIGFuZCBJbnRlbCB0ZWNobm9sb2dpZXM/DQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgbWUg
aXQgbG9va3MgbGlrZSB0aGF0IHlvdSBjYW4gcmVhZCwgd3JpdGUgYW5kIGV2ZW4gcmVwbGF5IA0K
PiA+ID4gPiBlbmNyeXB0ZWQgcGFnZXMgYm90aCBpbiBTTUUgYW5kIFRNRS4gDQo+ID4gPiANCj4g
PiA+IFdoYXQgcmVwbGF5IGF0dGFjayBhcmUgeW91IHRhbGtpbmcgYWJvdXQ/IE1LVE1FIHVzZXMg
QUVTLVhUUyB3aXRoIHBoeXNpY2FsDQo+ID4gPiBhZGRyZXNzIHR3ZWFrLiBTbyB0aGUgZGF0YSBp
cyB0aWVkIHRvIHRoZSBwbGFjZSBpbiBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlDQo+ID4gPiBhbmQN
Cj4gPiA+IHJlcGxhY2luZyBvbmUgZW5jcnlwdGVkIHBhZ2Ugd2l0aCBhbm90aGVyIGVuY3J5cHRl
ZCBwYWdlIGZyb20gZGlmZmVyZW50DQo+ID4gPiBhZGRyZXNzIHdpbGwgcHJvZHVjZSBnYXJiYWdl
IG9uIGRlY3J5cHRpb24uDQo+ID4gDQo+ID4gSnVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCBob3cg
dGhpcyB3b3Jrcy4NCj4gPiANCj4gPiBTbyB5b3UgdXNlIHBoeXNpY2FsIGFkZHJlc3MgbGlrZSBh
IG5vbmNlL3ZlcnNpb24gZm9yIHRoZSBwYWdlIGFuZA0KPiA+IHRodXMgcHJldmVudCByZXBsYXk/
IFdhcyBub3QgYXdhcmUgb2YgdGhpcy4NCj4gDQo+IFRoZSBicnV0YWwgZmFjdCBpcyB0aGF0IGEg
cGh5c2ljYWwgYWRkcmVzcyBpcyBhbiBhc3Ryb25vbWljYWwgc3RyZXRjaA0KPiBmcm9tIGEgcmFu
ZG9tIHZhbHVlIG9yIGluY3JlYXNpbmcgY291bnRlci4gVGh1cywgaXQgaXMgZmFpciB0byBzYXkg
dGhhdA0KPiBNS1RNRSBwcm92aWRlcyBvbmx5IG5haXZlIG1lYXN1cmVzIGFnYWluc3QgcmVwbGF5
IGF0dGFja3MuLi4NCj4gDQo+IC9KYXJra28NCg0KQ3VycmVudGx5IHRoZXJlJ3Mgbm8gbm9uY2Ug
dG8gcHJvdGVjdCBjYWNoZSBsaW5lIHNvIFRNRS9NS1RNRSBpcyBub3QgYWJsZSB0byBwcmV2ZW50
IHJlcGxheSBhdHRhY2sNCnlvdSBtZW50aW9uZWQuIEN1cnJlbnRseSBNS1RNRSBvbmx5IGludm9s
dmVzIEFFUy1YVFMtMTI4IGVuY3J5cHRpb24gYnV0IG5vdGhpbmcgZWxzZS4gQnV0IGxpa2UgSQ0K
c2FpZCBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IGV2ZW4gU0VWIGRvZXNuJ3QgaGF2ZSBpbnRl
Z3JpdHkgcHJvdGVjdGlvbiBzbyBub3QgYWJsZSB0byBwcmV2ZW50DQpyZXBseSBhdHRhY2sgYXMg
d2VsbC4NCg0KVGhhbmtzLA0KLUthaQ==
