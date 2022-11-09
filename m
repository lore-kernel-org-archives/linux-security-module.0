Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F58C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKIUNy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIUNx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 15:13:53 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125118B01
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 12:13:52 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id v81so20024157oie.5
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 12:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yB6HYvhBN3RVAfByHn6Mj6M7PU8T8ZuDtIlSesRugqE=;
        b=VtxYfuoGycTMs/QNDj9C6posySpJrMmYbilDidHZq1CwdThPJ/+bdO/MJdPm02wVdU
         5iEOsZO1oFUxuaFqMobK45DfcdHrKECbAoOali2jJsGPjr6GpXh3T2y5aOfg7+j3qpnF
         562x3bIoj/U+6gKdODz4stYBWXhNYu1gqL/TC2crukFXRf8ErgkxOGm6eBjsoK49zMVG
         kRiIy6SaKG9aPrbVhXh8KqW5wuSAd/otKoZwOSAnayoPx+fqPGgCXOxSCelrVw+ezn/p
         /PRt62ouWHWm2RxCTUkUXjh9HsdrjjLOfTN+kTCDdr6XTL9fZ/+/LAfZ1FRUQ9fELiEt
         NZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB6HYvhBN3RVAfByHn6Mj6M7PU8T8ZuDtIlSesRugqE=;
        b=LMkK99LzGFHisXqHgtuPbHge/w6U8lyX9I3m85jALKJQ3fVd7epTs95i5Udv7TPIGQ
         UNly2RtFVqSO75zpbAes+Me8evNaEGpYVhQMB3Z7PTdTODzEj9bjhIdfrO32Hp6Gl9Kp
         LrYNDFP38PvmUKqENaJkUB3hf9BM22Dlp7BwLtOtMsKOWXfYL1WEuff43saK9qB44yG6
         ODGINhMIHe2sAN7lsyahriDgeiOUONobmX0s3PsrC/K0e2iIKZU/4cclof7bnnycT7l9
         C2HbSLbzpmp8z5a0evxAnipmj16Hv1oQ1VORXSmSq81WHZkXAIbwDM+1XLU994re1xm/
         bNZg==
X-Gm-Message-State: ACrzQf04mEHCiIni6sYuOMxqtfLCPMmglyGV+DOqaX4qvkf/u51So/ln
        XFPNzpfYS244a3XRH/1AR2E1Ip10SLrdsJNacaGcTfuHUw==
X-Google-Smtp-Source: AMsMyM5BiojzHXd3s4SlDdTvp7SrcHcpqQ50w/EPBngyxCmha1b/OAMd3Pgv35j8TsHD4WyA9o3YivK76j3kF8CPULE=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr19974152oiv.172.1668024831341; Wed, 09
 Nov 2022 12:13:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
 <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com> <20221109143834.GB24561@mail.hallyn.com>
In-Reply-To: <20221109143834.GB24561@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 15:13:40 -0500
Message-ID: <CAHC9VhQgEej_yKXRJFtLHUQkL8hGrBYqRPye5SwBz_SU+2eK2A@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 9:38 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Mon, Oct 31, 2022 at 12:22:29PM -0700, Linus Torvalds wrote:
> > On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > A single patch to the capabilities code to fix a potential memory leak
> > > in the xattr allocation error handling.  Please apply for v6.1-rcX.
> >
> > Pulled.
> >
> > However, I react to the strange test condition. Sure, it's
> > pre-existing, but does it really make sense?
> >
> > It does
> >
> > +       if (ret < 0 || !tmpbuf) {
> > +               size = ret;
> > +               goto out_free;
> > +       }
> >
> > and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?
>
> I had to go through the history a bit - the !tmpbuf check was added
>
> https://www.spinics.net/lists/stable/msg463010.html
>
> because of a gcc warning.  Perhaps there's a better way to tell gcc
> that it can't remain NULL if ret was < 0 ?

Ooof, that's ugly, but thanks for digging it up.  As it turns out I
happen to be working on a patch for vfs_getxattr_alloc() to fix the
return value type right now, but it looks like I'll leave that gcc
hack in place ... although I might leave a comment about it so the
next person doesn't have to wonder.

> > I think that's not only impossible in the first place, but if it *was*
> > possible, then that
> >
> >                 size = ret;
> >                goto out_free;
> >
> > would be wrong, because this function would return success even if it
> > wasn't successful.
> >
> > That whole "cast to int, and then cast back to size_t" also smells of
> > some serious confusion in the return value handling. It looks to me
> > like vfs_getxattr_alloc() fundamentally returns an 'int', not a
> > 'ssize_t', just by looking at the ->get function. But it just all
> > looks weird.
> >
> > So this code has all kinds of oddities.
> >
> >                Linus

-- 
paul-moore.com
