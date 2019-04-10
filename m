Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2029C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE220830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmqiIsrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfDJR2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:28:55 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35236 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfDJR2y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:28:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id a46so1064396uae.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/mxPsW8jzYklJCVLh1m37teFkbHUKpVe+c8Ci49SVU=;
        b=MmqiIsrHdPaOMYqmujfDaQyLEnYtLgkLFwBvsZK3BahHtgACKfc04vJI395jIswSyk
         VgAKdb2vA79Naid3M1fyhjMB0C17xr6zAKVmoYkxJZiXqbZL+wlLDkN7LRPIej7hTQV8
         oVpUaRV9M19LkrOqnr8Q4JjlMNEQLkRF0g//M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/mxPsW8jzYklJCVLh1m37teFkbHUKpVe+c8Ci49SVU=;
        b=tNOjJYrIOYdeOVH5XvdtiJEU6C9krjNwCGjRKjSFEpBmamcV6Av4E3ODjpcRF4paY3
         Q77oJM+G/zHFTeBf57pnYdwhgFuUvh/t2gGafdqYwm/RfVvP6pvkDXfF7e8ZHgvhZHFt
         d3GE8H+GIJvP9NG0UhUr6XWnM4MOpZCEi17Ub0zTZHqY2k9TcSuzHkk7Ektd25wnILgE
         2ul5djlO0DLFyZa7SsSwGYcbKSmkTvVgxGNfgSpx/alZC+uJYTDHEQdpi2FN3A9Lxv/m
         4djpvIDuHlMkr2vB3awiq/DzorDzTwV/+aYaCE1Uf9LR0qesvV8ZqSUGyTDl4ojW8GDa
         YQzw==
X-Gm-Message-State: APjAAAXAfB8swD90mKrGnOABE1j+S/9RlA1Uerf68oZ2bco0asiRi7aT
        ZkTuaUF1OXb1L0RDmgbU5pAxe/LX5Og=
X-Google-Smtp-Source: APXvYqxgXssmRiZUMXdaHvNIj1pG/8ezHQBuliMOy0Jjhwopfdx+f5U6l3+CQ8x5UMesaWJJmXhU5Q==
X-Received: by 2002:ab0:714a:: with SMTP id k10mr3069213uao.82.1554917332893;
        Wed, 10 Apr 2019 10:28:52 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id o191sm10934653vko.4.2019.04.10.10.28.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:28:52 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id n16so1048728uae.10
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:28:52 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr23725267uah.123.1554917331390;
 Wed, 10 Apr 2019 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165619.212464-1-mortonm@chromium.org>
In-Reply-To: <20190410165619.212464-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:28:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+HTSPDR0Sp17=Jr3gRUSOX39dohy0bgxwyL+Wbh9swkQ@mail.gmail.com>
Message-ID: <CAGXu5j+HTSPDR0Sp17=Jr3gRUSOX39dohy0bgxwyL+Wbh9swkQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] LSM: SafeSetID: verify transitive constrainedness
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
> Someone might write a ruleset like the following, expecting that it
> securely constrains UID 1 to UIDs 1, 2 and 3:
>
>     1:2
>     1:3
>
> However, because no constraints are applied to UIDs 2 and 3, an attacker
> with UID 1 can simply first switch to UID 2, then switch to any UID from
> there. The secure way to write this ruleset would be:
>
>     1:2
>     1:3
>     2:2
>     3:3
>
> , which uses "transition to self" as a way to inhibit the default-allow
> policy without allowing anything specific.
>
> This is somewhat unintuitive. To make sure that policy authors don't
> accidentally write insecure policies because of this, let the kernel verify
> that a new ruleset does not contain any entries that are constrained, but
> transitively unconstrained.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>
> ---
>  security/safesetid/securityfs.c               | 21 +++++++++++++++++++
>  .../selftests/safesetid/safesetid-test.c      |  4 +++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 7a08fff2bc14..3ec64487f0e9 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -77,6 +77,23 @@ static void release_ruleset(struct setuid_ruleset *pol)
>                 call_rcu(&pol->rcu, __release_ruleset);
>  }
>
> +static int verify_ruleset(struct setuid_ruleset *pol)
> +{
> +       int bucket;
> +       struct setuid_rule *rule;
> +
> +       hash_for_each(pol->rules, bucket, rule, next) {
> +               if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> +                   SIDPOL_DEFAULT) {
> +                       pr_warn("insecure policy rejected: uid %d is constrained but transitively unconstrained through uid %d\n",
> +                               __kuid_val(rule->src_uid),
> +                               __kuid_val(rule->dst_uid));
> +                       return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}

Why fail open? How about having the policy automatically add the
constraints (since the entire policy is known at verification time)?

-Kees

> +
>  static ssize_t handle_policy_update(struct file *file,
>                                     const char __user *ubuf, size_t len)
>  {
> @@ -139,6 +156,10 @@ static ssize_t handle_policy_update(struct file *file,
>                 goto out_free_buf;
>         }
>
> +       err = verify_ruleset(pol);
> +       if (err)
> +               goto out_free_buf;
> +
>         /*
>          * Everything looks good, apply the policy and release the old one.
>          * What we really want here is an xchg() wrapper for RCU, but since that
> diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
> index 4f03813d1911..8f40c6ecdad1 100644
> --- a/tools/testing/selftests/safesetid/safesetid-test.c
> +++ b/tools/testing/selftests/safesetid/safesetid-test.c
> @@ -144,7 +144,9 @@ static void write_policies(void)
>  {
>         static char *policy_str =
>                 "1:2\n"
> -               "1:3\n";
> +               "1:3\n"
> +               "2:2\n"
> +               "3:3\n";
>         ssize_t written;
>         int fd;
>
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
