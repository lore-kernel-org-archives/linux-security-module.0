Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBBC04EB8
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 02:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9AC20868
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 02:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9AC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLGCF5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:05:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:55598 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCF4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 21:05:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 18:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="257495995"
Received: from kmsmsx153.gar.corp.intel.com ([172.21.73.88])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2018 18:05:52 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 KMSMSX153.gar.corp.intel.com ([169.254.5.24]) with mapi id 14.03.0415.000;
 Fri, 7 Dec 2018 10:05:51 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
Thread-Index: AQHUi6Q2qOY85E2yP0iMCMEcgHQzx6VubwyAgAHEsgCAAdGWAA==
Date:   Fri, 7 Dec 2018 02:05:50 +0000
Message-ID: <1544148344.28511.21.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
In-Reply-To: <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.4.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <44993893C3AA2C4BAD51777EAE072F55@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gV2VkLCAyMDE4LTEyLTA1IGF0IDIyOjE5ICswMDAwLCBTYWtraW5lbiwgSmFya2tvIHdyb3Rl
Og0KPiBPbiBUdWUsIDIwMTgtMTItMDQgYXQgMTE6MTkgLTA4MDAsIEFuZHkgTHV0b21pcnNraSB3
cm90ZToNCj4gPiBJJ20gbm90IFRob21hcywgYnV0IEkgdGhpbmsgaXQncyB0aGUgd3JvbmcgZGly
ZWN0aW9uLiAgQXMgaXQgc3RhbmRzLA0KPiA+IGVuY3J5cHRfbXByb3RlY3QoKSBpcyBhbiBpbmNv
bXBsZXRlIHZlcnNpb24gb2YgbXByb3RlY3QoKSAoc2luY2UgaXQncw0KPiA+IG1pc3NpbmcgdGhl
IHByb3RlY3Rpb24ga2V5IHN1cHBvcnQpLCBhbmQgaXQncyBhbHNvIGZ1bmN0aW9uYWxseSBqdXN0
DQo+ID4gTUFEVl9ET05UTkVFRC4gIEluIG90aGVyIHdvcmRzLCB0aGUgc29sZSB1c2VyLXZpc2li
bGUgZWZmZWN0IGFwcGVhcnMNCj4gPiB0byBiZSB0aGF0IHRoZSBleGlzdGluZyBwYWdlcyBhcmUg
Ymxvd24gYXdheS4gIFRoZSBmYWN0IHRoYXQgaXQNCj4gPiBjaGFuZ2VzIHRoZSBrZXkgaW4gdXNl
IGRvZXNuJ3Qgc2VlbSB0ZXJyaWJseSB1c2VmdWwsIHNpbmNlIGl0J3MNCj4gPiBhbm9ueW1vdXMg
bWVtb3J5LCBhbmQgdGhlIG1vc3Qgc2VjdXJlIGNob2ljZSBpcyB0byB1c2UgQ1BVLW1hbmFnZWQN
Cj4gPiBrZXlpbmcsIHdoaWNoIGFwcGVhcnMgdG8gYmUgdGhlIGRlZmF1bHQgYW55d2F5IG9uIFRN
RSBzeXN0ZW1zLiAgSXQNCj4gPiBhbHNvIGhhcyB0b3RhbGx5IHVuY2xlYXIgc2VtYW50aWNzIFdS
VCBzd2FwLCBhbmQsIG9mZiB0aGUgdG9wIG9mIG15DQo+ID4gaGVhZCwgaXQgbG9va3MgbGlrZSBp
dCBtYXkgaGF2ZSBzZXJpb3VzIGNhY2hlLWNvaGVyZW5jeSBpc3N1ZXMgYW5kDQo+ID4gbGlrZSBz
d2FwcGluZyB0aGUgcGFnZXMgbWlnaHQgY29ycnVwdCB0aGVtLCBib3RoIGJlY2F1c2UgdGhlcmUg
YXJlIG5vDQo+ID4gZmx1c2hlcyBhbmQgYmVjYXVzZSB0aGUgZGlyZWN0LW1hcCBhbGlhcyBsb29r
cyBsaWtlIGl0IHdpbGwgdXNlIHRoZQ0KPiA+IGRlZmF1bHQga2V5IGFuZCB0aGVyZWZvcmUgYXBw
ZWFyIHRvIGNvbnRhaW4gdGhlIHdyb25nIGRhdGEuDQo+ID4gDQo+ID4gSSB3b3VsZCBwcm9wb3Nl
IGEgdmVyeSBkaWZmZXJlbnQgZGlyZWN0aW9uOiBkb24ndCB0cnkgdG8gc3VwcG9ydCBNS1RNRQ0K
PiA+IGF0IGFsbCBmb3IgYW5vbnltb3VzIG1lbW9yeSwgYW5kIGluc3RlYWQgZmlndXJlIG91dCB0
aGUgaW1wb3J0YW50IHVzZQ0KPiA+IGNhc2VzIGFuZCBzdXBwb3J0IHRoZW0gZGlyZWN0bHkuICBU
aGUgdXNlIGNhc2VzIHRoYXQgSSBjYW4gdGhpbmsgb2YNCj4gPiBvZmYgdGhlIHRvcCBvZiBteSBo
ZWFkIGFyZToNCj4gPiANCj4gPiAxLiBwbWVtLiAgVGhpcyBzaG91bGQgcHJvYmFibHkgdXNlIGEg
dmVyeSBkaWZmZXJlbnQgQVBJLg0KPiA+IA0KPiA+IDIuIFNvbWUga2luZCBvZiBWTSBoYXJkZW5p
bmcsIHdoZXJlIGEgVk0ncyBtZW1vcnkgY2FuIGJlIHByb3RlY3RlZCBhDQo+ID4gbGl0dGxlIHRp
bnkgYml0IGZyb20gdGhlIG1haW4ga2VybmVsLiAgQnV0IEkgZG9uJ3Qgc2VlIHdoeSB0aGlzIGlz
IGFueQ0KPiA+IGJldHRlciB0aGFuIFhQTyAoZVhjbHVzaXZlIFBhZ2UtZnJhbWUgT3duZXJzaGlw
KSwgd2hpY2ggYnJpbmdzIHRvDQo+ID4gbWluZDoNCj4gDQo+IFdoYXQgaXMgdGhlIHRocmVhdCBt
b2RlbCBhbnl3YXkgZm9yIEFNRCBhbmQgSW50ZWwgdGVjaG5vbG9naWVzPw0KPiANCj4gRm9yIG1l
IGl0IGxvb2tzIGxpa2UgdGhhdCB5b3UgY2FuIHJlYWQsIHdyaXRlIGFuZCBldmVuIHJlcGxheSAN
Cj4gZW5jcnlwdGVkIHBhZ2VzIGJvdGggaW4gU01FIGFuZCBUTUUuIA0KDQpSaWdodC4gTmVpdGhl
ciBvZiB0aGVtIChpbmNsdWRpbmcgTUtUTUUpIHByZXZlbnRzIHJlcGxheSBhdHRhY2suIEJ1dCBp
biBteSB1bmRlcnN0YW5kaW5nIFNFViBkb2Vzbid0DQpwcmV2ZW50IHJlcGxheSBhdHRhY2sgZWl0
aGVyIHNpbmNlIGl0IGRvZXNuJ3QgaGF2ZSBpbnRlZ3JpdHkgcHJvdGVjdGlvbi4NCg0KVGhhbmtz
LA0KLUthaQ0K
