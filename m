Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C3C433FE
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Oct 2022 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJFM63 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiJFM6L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 08:58:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91181027
        for <linux-security-module@vger.kernel.org>; Thu,  6 Oct 2022 05:58:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m3so2643227eda.12
        for <linux-security-module@vger.kernel.org>; Thu, 06 Oct 2022 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lWPeU58iRjRyoDqwaFtxQGqfl9KnL32cM4cRmo8vYs4=;
        b=T+zTF1Tl5sDJwMTkiMCxkdQT8khtIFd/7B7mhXM6ZtZiuT+zRWCODove36KmJtU9rC
         TKb+TmBDlSZDHn/48XLKotY0Sgq81mN3DIlZq/jxem97KPpW/0WJ/1bThUMpfN11CrL7
         Y8dIEUAeX8BPl4L+XiX+m2LXfzZBDInq7RPYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lWPeU58iRjRyoDqwaFtxQGqfl9KnL32cM4cRmo8vYs4=;
        b=HDt8S9eExN+duPbiBrkdxfSoUKHNhkzwVtK0Vul3uCKrlAToePDH4mWhK2Bm6riBJk
         wCoX4IscAkZCJpQ4TMDRTEM7E5B/XRt6zLDefiihVsRrXwQYwhvi7sigeoukC8m5pp/9
         KvjEudWV1LaY23pj9Uy32vl2NYVcauk5QH2jwueu961uhGczl9rF4cKwbHHChNat2b2c
         YlWPBhP+zYNO+o/ZwXHXPb1zJl640/KyFluoFTL+gsTm1cZFPe7wtaAT7OPmyn5vTwuu
         bJBxE3HKJoK7Ql7FJgVZwFCfPgqQ3DT6cg5Xg0WQUxWcFmZqf3djJKDIzRNKqLcV3VBR
         YPMw==
X-Gm-Message-State: ACrzQf1J2cjlbVqXiFhPLSjnkgaCO/GY5WXBFjLnLkAWsNUEoVxnpG6J
        gUzeh/QoR+w4XTScOTCgivK/kT4ltS7YeVuk+ajkDvVA0lYL1Q==
X-Google-Smtp-Source: AMsMyM6j4TxIuyGrnoFijdlbKg7HT/nBqquZCHrQTmJmn0BEpysVBCEKSx/VbZt8FZ/qviUZukTtcd+y8QcDHJIw674=
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id
 i17-20020a1709064fd100b00787434fd755mr3774303ejw.356.1665060616356; Thu, 06
 Oct 2022 05:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-24-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-24-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 14:50:05 +0200
Message-ID: <CAJfpegu3_pDK2HTrwJ=ehBkBXYdTjF_DFd=oVF9M-k887sKkrA@mail.gmail.com>
Subject: Re: [PATCH v4 23/30] ovl: use posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
>
> Now that posix acls have a proper api us it to copy them.
>
> All filesystems that can serve as lower or upper layers for overlayfs
> have gained support for the new posix acl api in previous patches.
> So switch all internal overlayfs codepaths for copying posix acls to the
> new posix acl api.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
