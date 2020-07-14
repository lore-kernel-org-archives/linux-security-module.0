Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F89C43445
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA80206D9
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tkl+LLeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGNVAw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:00:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50511 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726768AbgGNVAw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 17:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594760451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z00rvsVZTFdUuigrucb84GtZBYdoQhBpetY3yD6qCBI=;
        b=Tkl+LLeF6Hx0awjXg1Z5nTFUqZziqQJCxblEn0DlJiahvMlKOp/QggPLMgPYGVtySbDCeT
        0HfZUE3Vhwh9y6MraopwiSzvO6LpFq6BYO6cEVmHOHexrJLX8Df93YDhc1usYRllZU9I1K
        aRStbTk82X4yIxcfgWU7ehWWW3EHuCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-eVLoMKjKOUiOF5BeLgCaCA-1; Tue, 14 Jul 2020 17:00:39 -0400
X-MC-Unique: eVLoMKjKOUiOF5BeLgCaCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 505B52D0;
        Tue, 14 Jul 2020 21:00:38 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448597980F;
        Tue, 14 Jul 2020 21:00:30 +0000 (UTC)
Date:   Tue, 14 Jul 2020 17:00:27 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     john.johansen@canonical.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
Message-ID: <20200714210027.me2ieywjfcsf4v5r@madcap2.tricolour.ca>
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
 <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
 <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca>
 <CAHC9VhQusQsdQc7EfdjdH5mp6qqqYVPHnG9nNhUhf3DS_cdWwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQusQsdQc7EfdjdH5mp6qqqYVPHnG9nNhUhf3DS_cdWwA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-14 16:29, Paul Moore wrote:
> On Tue, Jul 14, 2020 at 1:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-07-14 12:21, Paul Moore wrote:
> > > On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > >
> > > > audit_log_string() was inteded to be an internal audit function and
> > > > since there are only two internal uses, remove them.  Purge all external
> > > > uses of it by restructuring code to use an existing audit_log_format()
> > > > or using audit_log_format().
> > > >
> > > > Please see the upstream issue
> > > > https://github.com/linux-audit/audit-kernel/issues/84
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > > Passes audit-testsuite.
> > > >
> > > > Changelog:
> > > > v4
> > > > - use double quotes in all replaced audit_log_string() calls
> > > >
> > > > v3
> > > > - fix two warning: non-void function does not return a value in all control paths
> > > >         Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > v2
> > > > - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> > > >
> > > > v1 Vlad Dronov
> > > > - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> > > >
> > > >  include/linux/audit.h     |  5 -----
> > > >  kernel/audit.c            |  4 ++--
> > > >  security/apparmor/audit.c | 10 ++++------
> > > >  security/apparmor/file.c  | 25 +++++++------------------
> > > >  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> > > >  security/apparmor/net.c   | 14 ++++++++------
> > > >  security/lsm_audit.c      |  4 ++--
> > > >  7 files changed, 46 insertions(+), 62 deletions(-)
> > >
> > > Thanks for restoring the quotes, just one question below ...
> > >
> > > > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > > > index 4ecedffbdd33..fe36d112aad9 100644
> > > > --- a/security/apparmor/ipc.c
> > > > +++ b/security/apparmor/ipc.c
> > > > @@ -20,25 +20,23 @@
> > > >
> > > >  /**
> > > >   * audit_ptrace_mask - convert mask to permission string
> > > > - * @buffer: buffer to write string to (NOT NULL)
> > > >   * @mask: permission mask to convert
> > > > + *
> > > > + * Returns: pointer to static string
> > > >   */
> > > > -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> > > > +static const char *audit_ptrace_mask(u32 mask)
> > > >  {
> > > >         switch (mask) {
> > > >         case MAY_READ:
> > > > -               audit_log_string(ab, "read");
> > > > -               break;
> > > > +               return "read";
> > > >         case MAY_WRITE:
> > > > -               audit_log_string(ab, "trace");
> > > > -               break;
> > > > +               return "trace";
> > > >         case AA_MAY_BE_READ:
> > > > -               audit_log_string(ab, "readby");
> > > > -               break;
> > > > +               return "readby";
> > > >         case AA_MAY_BE_TRACED:
> > > > -               audit_log_string(ab, "tracedby");
> > > > -               break;
> > > > +               return "tracedby";
> > > >         }
> > > > +       return "";
> > >
> > > Are we okay with this returning an empty string ("") in this case?
> > > Should it be a question mark ("?")?
> > >
> > > My guess is that userspace parsing should be okay since it still has
> > > quotes, I'm just not sure if we wanted to use a question mark as we do
> > > in other cases where the field value is empty/unknown.
> >
> > Previously, it would have been an empty value, not even double quotes.
> > "?" might be an improvement.
> 
> Did you want to fix that now in this patch, or leave it to later?  As
> I said above, I'm not too bothered by it with the quotes so either way
> is fine by me.

I'd defer to Steve, otherwise I'd say leave it, since there wasn't
anything there before and this makes that more evident.

> John, I'm assuming you are okay with this patch?
> 
> -- 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

