Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD2EC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281420578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+aZYuI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfEGPBf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:01:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34111 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEGPBf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:01:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id n76so4834483ywd.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bS2UKh+SXUmahmXwcl+QO/MfFkM0RjZdp9WETHIz9TE=;
        b=R+aZYuI2oZZDPT1vqKd+D69iDgvWDTfiZTS6IlkWPylDikVyhrFF6cneTE+LAEkorn
         /ykMrAC7iIZNqsobTeI0Ap4/04k8X8Om8X1mMfzXpVZwyoD8s+QEOyyNiYYanFBx6+MK
         WylcT+VrY5rFMlE57zb5Wuvpjtkv7i4I2VMzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS2UKh+SXUmahmXwcl+QO/MfFkM0RjZdp9WETHIz9TE=;
        b=I/gyWevkOljuhGRVDtMhigtX9frMx0iVFT3S9X63HrAcnWeZecqDk/lg7l+9Bh2ShH
         JLmzVsWaiw0gprsKZVPw1rZ4yKcBo74rcdLJb9E9zJEhhGEongZj7lsVDp3mdiGQSNRd
         vKNq70J5/9qXwNeYlg8py6bQVAbHPhxSc0C/aZwZ+HPgK2H4qkndnS8BKj9K8tiZBPzP
         fVngMMvr2vfFCgbIQj94pw9AD5WZwKCSuJFlL49eptA4PtEgB4fsVCVhqj8Am+HEEtT+
         UDEOfGlInU1Zga2Wv5V9m1XUjZkVFaWxm+IYtTAnPmIZT6g43RzsMYU38qPIeK+P+gxn
         xnQw==
X-Gm-Message-State: APjAAAWhHQcHutdWcs56W+BCgmfy6nSsRirrImQ3yy/sIVfywZJsg15N
        G+yKpxuOYjRNVunvJ+lVmzfmolEG1Yfzje45PEWU1A==
X-Google-Smtp-Source: APXvYqzbP31+zY5VkAleD0/QnhN5UbvxpGJzfx7RzmpfD3s8iOuY6JAT5FEr81LmCkJH/BUiIjF8x90PtbUHufK10so=
X-Received: by 2002:a5b:80f:: with SMTP id x15mr20980790ybp.140.1557241294287;
 Tue, 07 May 2019 08:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165534.210333-1-mortonm@chromium.org> <CAGXu5jKmS48n7gajMVeNBfRdhCNgr5VTHLP8n83ktTc+kaskSQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKmS48n7gajMVeNBfRdhCNgr5VTHLP8n83ktTc+kaskSQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:23 -0700
Message-ID: <CAJ-EccPNfnbn0=ukgy1K47Lz5v3Mss_mBTBSo6B86UXE5VfH=g@mail.gmail.com>
Subject: Re: [PATCH 03/10] LSM: SafeSetID: refactor policy hash table
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

On Wed, Apr 10, 2019 at 10:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:55 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > parent_kuid and child_kuid are kuids, there is no reason to make them
> > uint64_t. (And anyway, in the kernel, the normal name for that would be
> > u64, not uint64_t.)
> >
> > check_setuid_policy_hashtable_key() and
> > check_setuid_policy_hashtable_key_value() are basically the same thing,
> > merge them.
> >
> > Also fix the comment that claimed that (1<<8)==128.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  security/safesetid/lsm.c | 62 ++++++++++++----------------------------
> >  security/safesetid/lsm.h | 19 ++++++++++++
> >  2 files changed, 37 insertions(+), 44 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index 5310fcf3052a..15cd13b5a211 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -14,67 +14,40 @@
> >
> >  #define pr_fmt(fmt) "SafeSetID: " fmt
> >
> > -#include <linux/hashtable.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/module.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/security.h>
> > +#include "lsm.h"
> >
> >  /* Flag indicating whether initialization completed */
> >  int safesetid_initialized;
> >
> > -#define NUM_BITS 8 /* 128 buckets in hash table */
> > +#define NUM_BITS 8 /* 256 buckets in hash table */
> >
> >  static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
> >
> > -/*
> > - * Hash table entry to store safesetid policy signifying that 'parent' user
> > - * can setid to 'child' user.
> > - */
> > -struct entry {
> > -       struct hlist_node next;
> > -       struct hlist_node dlist; /* for deletion cleanup */
> > -       uint64_t parent_kuid;
> > -       uint64_t child_kuid;
> > -};
> > -
> >  static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
> >
> > -static bool check_setuid_policy_hashtable_key(kuid_t parent)
> > +static enum sid_policy_type setuid_policy_lookup(kuid_t src, kuid_t dst)
> >  {
> >         struct entry *entry;
> > +       enum sid_policy_type result = SIDPOL_DEFAULT;
> >
> >         rcu_read_lock();
> >         hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > -                                  entry, next, __kuid_val(parent)) {
> > -               if (entry->parent_kuid == __kuid_val(parent)) {
> > +                                  entry, next, __kuid_val(src)) {
> > +               if (!uid_eq(entry->src_uid, src))
> > +                       continue;
> > +               if (uid_eq(entry->dst_uid, dst)) {
> >                         rcu_read_unlock();
> > -                       return true;
> > +                       return SIDPOL_ALLOWED;
> >                 }
> > +               result = SIDPOL_CONSTRAINED;
> >         }
> >         rcu_read_unlock();
> > -
> > -       return false;
> > -}
> > -
> > -static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
> > -                                                   kuid_t child)
> > -{
> > -       struct entry *entry;
> > -
> > -       rcu_read_lock();
> > -       hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > -                                  entry, next, __kuid_val(parent)) {
> > -               if (entry->parent_kuid == __kuid_val(parent) &&
> > -                   entry->child_kuid == __kuid_val(child)) {
> > -                       rcu_read_unlock();
> > -                       return true;
> > -               }
> > -       }
> > -       rcu_read_unlock();
> > -
> > -       return false;
> > +       return result;
> >  }
> >
> >  static int safesetid_security_capable(const struct cred *cred,
> > @@ -83,7 +56,7 @@ static int safesetid_security_capable(const struct cred *cred,
> >                                       unsigned int opts)
> >  {
> >         if (cap == CAP_SETUID &&
> > -           check_setuid_policy_hashtable_key(cred->uid)) {
> > +           setuid_policy_lookup(cred->uid, INVALID_UID) != SIDPOL_DEFAULT) {
> >                 if (!(opts & CAP_OPT_INSETID)) {
> >                         /*
> >                          * Deny if we're not in a set*uid() syscall to avoid
> > @@ -116,7 +89,8 @@ static bool uid_permitted_for_cred(const struct cred *old, kuid_t new_uid)
> >          * Transitions to new UIDs require a check against the policy of the old
> >          * RUID.
> >          */
> > -       permitted = check_setuid_policy_hashtable_key_value(old->uid, new_uid);
> > +       permitted =
> > +           setuid_policy_lookup(old->uid, new_uid) != SIDPOL_CONSTRAINED;
> >         if (!permitted) {
> >                 pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
> >                         __kuid_val(old->uid), __kuid_val(old->euid),
> > @@ -136,7 +110,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
> >  {
> >
> >         /* Do nothing if there are no setuid restrictions for our old RUID. */
> > -       if (!check_setuid_policy_hashtable_key(old->uid))
> > +       if (setuid_policy_lookup(old->uid, INVALID_UID) == SIDPOL_DEFAULT)
> >                 return 0;
> >
> >         if (uid_permitted_for_cred(old, new->uid) &&
> > @@ -159,14 +133,14 @@ int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> >         struct entry *new;
> >
> >         /* Return if entry already exists */
> > -       if (check_setuid_policy_hashtable_key_value(parent, child))
> > +       if (setuid_policy_lookup(parent, child) == SIDPOL_ALLOWED)
> >                 return 0;
> >
> >         new = kzalloc(sizeof(struct entry), GFP_KERNEL);
> >         if (!new)
> >                 return -ENOMEM;
> > -       new->parent_kuid = __kuid_val(parent);
> > -       new->child_kuid = __kuid_val(child);
> > +       new->src_uid = parent;
> > +       new->dst_uid = child;
> >         spin_lock(&safesetid_whitelist_hashtable_spinlock);
> >         hash_add_rcu(safesetid_whitelist_hashtable,
> >                      &new->next,
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > index c1ea3c265fcf..6806f902794c 100644
> > --- a/security/safesetid/lsm.h
> > +++ b/security/safesetid/lsm.h
> > @@ -15,6 +15,8 @@
> >  #define _SAFESETID_H
> >
> >  #include <linux/types.h>
> > +#include <linux/uidgid.h>
> > +#include <linux/hashtable.h>
> >
> >  /* Flag indicating whether initialization completed */
> >  extern int safesetid_initialized;
> > @@ -25,6 +27,23 @@ enum safesetid_whitelist_file_write_type {
> >         SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
> >  };
> >
> > +enum sid_policy_type {
> > +       SIDPOL_DEFAULT, /* source ID is unaffected by policy */
> > +       SIDPOL_CONSTRAINED, /* source ID is affected by policy */
> > +       SIDPOL_ALLOWED /* target ID explicitly allowed */
> > +};
> > +
> > +/*
> > + * Hash table entry to store safesetid policy signifying that 'src_uid'
> > + * can setid to 'dst_uid'.
> > + */
> > +struct entry {
> > +       struct hlist_node next;
> > +       struct hlist_node dlist; /* for deletion cleanup */
> > +       kuid_t src_uid;
> > +       kuid_t dst_uid;
> > +};
> > +
> >  /* Add entry to safesetid whitelist to allow 'parent' to setid to 'child'. */
> >  int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
> >
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
