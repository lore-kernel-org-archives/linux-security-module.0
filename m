Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890CC43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16FF20657
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 00:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPct2dI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfAOAid (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:38:33 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45598 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfAOAid (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Jan 2019 19:38:33 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so218729vke.12
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jan 2019 16:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=to1+iKmGmN5/VLAxRQB+AYKX5SnUqdCFwJy1z1U7MlE=;
        b=oPct2dI291yImPIEOmbIb0o+cYpsW4hgq79DRki7QawWE6fx6dBDGUqeYui6ADNo6T
         wGIDvnYgNGsUWoS4fllWW5egy03XF/heve48aXo9Y16JHwj6A5JJeGlPc56YfDuw2Igf
         8PO2edmOU/PKe/4JxSnTLRHZPMw/557g6TXfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=to1+iKmGmN5/VLAxRQB+AYKX5SnUqdCFwJy1z1U7MlE=;
        b=strVXC8Dc71FmdNn5NkO8qi7ftde8nyVVgaRzDDOELYAOAgbpubJaGhejmVI8AwQkp
         RDvQNZ0HbLtt5sTJnVwOOpe5/UNlLH5uV/zMpkqoazjFf9MB2ODKasNfiKFolK3BPt7q
         fNHFU4r/+B5O2hpHJb+5Ov3pZq2jKh4DEYxTtXUNCWmwhshGSgyVyfK2NeWNMFa71tHp
         WujESiThUYUSAjlxR0XfhM89X0CUkJmW8iRauVIsVqd2rNDcyzTJWoCkV6M1pJcHIH4E
         PnMl/r3P5o5B21620dm+2jriCMd5kuo33P9pX0jBbBOH2XEv53QSED8CgP8T+JJsV3ul
         yeCQ==
X-Gm-Message-State: AJcUukdaeuWDPVacK+z9DLxyB/lwsJt745GCmxbqq9Q6PYu6AcNzrmRg
        yQQ989gCUzPfTnyCFi8n9ikrd9LxHqE=
X-Google-Smtp-Source: ALg8bN4nMe3fw/oMnDk+gPUNtf+8Uqob0GqmDSpLvXFVxal1cBHh8khXn93pucKwWKRDXtr5NfF7og==
X-Received: by 2002:a1f:f8cf:: with SMTP id w198mr512107vkh.82.1547512710666;
        Mon, 14 Jan 2019 16:38:30 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id w65sm3995608vsc.16.2019.01.14.16.38.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 16:38:29 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id n13so637635vsk.4
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jan 2019 16:38:29 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr528152vss.172.1547512708580;
 Mon, 14 Jan 2019 16:38:28 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jJCk8p_nkuutM0kPLhwibKEVoA6E=ZqT2r8jVK5H47ORQ@mail.gmail.com>
 <20190111171302.26152-1-mortonm@chromium.org>
In-Reply-To: <20190111171302.26152-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 16:38:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
Message-ID: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: add SafeSetID module that gates setid calls
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

On Fri, Jan 11, 2019 at 9:13 AM <mortonm@chromium.org> wrote:
>
> From: Micah Morton <mortonm@chromium.org>
>
> SafeSetID gates the setid family of syscalls to restrict UID/GID
> transitions from a given UID/GID to only those approved by a
> system-wide whitelist. These restrictions also prohibit the given
> UIDs/GIDs from obtaining auxiliary privileges associated with
> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> mappings. For now, only gating the set*uid family of syscalls is
> supported, with support for set*gid coming in a future patch set.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
> Changes since the last patch set: Rebase after commit
> a35ce66b801631823fc78c8a78d104f9c0976867 got applied to next-general.
> As a result of that commit, we can remove the changes in arch/ and the
> setuid_syscall function in lsm.c, since this code no longer needs to do
> arch-specific operations to see if security_capable is being called from
> a setid syscall. Instead, we add the ns_capable_insetid function and
> call it from the setid syscalls in kernel/sys.c (rather than calling the
> original ns_capable function), which allows us to signal to the
> security_capable hooks whether the hook is being called from within a
> setid syscall.

I would split this patch into two halfs: the "no op" change that
"marks" all the setid call sites in the first patch, then the LSM
itself in the second patch.

> +bool ns_capable_insetid(struct user_namespace *ns, int cap)
> +{
> +       return ns_capable_common(ns, cap, CAP_OPT_INSETID);
> +}
> +EXPORT_SYMBOL(ns_capable_insetid);

Since we have the noaudit helper still, using this one seems fine to
me. I might bikeshed the name to "ns_capable_setid()". If others don't
want a new helper, then it should be fine to just change the callsites
to the direct ns_capable_common(ns, cap, CAP_OPT_INSETID).

> +static int safesetid_security_capable(const struct cred *cred,
> +                                     struct user_namespace *ns,
> +                                     int cap,
> +                                     unsigned int opts)
> +{
> +       if (cap == CAP_SETUID &&
> +           check_setuid_policy_hashtable_key(cred->uid)) {
> +               if (!(opts & CAP_OPT_INSETID)) {
> +                       /*
> +                        * Deny if we're not in a set*uid() syscall to avoid
> +                        * giving powers gated by CAP_SETUID that are related
> +                        * to functionality other than calling set*uid() (e.g.
> +                        * allowing user to set up userns uid mappings).
> +                        */
> +                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
> +                               __kuid_val(cred->uid));
> +                       return -1;
> +                }
> +       }
> +       return 0;
> +}

Much cleaner than the per-arch syscall tests. :)

> +static void setuid_policy_violation(kuid_t parent, kuid_t child)
> +{
> +       pr_warn("UID transition (%d -> %d) blocked",
> +               __kuid_val(parent),
> +               __kuid_val(child));
> +        /*
> +         * Kill this process to avoid potential security vulnerabilities
> +         * that could arise from a missing whitelist entry preventing a
> +         * privileged process from dropping to a lesser-privileged one.
> +         */
> +        do_exit(SIGKILL);

I think I asked earlier if this should be an unblockable signal raise
instead of a do_exit(). I don't remember if that got answered?

> +}
> +
> +static int check_uid_transition(kuid_t parent, kuid_t child)
> +{
> +       if (check_setuid_policy_hashtable_key_value(parent, child))
> +               return 0;
> +       setuid_policy_violation(parent, child);
> +       return -1;
> +}

Any reason not to just collapse setuid_policy_violation() into this function?

> +
> +/*
> + * Check whether there is either an exception for user under old cred struct to
> + * set*uid to user under new cred struct, or the UID transition is allowed (by
> + * Linux set*uid rules) even without CAP_SETUID.
> + */
> +static int safesetid_task_fix_setuid(struct cred *new,
> +                                    const struct cred *old,
> +                                    int flags)
> +{
> +
> +       /* Do nothing if there are no setuid restrictions for this UID. */
> +       if (!check_setuid_policy_hashtable_key(old->uid))
> +               return 0;
> +
> +       switch (flags) {
> +       case LSM_SETID_RE:
> +               /*
> +                * Users for which setuid restrictions exist can only set the
> +                * real UID to the real UID or the effective UID, unless an
> +                * explicit whitelist policy allows the transition.
> +                */
> +               if (!uid_eq(old->uid, new->uid) &&
> +                       !uid_eq(old->euid, new->uid)) {
> +                       return check_uid_transition(old->uid, new->uid);
> +               }
> +               /*
> +                * Users for which setuid restrictions exist can only set the
> +                * effective UID to the real UID, the effective UID, or the
> +                * saved set-UID, unless an explicit whitelist policy allows
> +                * the transition.
> +                */
> +               if (!uid_eq(old->uid, new->euid) &&
> +                       !uid_eq(old->euid, new->euid) &&
> +                       !uid_eq(old->suid, new->euid)) {
> +                       return check_uid_transition(old->euid, new->euid);
> +               }
> +               break;
> +       case LSM_SETID_ID:
> +               /*
> +                * Users for which setuid restrictions exist cannot change the
> +                * real UID or saved set-UID unless an explicit whitelist
> +                * policy allows the transition.
> +                */
> +               if (!uid_eq(old->uid, new->uid))
> +                       return check_uid_transition(old->uid, new->uid);
> +               if (!uid_eq(old->suid, new->suid))
> +                       return check_uid_transition(old->suid, new->suid);
> +               break;
> +       case LSM_SETID_RES:
> +               /*
> +                * Users for which setuid restrictions exist cannot change the
> +                * real UID, effective UID, or saved set-UID to anything but
> +                * one of: the current real UID, the current effective UID or
> +                * the current saved set-user-ID unless an explicit whitelist
> +                * policy allows the transition.
> +                */
> +               if (!uid_eq(new->uid, old->uid) &&
> +                       !uid_eq(new->uid, old->euid) &&
> +                       !uid_eq(new->uid, old->suid)) {
> +                       return check_uid_transition(old->uid, new->uid);
> +               }
> +               if (!uid_eq(new->euid, old->uid) &&
> +                       !uid_eq(new->euid, old->euid) &&
> +                       !uid_eq(new->euid, old->suid)) {
> +                       return check_uid_transition(old->euid, new->euid);
> +               }
> +               if (!uid_eq(new->suid, old->uid) &&
> +                       !uid_eq(new->suid, old->euid) &&
> +                       !uid_eq(new->suid, old->suid)) {
> +                       return check_uid_transition(old->suid, new->suid);
> +               }
> +               break;
> +       case LSM_SETID_FS:
> +               /*
> +                * Users for which setuid restrictions exist cannot change the
> +                * filesystem UID to anything but one of: the current real UID,
> +                * the current effective UID or the current saved set-UID
> +                * unless an explicit whitelist policy allows the transition.
> +                */
> +               if (!uid_eq(new->fsuid, old->uid)  &&
> +                       !uid_eq(new->fsuid, old->euid)  &&
> +                       !uid_eq(new->fsuid, old->suid) &&
> +                       !uid_eq(new->fsuid, old->fsuid)) {
> +                       return check_uid_transition(old->fsuid, new->fsuid);
> +               }
> +               break;
> +       }
> +       return 0;
> +}
> +
> +int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> +{
> +       struct entry *new;
> +
> +       /* Return if entry already exists */
> +       if (check_setuid_policy_hashtable_key_value(parent, child))
> +               return 0;
> +
> +       new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +       new->parent_kuid = __kuid_val(parent);
> +       new->child_kuid = __kuid_val(child);
> +       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> +       hash_add_rcu(safesetid_whitelist_hashtable,
> +                    &new->next,
> +                    __kuid_val(parent));
> +       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> +       return 0;
> +}
> +
> +void flush_safesetid_whitelist_entries(void)
> +{
> +       struct entry *entry;
> +       struct hlist_node *hlist_node;
> +       unsigned int bkt_loop_cursor;
> +       HLIST_HEAD(free_list);
> +
> +       /*
> +        * Could probably use hash_for_each_rcu here instead, but this should
> +        * be fine as well.
> +        */
> +       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> +       hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor,
> +                          hlist_node, entry, next) {
> +               hash_del_rcu(&entry->next);
> +               hlist_add_head(&entry->dlist, &free_list);
> +       }
> +       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> +       synchronize_rcu();
> +       hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
> +               hlist_del(&entry->dlist);
> +               kfree(entry);
> +       }
> +}
> +
> +static struct security_hook_list safesetid_security_hooks[] = {
> +       LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> +       LSM_HOOK_INIT(capable, safesetid_security_capable)
> +};
> +
> +static int __init safesetid_security_init(void)
> +{
> +       security_add_hooks(safesetid_security_hooks,
> +                          ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +
> +       return 0;
> +}
> +
> +DEFINE_LSM(safesetid_security_init) = {
> +       .init = safesetid_security_init,
> +};
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> new file mode 100644
> index 000000000000..bf78af9bf314
> --- /dev/null
> +++ b/security/safesetid/lsm.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SafeSetID Linux Security Module
> + *
> + * Author: Micah Morton <mortonm@chromium.org>
> + *
> + * Copyright (C) 2018 The Chromium OS Authors.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + */
> +#ifndef _SAFESETID_H
> +#define _SAFESETID_H
> +
> +#include <linux/types.h>
> +
> +/* Function type. */
> +enum safesetid_whitelist_file_write_type {
> +       SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
> +       SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
> +};
> +
> +/* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
> +int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
> +
> +void flush_safesetid_whitelist_entries(void);
> +
> +#endif /* _SAFESETID_H */
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> new file mode 100644
> index 000000000000..ff5fcf2c1b37
> --- /dev/null
> +++ b/security/safesetid/securityfs.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SafeSetID Linux Security Module
> + *
> + * Author: Micah Morton <mortonm@chromium.org>
> + *
> + * Copyright (C) 2018 The Chromium OS Authors.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/security.h>
> +#include <linux/cred.h>
> +
> +#include "lsm.h"
> +
> +static struct dentry *safesetid_policy_dir;
> +
> +struct safesetid_file_entry {
> +       const char *name;
> +       enum safesetid_whitelist_file_write_type type;
> +       struct dentry *dentry;
> +};
> +
> +static struct safesetid_file_entry safesetid_files[] = {
> +       {.name = "add_whitelist_policy",
> +        .type = SAFESETID_WHITELIST_ADD},
> +       {.name = "flush_whitelist_policies",
> +        .type = SAFESETID_WHITELIST_FLUSH},
> +};
> +
> +/*
> + * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> + * variables pointed to by 'parent' and 'child' will get updated but this
> + * function will return an error.
> + */
> +static int parse_safesetid_whitelist_policy(const char __user *buf,
> +                                           size_t len,
> +                                           kuid_t *parent,
> +                                           kuid_t *child)
> +{
> +       char *kern_buf;
> +       char *parent_buf;
> +       char *child_buf;
> +       const char separator[] = ":";
> +       int ret;
> +       size_t first_substring_length;
> +       long parsed_parent;
> +       long parsed_child;
> +
> +       /* Duplicate string from user memory and NULL-terminate */
> +       kern_buf = memdup_user_nul(buf, len);
> +       if (IS_ERR(kern_buf))
> +               return PTR_ERR(kern_buf);
> +
> +       /*
> +        * Format of |buf| string should be <UID>:<UID>.
> +        * Find location of ":" in kern_buf (copied from |buf|).
> +        */
> +       first_substring_length = strcspn(kern_buf, separator);
> +       if (first_substring_length == 0 || first_substring_length == len) {
> +               ret = -EINVAL;
> +               goto free_kern;
> +       }
> +
> +       parent_buf = kmemdup_nul(kern_buf, first_substring_length, GFP_KERNEL);
> +       if (!parent_buf) {
> +               ret = -ENOMEM;
> +               goto free_kern;
> +       }
> +
> +       ret = kstrtol(parent_buf, 0, &parsed_parent);
> +       if (ret)
> +               goto free_both;
> +
> +       child_buf = kern_buf + first_substring_length + 1;
> +       ret = kstrtol(child_buf, 0, &parsed_child);
> +       if (ret)
> +               goto free_both;
> +
> +       *parent = make_kuid(current_user_ns(), parsed_parent);
> +       if (!uid_valid(*parent)) {
> +               ret = -EINVAL;
> +               goto free_both;
> +       }
> +
> +       *child = make_kuid(current_user_ns(), parsed_child);
> +       if (!uid_valid(*child)) {
> +               ret = -EINVAL;
> +               goto free_both;
> +       }
> +
> +free_both:
> +       kfree(parent_buf);
> +free_kern:
> +       kfree(kern_buf);
> +       return ret;
> +}
> +
> +static ssize_t safesetid_file_write(struct file *file,
> +                                   const char __user *buf,
> +                                   size_t len,
> +                                   loff_t *ppos)
> +{
> +       struct safesetid_file_entry *file_entry =
> +               file->f_inode->i_private;
> +       kuid_t parent;
> +       kuid_t child;
> +       int ret;
> +
> +       if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))

Maybe CAP_MAC_ADMIN instead of (the overloaded) CAP_SYS_ADMIN?

> +               return -EPERM;
> +
> +       if (*ppos != 0)
> +               return -EINVAL;
> +
> +       if (file_entry->type == SAFESETID_WHITELIST_FLUSH) {
> +               flush_safesetid_whitelist_entries();
> +               return len;
> +       }
> +
> +       /*
> +        * If we get to here, must be the case that file_entry->type equals
> +        * SAFESETID_WHITELIST_ADD

It seems a bit silly with only two options here, but it'll change for
gids, yes? How about just building a switch() around file_entry->type
instead and avoid needing to refactor this later?

> +        */
> +       ret = parse_safesetid_whitelist_policy(buf, len, &parent,
> +                                                        &child);
> +       if (ret)
> +               return ret;
> +
> +       ret = add_safesetid_whitelist_entry(parent, child);
> +       if (ret)
> +               return ret;
> +
> +       /* Return len on success so caller won't keep trying to write */
> +       return len;
> +}
> +
> +static const struct file_operations safesetid_file_fops = {
> +       .write = safesetid_file_write,
> +};
> +
> +static void safesetid_shutdown_securityfs(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> +               struct safesetid_file_entry *entry =
> +                       &safesetid_files[i];
> +               securityfs_remove(entry->dentry);
> +               entry->dentry = NULL;
> +       }
> +
> +       securityfs_remove(safesetid_policy_dir);
> +       safesetid_policy_dir = NULL;
> +}
> +
> +static int __init safesetid_init_securityfs(void)
> +{
> +       int i;
> +       int ret;
> +
> +       safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
> +       if (!safesetid_policy_dir) {
> +               ret = PTR_ERR(safesetid_policy_dir);
> +               goto error;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> +               struct safesetid_file_entry *entry =
> +                       &safesetid_files[i];
> +               entry->dentry = securityfs_create_file(
> +                       entry->name, 0200, safesetid_policy_dir,
> +                       entry, &safesetid_file_fops);
> +               if (IS_ERR(entry->dentry)) {
> +                       ret = PTR_ERR(entry->dentry);
> +                       goto error;
> +               }
> +       }
> +
> +       return 0;
> +
> +error:
> +       safesetid_shutdown_securityfs();
> +       return ret;
> +}
> +fs_initcall(safesetid_init_securityfs);
> --
> 2.20.1.97.g81188d93c3-goog
>

But overall, it looks good to me. :)

-- 
Kees Cook
