Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39AC43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D56208AE
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 20:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8WI43Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D56208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeJBDJD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:09:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42435 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBDJC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Oct 2018 23:09:02 -0400
Received: by mail-yb1-f194.google.com with SMTP id p74-v6so6188151ybc.9
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=khTebGVL9i62T+Xj8yjXJ0sI8LTNTIeX+GszD8f48Nk=;
        b=X8WI43Zraz3OLHepdEtcK4ArMQLLsKAMf+HrUAsW8NA3cCC6Poebvan28Uyc8wY9Ir
         jW3+STc6+BoHFTm4u/hEEhaTLIEq+/vxBUsFEoaRQPHbHp8/WAQKo4IC9kklghyuHdrT
         h5cUPZMvzvko1/h8XlVthyh3PU1+Z1LvPGeX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=khTebGVL9i62T+Xj8yjXJ0sI8LTNTIeX+GszD8f48Nk=;
        b=VjTEqZxr6HUfl8nbE1l4ru4C05zjsNpVAJo7tIdXpLCqIALkD7bjN0iMBE976S0Dhm
         28zVK6CN8Hjia8hxr3mFBn6QiIt2GN6p1Yf2lYL7fpgLz8+jIOmRt13MedN7MkCYdVtR
         ZiMv2rXNbUYgnc3cT5fpi3pQOrE59Ouo+gXzUpbGO1PzYVxz41q56jA0ZcBBSgUbtqeQ
         nxUNl85NO/H1ZYD4pYbe+8RH5BC4YkwPu/rXOLx3LDDAWb9SySocgXs+rGvAybUJKZcc
         OgAXKdSoh2bKRBmQioVcAptmRvQmUq4JMJcNHwyJwuhn0lPEqoib3qw9KPAHSOBUf5n1
         uB6Q==
X-Gm-Message-State: ABuFfog1kgs2FU0xTPU3EZ6VInLiWaaORXg0+NfymwaWpkEHrix0spo5
        m5xSvc7GVFBG1YCUS1g64MBDmAl+eVQ=
X-Google-Smtp-Source: ACcGV61Hu7gEYNZAAit5yoCrbelA/ZLjb4a69O9Bh3MPuUSqY6F5ZZbPqVzNNzAAhv4unLkqJEDeHQ==
X-Received: by 2002:a25:2044:: with SMTP id g65-v6mr6824029ybg.402.1538425769510;
        Mon, 01 Oct 2018 13:29:29 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id c142-v6sm11035228ywa.81.2018.10.01.13.29.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:29:27 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id m127-v6so2482622ywb.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 13:29:26 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr7000601ywr.168.1538425766274;
 Mon, 01 Oct 2018 13:29:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 13:29:25 -0700 (PDT)
In-Reply-To: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLrvuhGonjCxUxMXi+HeEb8yWina=31OCvEqOeBBu1pkw@mail.gmail.com>
Message-ID: <CAGXu5jLrvuhGonjCxUxMXi+HeEb8yWina=31OCvEqOeBBu1pkw@mail.gmail.com>
Subject: Re: [PATCH v4 20/19] LSM: Correct file blob free empty blob check
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Instead of checking if the kmem_cache for file blobs
> has been initialized check if the blob is NULL. This
> allows non-blob using modules to do other kinds of
> clean up in the security_file_free hooks.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

This looks like it should get folded into "LSM: Infrastructure
management of the file security".

-Kees


> ---
>  security/security.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index e7c8506041f1..76f7dc49b63c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
>  {
>         void *blob;
>
> -       if (!lsm_file_cache)
> -               return;
> -
>         call_void_hook(file_free_security, file);
>
>         blob = file->f_security;
> -       file->f_security = NULL;
> -       kmem_cache_free(lsm_file_cache, blob);
> +       if (blob) {
> +               file->f_security = NULL;
> +               kmem_cache_free(lsm_file_cache, blob);
> +       }
>  }
>
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security
