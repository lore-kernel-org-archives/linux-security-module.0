Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD71C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F7620578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L2+NtqYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEGPBY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:01:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44730 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEGPBX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:01:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id j4so13443186ywk.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5Q4rCfZTCai+SPLakGIuYAvZu75fNm2KxkLIuZr/1s=;
        b=L2+NtqYQ0i3PoJhRRRuLS7BwiixkFZKKBZiS4awPeaWCaXrYBD6aTvDhDIcSXv7b7M
         RXQfGVIVSpL5w0h7DCJzCQYg2gDDYaubPfcFBovkOtEY+CKDwZCVSnMVXjWONUdIQkxU
         l5ifVCPgv/cWE9CfZwdr6/3Q5+NvCdbPnXy+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5Q4rCfZTCai+SPLakGIuYAvZu75fNm2KxkLIuZr/1s=;
        b=az9W6gH2ocn4z1q2NqVJG1J4q8C32/n7Ym0ToBHdCvh/GPyiYYa40EOWhYphh8/0rY
         MDkVaRANVKgOhXpoMSplU2XParKkjJST20mJM8lcAYDGfy8VNi1Kp51RmxPQtiMLq1aS
         P06na+MSG45YhiZ+jB28KfnHFE7YA/hdQxStL50Mf/WEz3MSUjjAGnKjA1yLAw4LT22p
         m85hyGeEzU7hFgIIIWic0IYp8XbdPMM8XTFXQcHb3vJTB/XCS6XjEE6bZKMT6rNDgn6F
         5eVOIITEY//xP9tHwqaeYy88us5RfAQi7QgUC1uCFLC2lORAXl1RER35O9c+ayYn/w36
         Mu2w==
X-Gm-Message-State: APjAAAWt5mcYvMs5tXbtUL8YU6228WBkoj1AeL4XmADqxAoYGz5/0Z2t
        Q5C0obTovM1kL4/TUmPB1DPtzMm+Hd+Rno8gx8ZGRw==
X-Google-Smtp-Source: APXvYqwSiDPXGxUhbI1zZTCos7KY4nUW+V2mY58VdmNuz1MmxSKrbNKt9h//CH6aTwTGtw3lKAi2dwoBGzgQmXYqySM=
X-Received: by 2002:a81:7085:: with SMTP id l127mr22496564ywc.167.1557241282956;
 Tue, 07 May 2019 08:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165519.209565-1-mortonm@chromium.org> <CAGXu5jL-jAc-jsDeRXnAXbETT+EUf8R0gFiqNvm60F42=tdhAQ@mail.gmail.com>
In-Reply-To: <CAGXu5jL-jAc-jsDeRXnAXbETT+EUf8R0gFiqNvm60F42=tdhAQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:12 -0700
Message-ID: <CAJ-EccN33Z874vjxEJ69Su23gO-p6Fzc4LvgLRGwSQoYwygtKg@mail.gmail.com>
Subject: Re: [PATCH 02/10] LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Wed, Apr 10, 2019 at 10:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:55 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > With the old code, when a process with the (real,effective,saved) UID set
> > (1,1,1) calls setresuid(2,3,4), safesetid_task_fix_setuid() only checks
> > whether the transition 1->2 is permitted; the transitions 1->3 and 1->4 are
> > not checked. Fix this.
> >
> > This is also a good opportunity to refactor safesetid_task_fix_setuid() to
> > be less verbose - having one branch per set*uid() syscall is unnecessary.
> >
> > Note that this slightly changes semantics: The UID transition check for
> > UIDs that were not in the old cred struct is now always performed against
> > the policy of the RUID. I think that's more consistent anyway, since the
> > RUID is also the one that decides whether any policy is enforced at all.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/lsm.c | 125 +++++++++++----------------------------
> >  1 file changed, 35 insertions(+), 90 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 2daecab3a4c0..5310fcf3052a 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -99,20 +99,30 @@ static int safesetid_security_capable(const struct cred *cred,
> >         return 0;
> >  }
> >
> > -static int check_uid_transition(kuid_t parent, kuid_t child)
> > +/*
> > + * Check whether a caller with old credentials @old is allowed to switch to
> > + * credentials that contain @new_uid.
> > + */
> > +static bool uid_permitted_for_cred(const struct cred *old, kuid_t new_uid)
> >  {
> > -       if (check_setuid_policy_hashtable_key_value(parent, child))
> > -               return 0;
> > -       pr_warn("UID transition (%d -> %d) blocked\n",
> > -               __kuid_val(parent),
> > -               __kuid_val(child));
> > +       bool permitted;
> > +
> > +       /* If our old creds already had this UID in it, it's fine. */
> > +       if (uid_eq(new_uid, old->uid) || uid_eq(new_uid, old->euid) ||
> > +           uid_eq(new_uid, old->suid))
> > +               return true;
> > +
> >         /*
> > -        * Kill this process to avoid potential security vulnerabilities
> > -        * that could arise from a missing whitelist entry preventing a
> > -        * privileged process from dropping to a lesser-privileged one.
> > +        * Transitions to new UIDs require a check against the policy of the old
> > +        * RUID.
> >          */
> > -       force_sig(SIGKILL, current);
> > -       return -EACCES;
> > +       permitted = check_setuid_policy_hashtable_key_value(old->uid, new_uid);
> > +       if (!permitted) {
> > +               pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
> > +                       __kuid_val(old->uid), __kuid_val(old->euid),
> > +                       __kuid_val(old->suid), __kuid_val(new_uid));
> > +       }
> > +       return permitted;
> >  }
> >
> >  /*
> > @@ -125,88 +135,23 @@ static int safesetid_task_fix_setuid(struct cred *new,
> >                                      int flags)
> >  {
> >
> > -       /* Do nothing if there are no setuid restrictions for this UID. */
> > +       /* Do nothing if there are no setuid restrictions for our old RUID. */
> >         if (!check_setuid_policy_hashtable_key(old->uid))
> >                 return 0;
> >
> > -       switch (flags) {
> > -       case LSM_SETID_RE:
> > -               /*
> > -                * Users for which setuid restrictions exist can only set the
> > -                * real UID to the real UID or the effective UID, unless an
> > -                * explicit whitelist policy allows the transition.
> > -                */
> > -               if (!uid_eq(old->uid, new->uid) &&
> > -                       !uid_eq(old->euid, new->uid)) {
> > -                       return check_uid_transition(old->uid, new->uid);
> > -               }
> > -               /*
> > -                * Users for which setuid restrictions exist can only set the
> > -                * effective UID to the real UID, the effective UID, or the
> > -                * saved set-UID, unless an explicit whitelist policy allows
> > -                * the transition.
> > -                */
> > -               if (!uid_eq(old->uid, new->euid) &&
> > -                       !uid_eq(old->euid, new->euid) &&
> > -                       !uid_eq(old->suid, new->euid)) {
> > -                       return check_uid_transition(old->euid, new->euid);
> > -               }
> > -               break;
> > -       case LSM_SETID_ID:
> > -               /*
> > -                * Users for which setuid restrictions exist cannot change the
> > -                * real UID or saved set-UID unless an explicit whitelist
> > -                * policy allows the transition.
> > -                */
> > -               if (!uid_eq(old->uid, new->uid))
> > -                       return check_uid_transition(old->uid, new->uid);
> > -               if (!uid_eq(old->suid, new->suid))
> > -                       return check_uid_transition(old->suid, new->suid);
> > -               break;
> > -       case LSM_SETID_RES:
> > -               /*
> > -                * Users for which setuid restrictions exist cannot change the
> > -                * real UID, effective UID, or saved set-UID to anything but
> > -                * one of: the current real UID, the current effective UID or
> > -                * the current saved set-user-ID unless an explicit whitelist
> > -                * policy allows the transition.
> > -                */
> > -               if (!uid_eq(new->uid, old->uid) &&
> > -                       !uid_eq(new->uid, old->euid) &&
> > -                       !uid_eq(new->uid, old->suid)) {
> > -                       return check_uid_transition(old->uid, new->uid);
> > -               }
> > -               if (!uid_eq(new->euid, old->uid) &&
> > -                       !uid_eq(new->euid, old->euid) &&
> > -                       !uid_eq(new->euid, old->suid)) {
> > -                       return check_uid_transition(old->euid, new->euid);
> > -               }
> > -               if (!uid_eq(new->suid, old->uid) &&
> > -                       !uid_eq(new->suid, old->euid) &&
> > -                       !uid_eq(new->suid, old->suid)) {
> > -                       return check_uid_transition(old->suid, new->suid);
> > -               }
> > -               break;
> > -       case LSM_SETID_FS:
> > -               /*
> > -                * Users for which setuid restrictions exist cannot change the
> > -                * filesystem UID to anything but one of: the current real UID,
> > -                * the current effective UID or the current saved set-UID
> > -                * unless an explicit whitelist policy allows the transition.
> > -                */
> > -               if (!uid_eq(new->fsuid, old->uid)  &&
> > -                       !uid_eq(new->fsuid, old->euid)  &&
> > -                       !uid_eq(new->fsuid, old->suid) &&
> > -                       !uid_eq(new->fsuid, old->fsuid)) {
> > -                       return check_uid_transition(old->fsuid, new->fsuid);
> > -               }
> > -               break;
> > -       default:
> > -               pr_warn("Unknown setid state %d\n", flags);
> > -               force_sig(SIGKILL, current);
> > -               return -EINVAL;
> > -       }
> > -       return 0;
> > +       if (uid_permitted_for_cred(old, new->uid) &&
> > +           uid_permitted_for_cred(old, new->euid) &&
> > +           uid_permitted_for_cred(old, new->suid) &&
> > +           uid_permitted_for_cred(old, new->fsuid))
> > +               return 0;
> > +
> > +       /*
> > +        * Kill this process to avoid potential security vulnerabilities
> > +        * that could arise from a missing whitelist entry preventing a
> > +        * privileged process from dropping to a lesser-privileged one.
> > +        */
> > +       force_sig(SIGKILL, current);
> > +       return -EACCES;
> >  }
> >
> >  int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
