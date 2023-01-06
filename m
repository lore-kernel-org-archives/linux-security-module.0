Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB7C54EBD
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Jan 2023 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjAFVPA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAFVO7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Jan 2023 16:14:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D19681C28
        for <linux-security-module@vger.kernel.org>; Fri,  6 Jan 2023 13:14:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x26so1974291pfq.10
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jan 2023 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwOLnK2ifzFuyr165LNzqz5GnvMFyliD+SS3u04GcaQ=;
        b=fQ3uOApcxQR/IsZivYDkfhBOj3GhwFU3tAsLTFuEVAPRPR10Inv7wS4kVorYVsJLlG
         8n0xE/1sTmVOH0hu+adBfEjI8JaSxtmQsvOScWoHbuCb/zC7iXJRmVjUi/zMHRyp1Woj
         aIkxixCOv2op1sVjyL0pqY0STzhYHHIKifcn+SV2YQ7lkhVjAP0pQ0BDvW7rWSaf9BcM
         FbrWjT1sIdJKfH5SiffG/z0ZWEfSoZqDaCViQqjeNsv5lVZHXzUN/xFq4XiDMSOWk69M
         Dl+f8JPEzAA1dBCgkT8/ssw8M92FVA43pnEzRE7ZHzoxOquhEfiJ7M967D5W8gGtWKtV
         vDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwOLnK2ifzFuyr165LNzqz5GnvMFyliD+SS3u04GcaQ=;
        b=IcGSlNvVVfTs9k67ALnDye7UkduWUBXMKCRtK+3n5drGTxJmdywJrOqhmg0mJgGBl8
         AIjsP1XEU4ktwDYdlDRiJlIkkv8Cb37U6FAdK9jNsMZHZmL3JbEOGhRATswNM3TxVY/2
         DxmunKZ7RhDiPSjQF6TNOwMHnD3c4knjWPm2vvOuoCUcw+MLdyXQIFZ5009Vt1tqf/9c
         5y4H5mU9tTiaoLQkR5DINWmAXrRq6vzRP5haJviaoRT00tA8LFf8VAeXgJFL+kVIWhi2
         +yw7Zz+qd0WByYehEjxJcm88ooq0SG9rQRd5zjm/U3HEklRP75L3xIg0SO1247UMoHQ+
         0fdQ==
X-Gm-Message-State: AFqh2kotya129PSHso0v0C7is4/53J1ZOyKJY+w62o853qI2xGuv01Ow
        Sl/UXurVtmVDZMNdvi5qRHIFrI8Lf4olEbLKgB+S
X-Google-Smtp-Source: AMrXdXunbq8svWmpL5uzJpDIG9dH1bnChWXrVS5uoNEeJGgqDMuv7i47INaTjXl1feUFwaMf91aGmisI+GELaFzB0V8=
X-Received: by 2002:a05:6a00:1345:b0:582:5f1a:97c2 with SMTP id
 k5-20020a056a00134500b005825f1a97c2mr1477126pfu.3.1673039698452; Fri, 06 Jan
 2023 13:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 16:14:47 -0500
Message-ID: <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Commit 98de59bfe4b2f ("take calculation of final prot in
> security_mmap_file() into a helper") moved the code to update prot with the
> actual protection flags to be granted to the requestor by the kernel to a
> helper called mmap_prot(). However, the patch didn't update the argument
> passed to ima_file_mmap(), making it receive the requested prot instead of
> the final computed prot.
>
> A possible consequence is that files mmapped as executable might not be
> measured/appraised if PROT_EXEC is not requested but subsequently added in
> the final prot.
>
> Replace prot with mmap_prot(file, prot) as the second argument of
> ima_file_mmap() to restore the original behavior.
>
> Cc: stable@vger.kernel.org
> Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index d1571900a8c7..0d2359d588a1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
>                                         mmap_prot(file, prot), flags);
>         if (ret)
>                 return ret;
> -       return ima_file_mmap(file, prot);
> +       return ima_file_mmap(file, mmap_prot(file, prot));
>  }

This seems like a reasonable fix, although as the original commit is
~10 years old at this point I am a little concerned about the impact
this might have on IMA.  Mimi, what do you think?

Beyond that, my only other comment would be to only call mmap_prot()
once and cache the results in a local variable.  You could also fix up
some of the ugly indentation crimes in security_mmap_file() while you
are at it, e.g. something like this:

diff --git a/security/security.c b/security/security.c
index d1571900a8c7..2f9cad9ecac8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1662,11 +1662,12 @@ int security_mmap_file(struct file *file, unsigned long
prot,
                       unsigned long flags)
{
       int ret;
-       ret = call_int_hook(mmap_file, 0, file, prot,
-                                       mmap_prot(file, prot), flags);
+       unsigned long prot_adj = mmap_prot(file, prot);
+
+       ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
       if (ret)
               return ret;
-       return ima_file_mmap(file, prot);
+       return ima_file_mmap(file, prot_adj);
}

--
paul-moore.com
