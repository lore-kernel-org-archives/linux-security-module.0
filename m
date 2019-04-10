Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB8C10F14
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47572083E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcDDkFX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDJR1J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:27:09 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39677 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfDJR1I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:27:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id s80so742329vke.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pswK9xWZ7M4M86wMMUsn8RkpDk7hoNOStG1GphqZQ9A=;
        b=CcDDkFX62gxdg3XKy7cNwDkxb6IB1qDgUjRv7NSZcPRdB7h07HjbOuHrOrn+xUDmlQ
         VxCrjW2pUbbzZCsdwM4wOZI4wyvPFzfYwz8TWkCRNhHLaV2KZvA9+J+SxTBaUlVY1DhN
         g/Of2wB5Oxdl3QWFArraSYvCeXIwCDxFy2GJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pswK9xWZ7M4M86wMMUsn8RkpDk7hoNOStG1GphqZQ9A=;
        b=L5Ikn1USMhw0y5myMjttUnToLf6g49CRW+9a4zk6Gy2pK0AB9cHRjOR+02LnXWwRpf
         4ziHmp1QPkw+5dylLAVB3m2AsbmpPP89ZK4LjK4kmQgy+f+qC+d5N1xfsZso+QwVrXZX
         jiNiU6r9JFNd6VhwsyS3aBr7nwPbu9cPkYQSg/iob7dcc1eZsSc7C57bB9W2FCdQNrn4
         PrPpzq77Sab4r32MIJzevblD5cMIgSYbBFPMlESmCa72JFc9XZEL3sVEomtk35NaHouG
         RWGhYVjbxe5EuID7vR0gBZOXA6/RHGTraOSTuWvgXKSQ1l59GsQO3Bx9f7V2XvdAZVPi
         DUtA==
X-Gm-Message-State: APjAAAWHqiy3T+Da96lvg7ucAqD7U3lSqBo0EEcpeguiqLmWAjIliXSe
        EPowp2HmxlLLbT5tOnw9RGOf70PgB5A=
X-Google-Smtp-Source: APXvYqx8ICoD5u0ubw2XE87hrwQQYgJG7OQxruaEt0XbvNRlMNDuP2kmlYrxHhpybs1d8Z6Rxn24vg==
X-Received: by 2002:ac5:c2cb:: with SMTP id i11mr24140390vkk.51.1554917226391;
        Wed, 10 Apr 2019 10:27:06 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id b81sm6743182vkf.47.2019.04.10.10.27.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:27:05 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id f22so1829335vso.7
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:27:05 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr25821900vsc.196.1554917225016;
 Wed, 10 Apr 2019 10:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165613.212056-1-mortonm@chromium.org>
In-Reply-To: <20190410165613.212056-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:26:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLUFURN7-bQqwdzFLXF5XH1qAS+rb1pCGFZqrqZqMP6AQ@mail.gmail.com>
Message-ID: <CAGXu5jLUFURN7-bQqwdzFLXF5XH1qAS+rb1pCGFZqrqZqMP6AQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] LSM: SafeSetID: add read handler
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
> For debugging a running system, it is very helpful to be able to see what
> policy the system is using. Add a read handler that can dump out a copy of
> the loaded policy.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
>  security/safesetid/lsm.h        |  3 +++
>  security/safesetid/securityfs.c | 38 +++++++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index 4a34f558d964..9380329fe30a 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -17,6 +17,7 @@
>  #include <linux/types.h>
>  #include <linux/uidgid.h>
>  #include <linux/hashtable.h>
> +#include <linux/refcount.h>
>
>  /* Flag indicating whether initialization completed */
>  extern int safesetid_initialized;
> @@ -41,7 +42,9 @@ struct setuid_rule {
>
>  struct setuid_ruleset {
>         DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
> +       char *policy_str;
>         struct rcu_head rcu;
> +       refcount_t refcount;
>  };

refcount seems like overkill? Why not just use the spinlock? Neither
read nor write are "fast path".

-Kees

>
>  enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 13fce4c10930..7a08fff2bc14 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -67,12 +67,14 @@ static void __release_ruleset(struct rcu_head *rcu)
>
>         hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
>                 kfree(rule);
> +       kfree(pol->policy_str);
>         kfree(pol);
>  }
>
>  static void release_ruleset(struct setuid_ruleset *pol)
>  {
> -       call_rcu(&pol->rcu, __release_ruleset);
> +       if (pol != NULL && refcount_dec_and_test(&pol->refcount))
> +               call_rcu(&pol->rcu, __release_ruleset);
>  }
>
>  static ssize_t handle_policy_update(struct file *file,
> @@ -85,6 +87,8 @@ static ssize_t handle_policy_update(struct file *file,
>         pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
>         if (!pol)
>                 return -ENOMEM;
> +       refcount_set(&pol->refcount, 1);
> +       pol->policy_str = NULL;
>         hash_init(pol->rules);
>
>         p = buf = memdup_user_nul(ubuf, len);
> @@ -92,6 +96,11 @@ static ssize_t handle_policy_update(struct file *file,
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
> @@ -162,7 +171,32 @@ static ssize_t safesetid_file_write(struct file *file,
>         return handle_policy_update(file, buf, len);
>  }
>
> +static ssize_t safesetid_file_read(struct file *file, char __user *buf,
> +                                  size_t len, loff_t *ppos)
> +{
> +       ssize_t res;
> +       struct setuid_ruleset *pol;
> +       const char *kbuf;
> +
> +       rcu_read_lock();
> +       pol = rcu_dereference(safesetid_setuid_rules);
> +       if (!pol) {
> +               rcu_read_unlock();
> +               return 0;
> +       }
> +       if (!refcount_inc_not_zero(&pol->refcount)) {
> +               rcu_read_unlock();
> +               return -EBUSY;
> +       }
> +       rcu_read_unlock();
> +       kbuf = pol->policy_str;
> +       res = simple_read_from_buffer(buf, len, ppos, kbuf, strlen(kbuf));
> +       release_ruleset(pol);
> +       return res;
> +}
> +
>  static const struct file_operations safesetid_file_fops = {
> +       .read = safesetid_file_read,
>         .write = safesetid_file_write,
>  };
>
> @@ -181,7 +215,7 @@ static int __init safesetid_init_securityfs(void)
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
>


-- 
Kees Cook
