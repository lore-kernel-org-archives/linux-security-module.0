Return-Path: <SRS0=nJ8u=CY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3917C43461
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Sep 2020 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3EB20809
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Sep 2020 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aEbKay3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgIOWVA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgIOQ3P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Sep 2020 12:29:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3908C0610D6
        for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2020 09:18:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so5956791eja.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2020 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0mv4M4l2nXHs6Svit7zs9nE44kkP6iF2KX8026tPck=;
        b=aEbKay3bCmBiTfuAaJd77hIEi9+Kw0g3PDChuYJcgXHJf2oC5kT/zW4He15ru2Owe4
         SJIcPq3qkUhWkIqt2My6LyuEeJ8U1imOmecNuI6dmaF6Ti5zaBU25uFfzGle/ggCrnF7
         4W47fIWC79MHWglkkozI1z/gLawMzs+TJZvz4k6Zpxvn1BAMkr7YQ2PLmD9ctvc+7Wh5
         HkW2WHVD44SXjvvIK/Mu08ybxUgNdiRomdqxc2AQbfvJODIOf73myAfL1QDoinH2Sxm/
         GPBm5HAZzBRGEY/Dxp7BjKT0Ti1wB4NC5dUPUU0R+oQbv1hV6jfnbOWPhibT6xkES2/B
         TfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0mv4M4l2nXHs6Svit7zs9nE44kkP6iF2KX8026tPck=;
        b=l0EdEU8HEnCTu02XCHtqOkxSPmVuZLskytJxhnisizyyVM+0Cia0qqLsqJNi142YL2
         pdg2s31mkmMNWYZvAnjgA9XgE7XpZc9UjIk0GP77p0f/cSyyYWPAplPhz0t+HW+QQPN6
         6adpXbRo7bi2b98SPVwzLZY1xZR6i727vVn8lNRXR42VQyWO3XkV5u45/bO1UU6e9AEB
         Wc6qqBChT9OJf0xYh0jQE4LUgaat2MbyGf+VDSDwWSpF6kaoINL/nSzVP6rhPzk8gGll
         J/GXy5HbO7q7VWxXiLhqQgVtaNmFOGXy5/rn7Md1nVnnjwP/IfeT/FK3yFbZpJvHoz0g
         21yA==
X-Gm-Message-State: AOAM530TrkmnrrMRQ1WGYNXdye6r+LyYLG+Y2hA2k/sGP5bUVgZAfp0n
        id+aUwkwNkC3NGQnj1byZxRRCZ16hrTaoJBs/107B8Sd3g==
X-Google-Smtp-Source: ABdhPJxny13HvsaUqVxMWx5bF/rrnCtepSvA1uRTJTMmx/17hKcUCAJC1b3PEJgPQ8cwJP2qYXjcNKeS/f0LDK1p2XA=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr4248389eja.488.1600186706771;
 Tue, 15 Sep 2020 09:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <35f2b8c69b4b9abbc076dd55a6f0f52cf20abad7.1599687447.git.rgb@redhat.com>
In-Reply-To: <35f2b8c69b4b9abbc076dd55a6f0f52cf20abad7.1599687447.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Sep 2020 12:18:15 -0400
Message-ID: <CAHC9VhRN33KcW2dL1KJZZJC_Sg4JEdBJdnecRz6SB+PQ0BSg9A@mail.gmail.com>
Subject: Re: [[PATCH V4]] audit: trigger accompanying records when no rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 10, 2020 at 11:03 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> When there are no audit rules registered, mandatory records (config,
> etc.) are missing their accompanying records (syscall, proctitle, etc.).
>
> This is due to audit context dummy set on syscall entry based on absence
> of rules that signals that no other records are to be printed.
>
> Clear the dummy bit if any record is generated.
>
> The proctitle context and dummy checks are pointless since the
> proctitle record will not be printed if no syscall records are printed.
>
> The fds array is reset to -1 after the first syscall to indicate it
> isn't valid any more, but was never set to -1 when the context was
> allocated to indicate it wasn't yet valid.
>
> The audit_inode* functions can be called without going through
> getname_flags() or getname_kernel() that sets audit_names and cwd, so
> set the cwd if it has not already been done so due to audit_names being
> valid.
>
> The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
> missed with the ghak96 patch, so add that case here.
>
> Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
> which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.
>
> Please see upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/120
> This is also related to upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/96
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
> Chagelog:
> v4:
> - rebase on audit/next v5.9-rc1
> - squash v2+v3fix
> - add pwd NULL check in audit_log_name()
> - resubmit after revert
>
> v3:
> - initialize fds[0] to -1
> - init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
> - init cwd for audit_inode{,_child}
>
> v2:
> - unconditionally clear dummy
> - create audit_clear_dummy accessor function
> - remove proctitle context and dummy checks
>
>  kernel/audit.c       |  1 +
>  kernel/audit.h       |  8 ++++++++
>  kernel/auditsc.c     | 11 +++++++----
>  security/lsm_audit.c |  1 +
>  4 files changed, 17 insertions(+), 4 deletions(-)

Comments below, but can you elaborate on if any testing was done
beyond the audit-testsuite?

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 3b9c0945225a..abcfef58435b 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -290,6 +290,13 @@ extern int audit_signal_info_syscall(struct task_struct *t);
>  extern void audit_filter_inodes(struct task_struct *tsk,
>                                 struct audit_context *ctx);
>  extern struct list_head *audit_killed_trees(void);
> +
> +static inline void audit_clear_dummy(struct audit_context *ctx)
> +{
> +       if (ctx)
> +               ctx->dummy = 0;
> +}

With the only caller being audit_log_start(), should this be moved to
kernel/audit.c?  I'm just not sure this is something we would ever
need (or want) to call from elsewhere, thoughts?

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8dba8f0983b5..9d2de93f40b3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1367,7 +1368,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>                         /* name was specified as a relative path and the
>                          * directory component is the cwd
>                          */
> -                       audit_log_d_path(ab, " name=", &context->pwd);
> +                       if (&context->pwd)

Hmm, I don't think this is going to work the way you are intending; I
believe this will always evaluate to true regardless of the state of
context->pwd.  If you look elsewhere in kernel/auditsc.c you will see
some examples of checking to see if context->pwd is valid (e.g.
_audit_getcwd() and audit_log_exit()).

> +                               audit_log_d_path(ab, " name=", &context->pwd);
> +                       else
> +                               audit_log_format(ab, " name=(null)");
>                         break;
>                 default:
>                         /* log the name's directory component */...

> @@ -2079,6 +2080,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>         }
>         handle_path(dentry);
>         audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> +       _audit_getcwd(context);
>  }
>
>  void __audit_file(const struct file *file)
> @@ -2197,6 +2199,7 @@ void __audit_inode_child(struct inode *parent,
>                 audit_copy_inode(found_child, dentry, inode, 0);
>         else
>                 found_child->ino = AUDIT_INO_UNSET;
> +       _audit_getcwd(context);
>  }
>  EXPORT_SYMBOL_GPL(__audit_inode_child);
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 53d0d183db8f..e93077612246 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>                                         audit_log_untrustedstring(ab, p);
>                                 else
>                                         audit_log_n_hex(ab, p, len);
> +                               audit_getcwd();
>                                 break;
>                         }
>                 }

I'm starting to wonder if audit is doing this wrong (it is audit after
all) ... why not just fetch the cwd in audit_log_exit() if there are
entries in the context->names_list?  The only time we care about
logging the working dir is when we actually have PATH records, right?
My initial thinking is that we can simplify a lot of code if we just
add a audit_getcwd() call in audit_log_exit() if the
context->names_list is not empty.  We should even be safe in the task
exit case as the fs info appears to get cleaned up *after*
audit_log_exit() is called.

Assuming we go this route, we can probably get rid of all the
audit_getcwd() calls outside of the audit code (e.g. the lsm_audit.c
code).  I guess we would need to make sure things still behave the
same for chdir(2), getcwd(2), etc. but even if we have to insert one
or two audit_getcwd() calls in that case we should still come out on
top (although I suspect the necessary calls are already being made).

-- 
paul moore
www.paul-moore.com
