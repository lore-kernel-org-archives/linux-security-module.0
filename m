Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F54C4332B
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B62F64F47
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhCCX7s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27937 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379852AbhCCPbz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-129-p7FEIIrCNG6cb_3HeC64uw-1; Wed, 03 Mar 2021 15:29:45 +0000
X-MC-Unique: p7FEIIrCNG6cb_3HeC64uw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 3 Mar 2021 15:29:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Mar 2021 15:29:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Walleij' <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "Ingo Molnar" <mingo@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH v4] ARM: Implement SLS mitigation
Thread-Topic: [PATCH v4] ARM: Implement SLS mitigation
Thread-Index: AQHXEECBQRoTQnOC90iuKvtWWC/yz6pyYx/A
Date:   Wed, 3 Mar 2021 15:29:37 +0000
Message-ID: <49e8725f29ab4ecda6d669e9216bca29@AcuMS.aculab.com>
References: <20210219201852.3213914-1-jiancai@google.com>
 <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck>
 <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
 <20210223100453.GB10254@willie-the-truck>
 <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
In-Reply-To: <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

RnJvbTogTGludXMgV2FsbGVpag0KPiBTZW50OiAwMyBNYXJjaCAyMDIxIDE1OjE5DQo+IA0KPiBP
biBUdWUsIEZlYiAyMywgMjAyMSBhdCAxMTowNSBBTSBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAwMTo1MDowNlBNIC0wODAw
LCBKaWFuIENhaSB3cm90ZToNCj4gPiA+IEkgYW0gbm90IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBw
bGFucyB0byBwcm90ZWN0IGFzc2VtYmx5IGNvZGUgYW5kIEkNCj4gPiA+IHdpbGwgbGVhdmUgaXQg
dG8gdGhlIEFybSBmb2xrcyBzaW5jZSB0aGV5IGtub3cgYSB3aG9sZSBsb3QgYmV0dGVyLiBCdXQN
Cj4gPiA+IGV2ZW4gd2l0aG91dCB0aGF0IHBhcnQsIHdlIHNob3VsZCBzdGlsbCBoYXZlIGJldHRl
ciBwcm90ZWN0aW9uLA0KPiA+ID4gZXNwZWNpYWxseSB3aGVuIG92ZXJoZWFkIGRvZXMgbm90IGxv
b2sgdG9vIGJhZDogSSBkaWQgc29tZSBwcmVsaW1pbmFyeQ0KPiA+ID4gZXhwZXJpbWVudHMgb24g
Q2hyb21lT1MsIGNvZGUgc2l6ZSBvZiB2bWxpbnV4IGluY3JlYXNlZCAzJSwgYW5kIHRoZXJlDQo+
ID4gPiB3ZXJlIG5vIG5vdGljZWFibGUgY2hhbmdlcyB0byBydW4tdGltZSBwZXJmb3JtYW5jZSBv
ZiB0aGUgYmVuY2htYXJrcyBJDQo+ID4gPiB1c2VkLg0KPiA+DQo+ID4gSWYgdGhlIG1pdGlnYXRp
b24gaXMgcmVxdWlyZWQsIEknbSBub3Qgc3VyZSBJIHNlZSBhIGxvdCBvZiBwb2ludCBpbiBvbmx5
DQo+ID4gZG9pbmcgYSBoYWxmLWJha2VkIGpvYiBvZiBpdC4gSXQgZmVlbHMgYSBiaXQgbGlrZSBh
IGJveC10aWNraW5nIGV4ZXJjaXNlLA0KPiA+IGluIHdoaWNoIGNhc2UgYW55IG92ZXJoZWFkIGlz
IHRvbyBtdWNoLg0KPiANCj4gSSB3cm90ZSBzb21lIHN1Z2dlc3Rpb25zIG9uIGZvbGxvdy11cHMg
aW4gbXkgcmVwbHksIGFuZCBJIGNhbg0KPiBoZWxwIG91dCBkb2luZyBzb21lIG9mIHRoZSBwYXRj
aGVzLCBJIHRoaW5rLg0KPiANCj4gU2luY2UgQVJNMzIgUkVUIGlzIG1vdiBwYywgPD4NCj4gZ2l0
IGdyZXAgJ21vdi4qcGMsJyB8IHdjIC1sIGdpdmVzIDkzIHNpdGVzIGluIGFyY2gvYXJtLg0KPiBJ
IHN1cHBvc2UgdGhlc2UgbmVlZCB0byBjb21lIG91dDoNCj4gDQo+IG1vdiBwYywgbHINCj4gZHNi
KG5zaCk7DQo+IGlzYigpOw0KDQpXb24ndCB0aGF0IGdvIGhvcnJpYmx5IHdyb25nIGZvciBjb25k
aXRpb25hbCByZXR1cm5zPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

