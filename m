Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFFC43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101A120657
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0L4dIcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfAOTe4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:34:56 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46927 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbfAOTe4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 14:34:56 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so1333828uap.13
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw3Vo/TLOUb6QLCaQRMt6CW+RgU20l+jc0/wbyCNGHI=;
        b=G0L4dIccXtM4a8fIrl6yB6t7I0lwXb8R6GsAzYnXOetNxk+0o/CFTR4wKJPW8kBScN
         KpAvGIJXWjneIqAPIstYE4C6EDNqZ8KfEI1w3dCONctA2/s2IEtY8iQhA33NFy7SK2lT
         3ylpdMA8XnU2/GyzA7Iq+OrsxS/9f0aSIlcME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw3Vo/TLOUb6QLCaQRMt6CW+RgU20l+jc0/wbyCNGHI=;
        b=aOYyR01qmT6FEwJ58A4R3ZwgB8li8z8lyVqvBsLZOsUjV1YeLIEqqsI01uwRFHlqVW
         OJtuPPPwyPMwcHUNsCZXGAEVVFrzS6zVskOLw8B5hbMgfo1F7EIDpycfyw428rh/Dbi7
         rm3bLe3IgZW4P5NnDuxKSzyB1OSk81THj5G+xkLjtpUgh1dGeZMdT29YIbwKMH6Z7bZ8
         tnx4QiPglGAfTTMMFsvLsV8aonKIclQN33oZZkZNu4UUs6Xaso+ICsA5qt3l4M3BLz/9
         QU3HwguTLqgkLMdiy6NEGkJwgectWz2vJHavLYj1uUJ+3AZ4cDfRJ9x85jTutuvn1r/F
         8+hQ==
X-Gm-Message-State: AJcUukd63rHh9iKt9/VRhvHa4+Lch5SO6oKhXmg/x4Z/aR3+Iy1XysWk
        +oN9Oi8Sfn6Mpx9tWaZ5n/vkPcGvopo=
X-Google-Smtp-Source: ALg8bN6mR5w2eXSV8v4654u63SYX95o2OPOVhJgbXAtjmInjqMIenf6+UHaKlultpqPpVRH+DI392w==
X-Received: by 2002:a9f:314c:: with SMTP id n12mr2384037uab.33.1547580894407;
        Tue, 15 Jan 2019 11:34:54 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id n15sm1667586uao.18.2019.01.15.11.34.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 11:34:53 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id u19so1355166uae.4
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 11:34:53 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr2274854uac.122.1547580892833;
 Tue, 15 Jan 2019 11:34:52 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
 <20190115180421.102209-1-mortonm@chromium.org>
In-Reply-To: <20190115180421.102209-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 15 Jan 2019 11:34:41 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJtPQQ=fk-Lixs2k2q8WPtD5WC-mH0H72mkFBHCRPMJSQ@mail.gmail.com>
Message-ID: <CAGXu5jJtPQQ=fk-Lixs2k2q8WPtD5WC-mH0H72mkFBHCRPMJSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] LSM: mark all set*uid call sites in kernel/sys.c
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 15, 2019 at 10:04 AM <mortonm@chromium.org> wrote:
>
> From: Micah Morton <mortonm@chromium.org>
>
> This change ensures that the set*uid family of syscalls in kernel/sys.c
> (setreuid, setuid, setresuid, setfsuid) all call ns_capable_common with
> the CAP_OPT_INSETID flag, so capability checks in the security_capable
> hook can know whether they are being called from within a set*uid
> syscall. This change is a no-op by itself, but is needed for the
> proposed SafeSetID LSM.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> These changes used to be part of the main SafeSetID LSM patch set.
>
>  include/linux/capability.h |  5 +++++
>  kernel/capability.c        | 19 +++++++++++++++++++
>  kernel/sys.c               | 10 +++++-----
>  3 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index f640dcbc880c..c3f9a4d558a0 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -209,6 +209,7 @@ extern bool has_ns_capability_noaudit(struct task_struct *t,
>  extern bool capable(int cap);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
> +extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>  #else
>  static inline bool has_capability(struct task_struct *t, int cap)
>  {
> @@ -240,6 +241,10 @@ static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  {
>         return true;
>  }
> +static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
> +{
> +       return true;
> +}
>  #endif /* CONFIG_MULTIUSER */
>  extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
>  extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 7718d7dcadc7..e0734ace5bc2 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -417,6 +417,25 @@ bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(ns_capable_noaudit);
>
> +/**
> + * ns_capable_setid - Determine if the current task has a superior capability
> + * in effect, while signalling that this check is being done from within a
> + * setid syscall.
> + * @ns:  The usernamespace we want the capability in
> + * @cap: The capability to be tested for
> + *
> + * Return true if the current task has the given superior capability currently
> + * available for use, false if not.
> + *
> + * This sets PF_SUPERPRIV on the task if the capability is available on the
> + * assumption that it's about to be used.
> + */
> +bool ns_capable_setid(struct user_namespace *ns, int cap)
> +{
> +       return ns_capable_common(ns, cap, CAP_OPT_INSETID);
> +}
> +EXPORT_SYMBOL(ns_capable_setid);
> +
>  /**
>   * capable - Determine if the current task has a superior capability in effect
>   * @cap: The capability to be tested for
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a48cbf1414b8..a98061c1a124 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -516,7 +516,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
>                 new->uid = kruid;
>                 if (!uid_eq(old->uid, kruid) &&
>                     !uid_eq(old->euid, kruid) &&
> -                   !ns_capable(old->user_ns, CAP_SETUID))
> +                   !ns_capable_setid(old->user_ns, CAP_SETUID))
>                         goto error;
>         }
>
> @@ -525,7 +525,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
>                 if (!uid_eq(old->uid, keuid) &&
>                     !uid_eq(old->euid, keuid) &&
>                     !uid_eq(old->suid, keuid) &&
> -                   !ns_capable(old->user_ns, CAP_SETUID))
> +                   !ns_capable_setid(old->user_ns, CAP_SETUID))
>                         goto error;
>         }
>
> @@ -584,7 +584,7 @@ long __sys_setuid(uid_t uid)
>         old = current_cred();
>
>         retval = -EPERM;
> -       if (ns_capable(old->user_ns, CAP_SETUID)) {
> +       if (ns_capable_setid(old->user_ns, CAP_SETUID)) {
>                 new->suid = new->uid = kuid;
>                 if (!uid_eq(kuid, old->uid)) {
>                         retval = set_user(new);
> @@ -646,7 +646,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
>         old = current_cred();
>
>         retval = -EPERM;
> -       if (!ns_capable(old->user_ns, CAP_SETUID)) {
> +       if (!ns_capable_setid(old->user_ns, CAP_SETUID)) {
>                 if (ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
>                     !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid))
>                         goto error;
> @@ -814,7 +814,7 @@ long __sys_setfsuid(uid_t uid)
>
>         if (uid_eq(kuid, old->uid)  || uid_eq(kuid, old->euid)  ||
>             uid_eq(kuid, old->suid) || uid_eq(kuid, old->fsuid) ||
> -           ns_capable(old->user_ns, CAP_SETUID)) {
> +           ns_capable_setid(old->user_ns, CAP_SETUID)) {
>                 if (!uid_eq(kuid, old->fsuid)) {
>                         new->fsuid = kuid;
>                         if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
> --
> 2.20.1.97.g81188d93c3-goog
>


-- 
Kees Cook
