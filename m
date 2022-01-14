Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC37C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jan 2022 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiANWNR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiANWNP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jan 2022 17:13:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44245C061574
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jan 2022 14:13:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so39039812edv.3
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jan 2022 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akNBIPEkQByIFfu1P2peeZN+JzE2WGUVrx0nJKmv+Ig=;
        b=GSAsqvuvZ11joKI+dRdRJOuuVW/GJ5oZzAyrppAVppJB8/otiBguI1w2lk9hHNXqnI
         Ah2KYY6LjOawBgQgGE7+KdjMHlAl54JHjYq3LkyXXdtAFjOKz1mvf6BzmmkH3bJ3ITRx
         BoAPd/vlyz23S4tdpthx6JmSXvk85dXhFPneTR68UnNNct00yEIDFQ7BKo5JeCGAFsTf
         kSfwAWc+cdnWmPAUKROQqfPdMslbpdSaLjacJqBTP+eYHZGM1v0OM3x0Yxp48pMigh0+
         RFP+MRBcL7tHV7qoZI8yQcfPZtmOb4cFGQM7UPaDISXkdWalKSpU0eAVdplz/50FrSXS
         esDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akNBIPEkQByIFfu1P2peeZN+JzE2WGUVrx0nJKmv+Ig=;
        b=h447XV5YTycUMIhJoq+Ggjb5WyuQMk8XEZcgBb2gJ24KG1CsqhR6dOC9Scj4ggGP+M
         F3XYBcmGYE/1L0sU4fr3kOVJxuas1yKJuiIz82tp6QBKWAF/BcBrI4MLJy708LjMpdD/
         +pJibScAFK8/QqmQ2qlWb+ghqXyimsRq7GWXO7H4sfAuhW1+9/iKiP4LD9zWoKcw0wwH
         cxkUnHI8wjXgwF+CwjM5eHzSAKIRq5pJbIlExbAZbDKfiRtLvBIYRTQ+xw8a5wO6YcIW
         vdfDb1aBjOjaNMAch/DcNIPKylkZ/hlrIO20lCONYskm7p2ogqX8qwCB+/5PeaMKe3Pw
         kFPQ==
X-Gm-Message-State: AOAM531x9Jj6KVYFlNG///fmr8Kb24AAdzc35QCaDBgGtPwOX3ENt3IF
        IRDsY5kHUupRwR1CFFGBGd1ksXiPweHi0C3cRtdR
X-Google-Smtp-Source: ABdhPJycdiADIHXzwCC4XbXDGCbSn1ShsYMkBqzWdZbiKVObYX6mlneZ3AzzwH9MsKG0FKNcfDxCMHxteeDPm3BK6vw=
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr10816345edd.331.1642198393740;
 Fri, 14 Jan 2022 14:13:13 -0800 (PST)
MIME-Version: 1.0
References: <tencent_A49992D0BF00081EB37A6E21070E45563806@qq.com>
In-Reply-To: <tencent_A49992D0BF00081EB37A6E21070E45563806@qq.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Jan 2022 17:13:02 -0500
Message-ID: <CAHC9VhQDEG7hOwAzTCkaiO7r7sgaV2B08BVV6V3XMVLZztcS+g@mail.gmail.com>
Subject: Re: [PATCHv2] integrity: check the return value of audit_log_start()
To:     xkernel.wang@foxmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 13, 2022 at 11:24 PM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error, so it is better to check the return value of it.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Reviewed-by: Paul Moore <paul@paul-moore.com>

> ---
> Changelogs: simplify the patch.
> Note: Take the suggestion from Paul Moore.
>  security/integrity/integrity_audit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 2922005..0ec5e4c 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>                 return;
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
> +       if (!ab)
> +               return;
>         audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
>                          task_pid_nr(current),
>                          from_kuid(&init_user_ns, current_uid()),
> --

-- 
paul moore
www.paul-moore.com
