Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA7AC3F6B0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiHPWJI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbiHPWJA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 18:09:00 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81F2A406
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 15:08:53 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so13216698fac.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E/hBZXF6wYTu26pFY4qX7I0dsAzZyW0vnwBH1OJ0zAk=;
        b=L/vWJjLhYBobflofse2vNZj4dU/r0PqzGFPmUNt7zecAlGUxSeNDuSyfkZgzdjUn4D
         hfez87XLIrrZ349R8QNCXk8mBpfWnjtm27h8V1h9njXPJuNwzYUgx6gv+XeSDy1K6I/W
         +/8F1L5mIvbpWQWNLTi3oMDHagsJpXfYyeUO9U+Q5ttSNGE+6kExasteYJXa5/d4sM29
         +LZLji7S0pH5SUhiP9JYlfADgDRp8ZlGBwNXFQpiHHDKB9lkpLF03HF13/7fZnEy1zxU
         6hdEAnwBbUByZrnpLARuwoikfgmazyYAwYM3XjkhtL89oiaM1q9/7OwKZdI+jfxP5ZDc
         SK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E/hBZXF6wYTu26pFY4qX7I0dsAzZyW0vnwBH1OJ0zAk=;
        b=gj1Ayz8HZ4mw+lo0rrcqh5HVbDc1HBZaZdAQBcQsMJyKrX1ZcpgOuDm2dCbHRnvYde
         iDaHnaO7brHgxP0GNHuscx+6RVlbp3EkFqStIhlbtNmQmAWagXW7V4Y46tRP6+1vjN1k
         7BcAlERpdsoSKmoyRSuAyo4hqHz4PmeOEGvMo9wlu08GFwr/23e/VPgc2Co7NBouySYX
         EPg8ktZd1dbqvgycr72XMQmRpS8bdqWXaLcTP/kl6peke6g8sWg4pnNCb7CQinRAqmxA
         L+IHC5LWh1Ip73SBfVKu5Iy89EHIgNizmx58xEUqIQXKxAchs7Ldu57rkrNP4NkIGjhI
         kgVg==
X-Gm-Message-State: ACgBeo2kvl6TnDFi7O9Ygz45O4A92XzpHW0KOXV31gfC4C+8rPECOarI
        MlO+NQapjiMn4oCF0sppKrn2b5IuY8/II2QdTYIB
X-Google-Smtp-Source: AA6agR4yyMJcuxHtonk9hdgEbeHukpk7pcwFlSX0mmZTJRUOLasBZP8hA/8Y3sA/k5FXDsww+ToMULa3wkzmedquiBg=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr296807oao.41.1660687732693; Tue, 16 Aug
 2022 15:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220602072943.8095-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20220602072943.8095-1-ruc_gongyuanjun@163.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Aug 2022 18:08:42 -0400
Message-ID: <CAHC9VhSK8y1NmiFTw8QN8xFzyzSdkq0fzovHBRev=mdW3KZvEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: avoid a leak in securityfs_remove()
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 2, 2022 at 3:31 AM Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:
>
> Delete the dentry in securityfs_remove() to make sure the
> dentry is not used by another thread and live longer than
> the call of securityfs_remove().
>
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  security/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..606f390d21d2 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
>                         simple_rmdir(dir, dentry);
>                 else
>                         simple_unlink(dir, dentry);
> +               d_delete(dentry);
>                 dput(dentry);

Doesn't the dput() call take care of this?

Do you have a reproducer where you can show that we are leaking dentries?

>         }
>         inode_unlock(dir);
> --
> 2.17.1

-- 
paul-moore.com
