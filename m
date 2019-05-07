Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF55C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E88D20578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9c3RsdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGPBO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:01:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34992 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEGPBO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:01:14 -0400
Received: by mail-yw1-f67.google.com with SMTP id n188so13482510ywe.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8fTPHt78sgDK++PbgkPDJz9lUJARrfo72555qlOW6o=;
        b=I9c3RsdFwyqzLCoHq+72r7OqYziTozPm7EW1WuEhS2cJukPoQaLFx8xhhBwYnqNGbS
         aG3DahTEL+Masg6M9pQYylgpJhLeqSCnV5aEVqSAwIk87JzntQIgJTOgKCgv0WV44l29
         w8z16aVCPwdJxe1Qn26BJSEFZdBNAvZU1WOXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8fTPHt78sgDK++PbgkPDJz9lUJARrfo72555qlOW6o=;
        b=kZKIlkmGi30Sx2M2CNkdSu+FI/QXiqmnzyC8Eqo2axTe/evf+/9VS3FMT0RfjM5G8c
         X75iB9+gAhma2nSDfDOFx+Anw7EUwsJTMFX3ELr+haThBmlWXaf39k7RuDQzonpTlHjv
         YNimHMrHSFnDO/N1R3uNiOhZHYF3HdCuJCgbnu7dTeoWz6w7yMLG4+rdQVRXoDeA964l
         QtnpmGXVoAhoFwcsZCti6zSKg1ldDbgVUD11nmiMazheg7mTlls+3lDNpixg58Gs3IiC
         ELf2Jhd2YYFZz5qaF0OUB0k88NBcMxIiEQiA6YoV0Iqy/K3qLx4uVMnm7g/mMWlAj3iT
         F/5w==
X-Gm-Message-State: APjAAAUCuphrGLQAemm/SfbPnI9HNsoe31ZCV7c/3fE5s97A/rh6CmJK
        9DRujj+BvYKQp8dZQxT7kxeosm3OXFCZVZWtrjrejg==
X-Google-Smtp-Source: APXvYqzAhlzP0mdbF3h37QacPT2Oo2kh4Ux6ZYEvS8s3j0IqAeeZaVds72m73VJ/emkPYW8PhYIsXAyEjR4p/FS4kUw=
X-Received: by 2002:a25:14c1:: with SMTP id 184mr12015642ybu.17.1557241273325;
 Tue, 07 May 2019 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165434.206579-1-mortonm@chromium.org> <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com>
 <CAJ-EccPz3fZXR-485szP28kTsFLN=Y6040GacxdNuSn9io-kPw@mail.gmail.com> <alpine.LRH.2.21.1905070939100.12945@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905070939100.12945@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:02 -0700
Message-ID: <CAJ-EccMBBPBjU7xc8HMD0Ae3NZGoS=CHxTKuNxTvujs4fbUczg@mail.gmail.com>
Subject: Re: [PATCH 01/10] LSM: SafeSetID: fix pr_warn() to include newline
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ok, this ones ready for merge.

On Mon, May 6, 2019 at 4:39 PM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 6 May 2019, Micah Morton wrote:
>
> > These 10 patches got buried, but Jann, Kees and myself are in
> > agreement on how they look.
> >
> > Could they get merged? Patches 8/10 and 9/10 have a v2 that should get
> > merged instead of the originals. I can respond on all the patches that
> > should get merged if that is helpful?
>
> Please do so.
>
> >
> > On Wed, Apr 10, 2019 at 10:09 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 9:54 AM Micah Morton <mortonm@chromium.org> wrote:
> > > >
> > > > From: Jann Horn <jannh@google.com>
> > > >
> > > > Fix the pr_warn() calls in the SafeSetID LSM to have newlines at the end.
> > > > Without this, denial messages will be buffered as incomplete lines in
> > > > log_output(), and will then only show up once something else prints into
> > > > dmesg.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > -Kees
> > >
> > > > ---
> > > >  security/safesetid/lsm.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > > > index cecd38e2ac80..2daecab3a4c0 100644
> > > > --- a/security/safesetid/lsm.c
> > > > +++ b/security/safesetid/lsm.c
> > > > @@ -91,7 +91,7 @@ static int safesetid_security_capable(const struct cred *cred,
> > > >                          * to functionality other than calling set*uid() (e.g.
> > > >                          * allowing user to set up userns uid mappings).
> > > >                          */
> > > > -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
> > > > +                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> > > >                                 __kuid_val(cred->uid));
> > > >                         return -1;
> > > >                 }
> > > > @@ -103,7 +103,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
> > > >  {
> > > >         if (check_setuid_policy_hashtable_key_value(parent, child))
> > > >                 return 0;
> > > > -       pr_warn("UID transition (%d -> %d) blocked",
> > > > +       pr_warn("UID transition (%d -> %d) blocked\n",
> > > >                 __kuid_val(parent),
> > > >                 __kuid_val(child));
> > > >         /*
> > > > --
> > > > 2.21.0.392.gf8f6787159e-goog
> > > >
> > >
> > >
> > > --
> > > Kees Cook
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
