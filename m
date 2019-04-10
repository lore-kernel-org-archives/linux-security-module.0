Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61098C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2757320674
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUW/uzr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfDJRPw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:15:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37247 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfDJRPw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:15:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so1830311vsc.4
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9uDLcydMwDsrTeLQHZUVKyB6URvKYUpQGO3nGwMUcc=;
        b=RUW/uzr/JKAFbdZDXUmqnkCOWFmqbpugF+RdqCYu8Mj3Odeo083GIv8vakvWQFn67j
         7fei0iGVl4R+xH1y2BO8sNB/v/JkOTVhgeKgo5mCs5S7/mOvR5NX8cfzaiTMFqrEWrs3
         X5MZzbtKZGQD3InKBIuJ0AuuNk1gASFdKr9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9uDLcydMwDsrTeLQHZUVKyB6URvKYUpQGO3nGwMUcc=;
        b=aH7beMQ1c2qZRd/tbLCD+IQL07LdM3CS4SLoY9eEX4c3xHUB5KosWHROZFpo2125FU
         N3n54G1+BhVRV8kgaZWFroEyWW89EUjU8aduX6jjYBDjsgGyvjU6YB+DtL3T8gkqYtk4
         NLCwVwEgZQCqs77rLSKfXEtLkeFOuBUiyM6aHrJ+rAtcd8keXOcS+oxIpYiz855n0NVo
         NsuUQaHU726CqARZerqxPskghL5TB3EX3jUjWfDHmhUDW4LLquz0RXOxF1wRuF8W000X
         4aHoDvciLyi5zz2W9xjRDruhjdC/PQgE0jf97xpIG8KvhpsxBnASldVotKQj0mPRCQOw
         2zJQ==
X-Gm-Message-State: APjAAAWUzEqN8LDH8AhOFaRHicGNqMnN8aiw6EMZ0vywYqK1t9dCVvqV
        Hv0mYpVJI+W0YQgd+vju3S234b5euGI=
X-Google-Smtp-Source: APXvYqydmDFo4OC/xWOGl79SiHBFfZyuS3eFr+72dVQF+4VwvW7MVuAUi4smb3CCDLghvrkg4t+21A==
X-Received: by 2002:a67:e256:: with SMTP id w22mr13355730vse.173.1554916550449;
        Wed, 10 Apr 2019 10:15:50 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id r3sm1341961vkr.18.2019.04.10.10.15.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:15:49 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id c6so1048260uan.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:15:49 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr23674854uah.123.1554916549015;
 Wed, 10 Apr 2019 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165548.211254-1-mortonm@chromium.org>
In-Reply-To: <20190410165548.211254-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:15:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK0GpT3MJfbNB=1bGGEGCah65v37_QXxOfhLOU0GM=Bwg@mail.gmail.com>
Message-ID: <CAGXu5jK0GpT3MJfbNB=1bGGEGCah65v37_QXxOfhLOU0GM=Bwg@mail.gmail.com>
Subject: Re: [PATCH 05/10] LSM: SafeSetID: refactor policy parsing
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 9:55 AM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> In preparation for changing the policy parsing logic, refactor the line
> parsing logic to be less verbose and move it into a separate function.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> I made a minor change to Jann's original patch to use u32 instead of
> s32 for the 'parsed_parent' and 'parsed_child' variables.
>
>  security/safesetid/securityfs.c | 84 +++++++++++++--------------------
>  1 file changed, 33 insertions(+), 51 deletions(-)
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 2c6c829be044..90784a8d950a 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -33,68 +33,50 @@ static struct safesetid_file_entry safesetid_files[] = {
>
>  /*
>   * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> - * variables pointed to by 'parent' and 'child' will get updated but this
> + * variables pointed to by @parent and @child will get updated but this
>   * function will return an error.
> + * Contents of @buf may be modified.
>   */
> -static int parse_safesetid_whitelist_policy(const char __user *buf,
> -                                           size_t len,
> -                                           kuid_t *parent,
> -                                           kuid_t *child)
> +static int parse_policy_line(
> +       struct file *file, char *buf, kuid_t *parent, kuid_t *child)
>  {
> -       char *kern_buf;
> -       char *parent_buf;
> -       char *child_buf;
> -       const char separator[] = ":";
> +       char *child_str;
>         int ret;
> -       size_t first_substring_length;
> -       long parsed_parent;
> -       long parsed_child;
> +       u32 parsed_parent, parsed_child;
>
> -       /* Duplicate string from user memory and NULL-terminate */
> -       kern_buf = memdup_user_nul(buf, len);
> -       if (IS_ERR(kern_buf))
> -               return PTR_ERR(kern_buf);
> -
> -       /*
> -        * Format of |buf| string should be <UID>:<UID>.
> -        * Find location of ":" in kern_buf (copied from |buf|).
> -        */
> -       first_substring_length = strcspn(kern_buf, separator);
> -       if (first_substring_length == 0 || first_substring_length == len) {
> -               ret = -EINVAL;
> -               goto free_kern;
> -       }
> -
> -       parent_buf = kmemdup_nul(kern_buf, first_substring_length, GFP_KERNEL);
> -       if (!parent_buf) {
> -               ret = -ENOMEM;
> -               goto free_kern;
> -       }
> +       /* Format of |buf| string should be <UID>:<UID>. */
> +       child_str = strchr(buf, ':');
> +       if (child_str == NULL)
> +               return -EINVAL;
> +       *child_str = '\0';
> +       child_str++;
>
> -       ret = kstrtol(parent_buf, 0, &parsed_parent);
> +       ret = kstrtou32(buf, 0, &parsed_parent);
>         if (ret)
> -               goto free_both;
> +               return ret;
>
> -       child_buf = kern_buf + first_substring_length + 1;
> -       ret = kstrtol(child_buf, 0, &parsed_child);
> +       ret = kstrtou32(child_str, 0, &parsed_child);
>         if (ret)
> -               goto free_both;
> +               return ret;
>
>         *parent = make_kuid(current_user_ns(), parsed_parent);
> -       if (!uid_valid(*parent)) {
> -               ret = -EINVAL;
> -               goto free_both;
> -       }
> -
>         *child = make_kuid(current_user_ns(), parsed_child);
> -       if (!uid_valid(*child)) {
> -               ret = -EINVAL;
> -               goto free_both;
> -       }
> +       if (!uid_valid(*parent) || !uid_valid(*child))
> +               return -EINVAL;
>
> -free_both:
> -       kfree(parent_buf);
> -free_kern:
> +       return 0;
> +}
> +
> +static int parse_safesetid_whitelist_policy(
> +       struct file *file, const char __user *buf, size_t len,
> +       kuid_t *parent, kuid_t *child)
> +{
> +       char *kern_buf = memdup_user_nul(buf, len);
> +       int ret;
> +
> +       if (IS_ERR(kern_buf))
> +               return PTR_ERR(kern_buf);
> +       ret = parse_policy_line(file, kern_buf, parent, child);
>         kfree(kern_buf);
>         return ret;
>  }
> @@ -121,8 +103,8 @@ static ssize_t safesetid_file_write(struct file *file,
>                 flush_safesetid_whitelist_entries();
>                 break;
>         case SAFESETID_WHITELIST_ADD:
> -               ret = parse_safesetid_whitelist_policy(buf, len, &parent,
> -                                                                &child);
> +               ret = parse_safesetid_whitelist_policy(file, buf, len,
> +                                                      &parent, &child);
>                 if (ret)
>                         return ret;
>
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
