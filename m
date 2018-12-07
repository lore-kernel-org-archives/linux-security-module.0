Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F9FC64EB1
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C5920837
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 21:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C5920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGV7b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:59:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:54769 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGV7b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 16:59:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 13:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,327,1539673200"; 
   d="scan'208";a="302014389"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2018 13:59:28 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX153.ger.corp.intel.com ([169.254.9.112]) with mapi id 14.03.0415.000;
 Fri, 7 Dec 2018 21:59:27 +0000
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+A
Date:   Fri, 7 Dec 2018 21:59:27 +0000
Message-ID: <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
In-Reply-To: <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA883A02E9D764DA7910B6F5FEDB45C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gRnJpLCAyMDE4LTEyLTA3IGF0IDE0OjU3ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+ID4gV2hhdCBpcyB0aGUgdGhyZWF0IG1vZGVsIGFueXdheSBmb3IgQU1EIGFuZCBJbnRl
bCB0ZWNobm9sb2dpZXM/DQo+ID4gDQo+ID4gRm9yIG1lIGl0IGxvb2tzIGxpa2UgdGhhdCB5b3Ug
Y2FuIHJlYWQsIHdyaXRlIGFuZCBldmVuIHJlcGxheSANCj4gPiBlbmNyeXB0ZWQgcGFnZXMgYm90
aCBpbiBTTUUgYW5kIFRNRS4gDQo+IA0KPiBXaGF0IHJlcGxheSBhdHRhY2sgYXJlIHlvdSB0YWxr
aW5nIGFib3V0PyBNS1RNRSB1c2VzIEFFUy1YVFMgd2l0aCBwaHlzaWNhbA0KPiBhZGRyZXNzIHR3
ZWFrLiBTbyB0aGUgZGF0YSBpcyB0aWVkIHRvIHRoZSBwbGFjZSBpbiBwaHlzaWNhbCBhZGRyZXNz
IHNwYWNlIGFuZA0KPiByZXBsYWNpbmcgb25lIGVuY3J5cHRlZCBwYWdlIHdpdGggYW5vdGhlciBl
bmNyeXB0ZWQgcGFnZSBmcm9tIGRpZmZlcmVudA0KPiBhZGRyZXNzIHdpbGwgcHJvZHVjZSBnYXJi
YWdlIG9uIGRlY3J5cHRpb24uDQoNCkp1c3QgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgaG93IHRoaXMg
d29ya3MuDQoNClNvIHlvdSB1c2UgcGh5c2ljYWwgYWRkcmVzcyBsaWtlIGEgbm9uY2UvdmVyc2lv
biBmb3IgdGhlIHBhZ2UgYW5kDQp0aHVzIHByZXZlbnQgcmVwbGF5PyBXYXMgbm90IGF3YXJlIG9m
IHRoaXMuDQoNCi9KYXJra28NCg==
