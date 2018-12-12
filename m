Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B909C65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42522080F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 23:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42522080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLLXYZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:24:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:33553 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeLLXYY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 18:24:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 15:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,346,1539673200"; 
   d="scan'208";a="117894847"
Received: from pgsmsx111.gar.corp.intel.com ([10.108.55.200])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2018 15:24:19 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 PGSMSX111.gar.corp.intel.com ([169.254.2.232]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 07:24:17 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q2qOY85E2yP0iMCMEcgHQzx6VubwyAgAHEsgCAAnbYgIAAqEOAgAAdjgCAB1HDgIAAEDmAgAD5JyA=
Date:   Wed, 12 Dec 2018 23:24:17 +0000
Message-ID: <105F7BF4D0229846AF094488D65A0989355536E9@PGSMSX112.gar.corp.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
 <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
 <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
 <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
 <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
 <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
In-Reply-To: <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjk1M2Q3M2ItNDk3Ni00Mzc3LWE1NTAtMTAxZjdhNDgyZDBiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidzJTbDI4MzhBcDNNdk9FOTVwRUl1VHU4NEZ3YkU2ZW5oWUZJSkR0TGhKcUV4QjdNZGlvYmRONkxCb0JYRjFYdiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiBJIHN0cm9uZ2x5IHN1c3BlY3QgdGhhdCwgb24gTDFURi12dWxuZXJhYmxlIENQVXMsIE1LVE1F
IHByb3ZpZGVzIG5vDQo+IHByb3RlY3Rpb24gd2hhdHNvZXZlci4gIEl0IHNvdW5kcyBsaWtlIE1L
VE1FIGlzIGltcGxlbWVudGVkIGluIHRoZQ0KPiBtZW1vcnkgY29udHJvbGxlciAtLSBhcyBmYXIg
YXMgdGhlIHJlc3Qgb2YgdGhlIENQVSBhbmQgdGhlIGNhY2hlIGhpZXJhcmNoeQ0KPiBhcmUgY29u
Y2VybmVkLCB0aGUgTUtUTUUga2V5IHNlbGN0aW9uIGJpdHMgYXJlIGp1c3QgcGFydCBvZiB0aGUg
cGh5c2ljYWwNCj4gYWRkcmVzcy4gIFNvIGFuIGF0dGFjayBsaWtlIEwxVEYgdGhhdCBsZWFrcyBh
IGNhY2hlbGluZSB0aGF0J3Mgc2VsZWN0ZWQgYnkNCj4gcGh5c2ljYWwgYWRkcmVzcyB3aWxsIGxl
YWsgdGhlIGNsZWFydGV4dCBpZiB0aGUga2V5IHNlbGVjdGlvbiBiaXRzIGFyZSBzZXQNCj4gY29y
cmVjdGx5Lg0KDQpSaWdodC4gTUtUTUUgZG9lc24ndCBwcmV2ZW50IGNhY2hlIGJhc2VkIGF0dGFj
ay4gRGF0YSBpbiBjYWNoZSBpcyBpbiBjbGVhci4NCg0KVGhhbmtzLA0KLUthaQ0KDQo=
