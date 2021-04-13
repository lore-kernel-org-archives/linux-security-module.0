Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077EC433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Apr 2021 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D534B61278
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Apr 2021 08:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhDMINn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241607AbhDMINl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Apr 2021 04:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618301601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLyUzT5M5en0X4VIingKMBNaeYaSW+6rovobSSA9k74=;
        b=Lja0P/0VQwFxjnsvoftM9cJvFqY9nFVQIv/6FyumD5ebWzqKQPGya9s+t9Gdt3eMKTpscE
        GoArjcNQvho9CeeaEwZAcDJWf8MwRFr/cedN83zYCXICLoCOVZjMHupiA76vGiI3WZQzLX
        s9ZAEv7ctmgyjiVcT2z81P4Jc01wYUQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-b8GQxmAyOBa3ciJRJ4fK7Q-1; Tue, 13 Apr 2021 04:13:18 -0400
X-MC-Unique: b8GQxmAyOBa3ciJRJ4fK7Q-1
Received: by mail-yb1-f200.google.com with SMTP id u128so15362718ybf.12
        for <linux-security-module@vger.kernel.org>; Tue, 13 Apr 2021 01:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLyUzT5M5en0X4VIingKMBNaeYaSW+6rovobSSA9k74=;
        b=I1/kdaLXhwohVj7/4lkIJYHGThvSdORQdHP35KNtneFYla/gukr3gr3zrpulORkbu6
         zU4cmVx9+1XCrgRo1pZVXjk7O5Gcushp0IKMd+zL1jeCDhfRZu/4BgbmTSVKHfQC5Z90
         OeEHmqNX53tvKUl1/trdl7Xm0AWvX9FP2UPCQRZMvn8cC0Jnk9nlhtKWEfdVlRP7hl3X
         pf2rt1qwgWaNedQhmvkuzpnf+2trxFkbuw/8Yc+Fy0TpxiBrojFIHuZrUL1CsP2AADnJ
         RkTJGxpiVF67EdNakcT+Gvadt+yv8AH/15vkUTHZalK1sFywD3NRpRg5GDSEbAdq3j1C
         ZblA==
X-Gm-Message-State: AOAM531KI3GQPqg/jqw3NAnPEZOK3vgmDXGF3bIh1PyWBTLKlsT8JPQ4
        6gIMd8oV9hef3LqOVr1dhKHu8KxZdxyRkXUfnDCkyu1/8yzH6eIdq7gqnFCdqxybCvi6YBhXh0Q
        fbVzxAlGT3nQjEXp+H64R3VGu/IEd3RDnErNozAizmazP6bgK8O/f
X-Received: by 2002:a25:ce09:: with SMTP id x9mr7099184ybe.81.1618301597499;
        Tue, 13 Apr 2021 01:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZMvsTkqUxAY9JNxCpjjk3fc9GGC9EFicegDOlF/Jpnn3EnjqB4N6bPUo4PnYHL4tsk1GsNBMxRJOZZ531USk=
X-Received: by 2002:a25:ce09:: with SMTP id x9mr7099155ybe.81.1618301597217;
 Tue, 13 Apr 2021 01:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191012005747.210722465@goodmis.org> <20191012005921.580293464@goodmis.org>
In-Reply-To: <20191012005921.580293464@goodmis.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 13 Apr 2021 10:13:04 +0200
Message-ID: <CAFqZXNs4eRC6kjFRe6CdwA-sng-w6bcJZf5io+hoLKwM98TVSA@mail.gmail.com>
Subject: Re: [PATCH 7/7 v2] tracing: Do not create tracefs files if tracefs
 lockdown is in effect
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Herton Krzesinski <hkrzesin@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Oct 12, 2019 at 2:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> If on boot up, lockdown is activated for tracefs, don't even bother creating
> the files. This can also prevent instances from being created if lockdown is
> in effect.
>
> Link: http://lkml.kernel.org/r/CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  fs/tracefs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index eeeae0475da9..0caa151cae4e 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -16,6 +16,7 @@
>  #include <linux/namei.h>
>  #include <linux/tracefs.h>
>  #include <linux/fsnotify.h>
> +#include <linux/security.h>
>  #include <linux/seq_file.h>
>  #include <linux/parser.h>
>  #include <linux/magic.h>
> @@ -390,6 +391,9 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>         struct dentry *dentry;
>         struct inode *inode;
>
> +       if (security_locked_down(LOCKDOWN_TRACEFS))
> +               return NULL;
> +
>         if (!(mode & S_IFMT))
>                 mode |= S_IFREG;
>         BUG_ON(!S_ISREG(mode));
> --
> 2.23.0

Hi all,

sorry for coming back to an old thread, but it turns out that this
patch doesn't play well with SELinux's implementation of the
security_locked_down() hook, which was added a few months later (so
not your fault :) in commit 59438b46471a ("security,lockdown,selinux:
implement SELinux lockdown").

What SELinux does is it checks if the current task's creds are allowed
the lockdown::integrity or lockdown::confidentiality permission in the
policy whenever security_locked_down() is called. The idea is to be
able to control at SELinux domain level which tasks can do these
sensitive operations (when the kernel is not actually locked down by
the Lockdown LSM).

With this patch + the SELinux lockdown mechanism in use, when a
userspace task loads a module that creates some tracefs nodes in its
initcall SELinux will check if the task has the
lockdown::confidentiality permission and if not, will report denials
in audit log and prevent the tracefs entries from being created. But
that is not a very logical behavior, since the task loading the module
is itself not (explicitly) doing anything that would breach
confidentiality. It just indirectly causes some tracefs nodes to be
created, but doesn't actually use them at that point.

Since it seems the other patches also added security_locked_down()
calls to the tracefs nodes' open functions, I guess reverting this
patch could be an acceptable way to fix this problem (please correct
me if there is something that this call catches, which the other ones
don't). However, even then I can understand that you (or someone else)
might want to keep this as an optimization, in which case we could
instead do this:
1. Add a new hook security_locked_down_permanently() (the name is open
for discussion), which would be intended for situations when we want
to avoid doing some pointless work when the kernel is in a "hard"
lockdown that can't be taken back (except perhaps in some rescue
scenario...).
2. This hook would be backed by the same implementation as
security_locked_down() in the Lockdown LSM and left unimplemented by
SELinux.
3. tracefs_create_file() would call this hook instead of security_locked_down().

This way it would work as before relative to the standard lockdown via
the Lockdown LSM and would be simply ignored by SELinux. I went over
all the security_locked_down() call in the kernel and I think this
alternative hook could also fit better in arch/powerpc/xmon/xmon.c,
where it seems to be called from interrupt context (so task creds are
irrelevant, anyway...) and mainly causes some values to be redacted.
(I also found a couple minor issues with how the hook is used in other
places, for which I plan to send patches later.)

Thoughts?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

