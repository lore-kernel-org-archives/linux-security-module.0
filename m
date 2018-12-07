Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A26BC07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445F320838
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445F320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGXpU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:45:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:10790 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbeLGXpU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 18:45:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 15:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,327,1539673200"; 
   d="scan'208";a="105811823"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2018 15:45:16 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.247]) with mapi id 14.03.0415.000;
 Fri, 7 Dec 2018 23:45:15 +0000
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgA=
Date:   Fri, 7 Dec 2018 23:45:14 +0000
Message-ID: <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
In-Reply-To: <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.201.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B14A143DE6497545AB154E1FB659B42E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gRnJpLCAyMDE4LTEyLTA3IGF0IDEzOjU5IC0wODAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIEZyaSwgMjAxOC0xMi0wNyBhdCAxNDo1NyArMDMwMCwgS2lyaWxsIEEuIFNodXRlbW92
IHdyb3RlOg0KPiA+ID4gV2hhdCBpcyB0aGUgdGhyZWF0IG1vZGVsIGFueXdheSBmb3IgQU1EIGFu
ZCBJbnRlbCB0ZWNobm9sb2dpZXM/DQo+ID4gPiANCj4gPiA+IEZvciBtZSBpdCBsb29rcyBsaWtl
IHRoYXQgeW91IGNhbiByZWFkLCB3cml0ZSBhbmQgZXZlbiByZXBsYXkgDQo+ID4gPiBlbmNyeXB0
ZWQgcGFnZXMgYm90aCBpbiBTTUUgYW5kIFRNRS4gDQo+ID4gDQo+ID4gV2hhdCByZXBsYXkgYXR0
YWNrIGFyZSB5b3UgdGFsa2luZyBhYm91dD8gTUtUTUUgdXNlcyBBRVMtWFRTIHdpdGggcGh5c2lj
YWwNCj4gPiBhZGRyZXNzIHR3ZWFrLiBTbyB0aGUgZGF0YSBpcyB0aWVkIHRvIHRoZSBwbGFjZSBp
biBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlDQo+ID4gYW5kDQo+ID4gcmVwbGFjaW5nIG9uZSBlbmNy
eXB0ZWQgcGFnZSB3aXRoIGFub3RoZXIgZW5jcnlwdGVkIHBhZ2UgZnJvbSBkaWZmZXJlbnQNCj4g
PiBhZGRyZXNzIHdpbGwgcHJvZHVjZSBnYXJiYWdlIG9uIGRlY3J5cHRpb24uDQo+IA0KPiBKdXN0
IHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0aGlzIHdvcmtzLg0KPiANCj4gU28geW91IHVzZSBw
aHlzaWNhbCBhZGRyZXNzIGxpa2UgYSBub25jZS92ZXJzaW9uIGZvciB0aGUgcGFnZSBhbmQNCj4g
dGh1cyBwcmV2ZW50IHJlcGxheT8gV2FzIG5vdCBhd2FyZSBvZiB0aGlzLg0KDQpUaGUgYnJ1dGFs
IGZhY3QgaXMgdGhhdCBhIHBoeXNpY2FsIGFkZHJlc3MgaXMgYW4gYXN0cm9ub21pY2FsIHN0cmV0
Y2gNCmZyb20gYSByYW5kb20gdmFsdWUgb3IgaW5jcmVhc2luZyBjb3VudGVyLiBUaHVzLCBpdCBp
cyBmYWlyIHRvIHNheSB0aGF0DQpNS1RNRSBwcm92aWRlcyBvbmx5IG5haXZlIG1lYXN1cmVzIGFn
YWluc3QgcmVwbGF5IGF0dGFja3MuLi4NCg0KL0phcmtrbw0K
