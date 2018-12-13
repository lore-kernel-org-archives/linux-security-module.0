Return-Path: <SRS0=Wiv6=OW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A41C65BAE
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 23:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2E20851
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 23:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F/DvrMkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeLMXKA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:10:00 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:35445 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbeLMXKA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 18:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544742595; bh=7EzQqGg3pcYjI0DUmKuzTUfrktKL396okR5iP89RZ4s=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=F/DvrMkOc522r9W3z6K3dFjrtvNCVYPtqTx29RZMX9N2U8ju+MjETTTPJPVowVdjGKppbHmfFTNZ/m6JlW5FdKx65XyqzAsxuLayc9MypFmKuzR5F26AqdIKj21XJvVkH/MHGp4dl6OfLOr8OLT5pYWUqiRcJMULdPfDy7738KTb1JM8lCB3hBsSaej0aMvotV3PFCMJ0Ls4Q/bY2+FX5FXdsPwHvJyJwnu87DNjetV+blVtpxMfKdJPzP7sAqo3Kld8z5KQSgbYkeRO3xrbnTaR1gj48CD3DRVsLC93qqZ3wmZFgF70JGUX0UMgoOQwXQ8asisqibxasmr8mVMB9Q==
X-YMail-OSG: lVjJ_psVM1n88VSIaUUNYIu5AgNdt7UL8AtR1jKeF7sl67ZTaeOWSZKdp5mPskW
 UcB.aSPMIuGEDBynaQhsT_CwUCFPj5MxxD5JvdddhIkaaMP7ip6SwIlfFBdW_GOQbdlV0GoLWcx9
 PqUoJWQkepW39Bz.8o1egQXHiAMuLxzmcaYqvPQgjcYvt5EV_fcry2rgljXxqmHideh3Ctd4KI2X
 vaoNzsg.6Cfhw2PQAAlgeaOrpbaQcPpb6uUxnKWa5sE3AlPBJQuNoqsVYedk2WsJfIyX5RXaFAJv
 XpHrsvj28yNOraTMhHRp.ZG0fg6RJ8fMB426fLm.1altS1AIhOWrlhl5PXtyYSjRfCOaDkQ6g7id
 Mi57xOSKIHgpxzk2woO80QkoYXiTZaCzYjr1YQoN.kG9KuIsqkF5MobPEGkhSznaYz_NcNTHFjGs
 lQyYR.5TEhcKZQs9azdH8J0QlW0gsDC68JK_reHaTSRaW4aadYkIdHNDoa7IlJN.39i3.9hlehcN
 UcHu1NvIShHr0Sq4eHeL09c4qPPZkJ4XqVsuEzJDWVoeIrCS4q0TMl9H7eqC_MK28af3kxzhrYYl
 xYKfgt6B8tORQNGAl7ZBm5giRKfRLVD.daCrcSvfDkddMrxJkmoyPiI8XeEBOE3SsjX1WKCjh5mH
 tl.HKSDm3jjooYyivOgnpxfh70Duxa1Xp4Tv416PCibmIqenvTcEi405k4s7wtsbUisj5i5TUtB6
 1nzouh.qLkrgIm1kKtBgv6jwApjYDh.s297kY6KzkQ6g_c7EPOaLhJaihfqvbJXZQLEuJkfyJAch
 LpbsRRPrGewNu92egMKSpEADgmZBEeRroylbHgnowKF5ATG_KsspoBrGkFxD.oaG1nlxDX6Lc9BE
 fhH7J8s0AyEpguJJVJXWhwmqOJER3C57o6IiBwCv1HWJUsD9eqFTo3sL2PD8NeNbgSytBssEGYr0
 462pXRLmGVYNKtR4VsgIxBCQG9.Of6mc0oW_S97I7cmXqOYKLHyav3gvn8I6HATn8muJdk.zBWo7
 tKUZbQHUinkpup4w7yeVoV9zD65byKtsjz0R2Xiyi23jx20oHZIMP35mgNgRXQ80FHbqMlMe_6tD
 nQvzd0H1BcyCBN.c496SOWq94pvm_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 13 Dec 2018 23:09:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d419b4db587c9f04744a44c113c8b433;
          Thu, 13 Dec 2018 23:09:53 +0000 (UTC)
Subject: Re: [PATCH] [PATCH] LSM: generalize flag passing to security_capable
To:     Micah Morton <mortonm@chromium.org>, jmorris@namei.org,
        serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
References: <f0a0dcb8-5659-904b-5cff-09bb36704799@tycho.nsa.gov>
 <20181119185444.13211-1-mortonm@chromium.org>
 <CAJ-EccPVjViSxCP=036Y+_DiA88XFBAc_+g984nq51tg+EfG5A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <52258331-8aba-c67e-bea0-b5fe0dfcd020@schaufler-ca.com>
Date:   Thu, 13 Dec 2018 15:09:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccPVjViSxCP=036Y+_DiA88XFBAc_+g984nq51tg+EfG5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/13/2018 2:29 PM, Micah Morton wrote:
> Any comments on this patch? If not, could it get merged at some point?

Sorry, up to my ears in dropbears.

> I booted a Linux kernel with the changes compiled in and verified with
> print statements that the code works properly AFAICT.
> On Mon, Nov 19, 2018 at 10:54 AM <mortonm@chromium.org> wrote:
>> From: Micah Morton <mortonm@chromium.org>
>>
>> This patch provides a general mechanism for passing flags to the
>> security_capable LSM hook. It replaces the specific 'audit' flag that is
>> used to tell security_capable whether it should log an audit message for
>> the given capability check. The reason for generalizing this flag
>> passing is so we can add an additional flag that signifies whether
>> security_capable is being called by a setid syscall (which is needed by
>> the proposed SafeSetID LSM). This generalization could also support
>> passing down the inode for CAP_DAC_OVERRIDE/READ_SEARCH checks so that
>> authorization could happen on a per-file basis for specific files rather
>> than all or nothing.
>>
>> Signed-off-by: Micah Morton <mortonm@chromium.org>
>> ---
>>
>> Developed against the 'next-general' branch.
>>
>> @Stephen: is this the approach you had in mind for modifying the
>> callers of ns_capable?
>>
>>  include/linux/lsm_hooks.h     |  8 ++++---
>>  include/linux/security.h      | 35 ++++++++++++++++++++----------
>>  kernel/capability.c           | 41 +++++++++++++++++++++++++++--------
>>  kernel/seccomp.c              |  7 ++++--
>>  security/apparmor/lsm.c       |  4 ++--
>>  security/commoncap.c          | 27 ++++++++++++++++-------
>>  security/security.c           | 14 +++++-------
>>  security/selinux/hooks.c      | 13 ++++++-----
>>  security/smack/smack_access.c |  5 ++++-
>>  9 files changed, 103 insertions(+), 51 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index aaeb7fa24dc4..02422592cc83 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1270,7 +1270,7 @@
>>   *     @cred contains the credentials to use.
>>   *     @ns contains the user namespace we want the capability in
>>   *     @cap contains the capability <include/linux/capability.h>.
>> - *     @audit contains whether to write an audit message or not
>> + *     @opts contains options for the capable check <include/linux/security.h>
>>   *     Return 0 if the capability is granted for @tsk.
>>   * @syslog:
>>   *     Check permission before accessing the kernel message ring or changing
>> @@ -1446,8 +1446,10 @@ union security_list_options {
>>                         const kernel_cap_t *effective,
>>                         const kernel_cap_t *inheritable,
>>                         const kernel_cap_t *permitted);
>> -       int (*capable)(const struct cred *cred, struct user_namespace *ns,
>> -                       int cap, int audit);
>> +       int (*capable)(const struct cred *cred,
>> +                       struct user_namespace *ns,
>> +                       int cap,
>> +                       struct security_capable_opts *opts);

If you used the existing "audit" argument as a bitmask you wouldn't
have to change the interface or most of the callers.

>>         int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
>>         int (*quota_on)(struct dentry *dentry);
>>         int (*syslog)(int type);
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index d170a5b031f3..b60621e93faf 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -58,6 +58,13 @@ struct mm_struct;
>>  #define SECURITY_CAP_NOAUDIT 0
>>  #define SECURITY_CAP_AUDIT 1
>>
>> +struct security_capable_opts {
>> +       /* If capable should audit the security request */
>> +       bool log_audit_message;
>> +       /* If capable is being called from a setid syscall */
>> +       bool in_setid;
>> +};
>> +

Why not
	#define SECURITY_CAP_AUDIT 0x01
	#define SECURITY_CAP_INSETID 0x02

>>  /* LSM Agnostic defines for sb_set_mnt_opts */
>>  #define SECURITY_LSM_NATIVE_LABELS     1
>>
>> @@ -72,7 +79,7 @@ enum lsm_event {
>>
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>> -                      int cap, int audit);
>> +                      int cap, struct security_capable_opts *opts);

Unnecessary if you use a bitmask.

>>  extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
>>  extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
>>  extern int cap_ptrace_traceme(struct task_struct *parent);
>> @@ -180,6 +187,13 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>>         return kernel_load_data_str[id];
>>  }
>>
>> +/* init a security_capable_opts struct with default values */
>> +static inline void init_security_capable_opts(struct security_capable_opts* opts)
>> +{
>> +       opts->log_audit_message = true;
>> +       opts->in_setid = false;
>> +}
>> +

Also unnecessary.

>>  #ifdef CONFIG_SECURITY
>>
>>  struct security_mnt_opts {
>> @@ -233,10 +247,10 @@ int security_capset(struct cred *new, const struct cred *old,
>>                     const kernel_cap_t *effective,
>>                     const kernel_cap_t *inheritable,
>>                     const kernel_cap_t *permitted);
>> -int security_capable(const struct cred *cred, struct user_namespace *ns,
>> -                       int cap);
>> -int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
>> -                            int cap);
>> +int security_capable(const struct cred *cred,
>> +                      struct user_namespace *ns,
>> +                      int cap,
>> +                      struct security_capable_opts *opts);

Bitmask.

>>  int security_quotactl(int cmds, int type, int id, struct super_block *sb);
>>  int security_quota_on(struct dentry *dentry);
>>  int security_syslog(int type);
>> @@ -492,14 +506,11 @@ static inline int security_capset(struct cred *new,
>>  }
>>
>>  static inline int security_capable(const struct cred *cred,
>> -                                  struct user_namespace *ns, int cap)
>> +                                  struct user_namespace *ns,
>> +                                  int cap,
>> +                                  struct security_capable_opts *opts)
>>  {
>> -       return cap_capable(cred, ns, cap, SECURITY_CAP_AUDIT);
>> -}
>> -
>> -static inline int security_capable_noaudit(const struct cred *cred,
>> -                                          struct user_namespace *ns, int cap) {
>> -       return cap_capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
>> +       return cap_capable(cred, ns, cap, opts);
>>  }
>>
>>  static inline int security_quotactl(int cmds, int type, int id,
>> diff --git a/kernel/capability.c b/kernel/capability.c
>> index 1e1c0236f55b..d8ff27e6e7c4 100644
>> --- a/kernel/capability.c
>> +++ b/kernel/capability.c
>> @@ -297,9 +297,12 @@ bool has_ns_capability(struct task_struct *t,
>>                        struct user_namespace *ns, int cap)
>>  {
>>         int ret;
>> +       struct security_capable_opts opts;
>> +
>> +       init_security_capable_opts(&opts);
>>
>>         rcu_read_lock();
>> -       ret = security_capable(__task_cred(t), ns, cap);
>> +       ret = security_capable(__task_cred(t), ns, cap, &opts);
>>         rcu_read_unlock();
>>
>>         return (ret == 0);
>> @@ -338,9 +341,13 @@ bool has_ns_capability_noaudit(struct task_struct *t,
>>                                struct user_namespace *ns, int cap)
>>  {
>>         int ret;
>> +       struct security_capable_opts opts;
>> +
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = false;

This is why I would prefer a bitmask. Too much work
for the desired result.

>>
>>         rcu_read_lock();
>> -       ret = security_capable_noaudit(__task_cred(t), ns, cap);
>> +       ret = security_capable(__task_cred(t), ns, cap, &opts);
>>         rcu_read_unlock();
>>
>>         return (ret == 0);
>> @@ -363,7 +370,9 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>>         return has_ns_capability_noaudit(t, &init_user_ns, cap);
>>  }
>>
>> -static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>> +static bool ns_capable_common(struct user_namespace *ns,
>> +                             int cap,
>> +                             struct security_capable_opts *opts)
>>  {
>>         int capable;
>>
>> @@ -372,8 +381,7 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>>                 BUG();
>>         }
>>
>> -       capable = audit ? security_capable(current_cred(), ns, cap) :
>> -                         security_capable_noaudit(current_cred(), ns, cap);
>> +       capable = security_capable(current_cred(), ns, cap, opts);
>>         if (capable == 0) {
>>                 current->flags |= PF_SUPERPRIV;
>>                 return true;
>> @@ -394,7 +402,10 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>>   */
>>  bool ns_capable(struct user_namespace *ns, int cap)
>>  {
>> -       return ns_capable_common(ns, cap, true);
>> +       struct security_capable_opts opts;
>> +
>> +       init_security_capable_opts(&opts);
>> +       return ns_capable_common(ns, cap, &opts);
>>  }
>>  EXPORT_SYMBOL(ns_capable);
>>
>> @@ -412,7 +423,11 @@ EXPORT_SYMBOL(ns_capable);
>>   */
>>  bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>>  {
>> -       return ns_capable_common(ns, cap, false);
>> +       struct security_capable_opts opts;
>> +
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = false;
>> +       return ns_capable_common(ns, cap, &opts);
>>  }
>>  EXPORT_SYMBOL(ns_capable_noaudit);
>>
>> @@ -448,10 +463,13 @@ EXPORT_SYMBOL(capable);
>>  bool file_ns_capable(const struct file *file, struct user_namespace *ns,
>>                      int cap)
>>  {
>> +       struct security_capable_opts opts;
>> +
>>         if (WARN_ON_ONCE(!cap_valid(cap)))
>>                 return false;
>>
>> -       if (security_capable(file->f_cred, ns, cap) == 0)
>> +       init_security_capable_opts(&opts);
>> +       if (security_capable(file->f_cred, ns, cap, &opts) == 0)
>>                 return true;
>>
>>         return false;
>> @@ -500,10 +518,15 @@ bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns)
>>  {
>>         int ret = 0;  /* An absent tracer adds no restrictions */
>>         const struct cred *cred;
>> +       struct security_capable_opts opts;
>> +
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = false;
>> +
>>         rcu_read_lock();
>>         cred = rcu_dereference(tsk->ptracer_cred);
>>         if (cred)
>> -               ret = security_capable_noaudit(cred, ns, CAP_SYS_PTRACE);
>> +               ret = security_capable(cred, ns, CAP_SYS_PTRACE, &opts);
>>         rcu_read_unlock();
>>         return (ret == 0);
>>  }
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index f2ae2324c232..eed0e34c1bc2 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -370,12 +370,15 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>>         struct seccomp_filter *sfilter;
>>         int ret;
>>         const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
>> +       struct security_capable_opts opts;
>>
>>         if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
>>                 return ERR_PTR(-EINVAL);
>>
>>         BUG_ON(INT_MAX / fprog->len < sizeof(struct sock_filter));
>>
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = false;
>>         /*
>>          * Installing a seccomp filter requires that the task has
>>          * CAP_SYS_ADMIN in its namespace or be running with no_new_privs.
>> @@ -383,8 +386,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>>          * behavior of privileged children.
>>          */
>>         if (!task_no_new_privs(current) &&
>> -           security_capable_noaudit(current_cred(), current_user_ns(),
>> -                                    CAP_SYS_ADMIN) != 0)
>> +           security_capable(current_cred(), current_user_ns(),
>> +                                    CAP_SYS_ADMIN, &opts) != 0)
>>                 return ERR_PTR(-EACCES);
>>
>>         /* Allocate a new seccomp_filter */
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 42446a216f3b..3be87dfd5e57 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -176,14 +176,14 @@ static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
>>  }
>>
>>  static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
>> -                           int cap, int audit)
>> +                           int cap, struct security_capable_opts *opts)
>>  {
>>         struct aa_label *label;
>>         int error = 0;
>>
>>         label = aa_get_newest_cred_label(cred);
>>         if (!unconfined(label))
>> -               error = aa_capable(label, cap, audit);
>> +               error = aa_capable(label, cap, opts->log_audit_message);
>>         aa_put_label(label);
>>
>>         return error;
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index 18a4fdf6f6eb..93fbb0dd70d6 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -69,7 +69,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>>   * kernel's capable() and has_capability() returns 1 for this case.
>>   */
>>  int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>> -               int cap, int audit)
>> +               int cap, struct security_capable_opts *opts)
>>  {
>>         struct user_namespace *ns = targ_ns;
>>
>> @@ -223,12 +223,14 @@ int cap_capget(struct task_struct *target, kernel_cap_t *effective,
>>   */
>>  static inline int cap_inh_is_capped(void)
>>  {
>> +       struct security_capable_opts opts;
>>
>> +       init_security_capable_opts(&opts);
>>         /* they are so limited unless the current task has the CAP_SETPCAP
>>          * capability
>>          */
>>         if (cap_capable(current_cred(), current_cred()->user_ns,
>> -                       CAP_SETPCAP, SECURITY_CAP_AUDIT) == 0)
>> +                       CAP_SETPCAP, &opts) == 0)
>>                 return 0;
>>         return 1;
>>  }
>> @@ -1174,6 +1176,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>  {
>>         const struct cred *old = current_cred();
>>         struct cred *new;
>> +       struct security_capable_opts opts;
>>
>>         switch (option) {
>>         case PR_CAPBSET_READ:
>> @@ -1204,13 +1207,15 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>          * capability-based-privilege environment.
>>          */
>>         case PR_SET_SECUREBITS:
>> +               init_security_capable_opts(&opts);
>>                 if ((((old->securebits & SECURE_ALL_LOCKS) >> 1)
>>                      & (old->securebits ^ arg2))                        /*[1]*/
>>                     || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))   /*[2]*/
>>                     || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))   /*[3]*/
>>                     || (cap_capable(current_cred(),
>> -                                   current_cred()->user_ns, CAP_SETPCAP,
>> -                                   SECURITY_CAP_AUDIT) != 0)           /*[4]*/
>> +                                   current_cred()->user_ns,
>> +                                   CAP_SETPCAP,
>> +                                   &opts) != 0)                        /*[4]*/
>>                         /*
>>                          * [1] no changing of bits that are locked
>>                          * [2] no unlocking of locks
>> @@ -1304,10 +1309,14 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>  int cap_vm_enough_memory(struct mm_struct *mm, long pages)
>>  {
>>         int cap_sys_admin = 0;
>> +       struct security_capable_opts opts;
>>
>> -       if (cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
>> -                       SECURITY_CAP_NOAUDIT) == 0)
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = false;
>> +
>> +       if (cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN, &opts) == 0)
>>                 cap_sys_admin = 1;
>> +
>>         return cap_sys_admin;
>>  }
>>
>> @@ -1323,10 +1332,12 @@ int cap_vm_enough_memory(struct mm_struct *mm, long pages)
>>  int cap_mmap_addr(unsigned long addr)
>>  {
>>         int ret = 0;
>> +       struct security_capable_opts opts;
>>
>> +        init_security_capable_opts(&opts);
>>         if (addr < dac_mmap_min_addr) {
>> -               ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
>> -                                 SECURITY_CAP_AUDIT);
>> +               ret = cap_capable(current_cred(), &init_user_ns,
>> +                                               CAP_SYS_RAWIO, &opts);
>>                 /* set PF_SUPERPRIV if it turns out we allow the low mmap */
>>                 if (ret == 0)
>>                         current->flags |= PF_SUPERPRIV;
>> diff --git a/security/security.c b/security/security.c
>> index 04d173eb93f6..bbc400a90c34 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -294,16 +294,12 @@ int security_capset(struct cred *new, const struct cred *old,
>>                                 effective, inheritable, permitted);
>>  }
>>
>> -int security_capable(const struct cred *cred, struct user_namespace *ns,
>> -                    int cap)
>> +int security_capable(const struct cred *cred,
>> +                    struct user_namespace *ns,
>> +                    int cap,
>> +                    struct security_capable_opts *opts)
>>  {
>> -       return call_int_hook(capable, 0, cred, ns, cap, SECURITY_CAP_AUDIT);
>> -}
>> -
>> -int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
>> -                            int cap)
>> -{
>> -       return call_int_hook(capable, 0, cred, ns, cap, SECURITY_CAP_NOAUDIT);
>> +       return call_int_hook(capable, 0, cred, ns, cap, opts);
>>  }
>>
>>  int security_quotactl(int cmds, int type, int id, struct super_block *sb)
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 7ce683259357..ebd36adc8856 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2316,9 +2316,10 @@ static int selinux_capset(struct cred *new, const struct cred *old,
>>   */
>>
>>  static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>> -                          int cap, int audit)
>> +                          int cap, struct security_capable_opts *opts)
>>  {
>> -       return cred_has_capability(cred, cap, audit, ns == &init_user_ns);
>> +       return cred_has_capability(cred, cap, opts->log_audit_message,
>> +                                                       ns == &init_user_ns);
>>  }
>>
>>  static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
>> @@ -3245,11 +3246,13 @@ static int selinux_inode_getattr(const struct path *path)
>>  static bool has_cap_mac_admin(bool audit)
>>  {
>>         const struct cred *cred = current_cred();
>> -       int cap_audit = audit ? SECURITY_CAP_AUDIT : SECURITY_CAP_NOAUDIT;
>> +       struct security_capable_opts opts;
>>
>> -       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, cap_audit))
>> +       init_security_capable_opts(&opts);
>> +       opts.log_audit_message = audit ? true : false;
>> +       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, &opts))
>>                 return false;
>> -       if (cred_has_capability(cred, CAP_MAC_ADMIN, cap_audit, true))
>> +       if (cred_has_capability(cred, CAP_MAC_ADMIN, opts.log_audit_message, true))
>>                 return false;
>>         return true;
>>  }
>> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
>> index 9a4c0ad46518..eca364b697d7 100644
>> --- a/security/smack/smack_access.c
>> +++ b/security/smack/smack_access.c
>> @@ -639,8 +639,11 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>>         struct smack_known *skp = tsp->smk_task;
>>         struct smack_known_list_elem *sklep;
>>         int rc;
>> +       struct security_capable_opts opts;
>>
>> -       rc = cap_capable(cred, &init_user_ns, cap, SECURITY_CAP_AUDIT);
>> +       init_security_capable_opts(&opts);
>> +
>> +       rc = cap_capable(cred, &init_user_ns, cap, &opts);
>>         if (rc)
>>                 return false;
>>
>> --
>> 2.19.1.1215.g8438c0b245-goog
>>

