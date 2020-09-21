Return-Path: <SRS0=i+Ac=C6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F4C4727C
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 23:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230DE23A60
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 23:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DepQq7sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIUXcC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Sep 2020 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgIUXcC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Sep 2020 19:32:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D524C0613CF
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 16:32:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a12so14390523eds.13
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+StbR8l+iINKxdKhhC9txI9lzzieJVqBdRCPZv/6Ho=;
        b=DepQq7shpg7ekeVfm9HNfqa6yN6Jm3pPgP763w0uduaMsldIKXbnVK14rvVfcKKZRD
         D+VcCmxqHftJcqzasAMsJwEqimKfm1Gj2S4o5ULBsxUScK1tvRsPn0P0QWTBYM6S3+m+
         lzCGSLHuHBLOhmXHY0+tEcDEoCavDR/ZOHpMhuVxIk55syGVG5UWs7hODFCl22FbIumW
         B/+TNvbCY27XBKFa12jD8EIZOU0Aen+dUVJNgKloJyZuK0QFa9W3dqlw30t3ugQeH+f2
         ugsAAg7bqiBCaXrfH7EghxTWfhddvkjfDDEqdLCQYfVwryK9Ah0UgL40JXaSJbfa43Qv
         ACNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+StbR8l+iINKxdKhhC9txI9lzzieJVqBdRCPZv/6Ho=;
        b=Uvs/CGGB39FdmN+fkOWVklGvAnlqHOkkh35t7Y+0+8RcDVG0a1l0qzeJ7cjsRuBnsl
         Hj0Ktqjt5b1i5Y1V23DIs+efJ+8TgHyjICanmqP0FPhF/xMwgrk6uZW32a+nNsIXg5F3
         KwoF5KCLx1Mz1rFE6vauDRX6qr/pn1QSNCXsvbph4K6Zqt7HUvPs5FqryAzzHIdDEGKd
         6UX1wBy/LoiLFRbGmTPuIlnkm58tzhA1Y0bDqHbvF4heqkjDz/30zJcXhQlYnpT8sm6w
         zJcouB7/vdwdBwKtYnIAvxQB8qn5muqPc1Agq0SYVdLJ/UlarAq3rlqbeTaciPVVvwIt
         kQSA==
X-Gm-Message-State: AOAM530rfqu5s0vyBA+Rcd/DSBSyBStTptL6L10SWtsTprl7RO/gLZDW
        WpeHUATYyikCNLcLSsHcYXYSb4vfPJAQic9iW+cZ
X-Google-Smtp-Source: ABdhPJz/GswSld2uh/zJGMdxdAOo8yrU4fDUXpk2a3TP2x+vmMQJTppKsxJPPBsYwlKJSV0XmbSFDcWI7lcaypeaT5Y=
X-Received: by 2002:a50:fc0b:: with SMTP id i11mr1283170edr.164.1600731120381;
 Mon, 21 Sep 2020 16:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <35f2b8c69b4b9abbc076dd55a6f0f52cf20abad7.1599687447.git.rgb@redhat.com>
 <CAHC9VhRN33KcW2dL1KJZZJC_Sg4JEdBJdnecRz6SB+PQ0BSg9A@mail.gmail.com> <20200921195655.GH822320@madcap2.tricolour.ca>
In-Reply-To: <20200921195655.GH822320@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Sep 2020 19:31:49 -0400
Message-ID: <CAHC9VhR2Xqp1wVe6UmLgGryyp_5bGwSHzgpVEdixKP6Y4srewA@mail.gmail.com>
Subject: Re: [[PATCH V4]] audit: trigger accompanying records when no rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 21, 2020 at 3:57 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-09-15 12:18, Paul Moore wrote:
> > On Thu, Sep 10, 2020 at 11:03 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > When there are no audit rules registered, mandatory records (config,
> > > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> > >
> > > This is due to audit context dummy set on syscall entry based on absence
> > > of rules that signals that no other records are to be printed.
> > >
> > > Clear the dummy bit if any record is generated.
> > >
> > > The proctitle context and dummy checks are pointless since the
> > > proctitle record will not be printed if no syscall records are printed.
> > >
> > > The fds array is reset to -1 after the first syscall to indicate it
> > > isn't valid any more, but was never set to -1 when the context was
> > > allocated to indicate it wasn't yet valid.
> > >
> > > The audit_inode* functions can be called without going through
> > > getname_flags() or getname_kernel() that sets audit_names and cwd, so
> > > set the cwd if it has not already been done so due to audit_names being
> > > valid.
> > >
> > > The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
> > > missed with the ghak96 patch, so add that case here.
> > >
> > > Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
> > > which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.
> > >
> > > Please see upstream github issue
> > > https://github.com/linux-audit/audit-kernel/issues/120
> > > This is also related to upstream github issue
> > > https://github.com/linux-audit/audit-kernel/issues/96
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > Passes audit-testsuite.
> > >
> > > Chagelog:
> > > v4:
> > > - rebase on audit/next v5.9-rc1
> > > - squash v2+v3fix
> > > - add pwd NULL check in audit_log_name()
> > > - resubmit after revert
> > >
> > > v3:
> > > - initialize fds[0] to -1
> > > - init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
> > > - init cwd for audit_inode{,_child}
> > >
> > > v2:
> > > - unconditionally clear dummy
> > > - create audit_clear_dummy accessor function
> > > - remove proctitle context and dummy checks
> > >
> > >  kernel/audit.c       |  1 +
> > >  kernel/audit.h       |  8 ++++++++
> > >  kernel/auditsc.c     | 11 +++++++----
> > >  security/lsm_audit.c |  1 +
> > >  4 files changed, 17 insertions(+), 4 deletions(-)
> >
> > Comments below, but can you elaborate on if any testing was done
> > beyond the audit-testsuite?
>
> Yes, it was tested with audit-testsuite and bauen1's reproducer
>
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index 3b9c0945225a..abcfef58435b 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -290,6 +290,13 @@ extern int audit_signal_info_syscall(struct task_struct *t);
> > >  extern void audit_filter_inodes(struct task_struct *tsk,
> > >                                 struct audit_context *ctx);
> > >  extern struct list_head *audit_killed_trees(void);
> > > +
> > > +static inline void audit_clear_dummy(struct audit_context *ctx)
> > > +{
> > > +       if (ctx)
> > > +               ctx->dummy = 0;
> > > +}
> >
> > With the only caller being audit_log_start(), should this be moved to
> > kernel/audit.c?  I'm just not sure this is something we would ever
> > need (or want) to call from elsewhere, thoughts?
>
> Yes, move it, or better yet just open code it.

Sure.  It might also help to put a one-liner comment in there about why.

> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index 8dba8f0983b5..9d2de93f40b3 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -1367,7 +1368,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
> > >                         /* name was specified as a relative path and the
> > >                          * directory component is the cwd
> > >                          */
> > > -                       audit_log_d_path(ab, " name=", &context->pwd);
> > > +                       if (&context->pwd)
> >
> > Hmm, I don't think this is going to work the way you are intending; I
> > believe this will always evaluate to true regardless of the state of
> > context->pwd.  If you look elsewhere in kernel/auditsc.c you will see
> > some examples of checking to see if context->pwd is valid (e.g.
> > _audit_getcwd() and audit_log_exit()).
>
> Sorry for the ctx->pwd.dentry/mnt brainfart, the compiler *did*
> complain.

That begs the question: why did you submit the patch?  I don't want to
dwell too much on this, but compilers are pretty smart these days,
it's best not to ignore their warnings unless you are *really* sure
you are right.

> > > +                               audit_log_d_path(ab, " name=", &context->pwd);
> > > +                       else
> > > +                               audit_log_format(ab, " name=(null)");
> > >                         break;
> > >                 default:
> > >                         /* log the name's directory component */...
> >
> > > @@ -2079,6 +2080,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
> > >         }
> > >         handle_path(dentry);
> > >         audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> > > +       _audit_getcwd(context);
> > >  }
> > >
> > >  void __audit_file(const struct file *file)
> > > @@ -2197,6 +2199,7 @@ void __audit_inode_child(struct inode *parent,
> > >                 audit_copy_inode(found_child, dentry, inode, 0);
> > >         else
> > >                 found_child->ino = AUDIT_INO_UNSET;
> > > +       _audit_getcwd(context);
> > >  }
> > >  EXPORT_SYMBOL_GPL(__audit_inode_child);
> > >
> > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > index 53d0d183db8f..e93077612246 100644
> > > --- a/security/lsm_audit.c
> > > +++ b/security/lsm_audit.c
> > > @@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> > >                                         audit_log_untrustedstring(ab, p);
> > >                                 else
> > >                                         audit_log_n_hex(ab, p, len);
> > > +                               audit_getcwd();
> > >                                 break;
> > >                         }
> > >                 }
> >
> > I'm starting to wonder if audit is doing this wrong (it is audit after
> > all) ... why not just fetch the cwd in audit_log_exit() if there are
> > entries in the context->names_list?  The only time we care about
> > logging the working dir is when we actually have PATH records, right?
> > My initial thinking is that we can simplify a lot of code if we just
> > add a audit_getcwd() call in audit_log_exit() if the
> > context->names_list is not empty.  We should even be safe in the task
> > exit case as the fs info appears to get cleaned up *after*
> > audit_log_exit() is called.
>
> > Assuming we go this route, we can probably get rid of all the
> > audit_getcwd() calls outside of the audit code (e.g. the lsm_audit.c
> > code).  I guess we would need to make sure things still behave the
> > same for chdir(2), getcwd(2), etc. but even if we have to insert one
> > or two audit_getcwd() calls in that case we should still come out on
> > top (although I suspect the necessary calls are already being made).
>
> Or just open code audit_getcwd() in audit_alloc_name() and kill all
> audit_getcwd() calls since it is audit_names that is populated as the
> result of a call to audit_alloc_name().
>
> How does this look?: 4 files changed, 9 insertions(+), 33 deletions(-)

It looks like a diffstat ... ?  I'm guessing you meant to copy-n-paste
a diff here?

-- 
paul moore
www.paul-moore.com
