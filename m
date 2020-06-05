Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CABC433DF
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 22:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FAD2065C
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 22:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMtIFlv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFEWwI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgFEWwI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 18:52:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB54C08C5C2
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 15:52:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x93so8630558ede.9
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ifucp6OHqM/ToXZ8ZM6gAg4Um7XcxYbCChtEUHehvdI=;
        b=kMtIFlv/N8flzXbI9/Ou126Ea2CLhR66tABhPwYJR1NbO0qJgUnQmBhkN2+y/Phbpj
         vjYLeDhrS+DKNvYf+/LhfgWlUFEP818EwfquWH4USPj4HVZ4+rw8/2rIm6xr/b4S8C0p
         LehKYPuM5G9Bwy2cLgPP4JKYw35SZ0aonmzKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ifucp6OHqM/ToXZ8ZM6gAg4Um7XcxYbCChtEUHehvdI=;
        b=M9fheLcB0jwPWvmxDqhyFGjFrbjEqLjOpBNas/R0hawYbaaUn3TLA2rYPc3kVy72lo
         U1EXd1rQq3ItdglNxzSfhNmmln69xOQK3rG/0jxp5dMFRd2p+7K8O+SCPO+d5XYLUDtj
         xqfjYrz2t39yJPhiH3RLGd8aSSUxMmZl0JFH89kjXd64HE65Snl89AUAs9lQSrUU9Cpa
         sMQ+C0eHbBZU+34F0cya2vW8ERbbJP1jmCMmtw9NdilgdEwmuAIeaiPqD2CGcw/2tKtp
         JO8JU+8xiCWPMArGBYmatew9vxtmsuh5gNiCUmHiLP0MUDZdP7QgGNl7a2m9W4JCAvSn
         OMJg==
X-Gm-Message-State: AOAM5312s6+oTIEFy65znWzBV2ZRuRHoNFI9kK9qWfxBvtvqpK7t3IXD
        mGydeP+gpQIbruAqHZ0RMtiqPjr0HXztBERR6CatDr9E
X-Google-Smtp-Source: ABdhPJwcpwe5JacgVpNK0I+b/UmalP62QGJZsQuEngT4+t8e6SUDJjANTGTxzGv+749kgswTZfyZTQ3bMZ4svXUx6i4=
X-Received: by 2002:a05:6402:b13:: with SMTP id bm19mr11732230edb.82.1591397526440;
 Fri, 05 Jun 2020 15:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200605193805.36531-1-mortonm@chromium.org> <202006051421.2168E5AA8@keescook>
In-Reply-To: <202006051421.2168E5AA8@keescook>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 5 Jun 2020 15:51:56 -0700
Message-ID: <CAJ-EccNorW2Y++hO3cC-iWWFAeGsfiGTS1jd2oUsVx1ZSySdiQ@mail.gmail.com>
Subject: Re: [PATCH] security: Add LSM hooks to set*gid syscalls
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        thomascedeno@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 5, 2020 at 2:25 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 05, 2020 at 12:38:05PM -0700, Micah Morton wrote:
> > The SafeSetID LSM uses the security_task_fix_setuid hook to filter
> > set*uid() syscalls according to its configured security policy. In
> > preparation for adding analagous support in the LSM for set*gid()
> > syscalls, we add the requisite hook here. Tested by putting print
> > statements in the security_task_fix_setgid hook and seeing them get hit
> > during kernel boot.
> >
> > From: Thomas Cedeno <thomascedeno@google.com>
>
> ^^^ this line should be before the commit log body (many tools won't
> find it here).
>
> > Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
> > Reviewed-by: Micah Morton <mortonm@chromium.org>
> > ---
> > NOTE: I (Micah) will send this patch as a pull request to Linus through
> > my SafeSetID tree if there are no objections.
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/lsm_hooks.h     |  9 +++++++++
> >  include/linux/security.h      |  9 +++++++++
> >  kernel/sys.c                  | 15 ++++++++++++++-
> >  security/security.c           |  6 ++++++
> >  5 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index fb3ce6cec997..d5401c09f2d3 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -191,6 +191,8 @@ LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
> >        loff_t size, enum kernel_read_file_id id)
> >  LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
> >        int flags)
> > +LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
> > +      int flags)
> >  LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
> >  LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
> >  LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 3e62dab77699..8012b610fe53 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -659,6 +659,15 @@
> >   *   @old is the set of credentials that are being replaces
> >   *   @flags contains one of the LSM_SETID_* values.
> >   *   Return 0 on success.
> > + * @task_fix_setgid:
> > + *     Update the module's state after setting one or more of the group
> > + *     identity attributes of the current process.  The @flags parameter
> > + *     indicates which of the set*gid system calls invoked this hook.
> > + *     @new is the set of credentials that will be installed.  Modifications
> > + *     should be made to this rather than to @current->cred.
> > + *     @old is the set of credentials that are being replaced.
> > + *     @flags contains one of the LSM_SETID_* values.
> > + *     Return 0 on success.
>
> The indenting here appears to be using spaces instead of a tab.
>
> Everything else looks okay. (There are a surprising number of gid
> changing places...)

Ah thanks! I'll fix those 2 things before doing the pull request.
Probably not worth doing a patch resend.

Will still give it some time to see if anyone else wants to comment.

>
> --
> Kees Cook
