Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CBC282D7
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 00:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC0217FA
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 00:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcXGbVeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfBLA0T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:26:19 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45419 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfBLA0S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Feb 2019 19:26:18 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so190117vke.12
        for <linux-security-module@vger.kernel.org>; Mon, 11 Feb 2019 16:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlOmcajIsX/TyRVqHHcJ2IUxXPM+kmCdH3mAHl/Kkko=;
        b=EcXGbVeNKTOlIXwKyuvoJEAuGqe9r28DubSTCS+eblu1zA8W6bjlfgxtbGOghAo3UT
         vkgbCjimvjPoVuDV59cux5VLhz54bE/8DOd3S+JDBQ5DaSIQtsASEjHRvOsVmeNbNefX
         rTuBao5M+KmOrhw9HW7BwgHqZUpPOd7t0yjbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlOmcajIsX/TyRVqHHcJ2IUxXPM+kmCdH3mAHl/Kkko=;
        b=Fkwc7MQCX4IS55ydrAVkNk6PbgVN0HDSlCmpX3R9Fg7z84RoLV+M3ifwQOtGqOO1Ex
         YwbNAuiF7Dn0SZbvKM/oo7xgU56dmbV8c8Z+YIkCt2kxjgHIGImWtXlrcB5Ev+NQM80c
         2rpKaGZ1La5fBrcQJzKcMK8Eb6rmVaIdK3YCQGpAFG1Qr1WTAWFQMDxPcoQteXsuUuZk
         imRDq0jgycXOkt5A3Yq73LnMvav9kK35T8T+3Adp3AG0YQjmjrrq3yqN2bEjW6djkshW
         uSmDL9GxptRpk/LHE7zyRzbp4zNigElUu2Q4/DR2Asr/GIrfSgYWBzOVwJptdKbhDOo4
         D7kg==
X-Gm-Message-State: AHQUAuYppUJyfr25aMbsqtQ7epa8nFRZ3uZyZAuQ865jRyARF1gLyorY
        Jp6R7a03wXZPr/gSHpl2IpGDzQQhJvg=
X-Google-Smtp-Source: AHgI3Ib6UvKMc3I6epV+Bg4E19v7cRzHXP+ywTMTGV2gOkcuFNygW60e/+bv839vbMO//xmWmGDmCA==
X-Received: by 2002:a1f:c487:: with SMTP id u129mr417153vkf.22.1549931175640;
        Mon, 11 Feb 2019 16:26:15 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d66sm13105152vkh.9.2019.02.11.16.26.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 16:26:14 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id e10so547065vsp.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Feb 2019 16:26:14 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr447476vsc.48.1549931173601;
 Mon, 11 Feb 2019 16:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20190211225403.GA7769@beast> <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
In-Reply-To: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 16:26:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
Message-ID: <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 11, 2019 at 4:21 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Kees Cook wrote:
> > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > used on the command line, and report that it is happening.
>
> To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
> This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
> security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.

No, this completely disables the purpose of lsm=

I don't understand the use-case you're concerned about?

-Kees

>
> ---
>  security/Kconfig    | 37 +++++++++++++++++++++++++++++++++++++
>  security/security.c |  5 ++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 9555f49..6a40995 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -250,5 +250,42 @@ config LSM
>
>           If unsure, leave this as the default.
>
> +choice
> +       prompt "Default exclusive security module"
> +       default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> +       default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> +       default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> +       default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +       default DEFAULT_SECURITY_DAC
> +
> +       help
> +         The security module where only one of these modules should be enabled if
> +         neither the "security=" parameter nor the "lsm=" parameter is specified.
> +
> +       config DEFAULT_SECURITY_SELINUX
> +               bool "SELinux" if SECURITY_SELINUX=y
> +
> +       config DEFAULT_SECURITY_SMACK
> +               bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> +
> +       config DEFAULT_SECURITY_TOMOYO
> +               bool "TOMOYO" if SECURITY_TOMOYO=y
> +
> +       config DEFAULT_SECURITY_APPARMOR
> +               bool "AppArmor" if SECURITY_APPARMOR=y
> +
> +       config DEFAULT_SECURITY_DAC
> +               bool "Unix Discretionary Access Controls"
> +
> +endchoice
> +
> +config DEFAULT_SECURITY
> +       string
> +       default "selinux" if DEFAULT_SECURITY_SELINUX
> +       default "smack" if DEFAULT_SECURITY_SMACK
> +       default "tomoyo" if DEFAULT_SECURITY_TOMOYO
> +       default "apparmor" if DEFAULT_SECURITY_APPARMOR
> +       default "" if DEFAULT_SECURITY_DAC
> +
>  endmenu
>
> diff --git a/security/security.c b/security/security.c
> index e6153ed..c44e3cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -294,8 +294,11 @@ static void __init ordered_lsm_init(void)
>                         chosen_major_lsm = NULL;
>                 }
>                 ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -       } else
> +       } else {
> +               if (!chosen_major_lsm)
> +                       chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
>                 ordered_lsm_parse(builtin_lsm_order, "builtin");
> +       }
>
>         for (lsm = ordered_lsms; *lsm; lsm++)
>                 prepare_lsm(*lsm);
> --
> 1.8.3.1
>


-- 
Kees Cook
