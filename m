Return-Path: <SRS0=Tise=DA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD665C4363D
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ACF206FB
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVdfHrYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWOtL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgIWOtK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Sep 2020 10:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600872549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETSNxiXI+yjry/yJpYwlH0aMDlvxPokWa5gE+O5Gmjc=;
        b=NVdfHrYV4MVdO+ZbLyI9xzDjNaZ/MQ3Qwd86mzH3TVQqgXqjSaXdK+jHcPuwYIhhGHQOVb
        SZyyb+SaQnnrZpBMSLH/FxR58kU1mPQkNA/RGDOCyq66sU0Zb8EaY82rWuXCXzTnL1aeg1
        3lcj51DHbIiTFHS6YV3wbqCwnXfwdl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-5SZmONnIM9OW4_UoQrvtMA-1; Wed, 23 Sep 2020 10:49:06 -0400
X-MC-Unique: 5SZmONnIM9OW4_UoQrvtMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F2028ECE6B;
        Wed, 23 Sep 2020 14:49:05 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74D8C9CBA;
        Wed, 23 Sep 2020 14:48:55 +0000 (UTC)
Date:   Wed, 23 Sep 2020 10:48:52 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak120 V5] audit: trigger accompanying records when no
 rules present
Message-ID: <20200923144852.GK822320@madcap2.tricolour.ca>
References: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
 <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-09-23 10:29, Paul Moore wrote:
> On Tue, Sep 22, 2020 at 8:45 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > When there are no audit rules registered, mandatory records (config,
> > etc.) are missing their accompanying records (syscall, proctitle, etc.).
> >
> > This is due to audit context dummy set on syscall entry based on absence
> > of rules that signals that no other records are to be printed.  Clear the dummy
> > bit if any record is generated, open coding this in audit_log_start().
> >
> > The proctitle context and dummy checks are pointless since the
> > proctitle record will not be printed if no syscall records are printed.
> >
> > The fds array is reset to -1 after the first syscall to indicate it
> > isn't valid any more, but was never set to -1 when the context was
> > allocated to indicate it wasn't yet valid.
> >
> > Check ctx->pwd in audit_log_name().
> >
> > The audit_inode* functions can be called without going through
> > getname_flags() or getname_kernel() that sets audit_names and cwd, so
> > set the cwd in audit_alloc_name() if it has not already been done so due to
> > audit_names being valid and purge all other audit_getcwd() calls.
> >
> > Revert the LSM dump_common_audit_data() LSM_AUDIT_DATA_* cases from the
> > ghak96 patch since they are no longer necessary due to cwd coverage in
> > audit_alloc_name().
> >
> > Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
> > which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.
> >
> > Please see upstream github issue
> > https://github.com/linux-audit/audit-kernel/issues/120
> > This is also related to upstream github issue
> > https://github.com/linux-audit/audit-kernel/issues/96
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Chagelog:
> > v5:
> > - open code audit_clear_dummy() in audit_log_start()
> > - fix check for ctx->pwd in audit_log_name()
> > - open code _audit_getcwd() contents in audit_alloc_name()
> > - ditch all *audit_getcwd() calls
> >
> > v4:
> > - resubmit after revert
> >
> > v3:
> > - initialize fds[0] to -1
> > - init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
> > - init cwd for audit_inode{,_child}
> >
> > v2:
> > - unconditionally clear dummy
> > - create audit_clear_dummy accessor function
> > - remove proctitle context and dummy checks
> >
> >  include/linux/audit.h |  8 --------
> >  kernel/audit.c        |  3 +++
> >  kernel/auditsc.c      | 27 +++++++--------------------
> >  security/lsm_audit.c  |  5 -----
> >  4 files changed, 10 insertions(+), 33 deletions(-)
> 
> I've gone over this revision a couple of times now and it looks okay,
> but past experience is whispering in my ear that perhaps this is
> better to wait on this for the next cycle so it gets a full set of
> -rcX releases.  Thoughts?

I thought I had lots of time since we were just at the end of the
previous cycle when this failed the previous time...  Ran out yet
again...  (there were two weeks of PTO and a devel system rebuild in
there somewhere...)  It isn't my call.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

