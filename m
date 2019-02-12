Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D8C282C4
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C35F2082F
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TDzGY2k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfBLQzP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:55:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40959 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfBLQzP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Feb 2019 11:55:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id z18so1996931vso.7
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 08:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DopTO6mzPwF/K2S+N7jiLzOIrEgHvF56VbXSPYIRgaI=;
        b=TDzGY2k4J9XkJbqYpBBT1miwmNv/9U1Q9W3uQalQShLyHbjEDTPiAwWD+LvWyLWKz5
         PJoIHX6xKTRx/QcUxiN7hIXgKEneG1z3sFZL6/2l7ueW8dQV8uL5h+Bu5BW2UWAiZ/dd
         dt2S3LdEjVpNgAJUdd6ni9xk156Y7egsltWBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DopTO6mzPwF/K2S+N7jiLzOIrEgHvF56VbXSPYIRgaI=;
        b=ASTLnalWCKB9Ditw3LyHJ+SxvbBMfIVfOXyubxXNQUEsFc3SwNc6pgysQD/xXUL5pS
         QA7gsh4iZwFK0GLQOE/KJ7j/uDiZbvGMl+pme20DLmTU98TsfHwE1KiDHtKaED1ToO1T
         onvbuu3AdkNIMWVhdOWMfgE9qjFNGDp5Y/p+lZ5XjvXGsIS7LGCpxAhY8Xb47ryoYid0
         l6POgleewehcD7G24r2deRQfcDCr9AmX0jGaX1oWIv1GKXb4rWEqdfCzzRSo9UEyEt5y
         G65B5mmhE8qhamH2wh1ZbWzGdT/9i2Bu0F/LsoBfz4wjnr4kzYtmfc5I4X6aLziWGaw5
         jrkg==
X-Gm-Message-State: AHQUAubU1JiTEYEXSw/99Y+exS3l3g+CuO+SDVbjHvomBh3DXL64Jgkg
        0ev4k4SDHqDsQIA7eHK8ecDrPLfy6oY=
X-Google-Smtp-Source: AHgI3IZLW5CLIN3P/Bub7Mo9leoX83JFOqgqhC6mYnptr93L/GNgpsrcq1W9/rAZTfutwI5bBI0oFA==
X-Received: by 2002:a67:688b:: with SMTP id d133mr1941148vsc.126.1549990513524;
        Tue, 12 Feb 2019 08:55:13 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a68sm13692348vsd.24.2019.02.12.08.55.12
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:55:12 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id s16so2009258vsk.4
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 08:55:12 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr2008287vsi.66.1549990511747;
 Tue, 12 Feb 2019 08:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20190212075831.114668-1-weiyongjun1@huawei.com>
In-Reply-To: <20190212075831.114668-1-weiyongjun1@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 08:55:00 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLRD49pbatrLPPOtJnGGFT+uT8Uz3OzVo-E0MgZg-NgxA@mail.gmail.com>
Message-ID: <CAGXu5jLRD49pbatrLPPOtJnGGFT+uT8Uz3OzVo-E0MgZg-NgxA@mail.gmail.com>
Subject: Re: [PATCH -next] LSM: fix return value check in safesetid_init_securityfs()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 11, 2019 at 11:44 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function securityfs_create_dir() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Fixes: aeca4e2ca65c ("LSM: add SafeSetID module that gates setid calls")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Nice catch! Thanks,

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/safesetid/securityfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 61be4ee459cc..2c6c829be044 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -167,7 +167,7 @@ static int __init safesetid_init_securityfs(void)
>                 return 0;
>
>         safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
> -       if (!safesetid_policy_dir) {
> +       if (IS_ERR(safesetid_policy_dir)) {
>                 ret = PTR_ERR(safesetid_policy_dir);
>                 goto error;
>         }
>
>
>


-- 
Kees Cook
