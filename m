Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C8E8FDBF
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Oct 2023 23:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbjJCXmJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjJCXmJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 19:42:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87919D9
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 16:42:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d865db5b4c7so1611642276.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696376525; x=1696981325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SjA75N+ejDLC45VlzVptLHxzNWXM0z0YjaVzLTZEJk=;
        b=cauXbrqDMYfBfIJdCkh//lgXTor8mD4MEg+eoTrnZG+HoNVuoSflTy46Zjd6p0zRb7
         cmQXkgJLQqV55dTMe3O66wgOqHtWHbRdo2ImyrT2gMxb7/tob+KHH7xoMvB/Jd1Jy65E
         Xi76UuJ0KvjM1ysIHgrA+F+bc3HbSg19CiB6xGbceG8eQegggEUTrM3oZSZ1nEgjaMuq
         8zwoLrnwTwXlL0GTgTxpJ/CjdEBaomlOQn8ZTrfpSpdDHGRlkUSSoc2Ofbv6bdM/T/iG
         jWFByrdJ+E1btZYv7b+0OedJAWnKdMrAx0+fv8P//ZFqS7ovjwdJfgknTyG58i1ZfZEQ
         1Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376525; x=1696981325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SjA75N+ejDLC45VlzVptLHxzNWXM0z0YjaVzLTZEJk=;
        b=JWMfhiU7N/2kxiIALuSy4jxuwnYKe7B5OIIS796KsMZ19bw31T3v00Frs1qYLjAwqR
         HoCMvZarGxLbklkt3EL7NZl6Dr8fznV9Mi5OiHPK9gsrY1wIQ7EQ3Uy+6LD26SXUcmx1
         GkBOheQEmyicUZxQDyKMueM+jEuEUTmCUOCxMjC+pBhqYRUc4Jlb7Fzv8eC7VSmo4xDI
         duZGEGM/vp7ok8z0mI7afwakZLmkTmVsiq3s3MqmdIoux0GzuOtQNsoyiBnK4/kVv4+p
         LTC88UnwEWTXsVV9TgfuivfsPYjQrZgh4AtfPYkjgSOIbeHmzU80CVPLI3C+PrEPGGF5
         bi2w==
X-Gm-Message-State: AOJu0Yw6z73d7ZSmPBnSLKmed+n0riOvNLchg+Yl7BxkjJxIYcqk0A5n
        aJmWiKxYGmbG6qOCndG0n6j6B4shuLblvA2j8wFW
X-Google-Smtp-Source: AGHT+IFn4aOITO9vhhWDdp9FdrjvDiH+io1tqL2nOtLDQ8d4YyHKQ8ObGVLtyHCRY1krbvWLxeBkhLZh3u09ydowjVY=
X-Received: by 2002:a25:ab0b:0:b0:d7a:ea5b:a45 with SMTP id
 u11-20020a25ab0b000000b00d7aea5b0a45mr667291ybi.57.1696376524736; Tue, 03 Oct
 2023 16:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110300.32891-1-jlayton@kernel.org> <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-83-jlayton@kernel.org>
In-Reply-To: <20230928110413.33032-83-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Oct 2023 19:41:54 -0400
Message-ID: <CAHC9VhTsk5GyetM3ekBDv1f-QQVqWWgZmMWqpg8hqdyCOySHEQ@mail.gmail.com>
Subject: Re: [PATCH 84/87] security: convert to new inode {a,m}time accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 7:22=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/inode.c b/security/inode.c
> index 3aa75fffa8c9..9e7cde913667 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const =
char *name, umode_t mode,
>
>         inode->i_ino =3D get_next_ino();
>         inode->i_mode =3D mode;
> -       inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(ino=
de);
> +       simple_inode_init_ts(inode);
>         inode->i_private =3D data;
>         if (S_ISDIR(mode)) {
>                 inode->i_op =3D &simple_dir_inode_operations;
> --
> 2.41.0

--=20
paul-moore.com
