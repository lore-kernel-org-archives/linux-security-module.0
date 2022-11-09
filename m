Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACEDC433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 20:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKIUWf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKIUW3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 15:22:29 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155011D678
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 12:22:29 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b23e29e36so22485fac.8
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkZEBtgDxLwh8xU3neb1FAkv2BmAFLuGBlDLcfKRoW8=;
        b=vnj1SQDl8mqR3MmD7DqMUdNfi9EUJZvJILOHciyG+VNOp6U0W8rfmn1+Xt31N+DcQi
         vDOnwVOnau8LUSczoJ0WHV2krITQHPokBhbZJC4BIkUnl+t4Dat/K/WTsgm/5X4H7YWQ
         zFVnHpsYmAev6RqZbkyoPpbxfEtuuC5V3kacc7B9jDIVJ86H3JkUSioH5iFiZXPAsk9u
         +2/qR/DZ7H515xlu6tv/Rw8xxaQ8v68Mmf2Mn0Ren3VUaznJd1IL/5goc6xepZl65XJt
         fP0AgfYdfvqQpcEsC69in5ywcxiT3s9Q3QxNfKI3qY3mYeuTNkzps4sk3UzAOewW8GKp
         JWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkZEBtgDxLwh8xU3neb1FAkv2BmAFLuGBlDLcfKRoW8=;
        b=4lDoVyZLXBYKCJL0yhbDAMnpS7clb0oZtAKoXIp7fvK8KU6XSg6xRUiLqTFACfGot1
         ef6gbeTLb4mZ4V1UX0heYjXz+8Tm7xKnKyB6VkB8pgM7FDfJu8Jno+MV47oFMhOfi3sK
         CPtCzc0Z/64bwZQYvy9rAeOXibmJgT+s0rlJWTrOgwtPvr4aVCiz0iIEFoS0RDJmd73V
         9BaBg/Ykjf9BepqPr4+S5wT5Pbpsrn358RNrj7zPZ/s/+PiLZjPENsyz2sF61FTb0fnf
         Ur8caX+3byKZvZgKJw0AlPJiNRfvqR42239edYrcPgd7DpEc4QcOZC21Qn3rQj8i+uFI
         123Q==
X-Gm-Message-State: ACrzQf23qWn2sU18u4wrtLI8JBKNlR4R7wn2BeEDtov3RDGup1OlDlEz
        IV3rI8d0h3OPH2yGzQvjT53uPEzwahRQQ7+VsyH/
X-Google-Smtp-Source: AMsMyM4PhU2aWuL/hCnXMmV01mOurB3yfd1swJ4U7viOAdtWTL7HzwxBLnJkoFMtxmc+5Qwsw+/v3/n+uTUZ8vvCy4s=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr36758992oap.172.1668025345426; Wed, 09
 Nov 2022 12:22:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
 <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
 <20221109143834.GB24561@mail.hallyn.com> <CAHC9VhQgEej_yKXRJFtLHUQkL8hGrBYqRPye5SwBz_SU+2eK2A@mail.gmail.com>
In-Reply-To: <CAHC9VhQgEej_yKXRJFtLHUQkL8hGrBYqRPye5SwBz_SU+2eK2A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 15:22:14 -0500
Message-ID: <CAHC9VhS9h2ZL=JZOoNK7Q+TDU7BSq3Jk2BqZ0nZExCfTvkuUuQ@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 3:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Nov 9, 2022 at 9:38 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Mon, Oct 31, 2022 at 12:22:29PM -0700, Linus Torvalds wrote:
> > > On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > A single patch to the capabilities code to fix a potential memory leak
> > > > in the xattr allocation error handling.  Please apply for v6.1-rcX.
> > >
> > > Pulled.
> > >
> > > However, I react to the strange test condition. Sure, it's
> > > pre-existing, but does it really make sense?
> > >
> > > It does
> > >
> > > +       if (ret < 0 || !tmpbuf) {
> > > +               size = ret;
> > > +               goto out_free;
> > > +       }
> > >
> > > and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?
> >
> > I had to go through the history a bit - the !tmpbuf check was added
> >
> > https://www.spinics.net/lists/stable/msg463010.html
> >
> > because of a gcc warning.  Perhaps there's a better way to tell gcc
> > that it can't remain NULL if ret was < 0 ?
>
> Ooof, that's ugly, but thanks for digging it up.  As it turns out I
> happen to be working on a patch for vfs_getxattr_alloc() to fix the
> return value type right now, but it looks like I'll leave that gcc
> hack in place ... although I might leave a comment about it so the
> next person doesn't have to wonder.

Actually, it looks like there are other similar conditions, e.g.
evm_is_immutable(), without such a check and my compiler (gcc v12.2.0)
seems okay with it; presumably they fixed the compiler bug?

I guess I'll leave the hack in place for commoncap.c but not propagate
it elsewhere.

-- 
paul-moore.com
