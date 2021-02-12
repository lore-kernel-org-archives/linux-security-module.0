Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B3C433DB
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3373064E65
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 10:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBLKnw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:43:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50080 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230393AbhBLKnO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Feb 2021 05:43:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-115-2rM-qm06PAG36k1cQRmO6Q-1; Fri, 12 Feb 2021 10:41:04 +0000
X-MC-Unique: 2rM-qm06PAG36k1cQRmO6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 12 Feb 2021 10:41:03 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 12 Feb 2021 10:41:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <nathan@kernel.org>,
        Jian Cai <jiancai@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Daniel Palmer" <daniel@0x0f.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "manojgupta@google.com" <manojgupta@google.com>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        "llozano@google.com" <llozano@google.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: RE: [PATCH] ARM: Implement Clang's SLS mitigation
Thread-Topic: [PATCH] ARM: Implement Clang's SLS mitigation
Thread-Index: AQHXAQPpjAt19oU7EUuQ7rTdUOVK86pUVCnA
Date:   Fri, 12 Feb 2021 10:41:03 +0000
Message-ID: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
References: <20210212051500.943179-1-jiancai@google.com>
 <20210212055508.GA3822196@ubuntu-m3-large-x86>
In-Reply-To: <20210212055508.GA3822196@ubuntu-m3-large-x86>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> > on -mharden-sls=all, which mitigates the straight-line speculation
> > vulnerability, or more commonly known as Spectre, Meldown.
> 
>                  ^ I would drop "or" here
>                                                   ^ drop comma,
>                                                     use "and",
>                                                     typo: "Meltdown"
> 
> Although, is that a fair statement? SLS is not called Spectre or
> Meltdown by ARM, it is a speculative processor vulnerabilty. It
> might just be better to drop eerything after the first comma (although
> maybe that is just being pedantic).

or replace with:
   (speculative execution of the instruction following some unconditional jumps).

Which will save a lot of people looking up what it means.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

