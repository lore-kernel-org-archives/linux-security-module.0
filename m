Return-Path: <SRS0=eMAe=PP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC4C43387
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jan 2019 18:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C5A2173C
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jan 2019 18:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Aar7BO1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAGSQx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:16:53 -0500
Received: from sonic305-26.consmr.mail.gq1.yahoo.com ([98.137.64.89]:44696
        "EHLO sonic305-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfAGSQx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jan 2019 13:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1546885009; bh=jdQBeVE8pViaxHxGnP1uDZTKHWX3r647E5Vo7PMnBhg=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Aar7BO1irABWtzcSszE/YSg8u4EoSad6DZroAmm8CMq+hqyR1qi4+1tc6Ak45hPuRSbZW2Kt9i/ZpruRFjvnHZNzn56hj6l9TYeI/e657ohtYCnDZfR7i4a4m6DhA1e1atr4IBCdUTMwhzuDyTUtiuqwHjJjSxEFPQvdKSLkulQfA89FnKVKSOTq9FbbxQomrKp6qTzbKv1l19RyvUYJMVfkKH0WkL2k4/tSDIFjN3qo+C9/zaif73TKanQ3oTl0tSRseCFDJddkO7/XrmjjVzAOUW2u35bssd9znG7JMJyKIpirEKfML2vDQMtaBQbd11eXgGKb7JC7gHKDRJTgnw==
X-YMail-OSG: F2Izbe0VM1kMyhrgY0OvVJH_TR7SOzOjXT6U7G2DTFlrl7nGzsXQSPrArgHBER2
 rhFjlkdBYn80Kw8uEhnJuhjxSrUp_dp9a.QgfBxza0eGhZdx9gaDwbfqOnxSALai2_9alH5EJec6
 F8IQb4sReLYkJo66Mrn81gmzZyU3Hkdi0z448hP_H2LSsRIXt6RWu8cZezkncz5FYlrAzE8j4kh2
 Yu7s0Vv4EUiD1atoGLsqX.ENwqN5DBMzwsZU4NLRHfNyHZblsZxSzrmckIucLKgzcxI8Azj1No3P
 e6lN2YTtRC8FVX2au3HY7dD_G7BP60Hx33K2CeexVHtQcJZzeH73eDicMXr5CjhSe3MBoCWArBxc
 jw3apjHh._iPYP85IPGt.9HNasE1iDRlxh8R.I5jlbLPYiA2LoMK..ywRfD7DH4JBIdVKYm3KysL
 sKCwiCsD9avMLemTelUHm_Tz7cNyRY8EpqmcnvrCYLmV5Q8Q3eBU7R7BwHZWVVe4SW2uzpUiEfST
 4iagRa_dSyhAx9j3EUALFS6ytTdZCUi3X3NkBxkTBcVRPlfqnq75flAMEAynUWf6NVOgl16dlejL
 TramDAijtCLHAONB.WFa1zRZcjJJ0vXE0w4v7CAaL1FT_xZoZqTYpOkfqn46uQgub973w6480u3S
 R.KQ7Vpg72bbkKWjIlSWboW9XQpkUZcC3TnCHMx.vEolr7Jc9zaJl1BT_JP7S4YB6FlSxLv9SYbe
 nvS.cmH0AtyHqbZsZkg9ZLbPjadS5IaguVYTyyaeChThWtB844o6.azu1uHV7.XbwUjRhR.jF7Dj
 yAp_BPKJT9QAVanUXU6uscOS_f0G82QAsO5gEMXmbGQGhuKrBcmeIhQw5G5lGZ3r5R9BO_EnUUNV
 UJVxqE9jXv5Q0ICO1AOjFytUXp8Ys7qF9shJ0YVlkwKRJRUxbVgq5dWmvgfu0mLXFkmaGv4s11jA
 iXe4rdvTWZv_T91GxpfmORgLxLfkK.12FDtK0khZ2s59ry05KxzqUDxmqX48Kto2MW6fU3xqECwM
 zKWZ1JMn.c6USDMwNy6y1GbBd3txyn6f.mf5QsOQFfnmcihie_k.6yxbdSWKf7ehdxp4jZ2_Dq78
 1DVEOqlAxAEHjQqZnzPBhGOA4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 7 Jan 2019 18:16:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3378dbcd8c9eb7d42f040207bdf93a4;
          Mon, 07 Jan 2019 18:16:47 +0000 (UTC)
Subject: Re: [PATCH v2] LSM: generalize flag passing to security_capable
To:     Micah Morton <mortonm@chromium.org>, jmorris@namei.org,
        serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        sds@tycho.nsa.gov, linux-security-module@vger.kernel.org
References: <52258331-8aba-c67e-bea0-b5fe0dfcd020@schaufler-ca.com>
 <20181218223718.96738-1-mortonm@chromium.org>
 <CAJ-EccM9BDcOkzT9=RN0jKyVLPtxB7x2UrV7rO+VXH66Qj0mWg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ec7e60ad-2692-3099-426b-f6cbe26b3eb8@schaufler-ca.com>
Date:   Mon, 7 Jan 2019 10:16:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccM9BDcOkzT9=RN0jKyVLPtxB7x2UrV7rO+VXH66Qj0mWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/7/2019 9:55 AM, Micah Morton wrote:
> Checking in to see if there are any further comments on this patch now
> that the holidays are passed? It seems like a straightforward change
> to me, but let me know if there is anything I can clarify that isn't
> explained by the commit message.
>
> On Tue, Dec 18, 2018 at 2:37 PM <mortonm@chromium.org> wrote:
>> From: Micah Morton <mortonm@chromium.org>
>>
>> This patch provides a general mechanism for passing flags to the
>> security_capable LSM hook. It replaces the specific 'audit' flag that is
>> used to tell security_capable whether it should log an audit message for
>> the given capability check. The reason for generalizing this flag
>> passing is so we can add an additional flag that signifies whether
>> security_capable is being called by a setid syscall (which is needed by
>> the proposed SafeSetID LSM).
>>
>> Signed-off-by: Micah Morton <mortonm@chromium.org>
>> ---
>> Changes since the last patch: Changed the code to use a bitmask instead
>> of a struct to represent the options passed to security_capable.
>>
>>  include/linux/lsm_hooks.h              |  8 +++++---
>>  include/linux/security.h               | 28 +++++++++++++-------------
>>  kernel/capability.c                    | 22 +++++++++++---------
>>  kernel/seccomp.c                       |  4 ++--
>>  security/apparmor/capability.c         | 14 ++++++-------
>>  security/apparmor/include/capability.h |  2 +-
>>  security/apparmor/ipc.c                |  3 ++-
>>  security/apparmor/lsm.c                |  4 ++--
>>  security/commoncap.c                   | 17 ++++++++--------
>>  security/security.c                    | 14 +++++--------
>>  security/selinux/hooks.c               | 16 +++++++--------
>>  security/smack/smack_access.c          |  2 +-
>>  12 files changed, 69 insertions(+), 65 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index aaeb7fa24dc4..ef955a44a782 100644
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
>> +                       unsigned int opts);
>>         int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
>>         int (*quota_on)(struct dentry *dentry);
>>         int (*syslog)(int type);
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index d170a5b031f3..038e6779948c 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -54,9 +54,12 @@ struct xattr;
>>  struct xfrm_sec_ctx;
>>  struct mm_struct;
>>
>> +/* Default (no) options for the capable function */
>> +#define SECURITY_CAP_DEFAULT 0x0
>>  /* If capable should audit the security request */
>> -#define SECURITY_CAP_NOAUDIT 0
>> -#define SECURITY_CAP_AUDIT 1
>> +#define SECURITY_CAP_NOAUDIT 0x01
>> +/* If capable is being called by a setid function */
>> +#define SECURITY_CAP_INSETID 0x02
>>
>>  /* LSM Agnostic defines for sb_set_mnt_opts */
>>  #define SECURITY_LSM_NATIVE_LABELS     1
>> @@ -72,7 +75,7 @@ enum lsm_event {
>>
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>> -                      int cap, int audit);
>> +                      int cap, unsigned int opts);
>>  extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
>>  extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
>>  extern int cap_ptrace_traceme(struct task_struct *parent);
>> @@ -233,10 +236,10 @@ int security_capset(struct cred *new, const struct cred *old,
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
>> +                      unsigned int opts);
>>  int security_quotactl(int cmds, int type, int id, struct super_block *sb);
>>  int security_quota_on(struct dentry *dentry);
>>  int security_syslog(int type);
>> @@ -492,14 +495,11 @@ static inline int security_capset(struct cred *new,
>>  }
>>
>>  static inline int security_capable(const struct cred *cred,
>> -                                  struct user_namespace *ns, int cap)
>> +                                  struct user_namespace *ns,
>> +                                  int cap,
>> +                                  unsigned int opts)
>>  {
>> -       return cap_capable(cred, ns, cap, SECURITY_CAP_AUDIT);
>> -}
>> -
>> -static inline int security_capable_noaudit(const struct cred *cred,
>> -                                          struct user_namespace *ns, int cap) {
>> -       return cap_capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
>> +       return cap_capable(cred, ns, cap, opts);
>>  }

Why get rid of security_capable_noaudit()?

>>
>>  static inline int security_quotactl(int cmds, int type, int id,
>> diff --git a/kernel/capability.c b/kernel/capability.c
>> index 1e1c0236f55b..454576743b1b 100644
>> --- a/kernel/capability.c
>> +++ b/kernel/capability.c
>> @@ -299,7 +299,7 @@ bool has_ns_capability(struct task_struct *t,
>>         int ret;
>>
>>         rcu_read_lock();
>> -       ret = security_capable(__task_cred(t), ns, cap);
>> +       ret = security_capable(__task_cred(t), ns, cap, SECURITY_CAP_DEFAULT);
>>         rcu_read_unlock();
>>
>>         return (ret == 0);
>> @@ -340,7 +340,7 @@ bool has_ns_capability_noaudit(struct task_struct *t,
>>         int ret;
>>
>>         rcu_read_lock();
>> -       ret = security_capable_noaudit(__task_cred(t), ns, cap);
>> +       ret = security_capable(__task_cred(t), ns, cap, SECURITY_CAP_NOAUDIT);
>>         rcu_read_unlock();
>>
>>         return (ret == 0);
>> @@ -363,7 +363,9 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>>         return has_ns_capability_noaudit(t, &init_user_ns, cap);
>>  }
>>
>> -static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>> +static bool ns_capable_common(struct user_namespace *ns,
>> +                             int cap,
>> +                             unsigned int opts)
>>  {
>>         int capable;
>>
>> @@ -372,8 +374,7 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>>                 BUG();
>>         }
>>
>> -       capable = audit ? security_capable(current_cred(), ns, cap) :
>> -                         security_capable_noaudit(current_cred(), ns, cap);
>> +       capable = security_capable(current_cred(), ns, cap, opts);
>>         if (capable == 0) {
>>                 current->flags |= PF_SUPERPRIV;
>>                 return true;
>> @@ -394,7 +395,7 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
>>   */
>>  bool ns_capable(struct user_namespace *ns, int cap)
>>  {
>> -       return ns_capable_common(ns, cap, true);
>> +       return ns_capable_common(ns, cap, SECURITY_CAP_DEFAULT);
>>  }
>>  EXPORT_SYMBOL(ns_capable);
>>
>> @@ -412,7 +413,7 @@ EXPORT_SYMBOL(ns_capable);
>>   */
>>  bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>>  {
>> -       return ns_capable_common(ns, cap, false);
>> +       return ns_capable_common(ns, cap, SECURITY_CAP_NOAUDIT);
>>  }
>>  EXPORT_SYMBOL(ns_capable_noaudit);
>>
>> @@ -448,10 +449,11 @@ EXPORT_SYMBOL(capable);
>>  bool file_ns_capable(const struct file *file, struct user_namespace *ns,
>>                      int cap)
>>  {
>> +
>>         if (WARN_ON_ONCE(!cap_valid(cap)))
>>                 return false;
>>
>> -       if (security_capable(file->f_cred, ns, cap) == 0)
>> +       if (security_capable(file->f_cred, ns, cap, SECURITY_CAP_DEFAULT) == 0)
>>                 return true;
>>
>>         return false;
>> @@ -500,10 +502,12 @@ bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns)
>>  {
>>         int ret = 0;  /* An absent tracer adds no restrictions */
>>         const struct cred *cred;
>> +
>>         rcu_read_lock();
>>         cred = rcu_dereference(tsk->ptracer_cred);
>>         if (cred)
>> -               ret = security_capable_noaudit(cred, ns, CAP_SYS_PTRACE);
>> +               ret = security_capable(cred, ns, CAP_SYS_PTRACE,
>> +                                      SECURITY_CAP_NOAUDIT);
>>         rcu_read_unlock();
>>         return (ret == 0);
>>  }
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index f2ae2324c232..ddf615eb1bf7 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -383,8 +383,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
>>          * behavior of privileged children.
>>          */
>>         if (!task_no_new_privs(current) &&
>> -           security_capable_noaudit(current_cred(), current_user_ns(),
>> -                                    CAP_SYS_ADMIN) != 0)
>> +           security_capable(current_cred(), current_user_ns(),
>> +                                    CAP_SYS_ADMIN, SECURITY_CAP_NOAUDIT) != 0)
>>                 return ERR_PTR(-EACCES);
>>
>>         /* Allocate a new seccomp_filter */
>> diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
>> index 253ef6e9d445..0f6dca54b66e 100644
>> --- a/security/apparmor/capability.c
>> +++ b/security/apparmor/capability.c
>> @@ -110,13 +110,13 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
>>   * profile_capable - test if profile allows use of capability @cap
>>   * @profile: profile being enforced    (NOT NULL, NOT unconfined)
>>   * @cap: capability to test if allowed
>> - * @audit: whether an audit record should be generated
>> + * @opts: SECURITY_CAP_NOAUDIT bit determines whether audit record is generated
>>   * @sa: audit data (MAY BE NULL indicating no auditing)
>>   *
>>   * Returns: 0 if allowed else -EPERM
>>   */
>> -static int profile_capable(struct aa_profile *profile, int cap, int audit,
>> -                          struct common_audit_data *sa)
>> +static int profile_capable(struct aa_profile *profile, int cap,
>> +                          unsigned int opts, struct common_audit_data *sa)
>>  {
>>         int error;
>>
>> @@ -126,7 +126,7 @@ static int profile_capable(struct aa_profile *profile, int cap, int audit,
>>         else
>>                 error = -EPERM;
>>
>> -       if (audit == SECURITY_CAP_NOAUDIT) {
>> +       if (opts & SECURITY_CAP_NOAUDIT) {
>>                 if (!COMPLAIN_MODE(profile))
>>                         return error;
>>                 /* audit the cap request in complain mode but note that it
>> @@ -142,13 +142,13 @@ static int profile_capable(struct aa_profile *profile, int cap, int audit,
>>   * aa_capable - test permission to use capability
>>   * @label: label being tested for capability (NOT NULL)
>>   * @cap: capability to be tested
>> - * @audit: whether an audit record should be generated
>> + * @opts: SECURITY_CAP_NOAUDIT bit determines whether audit record is generated
>>   *
>>   * Look up capability in profile capability set.
>>   *
>>   * Returns: 0 on success, or else an error code.
>>   */
>> -int aa_capable(struct aa_label *label, int cap, int audit)
>> +int aa_capable(struct aa_label *label, int cap, unsigned int opts)
>>  {
>>         struct aa_profile *profile;
>>         int error = 0;
>> @@ -156,7 +156,7 @@ int aa_capable(struct aa_label *label, int cap, int audit)
>>
>>         sa.u.cap = cap;
>>         error = fn_for_each_confined(label, profile,
>> -                       profile_capable(profile, cap, audit, &sa));
>> +                       profile_capable(profile, cap, opts, &sa));
>>
>>         return error;
>>  }
>> diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
>> index e0304e2aeb7f..1b3663b6ab12 100644
>> --- a/security/apparmor/include/capability.h
>> +++ b/security/apparmor/include/capability.h
>> @@ -40,7 +40,7 @@ struct aa_caps {
>>
>>  extern struct aa_sfs_entry aa_sfs_entry_caps[];
>>
>> -int aa_capable(struct aa_label *label, int cap, int audit);
>> +int aa_capable(struct aa_label *label, int cap, unsigned int opts);
>>
>>  static inline void aa_free_cap_rules(struct aa_caps *caps)
>>  {
>> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
>> index 527ea1557120..4a1da2313162 100644
>> --- a/security/apparmor/ipc.c
>> +++ b/security/apparmor/ipc.c
>> @@ -107,7 +107,8 @@ static int profile_tracer_perm(struct aa_profile *tracer,
>>         aad(sa)->label = &tracer->label;
>>         aad(sa)->peer = tracee;
>>         aad(sa)->request = 0;
>> -       aad(sa)->error = aa_capable(&tracer->label, CAP_SYS_PTRACE, 1);
>> +       aad(sa)->error = aa_capable(&tracer->label, CAP_SYS_PTRACE,
>> +                                   SECURITY_CAP_DEFAULT);
>>
>>         return aa_audit(AUDIT_APPARMOR_AUTO, tracer, sa, audit_ptrace_cb);
>>  }
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 42446a216f3b..0bd817084fc1 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -176,14 +176,14 @@ static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
>>  }
>>
>>  static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
>> -                           int cap, int audit)
>> +                           int cap, unsigned int opts)
>>  {
>>         struct aa_label *label;
>>         int error = 0;
>>
>>         label = aa_get_newest_cred_label(cred);
>>         if (!unconfined(label))
>> -               error = aa_capable(label, cap, audit);
>> +               error = aa_capable(label, cap, opts);
>>         aa_put_label(label);
>>
>>         return error;
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index 232db019f051..3d8609192e17 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -68,7 +68,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
>>   * kernel's capable() and has_capability() returns 1 for this case.
>>   */
>>  int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>> -               int cap, int audit)
>> +               int cap, unsigned int opts)
>>  {
>>         struct user_namespace *ns = targ_ns;
>>
>> @@ -222,12 +222,11 @@ int cap_capget(struct task_struct *target, kernel_cap_t *effective,
>>   */
>>  static inline int cap_inh_is_capped(void)
>>  {
>> -
>>         /* they are so limited unless the current task has the CAP_SETPCAP
>>          * capability
>>          */
>>         if (cap_capable(current_cred(), current_cred()->user_ns,
>> -                       CAP_SETPCAP, SECURITY_CAP_AUDIT) == 0)
>> +                       CAP_SETPCAP, SECURITY_CAP_DEFAULT) == 0)
>>                 return 0;
>>         return 1;
>>  }
>> @@ -1208,8 +1207,9 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>                     || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))   /*[2]*/
>>                     || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))   /*[3]*/
>>                     || (cap_capable(current_cred(),
>> -                                   current_cred()->user_ns, CAP_SETPCAP,
>> -                                   SECURITY_CAP_AUDIT) != 0)           /*[4]*/
>> +                                   current_cred()->user_ns,
>> +                                   CAP_SETPCAP,
>> +                                   SECURITY_CAP_DEFAULT) != 0)         /*[4]*/
>>                         /*
>>                          * [1] no changing of bits that are locked
>>                          * [2] no unlocking of locks
>> @@ -1304,9 +1304,10 @@ int cap_vm_enough_memory(struct mm_struct *mm, long pages)
>>  {
>>         int cap_sys_admin = 0;
>>
>> -       if (cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
>> -                       SECURITY_CAP_NOAUDIT) == 0)
>> +       if (cap_capable(current_cred(), &init_user_ns,
>> +                               CAP_SYS_ADMIN, SECURITY_CAP_NOAUDIT) == 0)
>>                 cap_sys_admin = 1;
>> +
>>         return cap_sys_admin;
>>  }
>>
>> @@ -1325,7 +1326,7 @@ int cap_mmap_addr(unsigned long addr)
>>
>>         if (addr < dac_mmap_min_addr) {
>>                 ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
>> -                                 SECURITY_CAP_AUDIT);
>> +                                 SECURITY_CAP_DEFAULT);
>>                 /* set PF_SUPERPRIV if it turns out we allow the low mmap */
>>                 if (ret == 0)
>>                         current->flags |= PF_SUPERPRIV;
>> diff --git a/security/security.c b/security/security.c
>> index d670136dda2c..d2334697797a 100644
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
>> +                    unsigned int opts)
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
>> index a67459eb62d5..a4b2e49213de 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1769,7 +1769,7 @@ static inline u32 signal_to_av(int sig)
>>
>>  /* Check whether a task is allowed to use a capability. */
>>  static int cred_has_capability(const struct cred *cred,
>> -                              int cap, int audit, bool initns)
>> +                              int cap, unsigned int opts, bool initns)
>>  {
>>         struct common_audit_data ad;
>>         struct av_decision avd;
>> @@ -1796,7 +1796,7 @@ static int cred_has_capability(const struct cred *cred,
>>
>>         rc = avc_has_perm_noaudit(&selinux_state,
>>                                   sid, sid, sclass, av, 0, &avd);
>> -       if (audit == SECURITY_CAP_AUDIT) {
>> +       if (!(opts & SECURITY_CAP_NOAUDIT)) {
>>                 int rc2 = avc_audit(&selinux_state,
>>                                     sid, sid, sclass, av, &avd, rc, &ad, 0);
>>                 if (rc2)
>> @@ -2316,9 +2316,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
>>   */
>>
>>  static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>> -                          int cap, int audit)
>> +                          int cap, unsigned int opts)
>>  {
>> -       return cred_has_capability(cred, cap, audit, ns == &init_user_ns);
>> +       return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>>  }
>>
>>  static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
>> @@ -3245,11 +3245,11 @@ static int selinux_inode_getattr(const struct path *path)
>>  static bool has_cap_mac_admin(bool audit)
>>  {
>>         const struct cred *cred = current_cred();
>> -       int cap_audit = audit ? SECURITY_CAP_AUDIT : SECURITY_CAP_NOAUDIT;
>> +       unsigned int opts = audit ? SECURITY_CAP_DEFAULT : SECURITY_CAP_NOAUDIT;
>>
>> -       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, cap_audit))
>> +       if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts))
>>                 return false;
>> -       if (cred_has_capability(cred, CAP_MAC_ADMIN, cap_audit, true))
>> +       if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true))
>>                 return false;
>>         return true;
>>  }
>> @@ -3649,7 +3649,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>>         case KDSKBENT:
>>         case KDSKBSENT:
>>                 error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
>> -                                           SECURITY_CAP_AUDIT, true);
>> +                                           SECURITY_CAP_DEFAULT, true);
>>                 break;
>>
>>         /* default case assumes that the command will go
>> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
>> index 9a4c0ad46518..fac2a21aa7d4 100644
>> --- a/security/smack/smack_access.c
>> +++ b/security/smack/smack_access.c
>> @@ -640,7 +640,7 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>>         struct smack_known_list_elem *sklep;
>>         int rc;
>>
>> -       rc = cap_capable(cred, &init_user_ns, cap, SECURITY_CAP_AUDIT);
>> +       rc = cap_capable(cred, &init_user_ns, cap, SECURITY_CAP_DEFAULT);
>>         if (rc)
>>                 return false;
>>
>> --
>> 2.20.0.405.gbc1bbc6f85-goog
>>

