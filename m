Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B3C4332F
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Nov 2022 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKFWuY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Nov 2022 17:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiKFWuX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Nov 2022 17:50:23 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9110FD2
        for <linux-security-module@vger.kernel.org>; Sun,  6 Nov 2022 14:50:22 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13bd19c3b68so10980366fac.7
        for <linux-security-module@vger.kernel.org>; Sun, 06 Nov 2022 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zUhglOvYU/SNtiXDw+NtTZWz+SiK9lfZ+m77nsBTgoc=;
        b=PXmGEjTPrRTwCpI2Jw6IqCV3I/YRj1OiDLIDv7nTugNrn6Ayuy66tjtEGRvKd7/L6S
         IO7tshGkyUQKnM1XZCPb7XIvzA6CGLtoG9XLb4nAJ3QlS8UsIXFF/uaGzlZM2E1pz09p
         oGNP1s9k/puFZm7qkT/2p0F17lqXDEHQF+HBKWwMjO92wZKkyXTkiS/xDq2lPxh3lhgV
         UX4ll4JaAk9/Lmg2HkI28w8x2gbWIdsbkpOjYBa5Wc9ZGhRaoEw1IP3l9MX07gt6seU3
         IPE75+yGooormwok1pAxek1Z5PdbBDo0lm4YRWshUDqVCV+ZNxaOjncIYgveLMuG5daB
         2WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUhglOvYU/SNtiXDw+NtTZWz+SiK9lfZ+m77nsBTgoc=;
        b=Mx4Iwf+6eLGMT1wJMYOCuw9RjZfw6i3mMH6/cvMCHDga8rrSQrwGn+EdHmZWFD9kN6
         doVHOG//0m/4f7WT+ztaYw+zQFOdQnkg2hBLgD1hlqrzGUg0dZ2CQqPHa7kSt6JNCtSS
         F1E6sIVoCZoX7lgA4ziBQJNMT/mwp81g3zRISDKH7m0DcAxEfwKAYXTPuqU3ZCU/OFN5
         ir7EZueLI35K5QGS2iff8sXWlzn3easiTaTRLgSrrJRLErTbaTRZaO42mSBDSzWIAYxY
         UX+bBeP1eV8oWS/vl+jsR1Az9NVusAe9coFhwo3bUfMl/JWZUo74IM3YyoIeWhYlaDsN
         XSUw==
X-Gm-Message-State: ACrzQf2ewplPm9L9kge7MFtdwNMCfHpD+PrA6e3I83qSHOeOLss43V/b
        b0HQExelP4BRMZ97QKjTeZLX/IAEi87KPFj7r5hPxMFwuA==
X-Google-Smtp-Source: AMsMyM43rjyP2ouC0E8/qjx8Tf4YiwEYnCb61K7ZbTb7nizNClpT2rU3I7YKhuAKeSmacQXQu0e+gf8IICBLj66dDUo=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr28113734oap.172.1667775021857; Sun, 06
 Nov 2022 14:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20221103151205.702826-1-omosnace@redhat.com> <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
 <20221105113413.lzgwdlcobmliq32b@wittgenstein>
In-Reply-To: <20221105113413.lzgwdlcobmliq32b@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 6 Nov 2022 17:50:11 -0500
Message-ID: <CAHC9VhSf1M9vV-SHEo8L4ja33nrCG2ndJM6HYjLqQ==L-AquhQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 5, 2022 at 7:34 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Sat, Nov 05, 2022 at 12:38:57AM -0400, Paul Moore wrote:
> > On Thu, Nov 3, 2022 at 11:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > The check being unconditional may lead to unwanted denials reported by
> > > LSMs when a process has the capability granted by DAC, but denied by an
> > > LSM. In the case of SELinux such denials are a problem, since they can't
> > > be effectively filtered out via the policy and when not silenced, they
> > > produce noise that may hide a true problem or an attack.
> > >
> > > Checking for the capability only if any trusted xattr is actually
> > > present wouldn't really address the issue, since calling listxattr(2) on
> > > such node on its own doesn't indicate an explicit attempt to see the
> > > trusted xattrs. Additionally, it could potentially leak the presence of
> > > trusted xattrs to an unprivileged user if they can check for the denials
> > > (e.g. through dmesg).
> > >
> > > Therefore, it's best (and simplest) to keep the check unconditional and
> > > instead use ns_capable_noaudit() that will silence any associated LSM
> > > denials.
> > >
> > > Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> > > Reported-by: Martin Pitt <mpitt@redhat.com>
> > > Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > v1 -> v2: switch to simpler and better solution as suggested by Christian
> > >
> > > v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/
> > >
> > >  fs/xattr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > VFS folks, this should really go through a vfs tree, but if nobody
> > wants to pick it up *and* there are no objections to the change, I can
> > take this via the LSM tree.
>
> I can pick this up as I'm currently massaging the simple xattr
> infrastructure.

Thanks Christian.

> I think the fix is pretty straightforward otherwise.

Agreed.

-- 
paul-moore.com
