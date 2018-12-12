Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A91AC65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 23:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E82080F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 23:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36E82080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLLX1j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:27:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:30921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeLLX1j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 18:27:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 15:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,346,1539673200"; 
   d="scan'208";a="125397949"
Received: from pgsmsx105.gar.corp.intel.com ([10.221.44.96])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2018 15:27:35 -0800
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.210]) by
 PGSMSX105.gar.corp.intel.com ([169.254.4.231]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 07:27:34 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
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
Subject: RE: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Topic: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Thread-Index: AQHUi6Q2qOY85E2yP0iMCMEcgHQzx6VubwyAgAHEsgCAAnbYgIAAqEOAgAAdjgCAB1HDgIAAEDmAgAAD9ACAAPYKQA==
Date:   Wed, 12 Dec 2018 23:27:33 +0000
Message-ID: <105F7BF4D0229846AF094488D65A098935553717@PGSMSX112.gar.corp.intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
         <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
         <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
         <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
         <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
         <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
         <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
 <42cb695e947e2c98a989285778d56a241fe67e7f.camel@intel.com>
In-Reply-To: <42cb695e947e2c98a989285778d56a241fe67e7f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjAzZDhkZTEtODI1Yy00NGRjLTllY2MtOWNlZTQxM2Q3NmM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic3RxbnpLVFNqVUFweWtaaHVyRXNrajE2bjZaQUFWa21HR1FQOUFKcUl2V25Ra3VYOUxwN2ZlNmo5MHVYVVk4aCJ9
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

PiBUaGlzIGFsbCBzaG91bGQgYmUgc3VtbWFyaXplZCBpbiB0aGUgZG9jdW1lbnRhdGlvbiAoaGln
aC1sZXZlbCBtb2RlbCBhbmQNCj4gY29ybmVyIGNhc2VzKS4NCg0KSSBhbSBub3Qgc3VyZSB3aGV0
aGVyIGl0IGlzIG5lY2Vzc2FyeSB0byBkb2N1bWVudCBMMVRGIGV4cGxpY2l0bHksIHNpbmNlIGl0
IGlzIHF1aXRlIG9idmlvdXMgdGhhdCBNS1RNRSBkb2Vzbid0IHByZXZlbnQgdGhhdC4gSU1ITyBp
ZiBuZWVkZWQgd2Ugb25seSBuZWVkIHRvIG1lbnRpb24gTUtUTUUgZG9lc24ndCBwcmV2ZW50IGFu
eSBzb3J0IG9mIGNhY2hlIGJhc2VkIGF0dGFjaywgc2luY2UgZGF0YSBpbiBjYWNoZSBpcyBpbiBj
bGVhci4NCg0KSW4gZmFjdCBTR1ggZG9lc24ndCBwcmV2ZW50IHRoaXMgZWl0aGVyLi4NCg0KVGhh
bmtzLA0KLUthaQ0K
