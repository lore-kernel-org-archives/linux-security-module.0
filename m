Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5831C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939532082E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDEUG6CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfDJRmq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:42:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39858 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfDJRmq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:42:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so2698086otb.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yd4df0LA6ckY0ZEgj52L97FFYnTrjeCQbkX8JsB43Ws=;
        b=wDEUG6CLREXIVvcRoy6bGNPtrNbUmuVU7HJxFnpnyON0G3jZiBvT7z/DMsjJBPg8ww
         PyaI3TDqk9JjcKZXaidrWYuMhC0rIzGhXyzp6WnCH+NzwRCzsrEOtUXJEk2xDUTfeeFI
         JovjBAyBRlHZFYQQNBonG/jGeDqrpTXpBgvZC8U1J+6QCJWN6ceJHZasp66B+otZaF2n
         YWYve8RMTyLw7uIY8CO7/upHxDsbtVrfx2PmdQKODrE1YIKwCWW6dXu9gAWTaOEpbKZM
         mQunlhWUATSf/I4joGFm0+DBTFhw4p/5+3j2p0Mad5AplGciF+qyHlmgEjQhpb2DDh7q
         HvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yd4df0LA6ckY0ZEgj52L97FFYnTrjeCQbkX8JsB43Ws=;
        b=NE5P5noQkP4ezV0HvtkFXIM5dml7GIAEtVuzBkm1N7jlT2Kz+Cy+NHlcfmPYIaw6qc
         mPCHDCnjyz24AP/i7Jai3/ht9x74/KfsEChb4OYKzz1QXlZM1n0tiXqiUPLJtd/iMpFy
         oBB/Wc53gubAYociWznjzbTsun9otxXBnT6jElY8AYIrkEieOHkFBxHE8ou5MfLlUl8B
         4vPbOvMy4LaYu+j12IUweK8JCN55uKao/W3TKmUZZ5OO9PRhiOVzF/2wVaNSd9hjNgmx
         hTvWm5DAHdGvb7mdXQa0MmO93mtXbVhWkpTUl4i9TCo2T/JUdrgIOTHN1GiROd9Mn8cl
         WrWA==
X-Gm-Message-State: APjAAAUFWShY3lP/zdwTnSUfARnc9dXJNUtCci57wHEiQv2ZALjz0NSA
        otE3KOH6QdxwRFHJCMAog3T/oyoT6v6m2rdvdg7fRw==
X-Google-Smtp-Source: APXvYqzvUGy/l4xYguizHPETLuAYKwsFsh07NO5Z00wpgbemHViXIXJtWVwpmTRQ3PVBWAeznztZtqy/9eWR3w5u5js=
X-Received: by 2002:a9d:5e82:: with SMTP id f2mr29451297otl.217.1554918164751;
 Wed, 10 Apr 2019 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165613.212056-1-mortonm@chromium.org> <CAGXu5jLUFURN7-bQqwdzFLXF5XH1qAS+rb1pCGFZqrqZqMP6AQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLUFURN7-bQqwdzFLXF5XH1qAS+rb1pCGFZqrqZqMP6AQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Apr 2019 19:42:18 +0200
Message-ID: <CAG48ez33RDOU11dJiUHEooPZMpophUiE6SBZvR31qe4vsBsmRA@mail.gmail.com>
Subject: Re: [PATCH 08/10] LSM: SafeSetID: add read handler
To:     Kees Cook <keescook@chromium.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 7:27 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > For debugging a running system, it is very helpful to be able to see what
> > policy the system is using. Add a read handler that can dump out a copy of
> > the loaded policy.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> >  security/safesetid/lsm.h        |  3 +++
> >  security/safesetid/securityfs.c | 38 +++++++++++++++++++++++++++++++--
> >  2 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > index 4a34f558d964..9380329fe30a 100644
> > --- a/security/safesetid/lsm.h
> > +++ b/security/safesetid/lsm.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/types.h>
> >  #include <linux/uidgid.h>
> >  #include <linux/hashtable.h>
> > +#include <linux/refcount.h>
> >
> >  /* Flag indicating whether initialization completed */
> >  extern int safesetid_initialized;
> > @@ -41,7 +42,9 @@ struct setuid_rule {
> >
> >  struct setuid_ruleset {
> >         DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
> > +       char *policy_str;
> >         struct rcu_head rcu;
> > +       refcount_t refcount;
> >  };
>
> refcount seems like overkill? Why not just use the spinlock? Neither
> read nor write are "fast path".

You can't copy to userspace under a spinlock or under RCU. But we
could change policy_update_lock to a mutex and hold that across the
policy read.
