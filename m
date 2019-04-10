Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F81C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3638320651
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMK05CJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfDJROC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:14:02 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41865 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfDJROC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:14:02 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so1808169vsc.8
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEHUY3tyffpA+xParE67XvQs2J0hXg/gut/zDF+LlNE=;
        b=lMK05CJ5EHiQj6FkTDweyWv+mju/lu4/WZ/LBupnkTiq2993LIvBS6BeE+2gm5922/
         +lUAfdo67ar9viR6KHdeGCsPvKR4Wtg9LDA9ergzQtllg+eYmsarMVnu6VZC355qsZCn
         vSSc5bECR0sZ1Xwn7OwKTUwjTV5Hn3y669lbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEHUY3tyffpA+xParE67XvQs2J0hXg/gut/zDF+LlNE=;
        b=q58h2ap8KLLHn3FBIb6D63zyol/gtHtGqM+zOeT4jmv3cvz0N4zhUcpUzp0WJSaHv+
         lgeOutkd1OdIKa0vUqFQQ63xcVVMyMRxNQl8FwQNizENMGC9945wu9OxydlRWB8owmLu
         f2ZgtKwFGmBOfh2svMJZKKsHpXL1ih3b2IOC+OTHmJwHD0v53o2KwZq2Xnh9ccfBd055
         BFZJrrNc3j2uXFoKrD2cMIoQ0lOophw/ldh1eOc/ApBu+AaCiT1zrdVlAIF48Rn5XU2i
         lQHSgQd0mwOfpRExYh6rHfdhdKz6gVeS3Icd46x8Fj2lh4i6wnLN7m2xNEJeb5WuljN/
         yDBw==
X-Gm-Message-State: APjAAAVL5xkurOd6pY1SYWMQTMDgr6kJ/beO4cxc3WxF/30/J2+g+rGz
        A9fmnuaJYAXuvRBJSXia70lqQxwz9hs=
X-Google-Smtp-Source: APXvYqzWrh2GYOoD6CGfTBd63g8GhEdWPWsOCNX5pUkYI36DJOhJ9gXXnlwdattPlD83NsjFvyippg==
X-Received: by 2002:a67:69d7:: with SMTP id e206mr23242826vsc.79.1554916440809;
        Wed, 10 Apr 2019 10:14:00 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id g19sm5114942vkf.33.2019.04.10.10.13.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:13:59 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id t15so1037480uao.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:13:59 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr22927681uam.85.1554916439192;
 Wed, 10 Apr 2019 10:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165541.210809-1-mortonm@chromium.org>
In-Reply-To: <20190410165541.210809-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:13:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+tssZ24eGXJ9cQ+EFyYCiAkS_i3+gk1O84OrJS=JXu3g@mail.gmail.com>
Message-ID: <CAGXu5j+tssZ24eGXJ9cQ+EFyYCiAkS_i3+gk1O84OrJS=JXu3g@mail.gmail.com>
Subject: Re: [PATCH 04/10] LSM: SafeSetID: refactor safesetid_security_capable()
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
> At the moment, safesetid_security_capable() has two nested conditional
> blocks, and one big comment for all the logic. Chop it up and reduce the
> amount of indentation.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/safesetid/lsm.c | 41 +++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 15cd13b5a211..ab429e1816c5 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -55,21 +55,32 @@ static int safesetid_security_capable(const struct cred *cred,
>                                       int cap,
>                                       unsigned int opts)
>  {
> -       if (cap == CAP_SETUID &&
> -           setuid_policy_lookup(cred->uid, INVALID_UID) != SIDPOL_DEFAULT) {
> -               if (!(opts & CAP_OPT_INSETID)) {
> -                       /*
> -                        * Deny if we're not in a set*uid() syscall to avoid
> -                        * giving powers gated by CAP_SETUID that are related
> -                        * to functionality other than calling set*uid() (e.g.
> -                        * allowing user to set up userns uid mappings).
> -                        */
> -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> -                               __kuid_val(cred->uid));
> -                       return -1;
> -               }
> -       }
> -       return 0;
> +       /* We're only interested in CAP_SETUID. */
> +       if (cap != CAP_SETUID)
> +               return 0;
> +
> +       /*
> +        * If CAP_SETUID is currently used for a set*uid() syscall, we want to
> +        * let it go through here; the real security check happens later, in the
> +        * task_fix_setuid hook.
> +        */
> +       if ((opts & CAP_OPT_INSETID) != 0)
> +               return 0;
> +
> +       /*
> +        * If no policy applies to this task, allow the use of CAP_SETUID for
> +        * other purposes.
> +        */
> +       if (setuid_policy_lookup(cred->uid, INVALID_UID) == SIDPOL_DEFAULT)
> +               return 0;
> +
> +       /*
> +        * Reject use of CAP_SETUID for functionality other than calling
> +        * set*uid() (e.g. setting up userns uid mappings).
> +        */
> +       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> +               __kuid_val(cred->uid));
> +       return -1;
>  }
>
>  /*
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
