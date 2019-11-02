Return-Path: <SRS0=iWO7=Y2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA35CA9EC7
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FFD20862
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CkSX5kc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfKBWax (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:30:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45486 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfKBWaw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Nov 2019 18:30:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so8707845pgj.12
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xB2VFGUZyiF2VFPR++wvNyybS4M2ews4nSbm+M32oPk=;
        b=CkSX5kc/xSP4pt89qT83QwNwQ7pjcK33im2ZlbhbYQXnvP8/g2zNUH0NSVCIYSeeSq
         j3Y5a76YdXpv39h+TCcl7eR3A2Zaq4m0LwZhwfjaSqxtIx+DoyS9Y8N34jYCjLZlOcpU
         OacyhB7MI78+ikrdnLdb5UldAwtetjPopJeULyZutottZOgK28zSZK4tt8sPv8dzOYcJ
         3h7oi0dTnHFvGd06RvAeCEs8oTRUkjWHbmdWP2/HCclucDdQa0KYua0Tf2SOsOmv0L2c
         fwG5fQAv5NM6nNXrVTQh5NPv3OEq1btThojafBbfJ0IOFz01EE/XwSfA7caDXfwTSgL3
         TBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xB2VFGUZyiF2VFPR++wvNyybS4M2ews4nSbm+M32oPk=;
        b=lU/ovUgfU4/M1v7Bf60wWHBa1bW3nxdGv7HBguEuXClT3Nlx+eayUHtzofD2QurxFF
         tMidS9DDWxgfrqUbyvOhg/ooNwR9sRYyLciNOz5KXZ2D+1NvzcykpmNm0ba1awxo69AV
         A3tMh0vamn0uWoe4wx2wlaSBJ4ZA0eJszbUIIDEjJU4RZau98oVMp3wxAy/2cund0wfU
         jbthVFSNGLAt+Q5NZVmdBpbNRZEzZ7bbZEPQvFp31DU6Qx75vse3eCT/tZiX2bNYQQZm
         Fxf4b/ZWoQ83lKNLvXGTqJtHB4RSpouLBA7hzxC6q4Pc387OdT6L+5C63wqPDk2z8Nfp
         w8Ow==
X-Gm-Message-State: APjAAAWCG0yIMMIOI1ulaKGdI3vpzPct3tKjNxXc3rQ8RmRmmtav4jSN
        LgXJVlrh4aWc6EI6433PRnrmnw==
X-Google-Smtp-Source: APXvYqzDRQiggB/0IWOZncaQ86RpbPc/jYJAjFDxSvO1yjd56TQhdj02MFsX+oGquyWY0UEfcJYLwg==
X-Received: by 2002:a63:cf46:: with SMTP id b6mr21945917pgj.90.1572733851860;
        Sat, 02 Nov 2019 15:30:51 -0700 (PDT)
Received: from ?IPv6:2600:1010:b067:e6ce:10dd:e058:94b7:feca? ([2600:1010:b067:e6ce:10dd:e058:94b7:feca])
        by smtp.gmail.com with ESMTPSA id e17sm9438491pgg.5.2019.11.02.15.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:30:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
Date:   Sat, 2 Nov 2019 15:30:49 -0700
Message-Id: <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17A878)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Nov 2, 2019, at 3:04 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
> =EF=BB=BFOn Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>>=20
>> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make it=
 just do write() under the hood.
>=20
> Sure it can. Just don't modify the data you vmsplice. It's really that sim=
ple.

So you allocate memory, vmsplice, and munmap() without reusing it?  Just pla=
in free() won=E2=80=99t be good enough. I suspect the TLB overhead will make=
 this a loss in most workloads?

Or maybe you vmsplice from a read-only mapping of a file that you know no on=
e modifies?  This could be useful, but you can just splice() from the file d=
irectly.=
