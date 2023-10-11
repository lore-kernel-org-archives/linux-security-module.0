Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D4CD6E5D
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Oct 2023 12:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjJKMRk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Oct 2023 08:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjJKMR1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Oct 2023 08:17:27 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0FDF2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Oct 2023 05:17:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7d9d357faso11778017b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Oct 2023 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697026642; x=1697631442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIwwSVPQgNdZrWxFWOKz+2uIJcJJpTj8JRe+NnP9VHY=;
        b=LZfqlEFB66enpkByNrCJLWD1XzkygJVu38cM3b8tPbCRW2660S2BK8kOSBmngCuzYN
         L31g56pVSheWxnDUgN2pCGV8i6RlK/lAWDaAvK6QmxRPAIqRVsAe6ASNCT3+wcNDtxbc
         YH3wl8lkWzjSdV2K8wGRX7mstshrkktmuSwRyuIxumCc390tC3BzmvrKq3mbrErmRDun
         QS1ydHoYwHiWHISP4nr75RuwxggEuOF1ablY5RWQyM1lKhJfDvmVnQi20C2wQvMDVyeU
         vKDNc8Ej1Lk2cLx1E4q4dwJY1hBpzqCRznL+FZFQ3uoFZggIYsFbm+uK5b/RTiXDjYwc
         ysDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026642; x=1697631442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIwwSVPQgNdZrWxFWOKz+2uIJcJJpTj8JRe+NnP9VHY=;
        b=v/yy6Ss3DxGdQclo0GB1xukgSDZrmxUrAtyTKfgVlWkISmYwjqu1iCHDFZMgqeu5Pc
         b+43Nn/grUkn4T0MxECxhendoqprAMO5SXSRNPZCCIVWmayBhI268FtJjv8ux1nINGBu
         k4pbro5iQqe4s0AUOfvwekWlztHoyvAE9dFJq2cpdaMSXKhokg0+ss7xTkWBrf/zH1qf
         RYdMn5G2eJqqkwvqgUBvgGDgfSrGxMBcsQ64zrp4jDe7FbJ5YsLggDwZ2xVUxOoYkzo7
         ABiDYpbihE9DPvb2wZvAD4ed/Dh//cU0ef4H4BzKIKo1/aXallKPUg904+ApdYILy+XK
         p3QQ==
X-Gm-Message-State: AOJu0YyIzafyXtP3aGDTpm1tzepuI9HuzBRaKFm4U3LNxih/FzTIZIP2
        HphvqghN8ueVfoCiO35mDd+mONUQbvGdKxLZL8H/aw==
X-Google-Smtp-Source: AGHT+IHdsGpUl2F/ABzPt0MiHqRLMOqD782Zj3S2K92UY3MNeAlMxM0Dfsb02ulGGkYsBm28PZa268wbqGdNjOa9tuA=
X-Received: by 2002:a05:690c:dd2:b0:5a4:f7d3:394e with SMTP id
 db18-20020a05690c0dd200b005a4f7d3394emr28388983ywb.14.1697026642640; Wed, 11
 Oct 2023 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org> <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
 <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org> <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
In-Reply-To: <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 17:47:11 +0530
Message-ID: <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > Do bind neither static calls nor trusted_key_exit() before a successful
> > > > init, in order to maintain a consistent state. In addition, depart the
> > > > init_trusted() in the case of a real error (i.e. getting back something
> > > > else than -ENODEV).
> > > >
> > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> > > > Cc: stable@vger.kernel.org # v5.13+
> > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > >  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
> > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > >                 if (!get_random)
> > > >                         get_random = kernel_get_random;
> > > >
> > > > -               static_call_update(trusted_key_seal,
> > > > -                                  trusted_key_sources[i].ops->seal);
> > > > -               static_call_update(trusted_key_unseal,
> > > > -                                  trusted_key_sources[i].ops->unseal);
> > > > -               static_call_update(trusted_key_get_random,
> > > > -                                  get_random);
> > > > -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > -               migratable = trusted_key_sources[i].ops->migratable;
> > > > -
> > > >                 ret = trusted_key_sources[i].ops->init();
> > > > -               if (!ret)
> > > > +               if (!ret) {
> > > > +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > +                       static_call_update(trusted_key_get_random, get_random);
> > > > +
> > > > +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > +                       migratable = trusted_key_sources[i].ops->migratable;
> > > > +               }
> > > > +
> > > > +               if (!ret || ret != -ENODEV)
> > >
> > > As mentioned in the other thread, we should allow other trust sources
> > > to be initialized if the primary one fails.
> >
> > I sent the patch before I received that response but here's what you
> > wrote:
> >
> > "We should give other trust sources a chance to register for trusted
> > keys if the primary one fails."
> >
> > 1. This condition is lacking an inline comment.
> > 2. Neither this response or the one that you pointed out has any
> >    explanation why for any system failure the process should
> >    continue.
> >
> > You should really know the situations (e.g. list of posix error
> > code) when the process can continue and "allow list" those. This
> > way way too abstract. It cannot be let all possible system failures
> > pass.
>
> And it would nice if it printed out something for legit cases. Like
> "no device found" etc. And for rest it must really withdraw the whole
> process.

IMO, it would be quite tricky to come up with an allow list. Can we
keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
these are all debatable.

The original intention to iterate through the trust source list was to
allow a single Linux kernel binary to support platforms with varying
trust sources (one or choose one from multiple) available. IMO, any
restriction on the basis of error codes here since we can't predict
them correctly may forfeit this intended use-case.

-Sumit

>
> BR, Jarkko
