Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A586C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D0E64F34
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 16:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhCOQwS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhCOQwA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Mar 2021 12:52:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62331C06174A
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 09:52:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jt13so67484724ejb.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8iu/dqbYsD4ADivKqrcDBjj85ZMGjGEXS6zWb8QZHs=;
        b=IPAY9WNX0xwK/EME9g4zTZOMCYaMz/tr/A4yH2QPe7DeCK1UUDcpRX8pqjO1sAZ7gR
         tM+7kjXFJvAu0Xx+LjGdF6MNYNiC/zh7MR8SMAz3MEnNj5wuhlhy5OFqMY2WmY1J/5yv
         J/3vb9hKuDxnwRsoFg2/4aZfkzdzj6ehoviPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8iu/dqbYsD4ADivKqrcDBjj85ZMGjGEXS6zWb8QZHs=;
        b=LmN2YgHYgPTRSo1t3v5IcSPoQNilSXw+vcfFzGxFNdoBn/3PRUSREWGftWamKHRMyg
         nZeIpqOk38+xf4w7Z/3qrtJbsSh5CCPRoQKzmZo5/S5Pin/e0S4zDl6joyVcLUNbc8+O
         DoyCD8+vDsBtp0yKpkrYT4OmugoQY5QbO+p8Raz2F38msiUDQ5CUazftZgKxepkxISa4
         K4ARr4MILf6qAMxTyJ8uUhgZ352eQa8R0ermTyrIxbw8aG/IBxo6w4oJ2l3jD7Xv1VvO
         2TiVMcW5jDxYds8SS9lQm81VjPyg7Jqvzn11zCBThBZy+cwDsNGM52LiUONHbHE1vuq/
         PPHQ==
X-Gm-Message-State: AOAM532t9H7WgadWDtUwPqs0De+Q0mxDPJYLOBoEcoMg7AhA5YJe3Zdu
        9l0kZUeoFKH9DWQZKZ1A+Z84dNp2NYZdFH5c6xlcKw==
X-Google-Smtp-Source: ABdhPJxFKCPeETve0G+3AgVwEveqCzeTxc0cpKGGjMz7oN+Bao4Xov9zyl1BaPyS86QW7OVIGECEEesc3zsE+h03hBc=
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr24554120ejf.277.1615827119197;
 Mon, 15 Mar 2021 09:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210310065212.174567-1-gaoyanwei.tx@gmail.com>
In-Reply-To: <20210310065212.174567-1-gaoyanwei.tx@gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Mar 2021 06:51:49 -1000
Message-ID: <CAJ-EccMjieOc6w9J9wfGWtfJ10dPJngB276gNDz-i-yR7rgZhA@mail.gmail.com>
Subject: Re: [PATCH] LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl
To:     Yanwei Gao <gaoyanwei.tx@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 9, 2021 at 8:52 PM Yanwei Gao <gaoyanwei.tx@gmail.com> wrote:
>
> First, the code is found to be irregular through checkpatch.pl.
> Then I found break is really useless here.
>
> Signed-off-by: Yanwei Gao <gaoyanwei.tx@gmail.com>

Thanks for the patch.

I can send it through my tree once the v5.13 merge window opens up.

> ---
>  security/safesetid/lsm.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 8a176b6adbe5..1079c6d54784 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -125,7 +125,6 @@ static int safesetid_security_capable(const struct cred *cred,
>                 pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
>                         __kuid_val(cred->uid));
>                 return -EPERM;
> -               break;
>         case CAP_SETGID:
>                 /*
>                 * If no policy applies to this task, allow the use of CAP_SETGID for
> @@ -140,11 +139,9 @@ static int safesetid_security_capable(const struct cred *cred,
>                 pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
>                         __kuid_val(cred->uid));
>                 return -EPERM;
> -               break;
>         default:
>                 /* Error, the only capabilities were checking for is CAP_SETUID/GID */
>                 return 0;
> -               break;
>         }
>         return 0;
>  }
> --
> 2.27.0
>
