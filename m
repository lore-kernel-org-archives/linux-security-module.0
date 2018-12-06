Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E25C64EB1
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 21:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE42082B
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 21:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLFVXZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:23:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:33955 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeLFVXZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 16:23:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 13:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="98687965"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2018 13:23:21 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.8]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 21:23:20 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVuT2gAgAAF2oCAAkbYgIAA+K6AgACnwQA=
Date:   Thu, 6 Dec 2018 21:23:20 +0000
Message-ID: <3a0a11bc557288190f6fa804dc8e7825738ccc70.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <20181204092550.GT11614@hirez.programming.kicks-ass.net>
         <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
         <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
         <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
In-Reply-To: <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.241.225.212]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B182726010624D963DB61DC95CECB1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDE0OjIyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFdoZW4geW91IHNheSAiZGlzYWJsZSBlbmNyeXB0aW9uIHRvIGEgcGFnZSIgZG9lcyB0
aGUgZW5jcnlwdGlvbiBnZXQNCj4gPiBhY3R1YWxseSBkaXNhYmxlZCBvciBkb2VzIHRoZSBDUFUg
anVzdCBkZWNyeXB0IGl0IHRyYW5zcGFyZW50bHkgaS5lLg0KPiA+IHdoYXQgaGFwcGVucyBwaHlz
aWNhbGx5Pw0KPiANCj4gWWVzLCBpdCBnZXRzIGRpc2FibGVkLiBQaHlzaWNhbGx5LiBJdCBvdmVy
cmlkZXMgVE1FIGVuY3J5cHRpb24uDQoNCk9LLCB0aGFua3MgZm9yIGNvbmZpcm1hdGlvbi4gQlRX
LCBob3cgbXVjaCBpcyB0aGUgcGVuYWx0eSB0byBrZWVwIGl0DQphbHdheXMgZW5hYmxlZD8gSXMg
aXQgc29tZXRoaW5nIHRoYXQgd291bGQgbm90IG1ha2Ugc2Vuc2UgZm9yIHNvbWUNCm90aGVyIHJl
YXNvbnM/DQoNCi9KYXJra28NCg==
