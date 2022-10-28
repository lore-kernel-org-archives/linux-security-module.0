Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E1C38A02
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Oct 2022 10:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiJ1Kze (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiJ1KzP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 06:55:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDE558C1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:55:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l5so5752476oif.7
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OSgzvsxOKlDatU1RP0O72rPiUBVZ4dyhmJWhltX+mc=;
        b=N1Ih8at4pd4Kvbk1hvvQuAUOgmQrahWkYlxdNY5kKYkIgRj69oPNFDjtAxiI2rYfP5
         CwM+43DXqo39eiO0dDynG9VBW8o/S+ySVWH691Rn13/DR6Y7H2d4WRh8+miUASyTTWP0
         /JcnwG7wskcWRQooXqwds7OM/TD6Ia5vuOfrkJ93P/a7LWsutAhEvghn2KbbudlAc5dh
         qhdyemeQtCYXJmuLPaMGV95EpjZHfOWDrdYyFsbfPINOwh00u93u9nRI+RI6r/DLe7d9
         vkQC5sQsNx1zD2sDy4LxFuihBzfqBNp5FmQ5+onHI3vZphwDq4/Lod3GjbMGG3rVWam5
         B0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OSgzvsxOKlDatU1RP0O72rPiUBVZ4dyhmJWhltX+mc=;
        b=bF1SAkUz0oj5wKK16EATloHnoOtZsvcw3NZhg3r8WmNxq4ypYfg7rtdCvI+j8cGEq7
         j+q38bKHMsvAazfAcyzvMcFuzo4mrmAx9NRjBsi4Cv1Z0JFRSY7dM+jqBDn4h6zN9bKb
         bocOTpPmc17/+/IXtl+4T97UyDnkyasXf4yNRIAXolDI8s9Ta3qz2arlNzePg9ZaNl57
         uhCj46KAny6EWHrkvSbR9399zqf38R0+v9o5/w1rW0qV7+ZUsSqIcoiCx0V1ltiTasZq
         qgz8hZ/vXaDLYqfKvFIV7pKETzXiejJR5UmacK1ujhPZzaYpuGTWmuVwmTzJaofSMPYB
         yc7Q==
X-Gm-Message-State: ACrzQf3JFO9k9n5d0cviMZbmeeMv+3GPNOuyHP63YNpN1nOj7HtMAhQO
        /9E7famDbA4BRkrGCc4cxinVa+JWQwqrNcWuCDO9
X-Google-Smtp-Source: AMsMyM5zsg40nrD6OFXhWyLp7gcu6600+i+XuVTeDsiArmRmEq4Svl9NHt15pm/2/r7qCPCs6oMhYrscECtFEXrIq/M=
X-Received: by 2002:a05:6808:10d4:b0:359:c147:7afe with SMTP id
 s20-20020a05680810d400b00359c1477afemr4015109ois.172.1666954499323; Fri, 28
 Oct 2022 03:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221025133357.2404086-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221025133357.2404086-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 06:54:48 -0400
Message-ID: <CAHC9VhRL8YwHtY-CziZt+EtQ-9nm+BqayyeUKoM+QXM_69-Fjg@mail.gmail.com>
Subject: Re: [PATCH v2] security: commoncap: fix potential memleak on error
 path from vfs_getxattr_alloc
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, jmorris@namei.org, ebiederm@xmission.com,
        brauner@kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 9:34 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> In cap_inode_getsecurity(), we will use vfs_getxattr_alloc() to
> complete the memory allocation of tmpbuf, if we have completed
> the memory allocation of tmpbuf, but failed to call handler->get(...),
> there will be a memleak in below logic:
>
>   |-- ret = (int)vfs_getxattr_alloc(mnt_userns, ...)  <-- alloc for tmpbuf
>     |-- value = krealloc(*xattr_value, error + 1, flags)  <-- alloc memory
>     |-- error = handler->get(handler, ...)  <-- if error
>     |-- *xattr_value = value <-- xattr_value is &tmpbuf  <-- memory leak
>
> So we will try to free(tmpbuf) after vfs_getxattr_alloc() fails to fix it.
>
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2:
> - Update the Fixes tag, from 71bc356f93a1 to 8db6c34f1dbc. Thanks!
>  security/commoncap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Merged into lsm/stable-6.1 and plan on sending it up to Linus early
next week (network connectivity permitting).  Thanks!

-- 
paul-moore.com
