Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A744C433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Oct 2022 19:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJRTOM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJRTNy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Oct 2022 15:13:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39308F269
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 12:13:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-360871745b0so146880697b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcJ/xbErnhkU7YIuf1pvj6IUQICGZQUe0Qc8Pk2Fhp0=;
        b=BwoExkDi2Uvo8U6alOZcZr9ieHzV/EzPaiN6gXiVyArwWY8I9VnXUYBe78bdgAJbFl
         B835Av7yVCP3BvfPaU7kCKW9CUHIv8+YaoEVBXzYy8pJjX3iuTS6b55xQBk+480wWsl+
         yB3xS53AnQ3wlKvLPqnn80PQ6bJEAJa8FwsPw66lOU+TkY+OBbDDsmky8PTbKjPhLDKW
         Ic75X+WcinQ6iiXDkByuWr0XmXJfFjQV/o+ubxiTE7Dd6Aw7t5/IVOyelSs1n6FBzJ0z
         nF+rrqRueYOResBBJTGXpcKe1EoWtvFNz6fHrqvpsC2ncmghM9ZYl449UpwW/Pzafent
         dGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcJ/xbErnhkU7YIuf1pvj6IUQICGZQUe0Qc8Pk2Fhp0=;
        b=F+zVtcqt22HatLiJUM0HccQwBmfgUOpI0ofBQCJi5TwI6z9yA0uM/0fud3GO34qNj6
         +fTWjPs162WN9s3uka7CJkX6166aoXvA45bVQs/gj/rEAW3F6xy/vYqOqDcs9cwKLLKg
         oesHqrQ801qDk9qo9AoeFZecTxt0ttQMEZLtXxMbrG6U4BPmtL1TdhnxxvFXkc2gNA/h
         xeJDEPIZBliCz6118HJWFLMGpNiGsdwHv1NbzU91C49Zkyy1bLyeNHMz59YRSJ2dtKzl
         3hyBwQ6AvaaMnZhw9NG0WCOYs21u5v8pdvhJIPuTA7Oh+tvLTRl2EX6ZTURlrJJltQMx
         ZcTQ==
X-Gm-Message-State: ACrzQf1D3yxh8+JYkFElZMdU40psRSEzoAhRprCK6onQ3siq1zZqYo/p
        pgCz9JVWSxv0xPb+gtnDB0ZVwH8XfLMCEtHRPVOz
X-Google-Smtp-Source: AMsMyM6clLSDFpw2sKQW2zs3XR6UXYycad8dnQF0C8n7utjAvU8Qy9XuX/E70evPgpIM8gNBF6TcYIjQrCfanTScDH8=
X-Received: by 2002:a0d:e64f:0:b0:357:815d:614 with SMTP id
 p76-20020a0de64f000000b00357815d0614mr3816985ywe.276.1666120431588; Tue, 18
 Oct 2022 12:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221018182216.301684-1-gnoack3000@gmail.com> <20221018182216.301684-5-gnoack3000@gmail.com>
In-Reply-To: <20221018182216.301684-5-gnoack3000@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 15:13:40 -0400
Message-ID: <CAHC9VhTCb2UXq_fATM6rHjLL-o4Bib3JXUYL_wONthB8WTnG9g@mail.gmail.com>
Subject: Re: [PATCH v10 04/11] landlock: Support file truncation
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 18, 2022 at 2:22 PM G=C3=BCnther Noack <gnoack3000@gmail.com> w=
rote:
>
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
>
> This flag hooks into the path_truncate, file_truncate and
> file_alloc_security LSM hooks and covers file truncation using
> truncate(2), ftruncate(2), open(2) with O_TRUNC, as well as creat().
>
> This change also increments the Landlock ABI version, updates
> corresponding selftests, and updates code documentation to document
> the flag.
>
> In security/security.c, allocate security blobs at pointer-aligned
> offsets. This fixes the problem where one LSM's security blob can
> shift another LSM's security blob to an unaligned address. (Reported
> by Nathan Chancellor)
>
> The following operations are restricted:
>
> open(2): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
> implicitly truncated as part of the open() (e.g. using O_TRUNC).
>
> Notable special cases:
> * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
> * open() with O_TRUNC does *not* need the TRUNCATE right when it
>   creates a new file.
>
> truncate(2) (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
> right.
>
> ftruncate(2) (on a file): requires that the file had the TRUNCATE
> right when it was previously opened. File descriptors acquired by
> other means than open(2) (e.g. memfd_create(2)) continue to support
> truncation with ftruncate(2).
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h                |  21 +++-
>  security/landlock/fs.c                       | 104 ++++++++++++++++++-
>  security/landlock/fs.h                       |  24 +++++
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/setup.c                    |   1 +
>  security/landlock/syscalls.c                 |   2 +-
>  security/security.c                          |  11 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   7 +-
>  9 files changed, 153 insertions(+), 21 deletions(-)

Thanks for the LSM security blob allocator fixes G=C3=BCnther!

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
