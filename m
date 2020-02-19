Return-Path: <SRS0=QiiV=4H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B98C34050
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0A2464E
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+WyVCnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSPm3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:42:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41014 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBSPm2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 10:42:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so24182835oie.8
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=m+WyVCnjj1MKoR4h4JIOlgp2fjMP9yF/DEMlRuSkziBg37L/i9PeB+qwHQtq+5TBM6
         SooNA0Wk6Ljhtp5qSzPtSknsnL4DWgLfrCjYHytGQKdcv6POKVRKZfNj2WLGQm/nydCI
         tLJnBS44YGa0T/JV/3kNf+/psgr2j9ltjMIFFiTi5//ha9SRMrTDUxEcO7tDYtXyCNU0
         0W+ISMm5w6/KIDLxt6/6C3JAxunTLQr6+KHCnpMaj0TdKqHVbfPLbNK5F/nDNzZq3/LD
         fJURS56rYXEp2uY/mJftWB6gjcZlAAKUD1/slAZtFwMjuk9DFgtmJPrszBy2PNb1wk3w
         XhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=Vb+G6TMhLJHdhrQ6rYCfa4Nyw7HFuw7dyx5WZmhGfi1JZdlezNdgW7fww8td5LliWg
         5QJGAZ6LWee8nZOACWgjGGIf2cX6iPUa9Kjj4sc1mq5UJAt9ENgclRFz76GSGUiXV7Hi
         uSX34rgf60qEX2kRzlJoblfEQz2VCv0zO/TbJ18XJQe4mBH2yq9R3uR+CGDWqYNyYXa2
         9941Hu4HL2fM12PVYh2xTaLJHsfQcQpi+AEDDjLBZKD6v5ov9hFijDLcUFAmEOjLMF/A
         dE29VKGIA9RzWQjmIxGeptGTk1BI5gO9+8Jc+vXcVjkfuhqQ2yunKI715sKXgNL60ova
         lEiA==
X-Gm-Message-State: APjAAAX2b9PTGycJNwdI5YC39QbKmEnBpip0/M+ymLF9YOLm55pDIEMf
        +zeVWZOut2VOc6i7NPEXKht06qU90eu1zrORU1Sgvw==
X-Google-Smtp-Source: APXvYqzYVTetcJbLAR2lHbzroMwjo5ViVjvR49a/DJvQymhESORCu2lQOkJU6wuyq4SCG9SAJgJJeWDh3Spsw3GeH0I=
X-Received: by 2002:aca:484a:: with SMTP id v71mr5008155oia.39.1582126947895;
 Wed, 19 Feb 2020 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-25-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-25-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:42:01 +0100
Message-ID: <CAG48ez3onfVSYF_qx+jJuz0y+KuZ3U75Or8dxFhiDqMTdXzCZg@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] sys: handle fsid mappings in set*id() calls
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 18, 2020 at 3:37 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Switch set*id() calls to lookup fsids in the fsid mappings. If no fsid mappings
> are setup the behavior is unchanged, i.e. fsids are looked up in the id
> mappings.
[...]
> @@ -353,7 +354,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>         const struct cred *old;
>         struct cred *new;
>         int retval;
> -       kgid_t krgid, kegid;
> +       kgid_t krgid, kegid, kfsgid;
>
>         krgid = make_kgid(ns, rgid);
>         kegid = make_kgid(ns, egid);
> @@ -385,12 +386,20 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>                         new->egid = kegid;
>                 else
>                         goto error;
> +               kfsgid = make_kfsgid(ns, egid);
> +       } else {
> +               kfsgid = kgid_to_kfsgid(new->user_ns, new->egid);
> +       }

Here the "kfsgid" is the new filesystem GID as translated by the
special fsgid mapping...

> +       if (!gid_valid(kfsgid)) {
> +               retval = -EINVAL;
> +               goto error;
>         }
>
>         if (rgid != (gid_t) -1 ||
>             (egid != (gid_t) -1 && !gid_eq(kegid, old->gid)))
>                 new->sgid = new->egid;
> -       new->fsgid = new->egid;
> +       new->kfsgid = new->egid;

... but the "kfsgid" of the creds struct is translated by the normal
gid mapping...

> +       new->fsgid = kfsgid;

... and the local "kfsgid" is stored into the "fsgid" member.

This is pretty hard to follow. Can you come up with some naming scheme
that is clearer and where one name is always used for the
normally-translated fsgid and another name is always used for the
specially-translated fsgid? E.g. something like "pfsgid" (with the "p"
standing for "process", because it uses the same id mappings as used
for process identities) for the IDs translated via the normal gid
mapping?
