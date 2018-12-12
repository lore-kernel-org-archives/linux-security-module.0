Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED905C65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84312084E
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84312084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeLLQoB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:44:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:17655 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLQoB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 11:44:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 08:43:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="109830574"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2018 08:43:56 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX107.ger.corp.intel.com (163.33.3.99) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 16:43:56 +0000
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.183]) with mapi id 14.03.0415.000;
 Wed, 12 Dec 2018 16:43:55 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>
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
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgCAB1HFgIAAEDuAgAAD8gA=
Date:   Wed, 12 Dec 2018 16:43:54 +0000
Message-ID: <42cb695e947e2c98a989285778d56a241fe67e7f.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
         <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
         <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
In-Reply-To: <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.254.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DD9A480BEDC748BA363349C285C8C1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gV2VkLCAyMDE4LTEyLTEyIGF0IDA4OjI5IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDEyLCAyMDE4IGF0IDc6MzEgQU0gU2Fra2luZW4sIEphcmtrbw0KPiA8
amFya2tvLnNha2tpbmVuQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTEyLTA3
IGF0IDE1OjQ1IC0wODAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gPiBUaGUgYnJ1dGFs
IGZhY3QgaXMgdGhhdCBhIHBoeXNpY2FsIGFkZHJlc3MgaXMgYW4gYXN0cm9ub21pY2FsIHN0cmV0
Y2gNCj4gPiA+IGZyb20gYSByYW5kb20gdmFsdWUgb3IgaW5jcmVhc2luZyBjb3VudGVyLiBUaHVz
LCBpdCBpcyBmYWlyIHRvIHNheSB0aGF0DQo+ID4gPiBNS1RNRSBwcm92aWRlcyBvbmx5IG5haXZl
IG1lYXN1cmVzIGFnYWluc3QgcmVwbGF5IGF0dGFja3MuLi4NCj4gPiANCj4gPiBJJ2xsIHRyeSB0
byBzdW1tYXJpemUgaG93IEkgdW5kZXJzdGFuZCB0aGUgaGlnaCBsZXZlbCBzZWN1cml0eQ0KPiA+
IG1vZGVsIG9mIE1LVE1FIGJlY2F1c2UgKHdvdWxkIGJlIGdvb2QgaWRlYSB0byBkb2N1bWVudCBp
dCkuDQo+ID4gDQo+ID4gQXNzdW1wdGlvbnM6DQo+ID4gDQo+ID4gMS4gVGhlIGh5cGVydmlzb3Ig
aGFzIG5vdCBiZWVuIGluZmlsdHJhdGVkLg0KPiA+IDIuIFRoZSBoeXBlcnZpc29yIGRvZXMgbm90
IGxlYWsgc2VjcmV0cy4NCj4gPiANCj4gPiBXaGVuICgxKSBhbmQgKDIpIGhvbGQgWzFdLCB3ZSBo
YXJkZW4gVk1zIGluIHR3byBkaWZmZXJlbnQgd2F5czoNCj4gPiANCj4gPiBBLiBWTXMgY2Fubm90
IGxlYWsgZGF0YSB0byBlYWNoIG90aGVyIG9yIGNhbiB0aGV5IHdpdGggTDFURiB3aGVuIEhUDQo+
ID4gICAgaXMgZW5hYmxlZD8NCj4gDQo+IEkgc3Ryb25nbHkgc3VzcGVjdCB0aGF0LCBvbiBMMVRG
LXZ1bG5lcmFibGUgQ1BVcywgTUtUTUUgcHJvdmlkZXMgbm8NCj4gcHJvdGVjdGlvbiB3aGF0c29l
dmVyLiAgSXQgc291bmRzIGxpa2UgTUtUTUUgaXMgaW1wbGVtZW50ZWQgaW4gdGhlDQo+IG1lbW9y
eSBjb250cm9sbGVyIC0tIGFzIGZhciBhcyB0aGUgcmVzdCBvZiB0aGUgQ1BVIGFuZCB0aGUgY2Fj
aGUNCj4gaGllcmFyY2h5IGFyZSBjb25jZXJuZWQsIHRoZSBNS1RNRSBrZXkgc2VsY3Rpb24gYml0
cyBhcmUganVzdCBwYXJ0IG9mDQo+IHRoZSBwaHlzaWNhbCBhZGRyZXNzLiAgU28gYW4gYXR0YWNr
IGxpa2UgTDFURiB0aGF0IGxlYWtzIGEgY2FjaGVsaW5lDQo+IHRoYXQncyBzZWxlY3RlZCBieSBw
aHlzaWNhbCBhZGRyZXNzIHdpbGwgbGVhayB0aGUgY2xlYXJ0ZXh0IGlmIHRoZSBrZXkNCj4gc2Vs
ZWN0aW9uIGJpdHMgYXJlIHNldCBjb3JyZWN0bHkuDQo+IA0KPiAoSSBzdXBwb3NlIHRoYXQsIGlm
IHRoZSBhdHRhY2tlciBuZWVkcyB0byBicnV0ZS1mb3JjZSB0aGUgcGh5c2ljYWwNCj4gYWRkcmVz
cywgdGhlbiBNS1RNRSBtYWtlcyBpdCBhIGJpdCBoYXJkZXIgYmVjYXVzZSB0aGUgZWZmZWN0aXZl
DQo+IHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UgaXMgbGFyZ2VyLikNCj4gDQo+ID4gQi4gUHJvdGVj
dHMgYWdhaW5zdCBjb2xkIGJvb3QgYXR0YWNrcy4NCj4gDQo+IFRNRSBkb2VzIHRoaXMsIEFGQUlL
LiAgTUtUTUUgZG9lcywgdG9vLCB1bmxlc3MgdGhlICJ1c2VyIiBtb2RlIGlzDQo+IHVzZWQsIGlu
IHdoaWNoIGNhc2UgdGhlIHByb3RlY3Rpb24gaXMgd2Vha2VyLg0KPiANCj4gPiBJc24ndCB0aGlz
IHdoYXQgdGhpcyBhYm91dCBpbiB0aGUgbnV0c2hlbGwgcm91Z2hseT8NCj4gPiANCj4gPiBbMV0g
WFBGTyBjb3VsZCBwb3RlbnRpYWxseSBiZSBhbiBvcHQtaW4gZmVhdHVyZSB0aGF0IHJlZHVjZXMg
dGhlDQo+ID4gICAgIGRhbWFnZSB3aGVuIGVpdGhlciBvZiB0aGVzZSBhc3N1bXB0aW9ucyBoYXMg
YmVlbiBicm9rZW4uDQoNClRoaXMgYWxsIHNob3VsZCBiZSBzdW1tYXJpemVkIGluIHRoZSBkb2N1
bWVudGF0aW9uIChoaWdoLWxldmVsIG1vZGVsDQphbmQgY29ybmVyIGNhc2VzKS4NCg0KL0phcmtr
bw0K
