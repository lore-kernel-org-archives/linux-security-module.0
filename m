Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BBC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7111320674
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8Rms7Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDJRQg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:16:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40990 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfDJRQf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:16:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so1813140vsc.8
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+26GghYbEjMmfuSEsYJKoCPqvaEHEUX+w+fP1jiXKKA=;
        b=H8Rms7LdMWpdJquhjWb1Agr6JBdZ1se26JVzuCimOvQ8xp9g/2VK5Sy7LsmdKn7Iwz
         OKpIlatrRtXzlssw76anX/yp2OweP6STR65Vcc7IwOhKSbVL2eRjyQOALRv4BW9A2Y8v
         sCsM4QzSwKxORLkxEXtkm3Ku2nsq5r+M/X3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+26GghYbEjMmfuSEsYJKoCPqvaEHEUX+w+fP1jiXKKA=;
        b=lg8QNtkXN767s+TV4duJrXDrvvyuLSLebD1zNmJ6FndJH5ivu/UqdOtpsPwBvapVls
         DirBJuasJC1+5zcpSSScENyAlksnZ67qfkHlo7yy5rT5qv1b/lMupuImxnNU/nF4RCIZ
         FUjXac87eFn1ThWIcc+5AcqCeegchBKN4O8JTJUd9UVvolShWmg7xY+WJlkQfKWRwnov
         8531m1BNc6UFMuciBhirsVdJge0Z1CbWsoKf0jcvKzIa79A4kYb75kWCZS84jhzo2CTB
         hBFtQswmIckRC4btD+30HP1j8bPSpZsEXgA2/yzHZa7MV2Y40jprjekKgqUDIVteh5WK
         L6Ow==
X-Gm-Message-State: APjAAAWQvgWk3iJjXWAzRFCZdd2g6l9dLGX5odd+K6GV/Tl+4X2HpGt/
        la97lfEsB11BeO+vdc5kVF+8SKZTnBA=
X-Google-Smtp-Source: APXvYqxovYlqX1IzzulrVPMDZFFqtPdzuncEKCuPmbBRKDsyTQ5JO7veZsEpd2v+XBkizjbVWoFVVQ==
X-Received: by 2002:a67:f30f:: with SMTP id p15mr24525319vsf.158.1554916593890;
        Wed, 10 Apr 2019 10:16:33 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id b197sm42948862vkd.9.2019.04.10.10.16.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:16:33 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a46so1050834uae.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:16:32 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr18371895uah.80.1554916592428;
 Wed, 10 Apr 2019 10:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165558.211483-1-mortonm@chromium.org>
In-Reply-To: <20190410165558.211483-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:16:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJJTRgahj_hhiqkeWxLETWD5+=0800E0WNatq+3MrdPag@mail.gmail.com>
Message-ID: <CAGXu5jJJTRgahj_hhiqkeWxLETWD5+=0800E0WNatq+3MrdPag@mail.gmail.com>
Subject: Re: [PATCH 06/10] LSM: SafeSetID: fix userns handling in securityfs
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
>
> From: Jann Horn <jannh@google.com>
>
> Looking at current_cred() in write handlers is bad form, stop doing that.
>
> Also, let's just require that the write is coming from the initial user
> namespace. Especially SAFESETID_WHITELIST_FLUSH requires privilege over all
> namespaces, and SAFESETID_WHITELIST_ADD should probably require it as well.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/safesetid/securityfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> index 87e42b7f3e33..76c1e8a6ab93 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -59,8 +59,8 @@ static int parse_policy_line(
>         if (ret)
>                 return ret;
>
> -       *parent = make_kuid(current_user_ns(), parsed_parent);
> -       *child = make_kuid(current_user_ns(), parsed_child);
> +       *parent = make_kuid(file->f_cred->user_ns, parsed_parent);
> +       *child = make_kuid(file->f_cred->user_ns, parsed_child);
>         if (!uid_valid(*parent) || !uid_valid(*child))
>                 return -EINVAL;
>
> @@ -92,7 +92,7 @@ static ssize_t safesetid_file_write(struct file *file,
>         kuid_t child;
>         int ret;
>
> -       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
> +       if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
>                 return -EPERM;
>
>         if (*ppos != 0)
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
