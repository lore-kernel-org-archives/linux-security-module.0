Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC9C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EE120578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/rKRHDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEGPBq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:01:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38795 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGPBq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:01:46 -0400
Received: by mail-yw1-f67.google.com with SMTP id b74so13338727ywe.5
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggE0IExwCjB4k6WIxmzSu8XLZh0z2mz6L+zqNhg63xo=;
        b=I/rKRHDcoy1zR0l1fLDiA0dDDETT3d5jF0dyIr6SPNq3ur0y+HVclnrCv7Nbnwtcwq
         kgGx69WLh/2s8tZY32vY8IKUYh4OnraZl+mW1fNWzLIwt3vKwK+0ueTOjkF60VK+QLKU
         tFS1wasWhenUTI2hb8miOiFuVW37jmEDeXzAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggE0IExwCjB4k6WIxmzSu8XLZh0z2mz6L+zqNhg63xo=;
        b=ISyfNYLxM99fK9+Y3vFJxFq/xS2m38iqFN/tvbWo11vzW/X9L21eqDLcX8BqMF0uyI
         hslrsd6WlvUNVXgDZT86fAVraz7EkEuo1oSqZx06duNi2Pc2P3PkXY07OYj5WTkvrsF7
         mmm20UvH9t0z2F1didTwGxdEzeq624on9hxNFwBsUGr5PWqKD8iaCzn4oxubS6OYvzk8
         TN1+FKB0Yl48GnmSQVhOEGOiBL7Cyawh/RAm9Q06vMii0ZGyx718O//0QSmblbPXg8xQ
         1I8dc8xZOOjPwOfON4s0QSZmaEV7QU7Fpff+JY1DrmPamrFBAt12bNObRBurejkwyej0
         0kIw==
X-Gm-Message-State: APjAAAWs9JLK6H9R4FPKL5Ocq6xY667XOn+fQdDPGX5T2wou+s/VAzXw
        aWqcGgQSvBOB5TAsqkPVSxncl6YhGoYG4Msf4vZUaQ==
X-Google-Smtp-Source: APXvYqxxXdA641IMZgkQ05k0vX6t9O7/RRfuOy1Uqwkxn96aypAds+RdzwhauTqUCopIC73Gxf2RJ34b2POju8ogpgs=
X-Received: by 2002:a25:9b05:: with SMTP id y5mr20176387ybn.464.1557241305848;
 Tue, 07 May 2019 08:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165541.210809-1-mortonm@chromium.org> <CAGXu5j+tssZ24eGXJ9cQ+EFyYCiAkS_i3+gk1O84OrJS=JXu3g@mail.gmail.com>
In-Reply-To: <CAGXu5j+tssZ24eGXJ9cQ+EFyYCiAkS_i3+gk1O84OrJS=JXu3g@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:34 -0700
Message-ID: <CAJ-EccOO3=8L-4ckX7=PW-7_jSnFthcscf0O70zKb0NacW=XxQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] LSM: SafeSetID: refactor safesetid_security_capable()
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Wed, Apr 10, 2019 at 10:14 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:55 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > At the moment, safesetid_security_capable() has two nested conditional
> > blocks, and one big comment for all the logic. Chop it up and reduce the
> > amount of indentation.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/lsm.c | 41 +++++++++++++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 15cd13b5a211..ab429e1816c5 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -55,21 +55,32 @@ static int safesetid_security_capable(const struct cred *cred,
> >                                       int cap,
> >                                       unsigned int opts)
> >  {
> > -       if (cap == CAP_SETUID &&
> > -           setuid_policy_lookup(cred->uid, INVALID_UID) != SIDPOL_DEFAULT) {
> > -               if (!(opts & CAP_OPT_INSETID)) {
> > -                       /*
> > -                        * Deny if we're not in a set*uid() syscall to avoid
> > -                        * giving powers gated by CAP_SETUID that are related
> > -                        * to functionality other than calling set*uid() (e.g.
> > -                        * allowing user to set up userns uid mappings).
> > -                        */
> > -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> > -                               __kuid_val(cred->uid));
> > -                       return -1;
> > -               }
> > -       }
> > -       return 0;
> > +       /* We're only interested in CAP_SETUID. */
> > +       if (cap != CAP_SETUID)
> > +               return 0;
> > +
> > +       /*
> > +        * If CAP_SETUID is currently used for a set*uid() syscall, we want to
> > +        * let it go through here; the real security check happens later, in the
> > +        * task_fix_setuid hook.
> > +        */
> > +       if ((opts & CAP_OPT_INSETID) != 0)
> > +               return 0;
> > +
> > +       /*
> > +        * If no policy applies to this task, allow the use of CAP_SETUID for
> > +        * other purposes.
> > +        */
> > +       if (setuid_policy_lookup(cred->uid, INVALID_UID) == SIDPOL_DEFAULT)
> > +               return 0;
> > +
> > +       /*
> > +        * Reject use of CAP_SETUID for functionality other than calling
> > +        * set*uid() (e.g. setting up userns uid mappings).
> > +        */
> > +       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> > +               __kuid_val(cred->uid));
> > +       return -1;
> >  }
> >
> >  /*
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
