Return-Path: <SRS0=R80q=QB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F5C282C6
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77845218CD
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkbKahUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfAYPwK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:52:10 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32796 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPwJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 Jan 2019 10:52:09 -0500
Received: by mail-yw1-f66.google.com with SMTP id p65so4083408ywe.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Jan 2019 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lro4u7JxdQTWISDmD00Oe4kWaPf+DLhskqy5jnkTtdk=;
        b=ZkbKahUsR5dEJjJv3lcfUqMogLGb1Yfgk0nOTXQAHey9pyGBKveAy+6CvBkMQ+jqmq
         gBekcp1yPnnO2hfaavbIenj+oG23q6wSvfXxhAuRvL422hi53VfQeGCgR2s26D6uP8r2
         op1lEhUe9sT0iNNpGNokDu1pPwPLXFjqLWqRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lro4u7JxdQTWISDmD00Oe4kWaPf+DLhskqy5jnkTtdk=;
        b=hBDTPGLsqp116Hhyim+eNpf+eiayL//TPWeXjXtDEXhkSlaavGqMgTs/1fuL55EQPv
         pH5YSrjquCvbHx0pXSYcGou9DR0GIx4tZOIjDEGjC5bV848nl6KNuowOKLm7pzaYFoXN
         YoM4q+sTpUv4Es3d/Jyp/r+C48cVrw+MAXbR2xsUmZw5Yum5ttz15FaW1wgizRiCjJpC
         mfgcc58jv8je8fGBI+fJTVYgUjgXp6gm5kDpPdtM7qZrgxXsF0eULakGC1VrwuZsY6ur
         KMBCROhT9ZO0reSnShTYE5iVaAkRw3HvX751cCIqNrRARkVsv75/DIDZbkxzzJ1KdVYR
         yvww==
X-Gm-Message-State: AJcUukckvCdybe7g8mIm3FEKh87uzH0rgbs/vpSl7E4N4Rm+8TbnyLy+
        dsUrVDyVPiIRVK1ey2XNXO7SVfo4ck9Sgs53WfmATi0xiEE=
X-Google-Smtp-Source: ALg8bN47XbSJXvm9XgSQOTYaaqEPAXAMaUM2P8jKuTR70kJGZ0D45GWdPnVeA/USXFqYg6v1CgMCEO27chQF1dSp9lQ=
X-Received: by 2002:a0d:cf04:: with SMTP id r4mr11352811ywd.283.1548431528672;
 Fri, 25 Jan 2019 07:52:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-EccM-uiYybMcLNfwJjJcVHRPb6b=BdhotBYVBV_j5stxxzA@mail.gmail.com>
 <20190122224209.222480-1-mortonm@chromium.org>
In-Reply-To: <20190122224209.222480-1-mortonm@chromium.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 25 Jan 2019 07:51:57 -0800
Message-ID: <CAJ-EccPTayPqZ9_sM+nB2SnGDcrJ2fLwVV7bbLFs9=AvrAAhmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] LSM: add SafeSetID module that gates setid calls
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Patch set 1 of 2 was "Reviewed-by: Kees Cook <keescook@chromium.org>"
as well -- forgot to add that in the commit message above.

On Tue, Jan 22, 2019 at 2:42 PM <mortonm@chromium.org> wrote:
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
