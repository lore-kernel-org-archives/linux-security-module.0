Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A09C04EBF
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8120989
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B8120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbeLEUaU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:30:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:61883 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLEUaU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 15:30:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 12:30:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,319,1539673200"; 
   d="scan'208";a="127429670"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2018 12:30:16 -0800
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX151.ger.corp.intel.com (163.33.192.59) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 5 Dec 2018 20:30:16 +0000
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.134]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.44]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 20:30:15 +0000
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
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVwm1wA
Date:   Wed, 5 Dec 2018 20:30:15 +0000
Message-ID: <b7fa2f2337adadd24594d7e799c337a9c7eaf906.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.241.224.239]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8A9C5F0E0B8C4FB8F40BC9179B80DA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDIzOjM5IC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBIaSBUaG9tYXMsIERhdmlkLA0KPiANCj4gSGVyZSBpcyBhbiB1cGRhdGVkIFJGQyBvbiB0
aGUgQVBJJ3MgdG8gc3VwcG9ydCBNS1RNRS4NCj4gKE11bHRpLUtleSBUb3RhbCBNZW1vcnkgRW5j
cnlwdGlvbikNCj4gDQo+IFRoaXMgUkZDIHByZXNlbnRzIHRoZSAyIEFQSSBhZGRpdGlvbnMgdG8g
c3VwcG9ydCB0aGUgY3JlYXRpb24gYW5kDQo+IHVzYWdlIG9mIG1lbW9yeSBlbmNyeXB0aW9uIGtl
eXM6DQo+ICAxKSBLZXJuZWwgS2V5IFNlcnZpY2UgdHlwZSAibWt0bWUiDQo+ICAyKSBTeXN0ZW0g
Y2FsbCBlbmNyeXB0X21wcm90ZWN0KCkNCj4gDQo+IFRoaXMgcGF0Y2hzZXQgaXMgYnVpbHQgdXBv
biBLaXJpbGwgU2h1dGVtb3YncyB3b3JrIGZvciB0aGUgY29yZSBNS1RNRQ0KPiBzdXBwb3J0Lg0K
DQpQbGVhc2UsIGV4cGxhaW4gd2hhdCBNS1RNRSBpcyByaWdodCBoZXJlLg0KDQpObyByZWZlcmVu
Y2VzLCBubyBleHBsYW5hdGlvbnMuLi4gRXZlbiB3aXRoIGEgcmVmZXJlbmNlLCBhIHNob3J0DQpz
dW1tYXJ5IHdvdWxkIGJlIHJlYWxseSBuaWNlIHRvIGhhdmUuDQoNCi9KYXJra28NCg==
