Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C54C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 23:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B3F20772
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 23:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DF6PjmMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGHXPH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:15:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbgGHXPH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 19:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594250105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OytB3quZY1eP1hAcswU5NCJlCCNbci/6JgQPYAMn2as=;
        b=DF6PjmMY+KtPf4akL3URqRRCAtIi8X2TBUDl/LUPEQCZBddfO/rJ4OZH4BC54QDnLDryO1
        LdIBQ9Xot0OhcPudJqe1S1HxKfxzGcPNKOE8J+BXVX3xT39pR16+I67fjymr48R7hB89YO
        FQCgoroR1cAxUorIUMEx/qa52mgezuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-yw7hg5-cPP-hlQUYP92gCA-1; Wed, 08 Jul 2020 19:15:03 -0400
X-MC-Unique: yw7hg5-cPP-hlQUYP92gCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F9581005504;
        Wed,  8 Jul 2020 23:15:02 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB9A19C4F;
        Wed,  8 Jul 2020 23:14:54 +0000 (UTC)
Date:   Wed, 8 Jul 2020 19:14:51 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@parisplace.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, john.johansen@canonical.com
Subject: Re: [PATCH ghak84 v3] audit: purge audit_log_string from the
 intra-kernel audit API
Message-ID: <20200708231451.7t7cadrqhrp357is@madcap2.tricolour.ca>
References: <20597345545df186f0a287c974c9dc88b5c940a0.1593808662.git.rgb@redhat.com>
 <CAHC9VhQT2O9GnVBhXvzpP+yNNoCqy-XTfMC7OHqz3xvFVaGvdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQT2O9GnVBhXvzpP+yNNoCqy-XTfMC7OHqz3xvFVaGvdw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-08 18:41, Paul Moore wrote:
> On Fri, Jul 3, 2020 at 5:50 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > audit_log_string() was inteded to be an internal audit function and
> > since there are only two internal uses, remove them.  Purge all external
> > uses of it by restructuring code to use an existing audit_log_format()
> > or using audit_log_format().
> >
> > Please see the upstream issue
> > https://github.com/linux-audit/audit-kernel/issues/84
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Passes audit-testsuite.
> >
> > Changelog:
> > v3
> > - fix two warning: non-void function does not return a value in all control paths
> >         Reported-by: kernel test robot <lkp@intel.com>
> >
> > v2
> > - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> >
> > v1 Vlad Dronov
> > - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> >
> >  include/linux/audit.h     |  5 -----
> >  kernel/audit.c            |  4 ++--
> >  security/apparmor/audit.c | 10 ++++------
> >  security/apparmor/file.c  | 25 +++++++------------------
> >  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> >  security/apparmor/net.c   | 14 ++++++++------
> >  security/lsm_audit.c      |  4 ++--
> >  7 files changed, 46 insertions(+), 62 deletions(-)
> 
> ...
> 
> > diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> > index 597732503815..335b5b8d300b 100644
> > --- a/security/apparmor/audit.c
> > +++ b/security/apparmor/audit.c
> > @@ -57,18 +57,16 @@ static void audit_pre(struct audit_buffer *ab, void *ca)
> >         struct common_audit_data *sa = ca;
> >
> >         if (aa_g_audit_header) {
> > -               audit_log_format(ab, "apparmor=");
> > -               audit_log_string(ab, aa_audit_type[aad(sa)->type]);
> > +               audit_log_format(ab, "apparmor=%s",
> > +                                aa_audit_type[aad(sa)->type]);
> >         }
> >
> >         if (aad(sa)->op) {
> > -               audit_log_format(ab, " operation=");
> > -               audit_log_string(ab, aad(sa)->op);
> > +               audit_log_format(ab, " operation=%s", aad(sa)->op);
> >         }
> 
> In the case below you've added the quotes around the string, but they
> appear to be missing in the two cases above.

They aren't needed above since they are text with no spaces or special
characters.  We don't usually include double quotes where they aren't
needed.  The one below contains spaces so needs double quotes.

> >         if (aad(sa)->info) {
> > -               audit_log_format(ab, " info=");
> > -               audit_log_string(ab, aad(sa)->info);
> > +               audit_log_format(ab, " info=\"%s\"", aad(sa)->info);
> >                 if (aad(sa)->error)
> >                         audit_log_format(ab, " error=%d", aad(sa)->error);
> >         }
> > diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> > index 9a2d14b7c9f8..70f27124d051 100644
> > --- a/security/apparmor/file.c
> > +++ b/security/apparmor/file.c
> > @@ -35,20 +35,6 @@ static u32 map_mask_to_chr_mask(u32 mask)
> >  }
> >
> >  /**
> > - * audit_file_mask - convert mask to permission string
> > - * @buffer: buffer to write string to (NOT NULL)
> > - * @mask: permission mask to convert
> > - */
> > -static void audit_file_mask(struct audit_buffer *ab, u32 mask)
> > -{
> > -       char str[10];
> > -
> > -       aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> > -                           map_mask_to_chr_mask(mask));
> > -       audit_log_string(ab, str);
> > -}
> > -
> > -/**
> >   * file_audit_cb - call back for file specific audit fields
> >   * @ab: audit_buffer  (NOT NULL)
> >   * @va: audit struct to audit values of  (NOT NULL)
> > @@ -57,14 +43,17 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
> >  {
> >         struct common_audit_data *sa = va;
> >         kuid_t fsuid = current_fsuid();
> > +       char str[10];
> >
> >         if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
> > -               audit_log_format(ab, " requested_mask=");
> > -               audit_file_mask(ab, aad(sa)->request);
> > +               aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> > +                                   map_mask_to_chr_mask(aad(sa)->request));
> > +               audit_log_format(ab, " requested_mask=%s", str);
> >         }
> >         if (aad(sa)->denied & AA_AUDIT_FILE_MASK) {
> > -               audit_log_format(ab, " denied_mask=");
> > -               audit_file_mask(ab, aad(sa)->denied);
> > +               aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> > +                                   map_mask_to_chr_mask(aad(sa)->denied));
> > +               audit_log_format(ab, " denied_mask=%s", str);
> >         }
> 
> More missing quotes.

This is a simple text field without punctuation or special characters.

> >         if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
> >                 audit_log_format(ab, " fsuid=%d",
> > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > index 4ecedffbdd33..fe431731883f 100644
> > --- a/security/apparmor/ipc.c
> > +++ b/security/apparmor/ipc.c
> > @@ -20,25 +20,23 @@
> >
> >  /**
> >   * audit_ptrace_mask - convert mask to permission string
> > - * @buffer: buffer to write string to (NOT NULL)
> >   * @mask: permission mask to convert
> > + *
> > + * Returns: pointer to static string
> >   */
> > -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> > +static const char *audit_ptrace_mask(u32 mask)
> >  {
> >         switch (mask) {
> >         case MAY_READ:
> > -               audit_log_string(ab, "read");
> > -               break;
> > +               return "read";
> >         case MAY_WRITE:
> > -               audit_log_string(ab, "trace");
> > -               break;
> > +               return "trace";
> >         case AA_MAY_BE_READ:
> > -               audit_log_string(ab, "readby");
> > -               break;
> > +               return "readby";
> >         case AA_MAY_BE_TRACED:
> > -               audit_log_string(ab, "tracedby");
> > -               break;
> > +               return "tracedby";
> >         }
> > +       return "";
> >  }
> >
> >  /* call back to audit ptrace fields */
> > @@ -47,12 +45,12 @@ static void audit_ptrace_cb(struct audit_buffer *ab, void *va)
> >         struct common_audit_data *sa = va;
> >
> >         if (aad(sa)->request & AA_PTRACE_PERM_MASK) {
> > -               audit_log_format(ab, " requested_mask=");
> > -               audit_ptrace_mask(ab, aad(sa)->request);
> > +               audit_log_format(ab, " requested_mask=%s",
> > +                                audit_ptrace_mask(aad(sa)->request));
> >
> >                 if (aad(sa)->denied & AA_PTRACE_PERM_MASK) {
> > -                       audit_log_format(ab, " denied_mask=");
> > -                       audit_ptrace_mask(ab, aad(sa)->denied);
> > +                       audit_log_format(ab, " denied_mask=%s",
> > +                                        audit_ptrace_mask(aad(sa)->denied));
> >                 }
> 
> Quotes.  There are none.
> 
> ... and it looks like there are more missing too, but I kinda stopped
> seriously reading the patch here, please take a closer look at the
> patch, make the necessary changes, and resubmit.

This was all intentional as per the previous patch review discussion on github.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

