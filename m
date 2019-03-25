Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67FAC10F03
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969F120863
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 14:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EuUGZ/iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCYOIP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:08:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40367 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfCYOIO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 10:08:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so7964273ljq.7
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLlCCs0P0FKSIqhUMo6zNydQHHiiClp2yAxqD9+auHM=;
        b=EuUGZ/iwKOufgSpnrJceU2MrjE7lXWEhLaUlBXWeujXkMyDvgNq2L7cB5CF5RgOonO
         tbFn/XAM4kAls41AiItslw9IeohOjwTv0D4kz6CbdI64CbuW6p6ptWvX9+cTdoI15Stm
         cD6BtlVKNzaitn42vqgoyNUiGg0/LDEdlDAylOn2EHEiH091OOZEFLy0s5QqHfpPH88I
         YuY/Xh9SZAiYxnb0k+Hc+CtZt0OUskp06/qVooTRkO9kcvXdXIv3c9dGM4Vx/C0Lg2F5
         Yw01S+ANZSXTYAFUmflYqCKTx1O9yEaFRmW5IOJBJpG+jjht3QGK3hHTMMpJIlKGCTKs
         PwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLlCCs0P0FKSIqhUMo6zNydQHHiiClp2yAxqD9+auHM=;
        b=U0AbaV0UoQmky5HBMeR4vytgyazK542x+rZOhVx2e6CfbwGAHFHfqh051KNeIok7dy
         9uaOXGL1+h7OfzULQXbx6yjneGAX+XEzv7JgUesK2Uoj8tSvL1CPbIAVd6LrAmbmq4Ma
         K2ljDDHzto8cbzqqGN3pOkQrUrZ9w6iG6WBaSgERkRtv05CrLxmBN8PaWuElOcznYhD3
         ryzJeFkdHYIi364012rMTyDeYsSVwM49M7sqIEXWl8Cq39yk624USdgUSrHKvJSl+WBJ
         3kqB/TU9wZeg14UKpY83LFYsT9eldHibBCjJNiRVIPqOrApKqJ3Df+uZpCv9JYK2gUgw
         L/rA==
X-Gm-Message-State: APjAAAV+NnIX8304o1SWLLxeF0/svbQrXZn5B5H00c74CFitoQby/31N
        JdUazHry54wBv2EnyS3qr3QRQqKSNaqHD6eyJbH+
X-Google-Smtp-Source: APXvYqzl0+CZ3K0oe5NfRXMHIeW+sP/ORzT9caFtvFlbkjCB3/N7jCWFoW6Ui42pErw+6LHbWbIgIad+cMeX7wUp2aA=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr13395071ljb.169.1553522892292;
 Mon, 25 Mar 2019 07:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <201903211834.Qtb0LJ32%lkp@intel.com> <20190325080535.19475-1-omosnace@redhat.com>
In-Reply-To: <20190325080535.19475-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 10:08:01 -0400
Message-ID: <CAHC9VhR0bSK2GXZZ1jCw=zzjKhGgxtueHLc7aUbHq_+MWFevuQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: lsm_hooks.h - fix missing colon in docstring
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, kbuild-all@01.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 25, 2019 at 4:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Apparently without it it is incorrect syntax and causes a warning about
> undocumented struct field.
>
> Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hooks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If it makes you feel any better, I didn't realize the colon was that
important either.  Thanks for the fix, merged into selinux/next.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0dd5bda719e6..b987dc282d63 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -447,7 +447,7 @@
>   *
>   * Security hooks for kernfs node operations
>   *
> - * @kernfs_init_security
> + * @kernfs_init_security:
>   *     Initialize the security context of a newly created kernfs node based
>   *     on its own and its parent's attributes.
>   *
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
