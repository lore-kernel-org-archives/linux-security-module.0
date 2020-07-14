Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C84C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8435820657
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 20:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KlCZJK6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGNU3p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGNU3o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 16:29:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC51C061755
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 13:29:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so24320574eja.9
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjKqA7umLRIxRuItN1sl62t5J7bejaeQmEpJ3yltvGM=;
        b=KlCZJK6fnRyegRYdJsWobHx2FV+Gq4Lh2SUzql483UhqoCJEh6JLqFtbOec+0frSiX
         zQZ7Uvf6ywQAmz37ByMEJQCut+/2KeRpVWLF/B4HMPXIY37MWBkBf8L/PAGwrEAcorhY
         hQUb4QbVM1E0oKiV8leScI7elEWX8895FKiMIU6CcOrwCt2sIn6uGs3DvG1C+sZpOxBy
         Cb8cp9ml+N5SZcW54mKdnF0S/ictRXPjAWScNhuxQFEDNVn3UHdtbkwjghfe8aJTFqX9
         eYqMXl44Eps/FNcyxmDV+qinADEyKwJxHyXL/YN5cRGorW+PF5r42LkPoN1JyPcSamwg
         HBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjKqA7umLRIxRuItN1sl62t5J7bejaeQmEpJ3yltvGM=;
        b=KuIRTlOfyDhBBJ64nDCxdeOIETH0d8StC0HeQTlCAWSiYwSb8t8oFK/Tz+RjIY3dfn
         8v57o10VX1kgXInyqyOh8fp5eroAPQ/VTfb21AUAtHiCbnhiHPDLqDOonCqF8rFKlo6S
         l14SvAaTcOLqw1yFKBQGeCbWpwXan1HnL+NmMa7g8wvHXevMd6C/PG/RJB6ff+TBWz0z
         D/7c47610xf++BjqCugcudCStW02RI+VBWyVOkWGL5V6yxci7YPqrvMakfJvyiZis/Dj
         xQQ0B5/ucDd3Gs4CjSpitqGfsstm6WKyrtICcz22u+ayp/Vemf/ah9BrIYUOGBicK9W1
         Eofw==
X-Gm-Message-State: AOAM532++NQOMLsPK2CdnaV9TY4Kj2oi6w+v4cxwumnNhMSAq4ADD4Qp
        SZIBMqgHWZgHuiggn9KQo3wAtVQV1MSFHEqlQuVi5h4=
X-Google-Smtp-Source: ABdhPJxvq7nppS25v1q/HDU5+iaADhxEqtCisqHD/Sqd9FpL1k9JSG25kraTuC2F3qavCtm5M30uvWwWkhoUSOMQTYI=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr6132963eja.178.1594758582843;
 Tue, 14 Jul 2020 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
 <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com> <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca>
In-Reply-To: <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jul 2020 16:29:30 -0400
Message-ID: <CAHC9VhQusQsdQc7EfdjdH5mp6qqqYVPHnG9nNhUhf3DS_cdWwA@mail.gmail.com>
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
To:     Richard Guy Briggs <rgb@redhat.com>, john.johansen@canonical.com
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 1:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-14 12:21, Paul Moore wrote:
> > On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > audit_log_string() was inteded to be an internal audit function and
> > > since there are only two internal uses, remove them.  Purge all external
> > > uses of it by restructuring code to use an existing audit_log_format()
> > > or using audit_log_format().
> > >
> > > Please see the upstream issue
> > > https://github.com/linux-audit/audit-kernel/issues/84
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > Passes audit-testsuite.
> > >
> > > Changelog:
> > > v4
> > > - use double quotes in all replaced audit_log_string() calls
> > >
> > > v3
> > > - fix two warning: non-void function does not return a value in all control paths
> > >         Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > v2
> > > - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> > >
> > > v1 Vlad Dronov
> > > - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> > >
> > >  include/linux/audit.h     |  5 -----
> > >  kernel/audit.c            |  4 ++--
> > >  security/apparmor/audit.c | 10 ++++------
> > >  security/apparmor/file.c  | 25 +++++++------------------
> > >  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> > >  security/apparmor/net.c   | 14 ++++++++------
> > >  security/lsm_audit.c      |  4 ++--
> > >  7 files changed, 46 insertions(+), 62 deletions(-)
> >
> > Thanks for restoring the quotes, just one question below ...
> >
> > > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > > index 4ecedffbdd33..fe36d112aad9 100644
> > > --- a/security/apparmor/ipc.c
> > > +++ b/security/apparmor/ipc.c
> > > @@ -20,25 +20,23 @@
> > >
> > >  /**
> > >   * audit_ptrace_mask - convert mask to permission string
> > > - * @buffer: buffer to write string to (NOT NULL)
> > >   * @mask: permission mask to convert
> > > + *
> > > + * Returns: pointer to static string
> > >   */
> > > -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> > > +static const char *audit_ptrace_mask(u32 mask)
> > >  {
> > >         switch (mask) {
> > >         case MAY_READ:
> > > -               audit_log_string(ab, "read");
> > > -               break;
> > > +               return "read";
> > >         case MAY_WRITE:
> > > -               audit_log_string(ab, "trace");
> > > -               break;
> > > +               return "trace";
> > >         case AA_MAY_BE_READ:
> > > -               audit_log_string(ab, "readby");
> > > -               break;
> > > +               return "readby";
> > >         case AA_MAY_BE_TRACED:
> > > -               audit_log_string(ab, "tracedby");
> > > -               break;
> > > +               return "tracedby";
> > >         }
> > > +       return "";
> >
> > Are we okay with this returning an empty string ("") in this case?
> > Should it be a question mark ("?")?
> >
> > My guess is that userspace parsing should be okay since it still has
> > quotes, I'm just not sure if we wanted to use a question mark as we do
> > in other cases where the field value is empty/unknown.
>
> Previously, it would have been an empty value, not even double quotes.
> "?" might be an improvement.

Did you want to fix that now in this patch, or leave it to later?  As
I said above, I'm not too bothered by it with the quotes so either way
is fine by me.

John, I'm assuming you are okay with this patch?

-- 
paul moore
www.paul-moore.com
