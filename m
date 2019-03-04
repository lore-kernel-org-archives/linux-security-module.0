Return-Path: <SRS0=S0ZR=RH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8786C43381
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536EF206BA
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l93oOuDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCDSK2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:10:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46138 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSK2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 13:10:28 -0500
Received: by mail-yw1-f65.google.com with SMTP id n12so4780642ywn.13
        for <linux-security-module@vger.kernel.org>; Mon, 04 Mar 2019 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iIgwhVkM9nfcV8HcZb1GupQCViWAm4iCymPOG5HfrIY=;
        b=l93oOuDosxKqQFGY2UmEL9hvNtRRgp4862u1vGdDlAlO3+NzeO4hQOPEGxG/82vF15
         N7xzuHlN3in60QxBgj/t7O07qbIk+M9pX5ZgOpADxoqcyDO3U2eKj4RNT7MVVZqLNnb2
         WBYGYculdyqnp6vSwWrG7r3Stk5r4oo7gYGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iIgwhVkM9nfcV8HcZb1GupQCViWAm4iCymPOG5HfrIY=;
        b=YexKebROkLOWsgX51XAiw7CDD7a+qe+JD9rN3512iTd7cf4lnaWnRLa4qxGLx6oDtv
         gPX57SR6PswYoBZK8nJObS8MziVFsNo0HtQ/wrtVU2284wT3xjwFnI49JKn6y9UMrL8J
         xCsHvQOmga5V9ZUKzHm+DMoQrPeD39r+o7nZi2xiNy7BBskwSXna8noWo+jtqLd8TwuD
         5Pml/JTljA5D3+piZEtk1VCfLBdznblj8yEqWGiWdHY+NVRVvceCNsBgrM+j6S2XW/+i
         aG267riiZv4B1ficN1RfNpMjxOoZNMlnjqVBn7d7neitck4VUUQ4cKP6u4UhGlQnsGe6
         Qukw==
X-Gm-Message-State: APjAAAVG5z5yr1Rai6HKHrblCGUd0o02xSVy8RTPcgppKMwPSS7USSYk
        8md435H28K2s3K6/uyJa2gaF4JfEU5Aj9yr76DtOZg==
X-Google-Smtp-Source: APXvYqz4ffq4bhS0MQQnhsvJQgxNDiUGlozJT/wNKAalUYSlpigu0+1rFh5aqbYm4fRJDDwZiMqj+GSBp0E67wp+kiQ=
X-Received: by 2002:a25:e80a:: with SMTP id k10mr5729238ybd.140.1551723026860;
 Mon, 04 Mar 2019 10:10:26 -0800 (PST)
MIME-Version: 1.0
References: <5552a810-8072-e0fe-4a4c-76f937f0c3f4@schaufler-ca.com> <20190228235534.248869-1-mortonm@chromium.org>
In-Reply-To: <20190228235534.248869-1-mortonm@chromium.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 4 Mar 2019 10:10:15 -0800
Message-ID: <CAJ-EccMu97tZCWXTakcTwqFwzXdzVDedgc3jWaRvaJu-duH6tQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] LSM: SafeSetID: gate setgid transitions
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

On Thu, Feb 28, 2019 at 3:55 PM <mortonm@chromium.org> wrote:
>
> From: Micah Morton <mortonm@chromium.org>
>
> This patch generalizes the 'task_fix_setuid' LSM hook to enable hooking
> setgid transitions as well as setuid transitions. The hook is renamed to
> 'task_fix_setid'. The patch introduces calls to this hook from the
> setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
> govern setgid transitions in addition to setuid transitions. This patch
> also makes sure the setgid functions in kernel/sys.c call
> security_capable_setid rather than the ordinary security_capable
> function, so that the security_capable hook in the SafeSetID LSM knows
> it is being invoked from a setid function.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
> Changes since the last patch: Add break statements for the
> setgid-related case statements in cap_task_fix_setid in
> security/commoncap.c. We don't want those cases to fall through to the
> default statement and return -EINVAL. Are the setreuid and setuid cases
> for this function always returning -EINVAL or am I missing something
> really obvious?.. Seems strange if that is the case.

Just realized that the 'break' statement in the 3rd case
(LSM_SETUID_RES) is what keeps the first 2 cases (LSM_SETUID_RE and
LSM_SETUID_ID) from dropping down to the 'default' case, which
explains the behavior I was seeing. Learned something new today about
switch statements.

>
>  Documentation/admin-guide/LSM/SafeSetID.rst |  2 +-
>  include/linux/lsm_hooks.h                   |  8 ++---
>  include/linux/security.h                    | 36 ++++++++++++++-------
>  kernel/sys.c                                | 35 ++++++++++++++------
>  security/commoncap.c                        | 25 +++++++++-----
>  security/safesetid/lsm.c                    | 12 +++----
>  security/security.c                         |  4 +--
>  7 files changed, 79 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> index 212434ef65ad..670a6544fd39 100644
> --- a/Documentation/admin-guide/LSM/SafeSetID.rst
> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> @@ -88,7 +88,7 @@ other system interactions, including use of pid namespaces and device creation.
>  Use an existing LSM
>  -------------------
>  None of the other in-tree LSMs have the capability to gate setid transitions, or
> -even employ the security_task_fix_setuid hook at all. SELinux says of that hook:
> +even employ the security_task_fix_setid hook at all. SELinux says of that hook:
>  "Since setuid only affects the current process, and since the SELinux controls
>  are not based on the Linux identity attributes, SELinux does not need to control
>  this operation."
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 22fc786d723a..47fd04410fde 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -594,14 +594,14 @@
>   *     @size length of the file contents.
>   *     @id kernel read file identifier
>   *     Return 0 if permission is granted.
> - * @task_fix_setuid:
> + * @task_fix_setid:
>   *     Update the module's state after setting one or more of the user
>   *     identity attributes of the current process.  The @flags parameter
>   *     indicates which of the set*uid system calls invoked this hook.  If
>   *     @new is the set of credentials that will be installed.  Modifications
>   *     should be made to this rather than to @current->cred.
>   *     @old is the set of credentials that are being replaces
> - *     @flags contains one of the LSM_SETID_* values.
> + *     @flags contains one of the LSM_SET*ID_* values.
>   *     Return 0 on success.
>   * @task_setpgid:
>   *     Check permission before setting the process group identifier of the
> @@ -1594,7 +1594,7 @@ union security_list_options {
>         int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
>         int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>                                      enum kernel_read_file_id id);
> -       int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> +       int (*task_fix_setid)(struct cred *new, const struct cred *old,
>                                 int flags);
>         int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>         int (*task_getpgid)(struct task_struct *p);
> @@ -1886,7 +1886,7 @@ struct security_hook_heads {
>         struct hlist_head kernel_read_file;
>         struct hlist_head kernel_post_read_file;
>         struct hlist_head kernel_module_request;
> -       struct hlist_head task_fix_setuid;
> +       struct hlist_head task_fix_setid;
>         struct hlist_head task_setpgid;
>         struct hlist_head task_getpgid;
>         struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 13537a49ae97..76df3e22fed1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -95,7 +95,7 @@ extern int cap_inode_getsecurity(struct inode *inode, const char *name,
>  extern int cap_mmap_addr(unsigned long addr);
>  extern int cap_mmap_file(struct file *file, unsigned long reqprot,
>                          unsigned long prot, unsigned long flags);
> -extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
> +extern int cap_task_fix_setid(struct cred *new, const struct cred *old, int flags);
>  extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>                           unsigned long arg4, unsigned long arg5);
>  extern int cap_task_setscheduler(struct task_struct *p);
> @@ -128,17 +128,29 @@ extern unsigned long dac_mmap_min_addr;
>  /*
>   * Values used in the task_security_ops calls
>   */
> -/* setuid or setgid, id0 == uid or gid */
> -#define LSM_SETID_ID   1
> +/* setuid, id0 == uid */
> +#define LSM_SETUID_ID  1
>
> -/* setreuid or setregid, id0 == real, id1 == eff */
> -#define LSM_SETID_RE   2
> +/* setreuid, id0 == real, id1 == eff */
> +#define LSM_SETUID_RE  2
>
> -/* setresuid or setresgid, id0 == real, id1 == eff, uid2 == saved */
> -#define LSM_SETID_RES  4
> +/* setresuid, id0 == real, id1 == eff, uid2 == saved */
> +#define LSM_SETUID_RES 4
>
> -/* setfsuid or setfsgid, id0 == fsuid or fsgid */
> -#define LSM_SETID_FS   8
> +/* setfsuid, id0 == fsgid */
> +#define LSM_SETUID_FS  8
> +
> +/* setgid, id0 == gid */
> +#define LSM_SETGID_ID  16
> +
> +/* setregid, id0 == real, id1 == eff */
> +#define LSM_SETGID_RE  32
> +
> +/* setresgid, id0 == real, id1 == eff, uid2 == saved */
> +#define LSM_SETGID_RES 64
> +
> +/* setfsgid, id0 == fsgid */
> +#define LSM_SETGID_FS  128
>
>  /* Flags for security_task_prlimit(). */
>  #define LSM_PRLIMIT_READ  1
> @@ -324,7 +336,7 @@ int security_kernel_load_data(enum kernel_load_data_id id);
>  int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>                                    enum kernel_read_file_id id);
> -int security_task_fix_setuid(struct cred *new, const struct cred *old,
> +int security_task_fix_setid(struct cred *new, const struct cred *old,
>                              int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
> @@ -923,11 +935,11 @@ static inline int security_kernel_post_read_file(struct file *file,
>         return 0;
>  }
>
> -static inline int security_task_fix_setuid(struct cred *new,
> +static inline int security_task_fix_setid(struct cred *new,
>                                            const struct cred *old,
>                                            int flags)
>  {
> -       return cap_task_fix_setuid(new, old, flags);
> +       return cap_task_fix_setid(new, old, flags);
>  }
>
>  static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c5f875048aef..615b44939238 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -372,7 +372,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>         if (rgid != (gid_t) -1) {
>                 if (gid_eq(old->gid, krgid) ||
>                     gid_eq(old->egid, krgid) ||
> -                   ns_capable(old->user_ns, CAP_SETGID))
> +                   ns_capable_setid(old->user_ns, CAP_SETGID))
>                         new->gid = krgid;
>                 else
>                         goto error;
> @@ -381,7 +381,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>                 if (gid_eq(old->gid, kegid) ||
>                     gid_eq(old->egid, kegid) ||
>                     gid_eq(old->sgid, kegid) ||
> -                   ns_capable(old->user_ns, CAP_SETGID))
> +                   ns_capable_setid(old->user_ns, CAP_SETGID))
>                         new->egid = kegid;
>                 else
>                         goto error;
> @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>                 new->sgid = new->egid;
>         new->fsgid = new->egid;
>
> +       retval = security_task_fix_setid(new, old, LSM_SETGID_RE);
> +       if (retval < 0)
> +               goto error;
> +
>         return commit_creds(new);
>
>  error:
> @@ -427,13 +431,17 @@ long __sys_setgid(gid_t gid)
>         old = current_cred();
>
>         retval = -EPERM;
> -       if (ns_capable(old->user_ns, CAP_SETGID))
> +       if (ns_capable_setid(old->user_ns, CAP_SETGID))
>                 new->gid = new->egid = new->sgid = new->fsgid = kgid;
>         else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
>                 new->egid = new->fsgid = kgid;
>         else
>                 goto error;
>
> +       retval = security_task_fix_setid(new, old, LSM_SETGID_ID);
> +       if (retval < 0)
> +               goto error;
> +
>         return commit_creds(new);
>
>  error:
> @@ -539,7 +547,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
>                 new->suid = new->euid;
>         new->fsuid = new->euid;
>
> -       retval = security_task_fix_setuid(new, old, LSM_SETID_RE);
> +       retval = security_task_fix_setid(new, old, LSM_SETUID_RE);
>         if (retval < 0)
>                 goto error;
>
> @@ -597,7 +605,7 @@ long __sys_setuid(uid_t uid)
>
>         new->fsuid = new->euid = kuid;
>
> -       retval = security_task_fix_setuid(new, old, LSM_SETID_ID);
> +       retval = security_task_fix_setid(new, old, LSM_SETUID_ID);
>         if (retval < 0)
>                 goto error;
>
> @@ -672,7 +680,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
>                 new->suid = ksuid;
>         new->fsuid = new->euid;
>
> -       retval = security_task_fix_setuid(new, old, LSM_SETID_RES);
> +       retval = security_task_fix_setid(new, old, LSM_SETUID_RES);
>         if (retval < 0)
>                 goto error;
>
> @@ -735,7 +743,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>         old = current_cred();
>
>         retval = -EPERM;
> -       if (!ns_capable(old->user_ns, CAP_SETGID)) {
> +       if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
>                 if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
>                     !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
>                         goto error;
> @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>                 new->sgid = ksgid;
>         new->fsgid = new->egid;
>
> +       retval = security_task_fix_setid(new, old, LSM_SETGID_RES);
> +       if (retval < 0)
> +               goto error;
> +
>         return commit_creds(new);
>
>  error:
> @@ -817,7 +829,7 @@ long __sys_setfsuid(uid_t uid)
>             ns_capable_setid(old->user_ns, CAP_SETUID)) {
>                 if (!uid_eq(kuid, old->fsuid)) {
>                         new->fsuid = kuid;
> -                       if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
> +                       if (security_task_fix_setid(new, old, LSM_SETUID_FS) == 0)
>                                 goto change_okay;
>                 }
>         }
> @@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
>
>         if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
>             gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> -           ns_capable(old->user_ns, CAP_SETGID)) {
> +           ns_capable_setid(old->user_ns, CAP_SETGID)) {
>                 if (!gid_eq(kgid, old->fsgid)) {
>                         new->fsgid = kgid;
> -                       goto change_okay;
> +                       if (security_task_fix_setid(new,
> +                                               old,
> +                                               LSM_SETGID_FS) == 0)
> +                               goto change_okay;
>                 }
>         }
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f1d117c3d8ae..6f514d91d010 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1026,27 +1026,27 @@ static inline void cap_emulate_setxuid(struct cred *new, const struct cred *old)
>  }
>
>  /**
> - * cap_task_fix_setuid - Fix up the results of setuid() call
> + * cap_task_fix_setid - Fix up the results of setid() call
>   * @new: The proposed credentials
>   * @old: The current task's current credentials
>   * @flags: Indications of what has changed
>   *
> - * Fix up the results of setuid() call before the credential changes are
> + * Fix up the results of setid() call before the credential changes are
>   * actually applied, returning 0 to grant the changes, -ve to deny them.
>   */
> -int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
> +int cap_task_fix_setid(struct cred *new, const struct cred *old, int flags)
>  {
>         switch (flags) {
> -       case LSM_SETID_RE:
> -       case LSM_SETID_ID:
> -       case LSM_SETID_RES:
> +       case LSM_SETUID_RE:
> +       case LSM_SETUID_ID:
> +       case LSM_SETUID_RES:
>                 /* juggle the capabilities to follow [RES]UID changes unless
>                  * otherwise suppressed */
>                 if (!issecure(SECURE_NO_SETUID_FIXUP))
>                         cap_emulate_setxuid(new, old);
>                 break;
>
> -       case LSM_SETID_FS:
> +       case LSM_SETUID_FS:
>                 /* juggle the capabilties to follow FSUID changes, unless
>                  * otherwise suppressed
>                  *
> @@ -1066,6 +1066,15 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>                 }
>                 break;
>
> +       case LSM_SETGID_RE:
> +                break;
> +       case LSM_SETGID_ID:
> +                break;
> +       case LSM_SETGID_RES:
> +                break;
> +       case LSM_SETGID_FS:
> +                break;
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -1355,7 +1364,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
>         LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
>         LSM_HOOK_INIT(mmap_file, cap_mmap_file),
> -       LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
> +       LSM_HOOK_INIT(task_fix_setid, cap_task_fix_setid),
>         LSM_HOOK_INIT(task_prctl, cap_task_prctl),
>         LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
>         LSM_HOOK_INIT(task_setioprio, cap_task_setioprio),
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..5deffa92f25f 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -120,7 +120,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
>   * set*uid to user under new cred struct, or the UID transition is allowed (by
>   * Linux set*uid rules) even without CAP_SETUID.
>   */
> -static int safesetid_task_fix_setuid(struct cred *new,
> +static int safesetid_task_fix_setid(struct cred *new,
>                                      const struct cred *old,
>                                      int flags)
>  {
> @@ -130,7 +130,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>                 return 0;
>
>         switch (flags) {
> -       case LSM_SETID_RE:
> +       case LSM_SETUID_RE:
>                 /*
>                  * Users for which setuid restrictions exist can only set the
>                  * real UID to the real UID or the effective UID, unless an
> @@ -152,7 +152,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>                         return check_uid_transition(old->euid, new->euid);
>                 }
>                 break;
> -       case LSM_SETID_ID:
> +       case LSM_SETUID_ID:
>                 /*
>                  * Users for which setuid restrictions exist cannot change the
>                  * real UID or saved set-UID unless an explicit whitelist
> @@ -163,7 +163,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>                 if (!uid_eq(old->suid, new->suid))
>                         return check_uid_transition(old->suid, new->suid);
>                 break;
> -       case LSM_SETID_RES:
> +       case LSM_SETUID_RES:
>                 /*
>                  * Users for which setuid restrictions exist cannot change the
>                  * real UID, effective UID, or saved set-UID to anything but
> @@ -187,7 +187,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>                         return check_uid_transition(old->suid, new->suid);
>                 }
>                 break;
> -       case LSM_SETID_FS:
> +       case LSM_SETUID_FS:
>                 /*
>                  * Users for which setuid restrictions exist cannot change the
>                  * filesystem UID to anything but one of: the current real UID,
> @@ -256,7 +256,7 @@ void flush_safesetid_whitelist_entries(void)
>  }
>
>  static struct security_hook_list safesetid_security_hooks[] = {
> -       LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> +       LSM_HOOK_INIT(task_fix_setid, safesetid_task_fix_setid),
>         LSM_HOOK_INIT(capable, safesetid_security_capable)
>  };
>
> diff --git a/security/security.c b/security/security.c
> index ed9b8cbf21cf..450784fd1d2b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1568,10 +1568,10 @@ int security_kernel_load_data(enum kernel_load_data_id id)
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_load_data);
>
> -int security_task_fix_setuid(struct cred *new, const struct cred *old,
> +int security_task_fix_setid(struct cred *new, const struct cred *old,
>                              int flags)
>  {
> -       return call_int_hook(task_fix_setuid, 0, new, old, flags);
> +       return call_int_hook(task_fix_setid, 0, new, old, flags);
>  }
>
>  int security_task_setpgid(struct task_struct *p, pid_t pgid)
> --
> 2.21.0.352.gf09ad66450-goog
>
