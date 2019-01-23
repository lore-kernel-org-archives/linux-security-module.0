Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29271C282C2
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A0B218A1
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfAWTAH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:00:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:31046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAWTAG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 14:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 11:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="131760729"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 23 Jan 2019 11:00:03 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 23 Jan 2019 10:59:51 -0800
Received: from HASMSX109.ger.corp.intel.com (10.184.198.21) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 23 Jan 2019 10:59:51 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.155]) by
 hasmsx109.ger.corp.intel.com ([169.254.3.105]) with mapi id 14.03.0415.000;
 Wed, 23 Jan 2019 20:59:48 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: RE: [PATCH v10 00/17] Remove nested TPM operations
Thread-Topic: [PATCH v10 00/17] Remove nested TPM operations
Thread-Index: AQHUreHHpwNI+OEb4EipFSW6DRZudqW9E3qAgAAJKACAACHQMA==
Date:   Wed, 23 Jan 2019 18:59:48 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA818C6@hasmsx108.ger.corp.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190123182057.GA24212@linux.intel.com>
 <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
In-Reply-To: <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTRhNGM3YzktYjY2Ni00MjU1LTlkOWYtYmNkZmIzNzJhNGU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkFkbGVid1hPaTRTdmlNc2hMNXRwT2Mrb2Z2QlFGdGtkcUpyS1FHOTVIeFB1XC9cL0ZUWmFYd1RjWHhCVko4ZzNPIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.254.153.236]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiANCj4gT24gMS8yMy8xOSAxOjIwIFBNLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gT24g
V2VkLCBKYW4gMTYsIDIwMTkgYXQgMTE6MjM6MjVQTSArMDIwMCwgSmFya2tvIFNha2tpbmVuIHdy
b3RlOg0KPiA+PiBNYWtlIHRoZSBjaGFuZ2VzIG5lY2Vzc2FyeSB0byBkZXRhY2ggVFBNIHNwYWNl
IGNvZGUgYW5kIFRQTQ0KPiA+PiBhY3RpdmF0aW9uIGNvZGUgb3V0IG9mIHRoZSB0cG1fdHJhbnNt
aXQoKSBmbG93IGJlY2F1c2Ugb2YgYm90aCBvZg0KPiA+PiB0aGVzZSBjYW4gY2F1c2UgbmVzdGVk
IHRwbV90cmFuc21pdCgpIGNhbGxzLiBUaGUgbmVzdGVkcyBjYWxscyBtYWtlDQo+ID4+IHRoZSB3
aG9sZSBmbG93IGhhcmQgdG8gbWFpbnRhaW4sIGFuZCB0aHVzLCBpdCBpcyBiZXR0ZXIgdG8ganVz
dCBmaXgNCj4gPj4gdGhpbmdzIG5vdyBiZWZvcmUgdGhpcyB0dXJucyBpbnRvIGEgYmlnZ2VyIG1l
c3MuDQo+ID4gQW55IHJlYXNvbnMgbm90IHRvIG1lcmdlIHRoaXMgc29vbj8NCj4gDQo+IEkgc3Vw
cG9zZSB2MTAgaGFzbid0IGNoYW5nZWQgYW55dGhpbmcgc2lnbmluZmljYXQuIFNvLCBub3QgZnJv
bSBteSBwZXJzcGVjdGl2ZS4NCj4gV2VyZSB5b3Ugd2FpdGluZyBmb3IgbW9yZSBSZXZpZXdlZC1i
eSdzPw0KPiANCkknbSBva2F5LCBpbiB0aGVvcnkgSSd2ZSBjbGVhbmVkIGFsbCBteSBjb25jZXJu
IHJlZ2FyZGluZyBpZGxlIGFuZCBsb2NhbGl0eSAuIEknbSBqdXN0IHdhbnQgZG8gZmV3IG1vcmUg
dGVzdHMgb24gU3VuZGF5Lg0KDQpUaGFua3MNClRvbWFzDQoNCg0K
