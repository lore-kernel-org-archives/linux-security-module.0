Return-Path: <SRS0=Wiv6=OW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05593C65BAE
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 05:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B226320849
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 05:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B226320849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLMFwR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:52:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:13824 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLMFwR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 00:52:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 21:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="303435142"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2018 21:52:13 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX102.ger.corp.intel.com ([169.254.2.29]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 05:52:12 +0000
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
Thread-Index: AQHUi6Q6VkrSspfrlUix6bu2w4w7sKVu9SmAgAHEq4CAAnbegIAAqD+AgAAdjgCAB1HFgIAAEDuAgAAD8gCAAHDKgIAAaqsAgAAAywA=
Date:   Thu, 13 Dec 2018 05:52:12 +0000
Message-ID: <d33cc487ebce596056096e3db46ee1ae0e9d7da6.camel@intel.com>
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
         <191aa6bc11ec795d0108f3369c3f696cd8a43171.camel@intel.com>
In-Reply-To: <191aa6bc11ec795d0108f3369c3f696cd8a43171.camel@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.254.195]
Content-Type: text/plain; charset="utf-8"
Content-ID: <052226B093F4784DAFBA4B413CF0511F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDA3OjQ5ICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFRodSwgMjAxOC0xMi0xMyBhdCAwNzoyNyArMDgwMCwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiA+IFRoaXMgYWxsIHNob3VsZCBiZSBzdW1tYXJpemVkIGluIHRoZSBkb2N1bWVudGF0aW9u
IChoaWdoLWxldmVsIG1vZGVsIGFuZA0KPiA+ID4gY29ybmVyIGNhc2VzKS4NCj4gPiANCj4gPiBJ
IGFtIG5vdCBzdXJlIHdoZXRoZXIgaXQgaXMgbmVjZXNzYXJ5IHRvIGRvY3VtZW50IEwxVEYgZXhw
bGljaXRseSwgc2luY2UgaXQNCj4gPiBpcw0KPiA+IHF1aXRlIG9idmlvdXMgdGhhdCBNS1RNRSBk
b2Vzbid0IHByZXZlbnQgdGhhdC4gSU1ITyBpZiBuZWVkZWQgd2Ugb25seSBuZWVkDQo+ID4gdG8N
Cj4gPiBtZW50aW9uIE1LVE1FIGRvZXNuJ3QgcHJldmVudCBhbnkgc29ydCBvZiBjYWNoZSBiYXNl
ZCBhdHRhY2ssIHNpbmNlIGRhdGEgaW4NCj4gPiBjYWNoZSBpcyBpbiBjbGVhci4NCj4gPiANCj4g
PiBJbiBmYWN0IFNHWCBkb2Vzbid0IHByZXZlbnQgdGhpcyBlaXRoZXIuLg0KPiANCj4gU29ycnks
IHdhcyBhIGJpdCB1bmNsZWFyLiBJIG1lYW50IHRoZSBhc3N1bXB0aW9ucyBhbmQgZ29hbHMuDQoN
CkkuZS4gd2hhdCBJIHB1dCBpbiBteSBlYXJsaWVyIHJlc3BvbnNlLCB3aGF0IGJlbG9uZ3MgdG8g
VENCIGFuZCB3aGF0DQp0eXBlcyBhZHZlcnNhcmllcyBpcyBwdXJzdWVkIHRvIGJlIHByb3RlY3Rl
ZC4NCg0KL0phcmtrbw0K
