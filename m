Return-Path: <SRS0=Wiv6=OW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4203C65BAE
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 05:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26E520870
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 05:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeLMFt1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:49:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:54022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLMFt1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 00:49:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 21:49:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="125476492"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2018 21:49:23 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.8]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 05:49:23 +0000
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
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
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgCAB1HFgIAAEDuAgAAD8gCAAHDKgIAAaqsA
Date:   Thu, 13 Dec 2018 05:49:22 +0000
Message-ID: <191aa6bc11ec795d0108f3369c3f696cd8a43171.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
         <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
         <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
         <42cb695e947e2c98a989285778d56a241fe67e7f.camel@intel.com>
         <105F7BF4D0229846AF094488D65A098935553717@PGSMSX112.gar.corp.intel.com>
In-Reply-To: <105F7BF4D0229846AF094488D65A098935553717@PGSMSX112.gar.corp.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.254.195]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8A4531AF036A54FB30267564C884EE2@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDA3OjI3ICswODAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IFRoaXMgYWxsIHNob3VsZCBiZSBzdW1tYXJpemVkIGluIHRoZSBkb2N1bWVudGF0aW9uIChoaWdo
LWxldmVsIG1vZGVsIGFuZA0KPiA+IGNvcm5lciBjYXNlcykuDQo+IA0KPiBJIGFtIG5vdCBzdXJl
IHdoZXRoZXIgaXQgaXMgbmVjZXNzYXJ5IHRvIGRvY3VtZW50IEwxVEYgZXhwbGljaXRseSwgc2lu
Y2UgaXQgaXMNCj4gcXVpdGUgb2J2aW91cyB0aGF0IE1LVE1FIGRvZXNuJ3QgcHJldmVudCB0aGF0
LiBJTUhPIGlmIG5lZWRlZCB3ZSBvbmx5IG5lZWQgdG8NCj4gbWVudGlvbiBNS1RNRSBkb2Vzbid0
IHByZXZlbnQgYW55IHNvcnQgb2YgY2FjaGUgYmFzZWQgYXR0YWNrLCBzaW5jZSBkYXRhIGluDQo+
IGNhY2hlIGlzIGluIGNsZWFyLg0KPiANCj4gSW4gZmFjdCBTR1ggZG9lc24ndCBwcmV2ZW50IHRo
aXMgZWl0aGVyLi4NCg0KU29ycnksIHdhcyBhIGJpdCB1bmNsZWFyLiBJIG1lYW50IHRoZSBhc3N1
bXB0aW9ucyBhbmQgZ29hbHMuDQoNCi9KYXJra28NCg==
