Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C23C433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56FE61983
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhCVTEv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhCVTEY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 15:04:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F4C061762
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:04:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u5so23082930ejn.8
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Mzx7dABocbFixc4b986h6yG+hI02Gitp8VvueIfB4I=;
        b=XxDku5bGoGMWgU04zqmwIPgsp44/uwmSatZM1QpHroiJjlMehDBLzTZs0WRjFTYS6F
         S5doTrEFCd4RoMoxmKKbEBoS1udESoEzcIwrs5UfxSvf046sqxRoe9eIwqE4FLohBOGM
         oi2AEaADE35Fopq0G6hlONdlNhvXT9AupFGmsrZ+j6ysii91vVh3nFKlqETIpyCbgum2
         zMwxot4h2So4tEKd82boQ5+yqKYgK7banbBYU4uCLqb3IB00joIegdL490vU8NjZwelX
         BKS4ca2bV/0GcvR1C4jLAWH5IjL93I4TfA+zYs9g/RTvfqE7UZHTjhETiiv3p9urxS4g
         d/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Mzx7dABocbFixc4b986h6yG+hI02Gitp8VvueIfB4I=;
        b=asN1e9EKtTR90NETDjM4MqQupJHnGwGczePoHzUUE1qD2j0qC99M7Jn4IWzkRsDkyt
         pQ/FmgLI2QKgHpcOfngwjme9BO1TfVm1/Gian6IGHXfJ/ADHl0v8bL4MKgU/+lgGhawm
         y364pbsfEn9ckJw51TcYtSjmS17feaJ5VbevO8nJZ3MONNnKv2W1kz4oNyQMpzZ+fVPn
         E8WXxeWECF9fTsAIZW03PQQ4bcQmc8zJ8Fb1fKryzgF8c0Ev6Uh6lD7IMSCAk4ITouod
         sfQPvzL0KQnz/DVYjjOh6+AcqRri8rdqHoRnIaLr3OsVXXuJMWbNPUIeTwNEgRuhP1Tt
         MQ9A==
X-Gm-Message-State: AOAM533rBBbWkYCq1wEsJ3rM++ZBGkjXlT0JntBLqNiPAG/gHDBGAxPW
        gQl3nN1GQdvSk+BJhGBSYecG+qnO+YSCa8JR6Peg
X-Google-Smtp-Source: ABdhPJx9/sqHzy6WGenbl4ERiZZdnZwOTEEIMZyqgV13jNwmI0i8sPqrXoJvGE5un4Kz9bFCd1WGmLGZxEKsoN/SgYs=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr1209220ejf.431.1616439858067;
 Mon, 22 Mar 2021 12:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com> <20210219222233.20748-3-olga.kornievskaia@gmail.com>
In-Reply-To: <20210219222233.20748-3-olga.kornievskaia@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 15:04:07 -0400
Message-ID: <CAHC9VhT30AjmsqN1RwT+At18W3Svr952EFSWsZ53D=qtV=4Wvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] NFSv4 account for selinux security context when
 deciding to share superblock
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 5:25 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Keep track of whether or not there were LSM security context
> options passed during mount (ie creation of the superblock).
> Then, while deciding if the superblock can be shared for the new
> mount, check if the newly passed in LSM security context options
> are compatible with the existing superblock's ones by calling
> security_sb_mnt_opts_compat().
>
> Previously, with selinux enabled, NFS wasn't able to do the
> following 2mounts:
> mount -o vers=4.2,sec=sys,context=system_u:object_r:root_t:s0
> <serverip>:/ /mnt
> mount -o vers=4.2,sec=sys,context=system_u:object_r:swapfile_t:s0
> <serverip>:/scratch /scratch
>
> 2nd mount would fail with "mount.nfs: an incorrect mount option was
> specified" and var log messages would have:
> "SElinux: mount invalid. Same superblock, different security
> settings for.."
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/fs_context.c       | 3 +++
>  fs/nfs/internal.h         | 1 +
>  fs/nfs/super.c            | 4 ++++
>  include/linux/nfs_fs_sb.h | 1 +
>  4 files changed, 9 insertions(+)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
