Return-Path: <SRS0=sGvM=2B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494EEC43603
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1868A21556
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb4elsbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfLKONU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:13:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53821 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727554AbfLKONU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Dec 2019 09:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576073599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4QnOSSBZw+RFveGlVtYGut18qy1cO5+rgBazraGMQQ=;
        b=Jb4elsbubPh7XEUxA9GXdNVEKkoWtVaF6KkWm0LxISrRD9BFfclG0cVw3S92aPhRYNhrNt
        eSBMzsd07oBj8adqaKXOmnBq04Rhh9yFlrMztOeEg1BKJD9Tb2xg4RWCPu+2XM5tZoTkZ/
        0JtwxJqK1aJOcI1A6CVPT2ckMUQUBY8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Y31Kd1NjNVyYFVfrGYJbhA-1; Wed, 11 Dec 2019 09:13:18 -0500
Received: by mail-oi1-f200.google.com with SMTP id e22so8350873oig.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Dec 2019 06:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4b5F0uENwz+VCk3qzf5shza4SHXxPgU5HVjexN0YI0E=;
        b=n57oU5YR7o4NtnhR+TZ0PPOE+kELFe0WfjZLdyj0fxhMscRN0+m0vhGMjvGvZG95Zs
         0669g4jV0XSJrVOzlxez+VEqXlObFuruc8Rrrhh3SBP3+nvwhZih39DCP49hvmv4otiG
         KbNzAcbXe8/G+Mciqxy906ITu2XRFJ4AjNnq24eR7lqourmfLYa4t5Pa1b/6qeq3vYa0
         eNwamQymODkKR+9u+7ogETWRQxLpE67EUGitHdFHXgFPzuF2w8Z/Dlh9zt0j/SIJlBBy
         eJYzavONFUJ8Qruv/1orD6z1lSrukW97ZfSc+auZCwM1r+HirR2JFNG5/5UdO0W+RDeT
         WyDA==
X-Gm-Message-State: APjAAAX/+GLYst+KVTzzD0a6rQTwNwEg5m2Wqh23HL+V2bG+TnJIfhb1
        IX7yk1a26lDHF/uHi8rj3QpJHDY/IVS9RseXHItEikr40zI5/pdp4Op4WoO2rg86bjU/gQPW8FP
        wTVIoK+vnMDhtClX0ZohZmpCprYHSWYGsSabbWJu7S5qU0RqdVSYy
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3051450oib.26.1576073597634;
        Wed, 11 Dec 2019 06:13:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHw9j580VkG7WcpIgsqsb3hgSe9qfJQApYpzDQq0q3Fddy25H2uVjlYSUR8TpoL71tWen6T3hQ3dD1Ossw3m0=
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3051421oib.26.1576073597241;
 Wed, 11 Dec 2019 06:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com>
In-Reply-To: <20191211140833.939845-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 11 Dec 2019 15:13:06 +0100
Message-ID: <CAFqZXNu3HEU+RB5vRSLZ_SCLgQtC5we1hirvVo-o_3ntrnRPgQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: Y31Kd1NjNVyYFVfrGYJbhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 11, 2019 at 3:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> Instead of deleting the hooks from each list one-by-one (which creates
> some bad race conditions), allow an LSM to provide a reference to its
> "enabled" variable and check this variable before calling the hook.
>
> As a nice side effect, this allows marking the hooks (and other stuff)
> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
> for turning on the runtime disable functionality, to emphasize that this
> is only used by SELinux and is meant to be removed in the future.
>
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> This is an alternative to [1]. It turned out to be less simple than I
> had hoped, but OTOH the hook arrays can now be unconditionally made
> __ro_after_init so may be still worth it.
>
> Compile- and boot- tested with SECURITY_SELINUX_DISABLE set to =3Dy and
> =3Dn; SELinux enabled. Changes to other LSMs only compile-tested (but
> those are trivial).
>
> [1] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redh=
at.com/T/
>
>  include/linux/lsm_hooks.h    | 46 +++++++++----------------------
>  security/Kconfig             |  5 ----
>  security/apparmor/lsm.c      | 14 ++++++----
>  security/commoncap.c         | 11 +++++---
>  security/loadpin/loadpin.c   | 10 +++++--
>  security/lockdown/lockdown.c | 11 +++++---
>  security/safesetid/lsm.c     |  9 +++++--
>  security/security.c          | 52 +++++++++++++++++++++---------------
>  security/selinux/Kconfig     |  5 ++--
>  security/selinux/hooks.c     | 28 ++++++++++++++-----
>  security/smack/smack_lsm.c   | 11 +++++---
>  security/tomoyo/tomoyo.c     | 13 ++++++---
>  security/yama/yama_lsm.c     | 10 +++++--
>  13 files changed, 133 insertions(+), 92 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..91b77ebcb822 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -27,7 +27,6 @@
>
>  #include <linux/security.h>
>  #include <linux/init.h>
> -#include <linux/rculist.h>

I missed that there is still a hlist_add_tail_rcu() call left, so I'll
have to add this back in the next revision in case of positive
feedback for this patch.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

