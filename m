Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA2C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9159C2075B
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO6LS6bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDKUin (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:38:43 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38172 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUim (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 16:38:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id t15so2498548uao.5
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADYKiAsYxo1C9rDt19cF7IlBOIA6nr/OY3Ao9Z3Rbsw=;
        b=TO6LS6bOzsELliDPYoiOz0EdQvGUpRJQCBItQKvcJs3EWw0IRXdt4Oy7qjReaimyU8
         d1eFTc+x7eUeEdPjtV0mBphxb46JAbVSYNetCzPyr1f9osHNoh1PMygGdn3iJKtpz+JB
         ewJGo/95MsqE+jCtlXkX6ETa8mecXiOtiq3Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADYKiAsYxo1C9rDt19cF7IlBOIA6nr/OY3Ao9Z3Rbsw=;
        b=EH4yh0IDFgF2m6Zt61UlT/bwE1sZrtMuNbneJ5nGbkXFohQqVADITtGbVTD8ljp96w
         rNscZ3WMx/R9MHeY/G0CeyHXHPYC5tsg4BQ9v6/Xxo1uizqWAtXthRu9oikVeUK+z6c4
         5VmLVRDb/khrYCKjZ0MoEZKL/gbmA5Amxq+cSmoYwDef21fLo/m4D3DuRL5LHZ9t3jUt
         lSbTEcfMbVORIB8Gbjg9kclxzlXe1noWDujK6XVUqWDM4uyq8pHeyhmQR8yp+fnvhFcI
         bDukyBN/3aa6eCToI8zDjoa9oxJ8amKyQFBLByGMjDM5vEpbWD19fcywrGNj0UxHW5ii
         xKtQ==
X-Gm-Message-State: APjAAAUQGKOelkkE4gmrE906XcAOYYcXmz3tr8YW5ZvHWG9o3vMEuyUU
        UadM7+qUO2HG2rImwyjtY8uRy8g0uVE=
X-Google-Smtp-Source: APXvYqyv0i+9fiNUz4McLwjCbj4KMKZPXmrHGmv6ISC5M0Vaj4j9iWHgeK8L5fCt6UkzklSz5f2KOA==
X-Received: by 2002:ab0:7298:: with SMTP id w24mr20329993uao.119.1555015120978;
        Thu, 11 Apr 2019 13:38:40 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id y1sm32881183uai.0.2019.04.11.13.38.39
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:38:40 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id f15so4284473vsk.9
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:38:39 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr30471724vsc.196.1555015119508;
 Thu, 11 Apr 2019 13:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190411201243.167800-1-mortonm@chromium.org>
In-Reply-To: <20190411201243.167800-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 13:38:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJgQME5-LRzFG1rxr5eb84-+o4HiTuPCf6PWRHWMPkagw@mail.gmail.com>
Message-ID: <CAGXu5jJgQME5-LRzFG1rxr5eb84-+o4HiTuPCf6PWRHWMPkagw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] LSM: SafeSetID: verify transitive constrainedness
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes since the last patch: Instead of failing open when userspace
> configures an unconstrained (and vulnerable) policy, fix up the policy
> to make sure it is safe by restricting the un-constrained UIDs. Return
> EINVAL from the policy write in the case that userspace writes an
> unconstrained policy. Also move hash_add() into a small helper function.
>  security/safesetid/securityfs.c               | 38 ++++++++++++++++++-
>  .../selftests/safesetid/safesetid-test.c      |  4 +-
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 997b403c6255..d568e17dd773 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -76,6 +76,37 @@ static void release_ruleset(struct setuid_ruleset *pol)
>         call_rcu(&pol->rcu, __release_ruleset);
>  }
>
> +static void insert_rule(struct setuid_ruleset *pol, struct setuid_rule *rule)
> +{
> +       hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> +}
> +
> +static int verify_ruleset(struct setuid_ruleset *pol)
> +{
> +       int bucket;
> +       struct setuid_rule *rule, *nrule;
> +       int res = 0;
> +
> +       hash_for_each(pol->rules, bucket, rule, next) {
> +               if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> +                   SIDPOL_DEFAULT) {
> +                       pr_warn("insecure policy detected: uid %d is constrained but transitively unconstrained through uid %d\n",
> +                               __kuid_val(rule->src_uid),
> +                               __kuid_val(rule->dst_uid));
> +                       res = -EINVAL;
> +
> +                       /* fix it up */
> +                       nrule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
> +                       if (!nrule)
> +                               return -ENOMEM;
> +                       nrule->src_uid = rule->dst_uid;
> +                       nrule->dst_uid = rule->dst_uid;
> +                       insert_rule(pol, nrule);
> +               }
> +       }
> +       return res;
> +}
> +
>  static ssize_t handle_policy_update(struct file *file,
>                                     const char __user *ubuf, size_t len)
>  {
> @@ -128,7 +159,7 @@ static ssize_t handle_policy_update(struct file *file,
>                         goto out_free_rule;
>                 }
>
> -               hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> +               insert_rule(pol, rule);
>                 p = end + 1;
>                 continue;
>
> @@ -137,6 +168,11 @@ static ssize_t handle_policy_update(struct file *file,
>                 goto out_free_buf;
>         }
>
> +       err = verify_ruleset(pol);
> +       /* bogus policy falls through after fixing it up */
> +       if (err && err != -EINVAL)
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



-- 
Kees Cook
