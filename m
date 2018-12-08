Return-Path: <SRS0=lHsL=OR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A0C65BAF
	for <linux-security-module@archiver.kernel.org>; Sat,  8 Dec 2018 03:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024920989
	for <linux-security-module@archiver.kernel.org>; Sat,  8 Dec 2018 03:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6024920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLHDxz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:53:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:6850 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeLHDxz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 22:53:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 19:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,328,1539673200"; 
   d="scan'208";a="128168057"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2018 19:53:52 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.8]) with mapi id 14.03.0415.000;
 Sat, 8 Dec 2018 03:53:51 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>,
        "Huang, Kai" <kai.huang@intel.com>
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgCAAB5PgIAAJyYA
Date:   Sat, 8 Dec 2018 03:53:50 +0000
Message-ID: <405976bf5c6332096e205af1a647d24d03af8c32.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
         <1544232812.28511.39.camel@intel.com>
In-Reply-To: <1544232812.28511.39.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.205.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43DCB342BCB434BBC4409AEAEB6F6C7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gU2F0LCAyMDE4LTEyLTA4IGF0IDA5OjMzICswODAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBD
dXJyZW50bHkgdGhlcmUncyBubyBub25jZSB0byBwcm90ZWN0IGNhY2hlIGxpbmUgc28gVE1FL01L
VE1FIGlzIG5vdCBhYmxlIHRvDQo+IHByZXZlbnQgcmVwbGF5IGF0dGFjaw0KPiB5b3UgbWVudGlv
bmVkLiBDdXJyZW50bHkgTUtUTUUgb25seSBpbnZvbHZlcyBBRVMtWFRTLTEyOCBlbmNyeXB0aW9u
IGJ1dA0KPiBub3RoaW5nIGVsc2UuIEJ1dCBsaWtlIEkNCj4gc2FpZCBpZiBJIHVuZGVyc3RhbmQg
Y29ycmVjdGx5IGV2ZW4gU0VWIGRvZXNuJ3QgaGF2ZSBpbnRlZ3JpdHkgcHJvdGVjdGlvbiBzbw0K
PiBub3QgYWJsZSB0byBwcmV2ZW50DQo+IHJlcGx5IGF0dGFjayBhcyB3ZWxsLg0KDQpZb3UncmUg
YWJzb2x1dGVseSBjb3JyZWN0Lg0KDQpUaGVyZSdzIGEgYWxzbyBnb29kIHBhcGVyIG9uIFNFViBz
dWJ2ZXJ0aW9uOg0KDQpodHRwczovL2FyeGl2Lm9yZy9wZGYvMTgwNS4wOTYwNC5wZGYNCg0KSSBk
b24ndCB0aGluayB0aGlzIG1ha2VzIE1LVE1FIG9yIFNFViB1c2Vsc3MsIGJ1dCB5ZWFoLCBpdCBp
cyBhDQpjb25zdHJhaW50IHRoYXQgbmVlZHMgdG8gYmUgdGFrZW4gaW50byBjb25zaWRlcmF0aW9u
IHdoZW4gZmluZGluZyB0aGUNCmJlc3Qgd2F5IHRvIHVzZSB0aGVzZSB0ZWNobm9sb2dpZXMgaW4g
TGludXguDQoNCi9KYXJra28NCg==
