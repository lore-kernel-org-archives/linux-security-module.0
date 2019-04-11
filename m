Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B5C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3322075B
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPEi1IQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDKUiM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:38:12 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41571 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDKUiL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 16:38:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id l22so2494161uao.8
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmRwmJEE/BAtGVgDlqmxD5v7O5rKqMeIRjbIageLLec=;
        b=CPEi1IQk3CO3ptnd4Qqr/RsoAVukVNT138UdW8jL23laYnK9Wnvnn4l8HQKNrbwyBH
         qF1z/dX76BhDW7+fGxBoyrtJQO+7JgsGG1TIq506uPJ9VkE45xdQODzfMOiyPK1VD3sg
         GHCdHRKWGW4z1lwyrLS7Zehl3dE9daXTzC2Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmRwmJEE/BAtGVgDlqmxD5v7O5rKqMeIRjbIageLLec=;
        b=R26o7U5QpOAtXLqtr2JkUwhJk2ryY3ytFxa41NB3/r7mYXBPfjPHW/ruzdh001E6zv
         g0rpMtivU14saJbMjPN0emsgQq4RJwz//3V1RRoZQjNN5Guo0wuDACfl8zUOizrDiLj8
         8jfK+BWMmFZVzRC7mnuINm6d/PWrOCwgHFvaT+0Hegol+BW3ofloxOE1YGkC1rkVNmZm
         5AY83GXAE21Kn3bjaoL6Ogf3rB2cAUH0tLP/PN7ABIyr6+nOAfQamDDdBeF0XHEyd7Sx
         Yn2w2Z2klSgdw9ObrBowbXUNJpe0OUQL435i5eZa0NKrQWjUrpghPhuCMvMJRlSZu/XA
         3soQ==
X-Gm-Message-State: APjAAAXwoZ7hlIACF6okoXs1P19dyuTgQ+Jfqan8NgUM3ZBhAEWJnA2Y
        uslC6mDrfgGALOpbzRzU/4ZUuoZjFMY=
X-Google-Smtp-Source: APXvYqxCitf8VayvOqWSVrGIaoaWPGFPRj8dFtBEkHdJW7Z4VfLWY0cl4dYbu6tiJjBzWCgKZ5Hcmg==
X-Received: by 2002:ab0:6514:: with SMTP id w20mr12926432uam.64.1555015090182;
        Thu, 11 Apr 2019 13:38:10 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id j71sm32970293vsd.0.2019.04.11.13.38.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:38:09 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id t78so4308819vsc.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:38:09 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr28391782vst.30.1555015088731;
 Thu, 11 Apr 2019 13:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190411201154.167617-1-mortonm@chromium.org>
In-Reply-To: <20190411201154.167617-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 13:37:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+B0RcNVJXOyn4FZ8NsGR-RgqDbnL+4Ws-8RBOtaAHg=w@mail.gmail.com>
Message-ID: <CAGXu5j+B0RcNVJXOyn4FZ8NsGR-RgqDbnL+4Ws-8RBOtaAHg=w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] LSM: SafeSetID: add read handler
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 11, 2019 at 1:12 PM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> For debugging a running system, it is very helpful to be able to see what
> policy the system is using. Add a read handler that can dump out a copy of
> the loaded policy.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes since the last patch set: Instead of doing refcounting, change
> policy_update_lock to a mutex and hold the mutex across the policy read.
>  security/safesetid/lsm.h        |  1 +
>  security/safesetid/securityfs.c | 35 +++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index 4a34f558d964..db6d16e6bbc3 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -41,6 +41,7 @@ struct setuid_rule {
>
>  struct setuid_ruleset {
>         DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
> +       char *policy_str;
>         struct rcu_head rcu;
>  };
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 250d59e046c1..997b403c6255 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -19,7 +19,7 @@
>
>  #include "lsm.h"
>
> -static DEFINE_SPINLOCK(policy_update_lock);
> +static DEFINE_MUTEX(policy_update_lock);
>
>  /*
>   * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> @@ -67,6 +67,7 @@ static void __release_ruleset(struct rcu_head *rcu)
>
>         hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
>                 kfree(rule);
> +       kfree(pol->policy_str);
>         kfree(pol);
>  }
>
> @@ -85,6 +86,7 @@ static ssize_t handle_policy_update(struct file *file,
>         pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
>         if (!pol)
>                 return -ENOMEM;
> +       pol->policy_str = NULL;
>         hash_init(pol->rules);
>
>         p = buf = memdup_user_nul(ubuf, len);
> @@ -92,6 +94,11 @@ static ssize_t handle_policy_update(struct file *file,
>                 err = PTR_ERR(buf);
>                 goto out_free_pol;
>         }
> +       pol->policy_str = kstrdup(buf, GFP_KERNEL);
> +       if (pol->policy_str == NULL) {
> +               err = -ENOMEM;
> +               goto out_free_buf;
> +       }
>
>         /* policy lines, including the last one, end with \n */
>         while (*p != '\0') {
> @@ -135,10 +142,10 @@ static ssize_t handle_policy_update(struct file *file,
>          * What we really want here is an xchg() wrapper for RCU, but since that
>          * doesn't currently exist, just use a spinlock for now.
>          */
> -       spin_lock(&policy_update_lock);
> +       mutex_lock(&policy_update_lock);
>         rcu_swap_protected(safesetid_setuid_rules, pol,
>                            lockdep_is_held(&policy_update_lock));
> -       spin_unlock(&policy_update_lock);
> +       mutex_unlock(&policy_update_lock);
>         err = len;
>
>  out_free_buf:
> @@ -162,7 +169,27 @@ static ssize_t safesetid_file_write(struct file *file,
>         return handle_policy_update(file, buf, len);
>  }
>
> +static ssize_t safesetid_file_read(struct file *file, char __user *buf,
> +                                  size_t len, loff_t *ppos)
> +{
> +       ssize_t res = 0;
> +       struct setuid_ruleset *pol;
> +       const char *kbuf;
> +
> +       mutex_lock(&policy_update_lock);
> +       pol = rcu_dereference_protected(safesetid_setuid_rules,
> +                                       lockdep_is_held(&policy_update_lock));
> +       if (pol) {
> +               kbuf = pol->policy_str;
> +               res = simple_read_from_buffer(buf, len, ppos,
> +                                             kbuf, strlen(kbuf));
> +       }
> +       mutex_unlock(&policy_update_lock);
> +       return res;
> +}
> +
>  static const struct file_operations safesetid_file_fops = {
> +       .read = safesetid_file_read,
>         .write = safesetid_file_write,
>  };
>
> @@ -181,7 +208,7 @@ static int __init safesetid_init_securityfs(void)
>                 goto error;
>         }
>
> -       policy_file = securityfs_create_file("whitelist_policy", 0200,
> +       policy_file = securityfs_create_file("whitelist_policy", 0600,
>                         policy_dir, NULL, &safesetid_file_fops);
>         if (IS_ERR(policy_file)) {
>                 ret = PTR_ERR(policy_file);
> --
> 2.21.0.392.gf8f6787159e-goog



-- 
Kees Cook
