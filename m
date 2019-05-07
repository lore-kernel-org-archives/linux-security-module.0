Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF20C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392CF205ED
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+aUPma3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEGQuH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 12:50:07 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36278 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfEGQuH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 12:50:07 -0400
Received: by mail-it1-f195.google.com with SMTP id o190so9741436itc.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63aS8sw/F6TbFDrFEXocdEEMHZPL4FvOqcqCevO4sME=;
        b=b+aUPma3TglgwH487SfmIB7REm9jQysSs7M3oCS9cLdD+EKk/akhC12UsQ8hjSGgow
         ewisgXEwvi+Fi1kIDwqqWtyKi+tlmuoZOnmeppe+T1A7827eJDeW6QVLFl+Y3yI/dxtK
         y0HcWoZ0gNrMbcfn6G8gR4B+vlusMlZb16q2CEN/+ACbG0lHtSFYCuCmdIZwmqj5VgOn
         yhMfpGO28hYP98+Xt1cB+p9rFVXDEIYHbIBTHe7fci8cfUlIaqhajJpP9xSCDLcOTnWP
         9sw5mUPF+Uml4i9ob3b2ii/Ixpnk1J0HaSbBfW+06fro1kWNCu65f0eRM6YHoy6yWbQa
         F/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63aS8sw/F6TbFDrFEXocdEEMHZPL4FvOqcqCevO4sME=;
        b=VugoOhx+RqgJqQajU5DzQwuhozlBoE/beXnRWpl8oNY7sEBPDnsIND99UQbPKgMumh
         aB/XDbPJbvxv32b6BH555rtu/5WWc7MTKvJeY9gi5/maKJqIJbG6Nacn7tZu8Pnwick+
         2lKk7aUAy9iTANntgXlLKH86RgHxGdBcLMCvwOoqEE71tCSu9u43pCIXj+i8sYDcZB0q
         I6+SR5kAkT17IbUL4kSNuHexiXKU7eSLn10J+djG4EQiu6twujkgMMNzZANKf0SaPEPo
         0gAhyZQdZY1glElk3rIfXKS0hX26A1jr8V8X1r+XfASG7ht9hfXGARZ4530WrAt0CJCH
         f2fQ==
X-Gm-Message-State: APjAAAUn0Dqmnmt3eMwF0STq0wc38egszy1R1TG7aM9WUb1B5BVLQOXe
        RRdZcr2xqBy5dheTo+oxX9T4Pa1W2QN7YEU6UkOoFLMs2Ig=
X-Google-Smtp-Source: APXvYqxzth9IKsPEFkDrrK3bO5U41uEddyjBZ/yl2Ruv45VyJD+8D08iOLya/TolHIwnn0CCJNuAsNSp/VQVzyd1ll8=
X-Received: by 2002:a02:b88b:: with SMTP id p11mr23443279jam.82.1557247806425;
 Tue, 07 May 2019 09:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1905080244530.13589@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905080244530.13589@namei.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 May 2019 18:49:54 +0200
Message-ID: <CACT4Y+ZGMHbJjNfA_jO_KDVxaa6eVVkhxdyr-EkH3Umy8v_p_w@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Don't emit WARNING: string while fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: James Morris <jmorris@namei.org>
Date: Tue, May 7, 2019 at 6:45 PM
To: Tetsuo Handa
Cc: <linux-security-module@vger.kernel.org>, Dmitry Vyukov

> On Tue, 7 May 2019, Tetsuo Handa wrote:
>
> > Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
> > testing.") enabled the learning mode, and syzbot started crashing by
> > encountering this warning message. Disable this warning if built for
> > fuzzing testing; otherwise syzbot can't start fuzzing testing.
>
> syzbot crashed? Sounds like a bug in syzbot which should be fixed rather
> than this approach.

syzbot did not crash, it detected this as kernel crash.

> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  security/tomoyo/util.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
> > index 0517cbd..52752e1 100644
> > --- a/security/tomoyo/util.c
> > +++ b/security/tomoyo/util.c
> > @@ -1076,8 +1076,10 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
> >               domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
> >               /* r->granted = false; */
> >               tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
> > +#ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
> >               pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
> >                       domain->domainname->name);
> > +#endif
> >       }
> >       return false;
> >  }
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
