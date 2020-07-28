Return-Path: <SRS0=UUiA=BH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D0BC433E4
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DB62074F
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRZeaKfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgG1Q1l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:27:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30741 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731372AbgG1Q1k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jul 2020 12:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595953658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ4NipVG4iPDCpcGLYscE38HzgmR7OQBW2u5YbpezBA=;
        b=MRZeaKfAM/8f5XrAxHcOBx/wWJhbt+OKRMb1zcTAZIX7S1unsmgQfmeg8YNdUfdqXr1q0n
        Jz0U8MR12LOpUuLp+XpPzMSb88SizMoFGC3tSjaAWTDic+Hhhb+ZbrTJUvRWh0627IwjfW
        p44wK7EV5YXU8ZeFZJfVXj1X/60q0RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-wZfrCqvSMjOJxX9bLuJRtw-1; Tue, 28 Jul 2020 12:27:34 -0400
X-MC-Unique: wZfrCqvSMjOJxX9bLuJRtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE598015F7;
        Tue, 28 Jul 2020 16:27:33 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC0C60BF4;
        Tue, 28 Jul 2020 16:27:24 +0000 (UTC)
Date:   Tue, 28 Jul 2020 12:27:22 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3fix ghak120] audit: initialize context values in case
 of mandatory events
Message-ID: <20200728162722.djvy3qyclj57wsfn@madcap2.tricolour.ca>
References: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
 <CAHC9VhSx23JiN6GprskxdEcs9uftJOp03Svh7YJbQLOV91AMiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSx23JiN6GprskxdEcs9uftJOp03Svh7YJbQLOV91AMiQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-27 22:14, Paul Moore wrote:
> On Mon, Jul 27, 2020 at 5:30 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Issue ghak120 enabled syscall records to accompany required records when
> > no rules are present to trigger the storage of syscall context.  A
> > reported issue showed that the cwd was not always initialized.  That
> > issue was already resolved ...
> 
> Yes and no.  Yes, it appears to be resolved in v5.8-rc1 and above, but
> the problematic commit is in v5.7 and I'm not sure backporting the fix
> in v5.8-rcX plus this patch is the right thing to do for a released
> kernel.  The lowest risk fix for v5.7 at this point is to do a revert;

Ok, fair enough.  I don't understand why you didn't do the revert since
it appears so trivial to you and this review and fix turned out to be
marginally more work.  I didn't understand what you wanted when you
referred to stable.

> regardless of what happens with this patch and v5.8-rcX please post a
> revert for the audit/stable-5.7 tree as soon as you can.

(more below...)

> > ... but a review of all other records that could
> > be triggered at the time of a syscall record revealed other potential
> > values that could be missing or misleading.  Initialize them.
> >
> > The fds array is reset to -1 after the first syscall to indicate it
> > isn't valid any more, but was never set to -1 when the context was
> > allocated to indicate it wasn't yet valid.
> >
> > The audit_inode* functions can be called without going through
> > getname_flags() or getname_kernel() that sets audit_names and cwd, so
> > set the cwd if it has not already been done so due to audit_names being
> > valid.
> >
> > The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
> > missed with the ghak96 patch, so add that case here.
> >
> > Please see issue https://github.com/linux-audit/audit-kernel/issues/120
> > Please see issue https://github.com/linux-audit/audit-kernel/issues/96
> > Passes audit-testsuite.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditsc.c     | 3 +++
> >  security/lsm_audit.c | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6884b50069d1..2f97618e6a34 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -929,6 +929,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
> >         context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
> >         INIT_LIST_HEAD(&context->killed_trees);
> >         INIT_LIST_HEAD(&context->names_list);
> > +       context->fds[0] = -1;
> >         return context;
> >  }
> >
> > @@ -2076,6 +2077,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
> >         }
> >         handle_path(dentry);
> >         audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
> > +       _audit_getcwd(context);
> >  }
> >
> >  void __audit_file(const struct file *file)
> > @@ -2194,6 +2196,7 @@ void __audit_inode_child(struct inode *parent,
> >                 audit_copy_inode(found_child, dentry, inode, 0);
> >         else
> >                 found_child->ino = AUDIT_INO_UNSET;
> > +       _audit_getcwd(context);
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_inode_child);
> >
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 53d0d183db8f..e93077612246 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >                                         audit_log_untrustedstring(ab, p);
> >                                 else
> >                                         audit_log_n_hex(ab, p, len);
> > +                               audit_getcwd();
> >                                 break;
> >                         }
> >                 }
> 
> I understand the "fds[0] = -1" fix in audit_alloc_context()
> (ironically, the kzalloc() which is supposed to help with cases like
> this, hurts us with this particular field), but I'm still not quite
> seeing why we need to sprinkle audit_getcwd() calls everywhere to fix
> this bug (this seems more like a feature add than a bigfix).  Yes,
> they may fix the problem but it seems like simply adding a
> context->pwd test in audit_log_name() similar to what we do in
> audit_log_exit() is the correct fix.

Well, considering that ghak96 ended up being a bugfix (that wasn't its
intent), I figured these audit_getcwd() were also bugfixes to prevent
the same BUG under different calling conditions.

> We are currently at -rc7 and this really needs to land before v5.8 is
> released, presumably this weekend; this means a small and limited bug
> fix patch is what is needed.

Ok, so it sounds like rather than just fix it now, it would be better to
revert it, then submit *one* patch for ghak120 plus this fix that will
go tentatively upstream in 3 months, fully in 5.  Arguably the last
chunk above should be added to ghak96, so that should be reverted too,
then resubmitted with this added chunk (or it could be a fixup chunk
that would need to be sequenced with ghak120).  As for the middle two
chunks, they could either be resubmitted with a resubmitted ghak96, or
with a resubmitted ghak120.  As for the timing of all of these, ghak96
should be in place before the ghak120 patch, so even resubmitting one
patch for the combined ghak120 and ghak96 might make more sense.

I know you like only really minimal fixes this late, but this seemed
pretty minimal to me...

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

