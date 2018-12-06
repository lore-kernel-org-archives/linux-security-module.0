Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD453C04EB9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5642146D
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 08:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5642146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeLFIir (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:38:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:11978 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFIiq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 03:38:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 00:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="257262165"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2018 00:38:43 -0800
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.237]) by
 IRSMSX102.ger.corp.intel.com ([169.254.2.29]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 08:38:42 +0000
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
Subject: Re: [RFC v2 06/13] mm: Add the encrypt_mprotect() system call
Thread-Topic: [RFC v2 06/13] mm: Add the encrypt_mprotect() system call
Thread-Index: AQHUi6Q0anNTDeetwUuO5Fl7wrN4PKVxZuQA
Date:   Thu, 6 Dec 2018 08:38:42 +0000
Message-ID: <e1689769d007da71a61c3bf5de823ef919182ab8.camel@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
         <0c5d9e96c75445ced3b22d9359a8cb3fa2b6f8ad.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <0c5d9e96c75445ced3b22d9359a8cb3fa2b6f8ad.1543903910.git.alison.schofield@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.207.188]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EA6810AA7DCF44D89A204727D55EBB5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDIzOjM5IC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBJbXBsZW1lbnQgbWVtb3J5IGVuY3J5cHRpb24gd2l0aCBhIG5ldyBzeXN0ZW0gY2FsbCB0
aGF0IGlzIGFuDQo+IGV4dGVuc2lvbiBvZiB0aGUgbGVnYWN5IG1wcm90ZWN0KCkgc3lzdGVtIGNh
bGwuDQo+IA0KPiBJbiBlbmNyeXB0X21wcm90ZWN0IHRoZSBjYWxsZXIgbXVzdCBwYXNzIGEgaGFu
ZGxlIHRvIGEgcHJldmlvdXNseQ0KPiBhbGxvY2F0ZWQgYW5kIHByb2dyYW1tZWQgZW5jcnlwdGlv
biBrZXkuIFZhbGlkYXRlIHRoZSBrZXkgYW5kIHN0b3JlDQo+IHRoZSBrZXlpZCBiaXRzIGluIHRo
ZSB2bV9wYWdlX3Byb3QgZm9yIGVhY2ggVk1BIGluIHRoZSBwcm90ZWN0aW9uDQo+IHJhbmdlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNo
dXRlbW92QGxpbnV4LmludGVsLmNvbT4NCg0KV2h5IHlvdSBkb24ndCB1c2UgdGhhdCBOT19LRVkg
aW4gdGhpcyBwYXRjaD8NCg0KL0phcmtrbw0K
