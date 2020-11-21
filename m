Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F476C2D0E4
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 00:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E7E22470
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Nov 2020 00:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbxfmC8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKUAIy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUAIy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 19:08:54 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBBC061A04
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:08:53 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id e139so15904488lfd.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2020 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PONzCKvr+vwt6Flh5wCrTZaAerJA45zVvmdcMNuJ7vs=;
        b=bbxfmC8eTRqjVK5ZEjTEUJxgrpO0kFVf9/uaSgCzhVMht34nhcdL+ZW4ekpzcvrIMO
         9G9gVesVNgsLfz8U1zun2zlQ6o1rW+PWPK5QLzF3yfRYlcmgfUNtISGccc6TFlKxNAtJ
         ewPxxLZFrlhcvMfHsn86USwX6n9sMnGcjDpCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PONzCKvr+vwt6Flh5wCrTZaAerJA45zVvmdcMNuJ7vs=;
        b=jUVvNCZcGxz9SeB3p0BMjuebtlE0N5FGPIOEF2qqqo7S9OTRHSAy1vSloMwLBf1HsU
         gFcWpl41X0f3dUA9/FtcCIJwCgfcLtMdtpuQRf2e4N94AeYSMpGVzHy3LcD1JS00NYKU
         XdjLS/76LdtPWoOBdhyVy3tuR+OOwccRPO3C8wSjAvCXlargqW6H69UemQZhZY+b89ly
         IiViwBKXkkN+6M5FoTLYje5hJdox7Ek4Dd4GT0BeYEoJMQnuvHcxP4jkar5wWlEzlC0T
         bUZRObH4BkYe7uF2mv1wxn7rlP+3hOxLd2bvv0IzTsRcG2FRSTML+hX97RTYGK4A97WV
         nu5w==
X-Gm-Message-State: AOAM532HvIUyXxzLZe2EgHSr9MPWveg4xVYunbj6Ev7oGp4FDOQdrGrq
        RkGHrYcxWv4Q/wNdNwZwhKGKvyBbzigPOZVv1th/vg==
X-Google-Smtp-Source: ABdhPJz4f0EWNC9BPY5Uq5ljrszSEuayardlmsA6lhGiyhp+CrxylzMiqBzF8AiYbAUAJdiVhGw27qnABItZDvOG/lg=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr8636915lfg.562.1605917331662;
 Fri, 20 Nov 2020 16:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org> <deea0ee7-85f4-1f3a-9737-1dba98aa8278@fb.com>
In-Reply-To: <deea0ee7-85f4-1f3a-9737-1dba98aa8278@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:08:40 +0100
Message-ID: <CACYkzJ7Oi8wXf=9a-e=fFHJirRbD=u47z+3+M2cRTCy_1fwtgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] ima: Implement ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> >
> > diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> > index c5bc947a70ad..add7fcb32dcd 100755
> > --- a/scripts/bpf_helpers_doc.py
> > +++ b/scripts/bpf_helpers_doc.py
> > @@ -478,6 +478,7 @@ class PrinterHelpers(Printer):
> >               'struct tcp_request_sock',
> >               'struct udp6_sock',
> >               'struct task_struct',
> > +            'struct inode',
>
> This change (bpf_helpers_doc.py) belongs to patch #2.

Indeed, I missed it during a rebase. Thanks!


>
> >               'struct path',
> >               'struct btf_ptr',
> >       }
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2d1af8899cab..1dd2123b5b43 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -501,37 +501,17 @@ int ima_file_check(struct file *file, int mask)
> >   }
> >   EXPORT_SYMBOL_GPL(ima_file_check);
> >
> > -/**
> > - * ima_file_hash - return the stored measurement if a file has been hashed and
> > - * is in the iint cache.
> > - * @file: pointer to the file
> > - * @buf: buffer in which to store the hash
> > - * @buf_size: length of the buffer
> > - *
> > - * On success, return the hash algorithm (as defined in the enum hash_algo).
> > - * If buf is not NULL, this function also outputs the hash into buf.
> > - * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> > - * It generally just makes sense to pass a buffer capable of holding the largest
> > - * possible hash: IMA_MAX_DIGEST_SIZE.
> > - * The file hash returned is based on the entire file, including the appended
> > - * signature.
> > - *
> > - * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> > - * If the parameters are incorrect, return -EINVAL.
> > - */
> > -int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> >   {
> > -     struct inode *inode;
> >       struct integrity_iint_cache *iint;
> >       int hash_algo;
> >
> > -     if (!file)
> > +     if (!inode)
> >               return -EINVAL;
>
> Based on original code, for ima_file_hash(), inode cannot be NULL,
> so I prefer to remove this change here and add !inode test in
> ima_inode_hash.

Makes sense. Thanks!

>
>
> >

[...]


> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
> > +{
>
> Add
>         if (!inode)
>                 return -EINVAL;

Done.

>
>
> > +     return __ima_inode_hash(inode, buf, buf_size);
> > +}
> > +EXPORT_SYMBOL_GPL(ima_inode_hash);
> > +
> >   /**
> >    * ima_post_create_tmpfile - mark newly created tmpfile as new
> >    * @file : newly created tmpfile
> >
