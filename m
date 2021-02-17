Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1120AC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D4C64DEC
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhBQLIH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:08:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29741 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhBQLHX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Feb 2021 06:07:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-259-RMvaaEXENMqE2t3sbz9bsg-1; Wed, 17 Feb 2021 11:05:41 +0000
X-MC-Unique: RMvaaEXENMqE2t3sbz9bsg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 17 Feb 2021 11:05:39 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Feb 2021 11:05:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>, Jian Cai <jiancai@google.com>
CC:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "manojgupta@google.com" <manojgupta@google.com>,
        "llozano@google.com" <llozano@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH v2] ARM: Implement Clang's SLS mitigation
Thread-Topic: [PATCH v2] ARM: Implement Clang's SLS mitigation
Thread-Index: AQHXBRIkVPd+AU3vQkaBjLLnHtqPv6pcLG4Q
Date:   Wed, 17 Feb 2021 11:05:38 +0000
Message-ID: <a2b21c7326e94c63a64a2e29ae64ba3b@AcuMS.aculab.com>
References: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
 <20210212195255.1321544-1-jiancai@google.com>
 <20210217094859.GA3706@willie-the-truck>
In-Reply-To: <20210217094859.GA3706@willie-the-truck>
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

From: Will Deacon
> Sent: 17 February 2021 09:49
> 
> On Fri, Feb 12, 2021 at 11:52:53AM -0800, Jian Cai wrote:
> > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > -mharden-sls=all, which mitigates the straight-line speculation
> > vulnerability, speculative execution of the instruction following some
> > unconditional jumps. Notice -mharden-sls= has other options as below,
> > and this config turns on the strongest option.
> >
> > all: enable all mitigations against Straight Line Speculation that are implemented.
> > none: disable all mitigations against Straight Line Speculation.
> > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> 
> What exactly does this mitigation do? This should be documented somewhere,
> maybe in the Kconfig text?

I looked it up, it adds some fairly heavy serialising instructions
after the unconditional jump.
For BLR (call indirect) it has to use a BL (call) to an indirect jump.

I don't know if the execution of the serialising instructions
gets aborted.
If not you could end up with unexpected delays - like those on
some x86 cpu when they speculatively executed trig functions.

It all seems pretty broken though.
I'd expect the branch prediction unit to speculate at the jump
target for 'predicted taken' conditional jumps.
So you'd really expect unconditional jumps to behave the same way.
BLR ought to be using the branch target buffer (BTB).

(It isn't actually 100% clear that some processors don't use the BTB
for non-indirect jumps though....)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

