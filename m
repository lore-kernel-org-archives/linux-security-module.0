Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1469E7D0AB
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjIUUhl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjIUUh3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F888496
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:39:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-986d8332f50so161862066b.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695317939; x=1695922739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duasdIDps1Ar+JiX8MLjxGEHHubOxG32YmdpyidUjAA=;
        b=XcM3rWYaMmhlNnRswsR0HhTNm6SxFSrzuCh3sBwVpv7qAfeBVzCxO/oAq7xZdsY17c
         4IaCoMvswi2LOU2U8IpDp/A+Pha/rZ+nr3oqQJ3PJHpVKKM6GI+YKAtnC6TldejnuZkZ
         wmHHECWwxgLQ1ZoTyw7KJaRqrTbp+afeJniVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317939; x=1695922739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duasdIDps1Ar+JiX8MLjxGEHHubOxG32YmdpyidUjAA=;
        b=dTb+G4C+O6bIdZ67jzqveB8VO5WztmlVAeg+KYvp+octgiOnxXGbv7AMhNyNL58a9P
         2x7B3wCBDtA6ObrctG7eNVe2q0xbrjcO6cawoRa55AFXLgfzTkH05HYOkdILIiHjfKOJ
         qCb60LkAh4gofc3OOhLW+09adtGSWpGrTL9wvlDX53Aa6B1140sYXy0Q2G17D5JfgsKL
         CtfEgOcJWfbvgwKDVn15nmdP/NFJR0DaSeoahDyMz/nD+gfcppLwk2iP/5U+mEKjFzCS
         TylI1DLoyHat9mK7r2BGypOxE4w2/YG8u1CcuyIaLZ8ilBJrZzUjWI9YGKoK69V+lgzO
         DYsA==
X-Gm-Message-State: AOJu0Yw21Nz1X/jp5BWYsMZqA1+ofUuRJ4dHGmJVMqxG8ZhM8RYenA8Q
        xt/AebQBLcNN/xxry4QEkgFbS8Yv0/M12yUZ3ZWJ4TYiMsaNpdWVEi8=
X-Google-Smtp-Source: AGHT+IEMcpET+KyGeAflcKrt2Lb0K8gxzNygopNZCsI5AgwGZvckAbSqyadk7XQvFGprUQhpXBwpf5gUZkOt9LY6QjE=
X-Received: by 2002:a17:906:d3:b0:99e:1358:ffdf with SMTP id
 19-20020a17090600d300b0099e1358ffdfmr3894831eji.72.1695281665917; Thu, 21 Sep
 2023 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919212840.144314-1-mattlloydhouse@gmail.com> <CAJfpeguMf7ouiW79iey1i68kYnCcvcpEXLpUNf+CF=aNWxXO2Q@mail.gmail.com>
 <20230920132606.187860-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230920132606.187860-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Sep 2023 09:34:14 +0200
Message-ID: <CAJfpegvZ+4SNnkOEkS=7D44bZNQBovA7SU7etChN6Bh_B9f3dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 20 Sept 2023 at 15:26, Matthew House <mattlloydhouse@gmail.com> wrote:

> The declared type of a variable *is* one of the different types, as far as
> the aliasing rules are concerned. In C17, section 6.5 ("Expressions"):
>
> > The *effective type* of an object for an access to its stored value is
> > the declared type of the object, if any. [More rules about objects with
> > no declared type, i.e., those created with malloc(3) or realloc(3)...]
> >
> > An object shall have its stored value accessed only by an lvalue
> > expression that has one of the following types:
> >
> > -- a type compatible with the effective type of the object,
> >
> > -- a qualified version of a type compatible with the effective type of
> >    the object,
> >
> > -- a type that is the signed or unsigned type corresponding to the
> >    effective type of the object,
> >
> > -- a type that is the signed or unsigned type corresponding to a
> >    qualified version of the effective type of the object,
> >
> > -- an aggregate or union type that includes one of the aforementioned
> >    types among its members (including, recursively, a member of a
> >    subaggregate or contained union), or
> >
> > -- a character type.
>
> In this case, buf is declared in the program as a char[10000] array, so the
> declared type of each element is char, and the effective type of each
> element is also char. If we want to access, say, st->mnt_id, the lvalue
> expression has type __u64, and it tries to access 8 of the char objects.
> However, the integer type that __u64 expands to doesn't meet any of those
> criteria, so the aliasing rules are violated and the behavior is undefined.

Some of the above is new information for me.

However for all practical purposes the code doesn't violate aliasing
rules.  Even the most aggressive "-Wstrict-aliasing=1" doesn't trigger
a warning.  I guess this is because gcc takes the definition to be
symmetric, i.e. anything may safely be aliased to a char pointer and a
char pointer may safely be aliased to anything.  I'm not saying that
that is what the language definition says, just that gcc interprets
the language definition that way.  Also plain "-Wstrict-aliasing"
doesn't trigger even if the type of the array is not char, because gcc
tries hard not to warn about cases where there's no dereference of the
aliased pointer.  This is consistent with what I said and what the gcc
manpage says:  only accesses count, declarations don't.

>
> I've always felt that capacity doubling is a bit wasteful, but it's
> definitely something I can live with, especially if providing size feedback
> is as complex as you suggest. Still, I'm not a big fan of single-buffer
> interfaces in general, with how poorly they tend to interact with C's
> aliasing rules. (Also, those kinds of interfaces also invite alignment
> errors: for instance, your snippet above is missing the necessary union to
> prevent the buffer from being misaligned, which would cause UB when you
> cast it to a struct statmnt *.)

Okay, alignment is a different story.   I'll note this in the man page.

Thanks,
Miklos
