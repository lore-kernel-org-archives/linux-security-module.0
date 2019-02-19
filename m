Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0324C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A292147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0HJ1V5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfBSRA0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:00:26 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42349 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSRAZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:00:25 -0500
Received: by mail-yb1-f194.google.com with SMTP id j189so8382181ybj.9
        for <linux-security-module@vger.kernel.org>; Tue, 19 Feb 2019 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt4+sAusfVYCEP+BcSdqWQy0LQQHvXqD6y+EoTktniU=;
        b=Q0HJ1V5H9XGNPdpoiM0NFDGPUTSulkfdumSWRUSnWiObavb46Wb08byFJTuxlgy8x7
         2TUF0CtEm7a5cI7IJGj//d/7jnvv9IupgbK8IO7/8ovseMZUMmO2cxWi7qPftABxf5PV
         aP+r7KDlvLs0uPMO5h1blnx4//5xAxwr0uO+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt4+sAusfVYCEP+BcSdqWQy0LQQHvXqD6y+EoTktniU=;
        b=G5YU7PcrWUdrXG0WICI7JLDXs+aUrCxQnAkNHCnT00IYp/8UL6lyMdoSHUCFkV3/w3
         eJ+N2UUI9CG6KszLBlodAd1QXDrKP6oUZu152CeoU4lUM3N+OscNwQulvOsS9g4zMi8l
         BrvW1LEAYppsouqVmkxo4/rJbf+9qHaocBMR5v4vTCujXz3BOnrcEFuRFY48sxP3dBzM
         JWimHHDWMp9+TBaG2QnRcCxizeM3a7Hkk5E3NMgUw79lgj8UJvkBI+7jiqPgm+RVh2mj
         eSOSpq2ZBdh84gJo+AM/iIfef3J5FBmuTIyg5JhWJBQleIHYiS6cR39NgiUQc05KDKk/
         BGhg==
X-Gm-Message-State: AHQUAuZDwj/WB2QM8p/5/rP/p/7NRlUYw0nugbCDgSvgA6MiY4YCiUjz
        TDh0WIPYrzq3wpBF3IAnThL9TaVTEy9vNRO/LBB6oQXg7BE=
X-Google-Smtp-Source: AHgI3Ia6Yuu50zbeRQP3Ob6ufctq9gnJw997SnDVLdmdIabyC/Sv4gBc0htPLUybbTRj1WJlIXsMzJiFq6oGjnoDErc=
X-Received: by 2002:a25:9cc4:: with SMTP id z4mr9939032ybo.303.1550595624401;
 Tue, 19 Feb 2019 09:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20190215222217.133213-1-mortonm@chromium.org> <20190216164333.GA10883@mail.hallyn.com>
In-Reply-To: <20190216164333.GA10883@mail.hallyn.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 19 Feb 2019 09:00:13 -0800
Message-ID: <CAJ-EccPGZzet27H18PS3ANS24FJ=FuLvtyaFaoo5YHbBgOzm6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: SafeSetID: gate setgid transitions
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

On Sat, Feb 16, 2019 at 8:43 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Fri, Feb 15, 2019 at 02:22:17PM -0800, mortonm@chromium.org wrote:
> > From: Micah Morton <mortonm@chromium.org>
> >
> > This patch adds a 'task_fix_setgid' LSM hook, which is analogous to the
> > existing 'task_fix_setuid' LSM hook, and calls this new hook from the
> > setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
> > govern setgid transitions in addition to setuid transitions. This change
> > also makes sure the setgid functions in kernel/sys.c call
> > security_capable_setid rather than the ordinary security_capable
>
> Sorry, where security_capable_setid this defined?  I assume it was in a recent
> patchset, but google and grep are failing me.

It was defined in commit 40852275a94afb3e836be9248399e036982d1a79 on
the origin/next-general branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git.

>
> > function, so that the security_capable hook in the SafeSetID LSM knows
> > it is being invoked from a setid function.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> > Tested with slight mod to test in tools/testing/selftests/safesetid for
> > testing setgid as well as setuid.
> >
> >  include/linux/lsm_hooks.h | 12 ++++++++++++
> >  include/linux/security.h  | 10 ++++++++++
> >  kernel/sys.c              | 27 +++++++++++++++++++++------
> >  security/security.c       |  6 ++++++
> >  4 files changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 22fc786d723a..f252ed3e95ef 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -603,6 +603,15 @@
> >   *   @old is the set of credentials that are being replaces
> >   *   @flags contains one of the LSM_SETID_* values.
> >   *   Return 0 on success.
> > + * @task_fix_setgid:
> > + *      Update the module's state after setting one or more of the group
> > + *      identity attributes of the current process.  The @flags parameter
> > + *      indicates which of the set*gid system calls invoked this hook.
> > + *      @new is the set of credentials that will be installed.  Modifications
> > + *      should be made to this rather than to @current->cred.
> > + *      @old is the set of credentials that are being replaced
> > + *      @flags contains one of the LSM_SETID_* values.
> > + *      Return 0 on success.
> >   * @task_setpgid:
> >   *   Check permission before setting the process group identifier of the
> >   *   process @p to @pgid.
> > @@ -1596,6 +1605,8 @@ union security_list_options {
> >                                    enum kernel_read_file_id id);
> >       int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> >                               int flags);
> > +     int (*task_fix_setgid)(struct cred *new, const struct cred *old,
> > +                             int flags);
> >       int (*task_setpgid)(struct task_struct *p, pid_t pgid);
> >       int (*task_getpgid)(struct task_struct *p);
> >       int (*task_getsid)(struct task_struct *p);
> > @@ -1887,6 +1898,7 @@ struct security_hook_heads {
> >       struct hlist_head kernel_post_read_file;
> >       struct hlist_head kernel_module_request;
> >       struct hlist_head task_fix_setuid;
> > +     struct hlist_head task_fix_setgid;
> >       struct hlist_head task_setpgid;
> >       struct hlist_head task_getpgid;
> >       struct hlist_head task_getsid;
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 13537a49ae97..f3d095e8dfc1 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -96,6 +96,7 @@ extern int cap_mmap_addr(unsigned long addr);
> >  extern int cap_mmap_file(struct file *file, unsigned long reqprot,
> >                        unsigned long prot, unsigned long flags);
> >  extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
> > +extern int cap_task_fix_setgid(struct cred *new, const struct cred *old, int flags);
> >  extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >                         unsigned long arg4, unsigned long arg5);
> >  extern int cap_task_setscheduler(struct task_struct *p);
> > @@ -326,6 +327,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
> >                                  enum kernel_read_file_id id);
> >  int security_task_fix_setuid(struct cred *new, const struct cred *old,
> >                            int flags);
> > +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> > +                          int flags);
> >  int security_task_setpgid(struct task_struct *p, pid_t pgid);
> >  int security_task_getpgid(struct task_struct *p);
> >  int security_task_getsid(struct task_struct *p);
> > @@ -930,6 +933,13 @@ static inline int security_task_fix_setuid(struct cred *new,
> >       return cap_task_fix_setuid(new, old, flags);
> >  }
> >
> > +static inline int security_task_fix_setgid(struct cred *new,
> > +                                        const struct cred *old,
> > +                                        int flags)
> > +{
> > +     return cap_task_fix_setgid(new, old, flags);
> > +}
> > +
> >  static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
> >  {
> >       return 0;
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index c5f875048aef..76f1c46ac66f 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -372,7 +372,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
> >       if (rgid != (gid_t) -1) {
> >               if (gid_eq(old->gid, krgid) ||
> >                   gid_eq(old->egid, krgid) ||
> > -                 ns_capable(old->user_ns, CAP_SETGID))
> > +                 ns_capable_setid(old->user_ns, CAP_SETGID))
> >                       new->gid = krgid;
> >               else
> >                       goto error;
> > @@ -381,7 +381,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
> >               if (gid_eq(old->gid, kegid) ||
> >                   gid_eq(old->egid, kegid) ||
> >                   gid_eq(old->sgid, kegid) ||
> > -                 ns_capable(old->user_ns, CAP_SETGID))
> > +                 ns_capable_setid(old->user_ns, CAP_SETGID))
> >                       new->egid = kegid;
> >               else
> >                       goto error;
> > @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
> >               new->sgid = new->egid;
> >       new->fsgid = new->egid;
> >
> > +     retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
> > +     if (retval < 0)
> > +             goto error;
> > +
> >       return commit_creds(new);
> >
> >  error:
> > @@ -427,13 +431,17 @@ long __sys_setgid(gid_t gid)
> >       old = current_cred();
> >
> >       retval = -EPERM;
> > -     if (ns_capable(old->user_ns, CAP_SETGID))
> > +     if (ns_capable_setid(old->user_ns, CAP_SETGID))
> >               new->gid = new->egid = new->sgid = new->fsgid = kgid;
> >       else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
> >               new->egid = new->fsgid = kgid;
> >       else
> >               goto error;
> >
> > +     retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
> > +     if (retval < 0)
> > +             goto error;
> > +
> >       return commit_creds(new);
> >
> >  error:
> > @@ -735,7 +743,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
> >       old = current_cred();
> >
> >       retval = -EPERM;
> > -     if (!ns_capable(old->user_ns, CAP_SETGID)) {
> > +     if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
> >               if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
> >                   !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
> >                       goto error;
> > @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
> >               new->sgid = ksgid;
> >       new->fsgid = new->egid;
> >
> > +     retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
> > +     if (retval < 0)
> > +             goto error;
> > +
> >       return commit_creds(new);
> >
> >  error:
> > @@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
> >
> >       if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
> >           gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> > -         ns_capable(old->user_ns, CAP_SETGID)) {
> > +         ns_capable_setid(old->user_ns, CAP_SETGID)) {
> >               if (!gid_eq(kgid, old->fsgid)) {
> >                       new->fsgid = kgid;
> > -                     goto change_okay;
> > +                     if (security_task_fix_setgid(new,
> > +                                             old,
> > +                                             LSM_SETID_FS) == 0)
> > +                             goto change_okay;
> >               }
> >       }
> >
> > diff --git a/security/security.c b/security/security.c
> > index b6bff646d373..4264a1e77ce8 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1570,6 +1570,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
> >       return call_int_hook(task_fix_setuid, 0, new, old, flags);
> >  }
> >
> > +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> > +                          int flags)
> > +{
> > +     return call_int_hook(task_fix_setgid, 0, new, old, flags);
> > +}
> > +
> >  int security_task_setpgid(struct task_struct *p, pid_t pgid)
> >  {
> >       return call_int_hook(task_setpgid, 0, p, pgid);
> > --
> > 2.21.0.rc0.258.g878e2cd30e-goog
