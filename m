Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C936C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210036109E
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhJLORu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbhJLORu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 10:17:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54DC06161C
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 07:15:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g10so292642edj.1
        for <linux-security-module@vger.kernel.org>; Tue, 12 Oct 2021 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoPtWn8baP6eRSr17d2f6zS5KeNXDmBfvhv/KvnkI98=;
        b=Q0GzZf8y3jQsalaCpkjO7Xc7tEeuj8YoaCdes5NuFUfZGzqwd61sYH2/NOkKwkD7q1
         WwK0oYsirPr1AmSrrRP6JbqEcT5PGqrznuXuc5/iQVnDFa0Lov/MyXavaY/WWsCIGqNg
         egtpFEbRfmlZKGX04zW70zw4q7QRz5iOQ1boWpvu+xOPrWOOuz8IzGo4norCr+j9lDe6
         JhVW4Vnr4R7GeV8dwaJouoKGuPjQGDc6x3vb9UhzageDyYX2rVei+75o+TBRrw3to7Xh
         XEDZorVzkxB2Ui/YtqiM4Bgtf+p7nk5DYd1pQbrV4AzkcM2NsoiqcLMeh2kh5F6HkxF1
         jzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoPtWn8baP6eRSr17d2f6zS5KeNXDmBfvhv/KvnkI98=;
        b=RgcYJGlauh5KLSPWbtZMe4A/TP9T4/8siNvnF62jpyfGxBy7Lvvji41DCGXq0ltwHT
         xwDY0vrug9xbgHMM72RCI5CDXBbxhkQVYUVJL/0helFel5VmD3w/DuYnG3/N9syfVjpu
         d6fq9exik+CuYKDfIUI4W7chsEIPN7L8SaHVBoInK8MwixxYX3yMO2s5uArwMK6/EUlf
         ziu8O++IMYIowg2R9eI1AKqV1r8nZLDaX6xFeN2j/s1P63TpZzbMXm3wqc9VDi7JA1Zn
         YxZYIbG6XJF0LoHAVyVu/LwP6ADOnZTniH3l044d2ZqUt2Xi3jYWGPitIUCYgendtS0n
         EsFQ==
X-Gm-Message-State: AOAM531xThRmj4L/BT4ZYaDYnGWn1ra9jlZ7CPt1yLvKmMV1OW0kBdj2
        A8u0yCWYP7UdGVutUBJZfNviOL0UnOC2/7kGIcUz
X-Google-Smtp-Source: ABdhPJzAhF3kFHRyB9RJcZzE5mPMvbI7D9RRlGMRlB0qZKuSNHL2WEUygRk4E8noeQ40AfRTVa2UlSHslAqAuo457lk=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr172650edb.370.1634048146288;
 Tue, 12 Oct 2021 07:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211009063053.187953-1-cuigaosheng1@huawei.com>
In-Reply-To: <20211009063053.187953-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 10:15:34 -0400
Message-ID: <CAHC9VhRopU95Vxroaa4JxWkt=gK7KgJjvK+t9kmkQZTor63p_g@mail.gmail.com>
Subject: Re: [PATCH -next] integrity: return early if audit_log_start return NULL
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Oct 9, 2021 at 2:28 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> audit_log_start() may return NULL in below cases:
>   - when audit is not initialized.
>   - when audit backlog limit exceeds.
>
> After the call to audit_log_start() is made and then possible NULL audit
> buffer argument is passed to audit_log_*() functions, audit_log_*()
> functions return immediately in case of a NULL audit buffer argument.
>
> It is not necessary for audit_log_*() functions to be called with
> NULL audit buffer argument, so return early when audit_log_start()
> returns NULL.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/integrity/integrity_audit.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 29220056207f..fbc032185d72 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>                 return;
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
> +       if (unlikely(!ab))
> +               return;
>         audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
>                          task_pid_nr(current),
>                          from_kuid(&init_user_ns, current_uid()),
> --
> 2.30.0

-- 
paul moore
www.paul-moore.com
