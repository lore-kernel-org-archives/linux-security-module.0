Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B0BC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DFB20578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9zGjg+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEGPCH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:02:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40794 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGPCH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:02:07 -0400
Received: by mail-yw1-f65.google.com with SMTP id 18so8654811ywe.7
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeScbsp/IKK0pKPzfC+v/hGa+AjOYD35W0DPYXRLxGw=;
        b=X9zGjg+DeoaStr68A5ZmR/eTXP8GFMug9zKVLRcV37d19VqgRDxNAI5A/VOKAIiIYr
         NCSDaHuA4/iQp7tK0CFjnNiQsOcuItj6mpRytyMatpQZ8NB8Pcr5o5JkeHCxk9LxqdNx
         avAsFHPPmOd4VVzj1cTjOR9/Kh3tjyZb+ARHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeScbsp/IKK0pKPzfC+v/hGa+AjOYD35W0DPYXRLxGw=;
        b=oz98SkBCkxP+0K2n/1PH+TludsU5PPsatVcrWjhew7saEFGnTBXduNGkwtjAU8RlHm
         dy8UfPlRTEuKZsp5WA/GgQnFD1+n/tWQNHfI6GH+be3ksdTVThmdwyakT5c4mkCyd9mH
         wOh7CTzoNzuYQdET3uS2kF40EvCcAs3fTchAm4FJ22ucbfNfdjTZDY33kyRTuS+2yjVG
         D8+sFKxlXsuyRso296HkUIpN+3AD2pIH9cfCSW9/dUvPHcsq3567oMu3eZ/4NG+4P2Wg
         GSI2yuaFnOwfrvguEWl17TZ+amUXbiL0TgXypmwCBUh6byyLbF0yopv3wPxxyoHqnzf6
         nlKQ==
X-Gm-Message-State: APjAAAUodQbYaDvXXdZ+rrFup35MlTpT6/9j43a7BPWq5y8sdwMsfEwk
        iSH5T8yKfrrfQoV/ztS91CLyXDNEGc8Nbb+poq3gVQ==
X-Google-Smtp-Source: APXvYqyy60duiL/yZbzpYNqJVRRKQxGrv3F3Sp31qdE2WSWf1dwbI9+nV0dPWvibEygwBiIlG4KLZrnpqgpfxZFReak=
X-Received: by 2002:a25:3609:: with SMTP id d9mr19091724yba.260.1557241326490;
 Tue, 07 May 2019 08:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165558.211483-1-mortonm@chromium.org> <CAGXu5jJJTRgahj_hhiqkeWxLETWD5+=0800E0WNatq+3MrdPag@mail.gmail.com>
In-Reply-To: <CAGXu5jJJTRgahj_hhiqkeWxLETWD5+=0800E0WNatq+3MrdPag@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:55 -0700
Message-ID: <CAJ-EccPp2cqoiRcb=R2JNt5fDByT9AXA+Y_q8VWNuyxTj2PRAw@mail.gmail.com>
Subject: Re: [PATCH 06/10] LSM: SafeSetID: fix userns handling in securityfs
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

On Wed, Apr 10, 2019 at 10:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > Looking at current_cred() in write handlers is bad form, stop doing that.
> >
> > Also, let's just require that the write is coming from the initial user
> > namespace. Especially SAFESETID_WHITELIST_FLUSH requires privilege over all
> > namespaces, and SAFESETID_WHITELIST_ADD should probably require it as well.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/securityfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > index 87e42b7f3e33..76c1e8a6ab93 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -59,8 +59,8 @@ static int parse_policy_line(
> >         if (ret)
> >                 return ret;
> >
> > -       *parent = make_kuid(current_user_ns(), parsed_parent);
> > -       *child = make_kuid(current_user_ns(), parsed_child);
> > +       *parent = make_kuid(file->f_cred->user_ns, parsed_parent);
> > +       *child = make_kuid(file->f_cred->user_ns, parsed_child);
> >         if (!uid_valid(*parent) || !uid_valid(*child))
> >                 return -EINVAL;
> >
> > @@ -92,7 +92,7 @@ static ssize_t safesetid_file_write(struct file *file,
> >         kuid_t child;
> >         int ret;
> >
> > -       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
> > +       if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
> >                 return -EPERM;
> >
> >         if (*ppos != 0)
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
