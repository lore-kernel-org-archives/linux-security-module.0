Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A3C47094
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC7C613E7
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhFJQx4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:53:56 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:35827 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFJQx4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 12:53:56 -0400
Received: by mail-ed1-f50.google.com with SMTP id ba2so32099295edb.2
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp6LvbTQVyzjMEi6wu5Mnp8jX00/m6s57GNvET58FOo=;
        b=ZnadtM5epcBD+4Cp5Oz7XjM95Tc8RoqKEZiTjoS3+g/5zNMiTlJ9tnG4dnpp5ZypOi
         11CWXzvKZtG3yPeoXJ28Cgn5m6xRhPdzVqKyn/Ioedu6456TybmNOtgyKVyHH5sUuSZD
         Pc/X6VQitO34zJbnYbd8haf0Md4wgmUSBrXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp6LvbTQVyzjMEi6wu5Mnp8jX00/m6s57GNvET58FOo=;
        b=k2hrEVik8bF5asHbsapIyqA1L41hEs9wtxtM5yd6xJGmdB0fquBZN+48sCvAHwdZ2/
         czDK7CKavwzkOfBa18A5kp3Ddr3AQx+Zn+H7b3HtE+wtaQU4VHMyNAG/PnWuD2eI4xlM
         0PYRqwAIolYMd//Hr1W50WEQYpwUnnqQ6pYtCxvTWPVmOVoF8NABeKX1KeVZkFb8agdi
         MPmzN5w4qLDF/pMTbTjbtv2cX4aqLQjsitbm0LOq4MhNmARtI01GcjmSy8IoJN7yBBng
         kOQuAMHUbAUPvl+hA5Z9pRPcMZ1HDF7lhGGzG+EU3KIgVW93DO5WUB9oLOxxHvuUPlYM
         L/nw==
X-Gm-Message-State: AOAM533In4XfQfhFm3vBvGZ5iS9MVTHFTWyrhgO7RuuX/x/nDZRH+aQC
        pw807pu9XTAHmWd1uZoJOy6WvS2sarMhIfn35KxOyg==
X-Google-Smtp-Source: ABdhPJz+ZmiSGZrHNtkFBN4miDJMJymldyO+LnR6cbXH+76gEcwRIpP8yXh1meoLW8CFrdoyZFxFp3qkh09HONZa9qQ=
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr411825edu.328.1623343858979;
 Thu, 10 Jun 2021 09:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210608230929.GA1214@raspberrypi>
In-Reply-To: <20210608230929.GA1214@raspberrypi>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 10 Jun 2021 06:50:47 -1000
Message-ID: <CAJ-EccMvTNpnZXAF6n2x7oXu_hsSOnbJvvQA6NsK1VG26t5CeQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: SafeSetID: Mark safesetid_initialized as __initdata
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the patch. Looks right, since that variable is only used in
safesetid_security_init() and safesetid_init_securityfs(), which are
both marked __init. I can merge it to the safesetid-next branch today
and send the patch through my tree during the 5.14 merge window.

On Tue, Jun 8, 2021 at 1:09 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> Mark safesetid_initialized as __initdata since it is only used
> in initialization routine.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/safesetid/lsm.c | 2 +-
>  security/safesetid/lsm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 1079c6d54784..963f4ad9cb66 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -22,7 +22,7 @@
>  #include "lsm.h"
>
>  /* Flag indicating whether initialization completed */
> -int safesetid_initialized;
> +int safesetid_initialized __initdata;
>
>  struct setid_ruleset __rcu *safesetid_setuid_rules;
>  struct setid_ruleset __rcu *safesetid_setgid_rules;
> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> index bde8c43a3767..d346f4849cea 100644
> --- a/security/safesetid/lsm.h
> +++ b/security/safesetid/lsm.h
> @@ -19,7 +19,7 @@
>  #include <linux/hashtable.h>
>
>  /* Flag indicating whether initialization completed */
> -extern int safesetid_initialized;
> +extern int safesetid_initialized __initdata;
>
>  enum sid_policy_type {
>         SIDPOL_DEFAULT, /* source ID is unaffected by policy */
> --
> 2.20.1
>
