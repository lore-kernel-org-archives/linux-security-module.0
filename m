Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC11C47071
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Nov 2023 04:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjKPEhF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Nov 2023 23:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjKPEhE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 23:37:04 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6ADA
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 20:37:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so358462276.0
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 20:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109420; x=1700714220; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcqBDslEmUQAJysV7NyEk8RtIXTzf0hWr6mvwOKWDyA=;
        b=PXhnFekGIWzVPsypOgHt32CEwNh5r2iv6RfOtMxpdRbv8VoXy3NK1a4aSsScUSFKtP
         BnEj3tOPXPYcTZDSNMw5qblXqzmtEMr6jeNA/g5XqPDaksYEUA3YQRAqtrbqsjx+Ous7
         io3/KwBiGyDy6h1aXSKjfPymm/yyXofGDC2LRb6gz6Ac4u+HoA86WZpg/Z8Ao/h+XpR0
         cwsMaC4BFQQie3paSfZHBm8oN6cj9w8bWjXXO6QWGeGwUJT8pxEiUvb3OqMIEKHjlrx0
         XLySwmRfVagLPGVhLj+5vrXYIqTxsS3shTayDINVfeZ6rW/Rmq2xk3c2eJXxcBIPxCWI
         GMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109420; x=1700714220;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcqBDslEmUQAJysV7NyEk8RtIXTzf0hWr6mvwOKWDyA=;
        b=VYgE9+HPq/C4pCOoaKBavvHI4y/RoO4n14WlJScNayLN7VOtMGl3JcquvGauNMcbdg
         fJ+FtDmrHRvqsd010jCHwVYXYMa3Js2GAclo3L8JLQfu3x0rmyL4t6kK+hEliNydDxGu
         PqLtT/q09SbgGuSMKAtDur4bbZB2XRAFtXhxd4ckyICVoS6Im8dRmNZ+bBWDSjOY3e7d
         rnFAk6pM1ju5Ek4+xmV8OaATtI35BjxYKCRXVTA9qf57Zc+qis7o51bxOoe3DQX9U6iJ
         89VZ+YzASV9YCLo809nRq5ApPZKBO5CL0k/EVJHUs4poD9KtWB9RE3ZDb+1rTJ0qW5jO
         qs+Q==
X-Gm-Message-State: AOJu0Yy+6i3InqrdNOAW5/mQ9GkoVGFPpo1IIW/XcOOCL2gHBbqEzzMT
        k3jJ1eFSHS8CHfETPGzQl+tzLOQKVYlrFcRnOSBUiebWTdORxS8=
X-Google-Smtp-Source: AGHT+IFHGfn1tt8Pen1o9yDU00rzkJq2q6Jitvpj8Uxph9rFiHFPc265HGOUzE8IgYE60HDx7MvzmkhZQjHr5wfN7p4=
X-Received: by 2002:a25:3ca:0:b0:da0:52e4:b5aa with SMTP id
 193-20020a2503ca000000b00da052e4b5aamr13876662ybd.8.1700109420481; Wed, 15
 Nov 2023 20:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20231115164832.100894-2-paul@paul-moore.com> <CAHC9VhToYWVTmXmmXMdGE3XZcBV65RrFWvFaYX+nWd-Mr6k=yA@mail.gmail.com>
In-Reply-To: <CAHC9VhToYWVTmXmmXMdGE3XZcBV65RrFWvFaYX+nWd-Mr6k=yA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Nov 2023 23:36:49 -0500
Message-ID: <CAHC9VhSjAvDPiUtisP8mNbdPwvi6-8uJUbgoRv0GzYZ5-c_qtg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM entry
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 15, 2023 at 12:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Wed, Nov 15, 2023 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Bring the LSM / "SECURITY SUBSYSTEM" entry up to date with the
> > following changes:
> >
> > * Remove the "(suggested Cc:)" note on the mailing list.  I don't
> > really care if the LSM list is on the To: or Cc: line, I just want
> > folks to include it when appropriate.
> >
> > * Remove the website link.  The website isn't really maintained in
> > any meaningful way so we're going to go ahead and remove it so we
> > lessen the chance of conflicting or confusing information in the
> > future.
> >
> > * Add our patchwork link.  I'm not sure this is of much use for
> > anyone but the maintainer, but there is a provision for including it
> > here so we might as well include it.
> >
> > * Add a bug report URI.  I suspect most everyone knows to send mail
> > to the mailing list if they hit a bug, but let's make it official.
> >
> > * Add a link to the LSM tree process/management documentation.  While
> > the doc exists both in the canonical kernel.org location and the
> > GitHub mirror, provide a link to the mirror as GitHub does a better
> > job rendering the Markdown.
> >
> > * Aside from changes to the LSM code itself, we also would like to be
> > notified when the LSMM call sites are changed so we are adding a
> > security_XXX(...) regex to try and catch all of the callers.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2482b40fd786..007e43ee3e47 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19507,14 +19507,17 @@ SECURITY SUBSYSTEM
> >  M:     Paul Moore <paul@paul-moore.com>
> >  M:     James Morris <jmorris@namei.org>
> >  M:     "Serge E. Hallyn" <serge@hallyn.com>
> > -L:     linux-security-module@vger.kernel.org (suggested Cc:)
> > +L:     linux-security-module@vger.kernel.org
> >  S:     Supported
> > -W:     http://kernsec.org/
> > +Q:     https://patchwork.kernel.org/project/linux-security-module/list
> > +B:     mailto:linux-security-module@vger.kernel.org
> > +P:     https://github.com/LinuxSecurityModule/kernel/blob/main/README.=
md
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
>
> Unfortunately I didn't realize this until the patch hit my inbox, but
> I should also update the tree location to use https instead of git.
> I'll fix that when I merge the patch.

Merged into lsm/dev.

--=20
paul-moore.com
