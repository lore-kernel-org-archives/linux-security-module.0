Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC13ECD80BB
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Oct 2023 12:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJJMAL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJJMAE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A5113
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 04:59:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso930058966b.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696939193; x=1697543993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wLQsQuOsWejoU0OnrXi9mSD8MpURT7HqfTQjNz0yMO8=;
        b=frprtuXLSULbwGZLMrH92NuTOvW1SJRtIKKthHmBNWMtxPbX6XC4pfHIOllfwhEewv
         6X31752vTuXWZ32L5EMUdSY+PMTB93duQQ79I6NpTt60vXTppOzRRIXyb4LjJzV8kg/J
         XcjENQdmltGiJ5ZZd/ScsnvmFSNsFoeAW6Grw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939193; x=1697543993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLQsQuOsWejoU0OnrXi9mSD8MpURT7HqfTQjNz0yMO8=;
        b=hlU2NiymtgUBueD8p+lTIjdqHABFkGlE8OcGA61xtryloyVe6bqJTgHurTypnAguYM
         TTwf4rdVXJmsBPZK6uOal+ACNVw3wI7E7Ez6tIilYfYVpH5/Y3+K4vqBIB1VnGBJ/zj2
         4WsZNtj6mXjv31tpkfYh8lUfolgMqMXOPZz0z9Ot2oDTwWrOkRTpcFBTXTy8gbgs2R9+
         kxqqYcVqV+cGdcdT6NtEPdzhGoqqidI2pEUqoUBQFabktGihmw+qQu8H62pv7SjYTIPu
         9OKxB7tt3DvJMSbvGWF2gUEWFXZWZpMRLXxw7ftS4cLeCG421GbxpNdf/7LUDGrlYyMf
         WKlg==
X-Gm-Message-State: AOJu0YzBht406MrZVZr+y4DMs9r70i+MKOv+z0fDi+XbqPa+fv/11zu7
        lNHl1LeSDxpMD4sIB7sJZZ11eZ+umj0xSfREmXJfVQ==
X-Google-Smtp-Source: AGHT+IHuPQMXvx41pjFlEOEJcQh0r2acSYASqorJEhhRFR3294C8jolKTvIf3FuZCDAP872XQzr3xhS13RvSz1m8JyM=
X-Received: by 2002:a17:906:3050:b0:9a1:f10d:9746 with SMTP id
 d16-20020a170906305000b009a1f10d9746mr15703509ejd.20.1696939192671; Tue, 10
 Oct 2023 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
In-Reply-To: <20231009153712.1566422-4-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 13:59:41 +0200
Message-ID: <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 9 Oct 2023 at 17:37, Amir Goldstein <amir73il@gmail.com> wrote:

>  static inline void put_file_access(struct file *file)
> diff --git a/fs/open.c b/fs/open.c
> index fe63e236da22..02dc608d40d8 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -881,7 +881,7 @@ static inline int file_get_write_access(struct file *f)
>         if (unlikely(error))
>                 goto cleanup_inode;
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
> -               error = mnt_get_write_access(backing_file_real_path(f)->mnt);
> +               error = mnt_get_write_access(backing_file_user_path(f)->mnt);
>                 if (unlikely(error))
>                         goto cleanup_mnt;
>         }

Do we really need write access on the overlay mount?

If so, should the order of getting write access not be the other way
round (overlay first, backing second)?

Thanks,
Miklos
