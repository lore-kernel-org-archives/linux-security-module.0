Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE9C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9C4206BB
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gyQOAeLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfBSREW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:04:22 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33354 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBSREW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:04:22 -0500
Received: by mail-yb1-f195.google.com with SMTP id w2so8424657ybi.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Feb 2019 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noiDrczKGbhF44NP/ZFkxfX2jHlLrDZ3QMqbb78FL4k=;
        b=gyQOAeLJO/hVoY2ht7e8thT/4ovHpFSR41ZQw4BXN/6uKUalD3LRSWJmt7uH/eHD78
         NtHVBj8/8e5n1YMqGdyBlNYRJxLOrj7vCWW1zPFC+M90WPnbA79CFDfTWHznMZDVflgj
         irCeYuniQItKUCQ64kGjHR7PJsVrhS81FVOuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noiDrczKGbhF44NP/ZFkxfX2jHlLrDZ3QMqbb78FL4k=;
        b=nMPnKzsD50Cg2JkVN3d5ZIA6WQigC4EdmoXtT0mEFU5FB8FSd/CkFMaQb8irGeAI5g
         vJUB6NM/AsKorNkMTgX8oeJfNAScVzTIer+JA4Ax7Z0VxY2iYNs/ziKsjxUHNz48or6Q
         Ju6IMX2ZIn5SZxKeFO9VzgR4u6/5k+SIqpb4cs9ppuUsaIUBvu2kH4V58wR1P8DrMNZp
         4h2V8LN2au5xJkQfktE+/AG0/1jWRtOMnKlAX7mlhkBYHqhLI+uSsu56LY08QHuT6sZy
         KykV3TRnVI0BC1RhilxxzFb7redkSgsKnJwDG/XBwAfOfnEkTEPpmn2QVEquG0r9R2rl
         1J3g==
X-Gm-Message-State: AHQUAuYLUVj+ShFV13qATLW5ly6u/64BiakB33I5pRdoP2TXGZeR6k2/
        qvPoaYRP8WAOhHBsIeQDVwkpctIWp5QYJS2Stq3byL+PicU=
X-Google-Smtp-Source: AHgI3IYYzRcQ8IGYB/Glpo34S95LuKUQfPmCEsPxwXePsY89C633S0n7/qJKHKF+Go90zTdaLT4zfm2Fiovsoy4Zhn0=
X-Received: by 2002:a25:bd5:: with SMTP id 204mr23860955ybl.97.1550595861412;
 Tue, 19 Feb 2019 09:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20190215222228.133709-1-mortonm@chromium.org> <20190217184906.GA20247@mail.hallyn.com>
In-Reply-To: <20190217184906.GA20247@mail.hallyn.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 19 Feb 2019 09:04:10 -0800
Message-ID: <CAJ-EccNax1U0Kc71BJLugjc3t8RUC+oGnOMSQ1=p+bhQtG=Ajw@mail.gmail.com>
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

On Sun, Feb 17, 2019 at 10:49 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Fri, Feb 15, 2019 at 02:22:28PM -0800, mortonm@chromium.org wrote:
> > From: Micah Morton <mortonm@chromium.org>
> >
> > The SafeSetID LSM already gates setuid transitions for UIDs on the
> > system whose use of CAP_SETUID has been 'restricted'. This patch
> > implements the analogous functionality for setgid transitions, in order
> > to restrict the use of CAP_SETGID for certain UIDs on the system. One
> > notable consequence of this addition is that a process running under a
> > restricted UID (i.e. one that is only allowed to setgid to certain
> > approved GIDs) will not be allowed to call the setgroups() syscall to
> > set its supplementary group IDs. For now, we leave such support for
> > restricted setgroups() to future work, as it would require hooking the
> > logic in setgroups() and verifying that the array of GIDs passed in from
> > userspace only consists of approved GIDs.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> > Tested with slight mod to test in tools/testing/selftests/safesetid for
> > testing setgid as well as setuid.
> >
> >  security/safesetid/lsm.c        | 263 +++++++++++++++++++++++++++-----
> >  security/safesetid/lsm.h        |  11 +-
> >  security/safesetid/securityfs.c | 105 +++++++++----
> >  3 files changed, 307 insertions(+), 72 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index cecd38e2ac80..5d9710b7bb04 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -26,27 +26,30 @@ int safesetid_initialized;
> >
> >  #define NUM_BITS 8 /* 128 buckets in hash table */
> ...
> > +int add_safesetid_whitelist_uid_entry(kuid_t parent, kuid_t child)
> >  {
> > -     struct entry *new;
> > +     struct id_entry *new;
> >
> >       /* Return if entry already exists */
> >       if (check_setuid_policy_hashtable_key_value(parent, child))
> >               return 0;
> >
> > -     new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> > +     new = kzalloc(sizeof(struct id_entry), GFP_KERNEL);
> > +     if (!new)
> > +             return -ENOMEM;
> > +     new->parent_kuid = __kuid_val(parent);
> > +     new->child_kid = __kuid_val(child);
> > +     spin_lock(&safesetid_whitelist_uid_hashtable_spinlock);
> > +     hash_add_rcu(safesetid_whitelist_uid_hashtable,
> > +                  &new->next,
> > +                  __kuid_val(parent));
>
> Do you care at all about the possibility of duplicate entries?

Duplicate entries shouldn't be possible due to the invocation of
check_setuid_policy_hashtable_key_value() above where it says "Return
if entry already exists". Does this make sense?

>
> > +     spin_unlock(&safesetid_whitelist_uid_hashtable_spinlock);
> > +     return 0;
> > +}
