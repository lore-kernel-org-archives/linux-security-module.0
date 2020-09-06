Return-Path: <SRS0=OZUD=CP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9BC2D0A8
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Sep 2020 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD2F20782
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Sep 2020 02:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zYC43D3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIFC4A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Sep 2020 22:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgIFCz6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Sep 2020 22:55:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD732C061573
        for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2020 19:55:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so13458750ejb.4
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2020 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrzR+/JpzSYwrKw8f7HoYXOSurj0d42UoeyPovZLhO8=;
        b=zYC43D3BtPdQLnRCjnxRp1hX757mvabTDTjRo3bYiFlRs11tftTlYr5CsfALgpdZks
         TiACz+n8b2M+WGf3kYgjPpGmyfvnL80caU2SsdDafT6Kf+ItT958/180nr3BbExO/IBQ
         qZQ08L4xfQMLppIaiBW8NAyzr7KnxaRSOUHEYg3fBwgAYIbzanej+AsHGiy1C4lBjDFx
         jpC9Z4a/mNBjU47QCLI1iNQf4o0HazCyuqfFRei7Tl2Z7Zw4SFT+PByuqnO2KISyiK9f
         PduND22ms9vHOqvvvLG/0HjpNT4IdkG3u/7jFRopdPac7yUk8oKPe8Jz3Ldibruqptuw
         l6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrzR+/JpzSYwrKw8f7HoYXOSurj0d42UoeyPovZLhO8=;
        b=ll/2xmQCA2GGul3X7h9Y4a8gJyoEfI04NTUfTGquRmhNUtlmwCkslD0Gu8+8RFIwts
         IyydxZ/sastDkn14m2e41BTmvzim/t1bgY2LjZ08MPYXOepFUV03czx4wwYnlQ1VfkF2
         FVo2n3RA9mkDh/JalRNj0jBe1z3D4tx8eKM++B9xpZaT99mlR25gmxt3ModvPw2st1dj
         vnLP88WXaFAqVrbdHzjoimt5RDsmlPQuk2G9kdsgvOVLbHKYpjP5/r8aTDaDPz1sEH7N
         83nPovA1mbJKw0Mp3lHRlU2Dd6zr3PTYPLcsrTm8tL4vbx0b5NsbGQnAEZhsNnj82wXS
         Tyhg==
X-Gm-Message-State: AOAM5315317Bd0EekaE6vYeYnmnWEeRl5LJ0CjkGEGdP5HFo6+Op7nPr
        f9VP4iVRmCbzWN/ix3sFjsOURq0FDNOydNDxCW1L
X-Google-Smtp-Source: ABdhPJx0bbwxpEDgIIhOu/lGMFbl3Uwi1hzkVJXfvBMLz4eoFci2W4EPe6s5SiDNNFf68i9C+KtANwcP2Ndg6HpJu4Y=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr13943401ejz.431.1599360955372;
 Sat, 05 Sep 2020 19:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-17-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-17-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 22:55:44 -0400
Message-ID: <CAHC9VhScgUoV452BrbufH1xCdFS3hLmKSyFqQRxHBO6k8tk55Q@mail.gmail.com>
Subject: Re: [PATCH v20 16/23] LSM: Use lsmcontext in security_inode_getsecctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:19 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
>  include/linux/security.h |  5 +++--
>  security/security.c      | 13 +++++++++++--
>  3 files changed, 23 insertions(+), 18 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
