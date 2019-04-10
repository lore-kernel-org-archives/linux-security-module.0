Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1CBC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ED62083E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/NA3Eos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfDJRYm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:24:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41418 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfDJRYm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:24:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so1827823vsc.8
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YtURZytC1EtGBkuTH9np6J5bRqrOKeMeciUamfsRrU=;
        b=M/NA3EosftdXGUVYj0wf0/oslVBDkQokH+KzNX06ARqaA5Z8cphOvaGbhhk2TAkQm8
         X/MZ4BWnHMrPWqbKs3C3dz2s2875LWlc2IKf6cvAmYgv6g6XMS5W4TARIPYPIgo9mJy/
         u/hC44srJq8G92pA4JViFu4If8Wi3KBrfD6kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YtURZytC1EtGBkuTH9np6J5bRqrOKeMeciUamfsRrU=;
        b=SjKT1gTSXt2J7XPL/DRQUp6aCw1wEUp8H8sRR6KxZ8Ga7tQT6t6k2y0Y9jqJOJCWpV
         LHKO2w3ErSH6ynd5WdOb1vj5MDYh9OWeIwoiLJWWXgurkoHsrD7HTAHcR5ruQPAaZkKn
         G9XolNNFYh0dI8qZRV3laJqot8ZfpLZv74f0i/MOLVBsP0VaAJ3eLHWX3PjMQzRyf1d5
         6JpRQ10hJRo4GxKrkuJPVIN3H6QWxgMzmGHW4XeDNj5B8CI39FeEvvKoSZwEr/TB5BPJ
         AfvB0jET0uaD4C2+p7vHKvGviciv+JQN5i+UPGd91SvyjUaQc6o65wkmSqPzjjY46goY
         nJig==
X-Gm-Message-State: APjAAAWv7g6ogb9p+ydCBLNs+rzHVxniIWYnbsArWlT8/2X674hMnK0t
        dy/FBd8XLFJw6d2DGRFCQGY83Wt8WRM=
X-Google-Smtp-Source: APXvYqyWumFfzExvPf7a3QTjpv1HI5UXiuIkuwY90fqIMiq7HmxLP3AB62DlbOzstpU/uzbswZlAqA==
X-Received: by 2002:a67:d098:: with SMTP id s24mr24559336vsi.95.1554917080561;
        Wed, 10 Apr 2019 10:24:40 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id k65sm10722889vkk.40.2019.04.10.10.24.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:24:39 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id d5so1052172uan.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:24:39 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr23709898uah.123.1554917078903;
 Wed, 10 Apr 2019 10:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165605.211749-1-mortonm@chromium.org>
In-Reply-To: <20190410165605.211749-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:24:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
Message-ID: <CAGXu5jK9tc28tsxEKOQ=R9B2AUOJ5Rt3j=VNqr1PQcAyAeNpgQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] LSM: SafeSetID: rewrite userspace API to atomic updates
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> The current API of the SafeSetID LSM uses one write() per rule, and applies
> each written rule instantly. This has several downsides:
>
>  - While a policy is being loaded, once a single parent-child pair has been
>    loaded, the parent is restricted to that specific child, even if
>    subsequent rules would allow transitions to other child UIDs. This means
>    that during policy loading, set*uid() can randomly fail.
>  - To replace the policy without rebooting, it is necessary to first flush
>    all old rules. This creates a time window in which no constraints are
>    placed on the use of CAP_SETUID.
>  - If we want to perform sanity checks on the final policy, this requires
>    that the policy isn't constructed in a piecemeal fashion without telling
>    the kernel when it's done.
>
> Other kernel APIs - including things like the userns code and netfilter -
> avoid this problem by performing updates atomically. Luckily, SafeSetID
> hasn't landed in a stable (upstream) release yet, so maybe it's not too
> late to completely change the API.
>
> The new API for SafeSetID is: If you want to change the policy, open
> "safesetid/whitelist_policy" and write the entire policy,
> newline-delimited, in there.

So the entire policy is expected to be sent in a single write() call?

open()
write(policy1)
write(policy2)
close()

means only policy2 is active? I thought policy was meant to be built
over time? i.e. new policy could get appended to existing?

-Kees

>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
>  security/safesetid/lsm.c                      |  84 +++-----
>  security/safesetid/lsm.h                      |  24 +--
>  security/safesetid/securityfs.c               | 194 ++++++++++--------
>  .../selftests/safesetid/safesetid-test.c      |  16 +-
>  4 files changed, 149 insertions(+), 169 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index ab429e1816c5..4ab4d7cdba31 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -24,28 +24,38 @@
>  /* Flag indicating whether initialization completed */
>  int safesetid_initialized;
>
> -#define NUM_BITS 8 /* 256 buckets in hash table */
> +struct setuid_ruleset __rcu *safesetid_setuid_rules;
>
> -static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
> -
> -static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
> -
> -static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
> +/* Compute a decision for a transition from @src to @dst under @policy. */
> +enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
> +               kuid_t src, kuid_t dst)
>  {
> -       struct entry *entry;
> +       struct setuid_rule *rule;
>         enum sid_policy_type result = SIDPOL_DEFAULT;
>
> -       rcu_read_lock();
> -       hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> -                                  entry, next, __kuid_val(src)) {
> -               if (!uid_eq(entry->src_uid, src))
> +       hash_for_each_possible(policy->rules, rule, next, __kuid_val(src)) {
> +               if (!uid_eq(rule->src_uid, src))
>                         continue;
> -               if (uid_eq(entry->dst_uid, dst)) {
> -                       rcu_read_unlock();
> +               if (uid_eq(rule->dst_uid, dst))
>                         return SIDPOL_ALLOWED;
> -               }
>                 result = SIDPOL_CONSTRAINED;
>         }
> +       return result;
> +}
> +
> +/*
> + * Compute a decision for a transition from @src to @dst under the active
> + * policy.
> + */
> +static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
> +{
> +       enum sid_policy_type result = SIDPOL_DEFAULT;
> +       struct setuid_ruleset *pol;
> +
> +       rcu_read_lock();
> +       pol = rcu_dereference(safesetid_setuid_rules);
> +       if (pol)
> +               result = _setuid_policy_lookup(pol, src, dst);
>         rcu_read_unlock();
>         return result;
>  }
> @@ -139,52 +149,6 @@ static int safesetid_task_fix_setuid(struct cred *new,
>         return -EACCES;
>  }
>
> -int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> -{
> -       struct entry *new;
> -
> -       /* Return if entry already exists */
> -       if (setuid_policy_lookup(parent, child) == SIDPOL_ALLOWED)
> -               return 0;
> -
> -       new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> -       if (!new)
> -               return -ENOMEM;
> -       new->src_uid = parent;
> -       new->dst_uid = child;
> -       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> -       hash_add_rcu(safesetid_whitelist_hashtable,
> -                    &new->next,
> -                    __kuid_val(parent));
> -       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> -       return 0;
> -}
> -
> -void flush_safesetid_whitelist_entries(void)
> -{
> -       struct entry *entry;
> -       struct hlist_node *hlist_node;
> -       unsigned int bkt_loop_cursor;
> -       HLIST_HEAD(free_list);
> -
> -       /*
> -        * Could probably use hash_for_each_rcu here instead, but this should
> -        * be fine as well.
> -        */
> -       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> -       hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor,
> -                          hlist_node, entry, next) {
> -               hash_del_rcu(&entry->next);
> -               hlist_add_head(&entry->dlist, &free_list);
> -       }
> -       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> -       synchronize_rcu();
> -       hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
> -               hlist_del(&entry->dlist);
> -               kfree(entry);
> -       }
> -}
> -
>  static struct security_hook_list safesetid_security_hooks[] = {
>         LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>         LSM_HOOK_INIT(capable, safesetid_security_capable)
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index 6806f902794c..4a34f558d964 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -21,12 +21,6 @@
>  /* Flag indicating whether initialization completed */
>  extern int safesetid_initialized;
>
> -/* Function type. */
> -enum safesetid_whitelist_file_write_type {
> -       SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
> -       SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
> -};
> -
>  enum sid_policy_type {
>         SIDPOL_DEFAULT, /* source ID is unaffected by policy */
>         SIDPOL_CONSTRAINED, /* source ID is affected by policy */
> @@ -35,18 +29,24 @@ enum sid_policy_type {
>
>  /*
>   * Hash table entry to store safesetid policy signifying that 'src_uid'
> - * can setid to 'dst_uid'.
> + * can setuid to 'dst_uid'.
>   */
> -struct entry {
> +struct setuid_rule {
>         struct hlist_node next;
> -       struct hlist_node dlist; /* for deletion cleanup */
>         kuid_t src_uid;
>         kuid_t dst_uid;
>  };
>
> -/* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
> -int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
> +#define SETID_HASH_BITS 8 /* 256 buckets in hash table */
> +
> +struct setuid_ruleset {
> +       DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
> +       struct rcu_head rcu;
> +};
> +
> +enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
> +               kuid_t src, kuid_t dst);
>
> -void flush_safesetid_whitelist_entries(void);
> +extern struct setuid_ruleset __rcu *safesetid_setuid_rules;
>
>  #endif /* _SAFESETID_H */
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 76c1e8a6ab93..13fce4c10930 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -11,25 +11,15 @@
>   * published by the Free Software Foundation.
>   *
>   */
> +
> +#define pr_fmt(fmt) "SafeSetID: " fmt
> +
>  #include <linux/security.h>
>  #include <linux/cred.h>
>
>  #include "lsm.h"
>
> -static struct dentry *safesetid_policy_dir;
> -
> -struct safesetid_file_entry {
> -       const char *name;
> -       enum safesetid_whitelist_file_write_type type;
> -       struct dentry *dentry;
> -};
> -
> -static struct safesetid_file_entry safesetid_files[] = {
> -       {.name = "add_whitelist_policy",
> -        .type = SAFESETID_WHITELIST_ADD},
> -       {.name = "flush_whitelist_policies",
> -        .type = SAFESETID_WHITELIST_FLUSH},
> -};
> +static DEFINE_SPINLOCK(policy_update_lock);
>
>  /*
>   * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> @@ -37,8 +27,8 @@ static struct safesetid_file_entry safesetid_files[] = {
>   * function will return an error.
>   * Contents of @buf may be modified.
>   */
> -static int parse_policy_line(
> -       struct file *file, char *buf, kuid_t *parent, kuid_t *child)
> +static int parse_policy_line(struct file *file, char *buf,
> +       struct setuid_rule *rule)
>  {
>         char *child_str;
>         int ret;
> @@ -59,26 +49,103 @@ static int parse_policy_line(
>         if (ret)
>                 return ret;
>
> -       *parent = make_kuid(file->f_cred->user_ns, parsed_parent);
> -       *child = make_kuid(file->f_cred->user_ns, parsed_child);
> -       if (!uid_valid(*parent) || !uid_valid(*child))
> +       rule->src_uid = make_kuid(file->f_cred->user_ns, parsed_parent);
> +       rule->dst_uid = make_kuid(file->f_cred->user_ns, parsed_child);
> +       if (!uid_valid(rule->src_uid) || !uid_valid(rule->dst_uid))
>                 return -EINVAL;
>
>         return 0;
>  }
>
> -static int parse_safesetid_whitelist_policy(
> -       struct file *file, const char __user *buf, size_t len,
> -       kuid_t *parent, kuid_t *child)
> +static void __release_ruleset(struct rcu_head *rcu)
>  {
> -       char *kern_buf = memdup_user_nul(buf, len);
> -       int ret;
> +       struct setuid_ruleset *pol =
> +               container_of(rcu, struct setuid_ruleset, rcu);
> +       int bucket;
> +       struct setuid_rule *rule;
> +       struct hlist_node *tmp;
> +
> +       hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
> +               kfree(rule);
> +       kfree(pol);
> +}
>
> -       if (IS_ERR(kern_buf))
> -               return PTR_ERR(kern_buf);
> -       ret = parse_policy_line(file, kern_buf, parent, child);
> -       kfree(kern_buf);
> -       return ret;
> +static void release_ruleset(struct setuid_ruleset *pol)
> +{
> +       call_rcu(&pol->rcu, __release_ruleset);
> +}
> +
> +static ssize_t handle_policy_update(struct file *file,
> +                                   const char __user *ubuf, size_t len)
> +{
> +       struct setuid_ruleset *pol;
> +       char *buf, *p, *end;
> +       int err;
> +
> +       pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
> +       if (!pol)
> +               return -ENOMEM;
> +       hash_init(pol->rules);
> +
> +       p = buf = memdup_user_nul(ubuf, len);
> +       if (IS_ERR(buf)) {
> +               err = PTR_ERR(buf);
> +               goto out_free_pol;
> +       }
> +
> +       /* policy lines, including the last one, end with \n */
> +       while (*p != '\0') {
> +               struct setuid_rule *rule;
> +
> +               end = strchr(p, '\n');
> +               if (end == NULL) {
> +                       err = -EINVAL;
> +                       goto out_free_buf;
> +               }
> +               *end = '\0';
> +
> +               rule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
> +               if (!rule) {
> +                       err = -ENOMEM;
> +                       goto out_free_buf;
> +               }
> +
> +               err = parse_policy_line(file, p, rule);
> +               if (err)
> +                       goto out_free_rule;
> +
> +               if (_setuid_policy_lookup(pol, rule->src_uid, rule->dst_uid) ==
> +                   SIDPOL_ALLOWED) {
> +                       pr_warn("bad policy: duplicate entry\n");
> +                       err = -EEXIST;
> +                       goto out_free_rule;
> +               }
> +
> +               hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> +               p = end + 1;
> +               continue;
> +
> +out_free_rule:
> +               kfree(rule);
> +               goto out_free_buf;
> +       }
> +
> +       /*
> +        * Everything looks good, apply the policy and release the old one.
> +        * What we really want here is an xchg() wrapper for RCU, but since that
> +        * doesn't currently exist, just use a spinlock for now.
> +        */
> +       spin_lock(&policy_update_lock);
> +       rcu_swap_protected(safesetid_setuid_rules, pol,
> +                          lockdep_is_held(&policy_update_lock));
> +       spin_unlock(&policy_update_lock);
> +       err = len;
> +
> +out_free_buf:
> +       kfree(buf);
> +out_free_pol:
> +       release_ruleset(pol);
> +       return err;
>  }
>
>  static ssize_t safesetid_file_write(struct file *file,
> @@ -86,90 +153,45 @@ static ssize_t safesetid_file_write(struct file *file,
>                                     size_t len,
>                                     loff_t *ppos)
>  {
> -       struct safesetid_file_entry *file_entry =
> -               file->f_inode->i_private;
> -       kuid_t parent;
> -       kuid_t child;
> -       int ret;
> -
>         if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
>                 return -EPERM;
>
>         if (*ppos != 0)
>                 return -EINVAL;
>
> -       switch (file_entry->type) {
> -       case SAFESETID_WHITELIST_FLUSH:
> -               flush_safesetid_whitelist_entries();
> -               break;
> -       case SAFESETID_WHITELIST_ADD:
> -               ret = parse_safesetid_whitelist_policy(file, buf, len,
> -                                                      &parent, &child);
> -               if (ret)
> -                       return ret;
> -
> -               ret = add_safesetid_whitelist_entry(parent, child);
> -               if (ret)
> -                       return ret;
> -               break;
> -       default:
> -               pr_warn("Unknown securityfs file %d\n", file_entry->type);
> -               break;
> -       }
> -
> -       /* Return len on success so caller won't keep trying to write */
> -       return len;
> +       return handle_policy_update(file, buf, len);
>  }
>
>  static const struct file_operations safesetid_file_fops = {
>         .write = safesetid_file_write,
>  };
>
> -static void safesetid_shutdown_securityfs(void)
> -{
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> -               struct safesetid_file_entry *entry =
> -                       &safesetid_files[i];
> -               securityfs_remove(entry->dentry);
> -               entry->dentry = NULL;
> -       }
> -
> -       securityfs_remove(safesetid_policy_dir);
> -       safesetid_policy_dir = NULL;
> -}
> -
>  static int __init safesetid_init_securityfs(void)
>  {
> -       int i;
>         int ret;
> +       struct dentry *policy_dir;
> +       struct dentry *policy_file;
>
>         if (!safesetid_initialized)
>                 return 0;
>
> -       safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
> -       if (IS_ERR(safesetid_policy_dir)) {
> -               ret = PTR_ERR(safesetid_policy_dir);
> +       policy_dir = securityfs_create_dir("safesetid", NULL);
> +       if (IS_ERR(policy_dir)) {
> +               ret = PTR_ERR(policy_dir);
>                 goto error;
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> -               struct safesetid_file_entry *entry =
> -                       &safesetid_files[i];
> -               entry->dentry = securityfs_create_file(
> -                       entry->name, 0200, safesetid_policy_dir,
> -                       entry, &safesetid_file_fops);
> -               if (IS_ERR(entry->dentry)) {
> -                       ret = PTR_ERR(entry->dentry);
> -                       goto error;
> -               }
> +       policy_file = securityfs_create_file("whitelist_policy", 0200,
> +                       policy_dir, NULL, &safesetid_file_fops);
> +       if (IS_ERR(policy_file)) {
> +               ret = PTR_ERR(policy_file);
> +               goto error;
>         }
>
>         return 0;
>
>  error:
> -       safesetid_shutdown_securityfs();
> +       securityfs_remove(policy_dir);
>         return ret;
>  }
>  fs_initcall(safesetid_init_securityfs);
> diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
> index 892c8e8b1b8b..4f03813d1911 100644
> --- a/tools/testing/selftests/safesetid/safesetid-test.c
> +++ b/tools/testing/selftests/safesetid/safesetid-test.c
> @@ -142,23 +142,17 @@ static void ensure_securityfs_mounted(void)
>
>  static void write_policies(void)
>  {
> +       static char *policy_str =
> +               "1:2\n"
> +               "1:3\n";
>         ssize_t written;
>         int fd;
>
>         fd = open(add_whitelist_policy_file, O_WRONLY);
>         if (fd < 0)
>                 die("cant open add_whitelist_policy file\n");
> -       written = write(fd, "1:2", strlen("1:2"));
> -       if (written != strlen("1:2")) {
> -               if (written >= 0) {
> -                       die("short write to %s\n", add_whitelist_policy_file);
> -               } else {
> -                       die("write to %s failed: %s\n",
> -                               add_whitelist_policy_file, strerror(errno));
> -               }
> -       }
> -       written = write(fd, "1:3", strlen("1:3"));
> -       if (written != strlen("1:3")) {
> +       written = write(fd, policy_str, strlen(policy_str));
> +       if (written != strlen(policy_str)) {
>                 if (written >= 0) {
>                         die("short write to %s\n", add_whitelist_policy_file);
>                 } else {
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
