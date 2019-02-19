Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A8DC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8302147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gAHSPGk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfBSXaS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:30:18 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38102 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSXaS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 18:30:18 -0500
Received: by mail-yb1-f196.google.com with SMTP id f196so3997873yba.5
        for <linux-security-module@vger.kernel.org>; Tue, 19 Feb 2019 15:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyfgBizjuN6AGJPc8AVuXeA0iR5kiyleS0R9Aqrh8iY=;
        b=gAHSPGk/1TUEnOQsgTmczCnil4ditsyBCinTqMm/6L+LSQXIiO0ipDWN2kVYxi7vEK
         esQ6UcayoKJqIlMTdh8gYh9FsdYksJhITBwoql8Sv/txn0tZbyTFvwRb+DSXKZLFkaWa
         QWQo1piY24qghXBBRSTsLsdPTQxI0IqfDeyjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyfgBizjuN6AGJPc8AVuXeA0iR5kiyleS0R9Aqrh8iY=;
        b=E0NPQ3tf5O25cYWV+38j0H96sEH/ewHSDgZKlsqxfAGayDTvGam+mh2Szb89r3KHCq
         ZjD34DzcbZqASXj+htaXGyXeqzv4mVi13qSZCQqxa6ji5fDJG++DCoXebmcJzizSTx+s
         6eT0OOFANnJ276EgLqJu9QGbAdQFgbMj1IOPsPgXQCDexi9+TGwkZa6rezO7DLNe6oRP
         ZCVdt8/Wv1qxEUU43zmEmWJFlqhL2ioa33DJCO2rBcrlwsfs1XH7daeoho1mmqS84Tg6
         Aljv5c4taGR2OPtsbzdIl2fIy597EZ4p+yDq2bRsE8a5CcI3ez420F1FxPtTDnASp38E
         MU8A==
X-Gm-Message-State: AHQUAuY2r7/JB9MG7exFEnk9KAKFChH/LRRtfQFvHApfe1mGVtVgVefm
        VGrNXciZEvASozzp7f9ksf5L0mN+YepHfoey8KCHdg==
X-Google-Smtp-Source: AHgI3IYDG9DpUU9mBNzaHaW9i9C1e4CCAjOJnEa7Um8QPBQPLkWlQGAkZ8B4UhwKVpQOlfv4Hh4XObzL14QWNqu8o3c=
X-Received: by 2002:a25:b988:: with SMTP id r8mr25897270ybg.464.1550619017036;
 Tue, 19 Feb 2019 15:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20190215222228.133709-1-mortonm@chromium.org> <20190217184906.GA20247@mail.hallyn.com>
 <CAJ-EccNax1U0Kc71BJLugjc3t8RUC+oGnOMSQ1=p+bhQtG=Ajw@mail.gmail.com> <20190219182656.GB10524@mail.hallyn.com>
In-Reply-To: <20190219182656.GB10524@mail.hallyn.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 19 Feb 2019 15:30:06 -0800
Message-ID: <CAJ-EccPdoXp_duz8uL2pEHa3bA9QoCs-9=ybYwwVhMqMChXhtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: gate setgid transitions
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Oh I see, good point. Right now there's no harm in having duplicate
entries, but it could be a problem later if certain functionality were
added (e.g. deletion of individual policy entries). Might as well fix
it. Uploading a v2 patch.

On Tue, Feb 19, 2019 at 10:26 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Tue, Feb 19, 2019 at 09:04:10AM -0800, Micah Morton wrote:
> > On Sun, Feb 17, 2019 at 10:49 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 02:22:28PM -0800, mortonm@chromium.org wrote:
> > > > From: Micah Morton <mortonm@chromium.org>
> > > >
> > > > The SafeSetID LSM already gates setuid transitions for UIDs on the
> > > > system whose use of CAP_SETUID has been 'restricted'. This patch
> > > > implements the analogous functionality for setgid transitions, in order
> > > > to restrict the use of CAP_SETGID for certain UIDs on the system. One
> > > > notable consequence of this addition is that a process running under a
> > > > restricted UID (i.e. one that is only allowed to setgid to certain
> > > > approved GIDs) will not be allowed to call the setgroups() syscall to
> > > > set its supplementary group IDs. For now, we leave such support for
> > > > restricted setgroups() to future work, as it would require hooking the
> > > > logic in setgroups() and verifying that the array of GIDs passed in from
> > > > userspace only consists of approved GIDs.
> > > >
> > > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > > > ---
> > > > Tested with slight mod to test in tools/testing/selftests/safesetid for
> > > > testing setgid as well as setuid.
> > > >
> > > >  security/safesetid/lsm.c        | 263 +++++++++++++++++++++++++++-----
> > > >  security/safesetid/lsm.h        |  11 +-
> > > >  security/safesetid/securityfs.c | 105 +++++++++----
> > > >  3 files changed, 307 insertions(+), 72 deletions(-)
> > > >
> > > > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > > > index cecd38e2ac80..5d9710b7bb04 100644
> > > > --- a/security/safesetid/lsm.c
> > > > +++ b/security/safesetid/lsm.c
> > > > @@ -26,27 +26,30 @@ int safesetid_initialized;
> > > >
> > > >  #define NUM_BITS 8 /* 128 buckets in hash table */
> > > ...
> > > > +int add_safesetid_whitelist_uid_entry(kuid_t parent, kuid_t child)
> > > >  {
> > > > -     struct entry *new;
> > > > +     struct id_entry *new;
> > > >
> > > >       /* Return if entry already exists */
> > > >       if (check_setuid_policy_hashtable_key_value(parent, child))
> > > >               return 0;
> > > >
> > > > -     new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> > > > +     new = kzalloc(sizeof(struct id_entry), GFP_KERNEL);
> > > > +     if (!new)
> > > > +             return -ENOMEM;
> > > > +     new->parent_kuid = __kuid_val(parent);
> > > > +     new->child_kid = __kuid_val(child);
> > > > +     spin_lock(&safesetid_whitelist_uid_hashtable_spinlock);
> > > > +     hash_add_rcu(safesetid_whitelist_uid_hashtable,
> > > > +                  &new->next,
> > > > +                  __kuid_val(parent));
> > >
> > > Do you care at all about the possibility of duplicate entries?
> >
> > Duplicate entries shouldn't be possible due to the invocation of
> > check_setuid_policy_hashtable_key_value() above where it says "Return
> > if entry already exists". Does this make sense?
>
> I don't believe it does, because you do the check before you lock.  So
> two tasks can race.
>
> Obviously you can't do the malloc under the spinlock, but I think you
> will need to check for an existing entry once, do the malloc, lock,
> then check again for an existing entry, then free the alloced
> 'new' if found.
>
> > > > +     spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
> > > > +     return 0;
> > > > +}
