Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6999AC04EB9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8520892
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F8520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLFIb3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:31:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:31332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFIb3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 03:31:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 00:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="127594493"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2018 00:31:26 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.38]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 08:31:25 +0000
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
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory
 encryption keys
Thread-Topic: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory
 encryption keys
Thread-Index: AQHUi6Q0XNLsLenuyU+ONMUFsdeag6VxZNaA
Date:   Thu, 6 Dec 2018 08:31:24 +0000
Message-ID: <6cabe09dd085f74a3111faebeb285cf0cac1146d.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.207.188]
Content-Type: text/plain; charset="utf-8"
Content-ID: <216ECE3FADEC4042AABDCAEF5A292CDA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDIzOjM5IC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiArZXh0ZXJuIGludCBta3RtZV9tYXBfYWxsb2Modm9pZCk7DQo+ICtleHRlcm4gdm9pZCBt
a3RtZV9tYXBfZnJlZSh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIG1rdG1lX21hcF9sb2NrKHZvaWQp
Ow0KPiArZXh0ZXJuIHZvaWQgbWt0bWVfbWFwX3VubG9jayh2b2lkKTsNCj4gK2V4dGVybiBpbnQg
bWt0bWVfbWFwX21hcHBlZF9rZXlpZHModm9pZCk7DQo+ICtleHRlcm4gdm9pZCBta3RtZV9tYXBf
c2V0X2tleWlkKGludCBrZXlpZCwgdm9pZCAqa2V5KTsNCj4gK2V4dGVybiB2b2lkIG1rdG1lX21h
cF9mcmVlX2tleWlkKGludCBrZXlpZCk7DQo+ICtleHRlcm4gaW50IG1rdG1lX21hcF9rZXlpZF9m
cm9tX2tleSh2b2lkICprZXkpOw0KPiArZXh0ZXJuIHZvaWQgKm1rdG1lX21hcF9rZXlfZnJvbV9r
ZXlpZChpbnQga2V5aWQpOw0KPiArZXh0ZXJuIGludCBta3RtZV9tYXBfZ2V0X2ZyZWVfa2V5aWQo
dm9pZCk7DQoNCk5vIG5lZWQgZm9yIGV4dGVybiBrZXl3b3JkIGZvciBmdW5jdGlvbiBkZWNsYXJh
dGlvbnMuIEl0IGlzDQpvbmx5IG5lZWRlZCBmb3IgdmFyaWFibGUgZGVjbGFyYXRpb25zLg0KDQo+
ICsNCj4gIERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShta3RtZV9lbmFibGVkX2tleSk7DQo+ICBz
dGF0aWMgaW5saW5lIGJvb2wgbWt0bWVfZW5hYmxlZCh2b2lkKQ0KPiAgew0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvbW0vbWt0bWUuYyBiL2FyY2gveDg2L21tL21rdG1lLmMNCj4gaW5kZXggYzgx
NzI3NTQwZTdjLi4zNDIyNGQ0ZTNmNDUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL21rdG1l
LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vbWt0bWUuYw0KPiBAQCAtNDAsNiArNDAsOTcgQEAgaW50
IF9fdm1hX2tleWlkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiAgCXJldHVybiAocHJv
dCAmIG1rdG1lX2tleWlkX21hc2spID4+IG1rdG1lX2tleWlkX3NoaWZ0Ow0KPiAgfQ0KPiAgDQo+
ICsvKg0KPiArICogc3RydWN0IG1rdG1lX21hcCBhbmQgdGhlIG1rdG1lX21hcF8qIGZ1bmN0aW9u
cyBtYW5hZ2UgdGhlIG1hcHBpbmcNCj4gKyAqIG9mIHVzZXJzcGFjZSBLZXlzIHRvIGhhcmR3YXJl
IEtleUlEcy4gVGhlc2UgYXJlIHVzZWQgYnkgdGhlIE1LVE1FIEtleQ0KDQpXaGF0IGFyZSAidXNl
cnNwYWNlIEtleXMiIGFueXdheSBhbmQgd2h5IEtleSBhbmQgbm90IGtleT8NCg0KPiArICogU2Vy
dmljZSBBUEkgYW5kIHRoZSBlbmNyeXB0X21wcm90ZWN0KCkgc3lzdGVtIGNhbGwuDQo+ICsgKi8N
Cj4gKw0KPiArc3RydWN0IG1rdG1lX21hcHBpbmcgew0KPiArCXN0cnVjdCBtdXRleAlsb2NrOwkJ
LyogcHJvdGVjdCB0aGlzIG1hcCAmIEhXIHN0YXRlICovDQo+ICsJdW5zaWduZWQgaW50CW1hcHBl
ZF9rZXlpZHM7DQo+ICsJdm9pZAkJKmtleVtdOw0KPiArfTsNCg0KUGVyc29uYWxseSwgSSBwcmVm
ZXIgbm90IHRvIGFsaWduIHN0cnVjdCBmaWVsZHMgKEkgZG8gYWxpZ24gZW51bXMNCmJlY2F1c2Ug
dGhlcmUgaXQgbWFrZXMgbW9yZSBzZW5zZSkgYXMgb2Z0ZW4geW91IGVuZCB1cCByZWFsaWduaW5n
DQpldmVyeXRoaW5nLg0KDQpEb2N1bWVudGF0aW9uIHdvdWxkIGJyaW5nIG1vcmUgY2xhcml0eS4g
Rm9yIGV4YW1wbGUsIHdoYXQgZG9lcyBrZXlbXQ0KY29udGFpbiwgd2h5IHRoZXJlIGlzIGEgbG9j
ayBhbmQgd2hhdCBtYXBwZWRfa2V5aWRzIGZpZWxkIGNvbnRhaW5zPw0KDQovSmFya2tvDQo=
