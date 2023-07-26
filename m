Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8575C001DC
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jul 2023 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGZVHl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGZVHl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jul 2023 17:07:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31619BF
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 14:07:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63d0bf91362so1857546d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690405659; x=1691010459;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipuyVvhtw8ld3ugqmOO37ZEEDxUTJvpDjiGGAQ5NnTI=;
        b=fN+ICpe51EY4nJozxnE94ROCZ7R/rHEwPE1gofb8QUaWjrqxxzvpEgVRJUJqhVx13d
         qTwBnB1QKuXcd0qa8rcbkn1D5VnnDs1TVxM5vvvdxyYKyT/vjpVald09UfUUDKLb0bPY
         x3CZ3GO76xUtoR7BWpTqZ/i/oHgg9GUGZmXCUNChkGLpHtjJ9zXVaBwdhdIHeQcFaLzh
         GxXDm1/LHOShS3Sfc99wqM6J8Wvpodn9LOaTYQlcJMKlPnzWA0p4KDv8RC8ZISuGb6t8
         v6sO7gQLEJWfeS1eY2QU5mb3rsMwLcRF8HGayRJg/6CosWHy8Wze84655DqiOQ2qmGRP
         C3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405659; x=1691010459;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipuyVvhtw8ld3ugqmOO37ZEEDxUTJvpDjiGGAQ5NnTI=;
        b=SdGQbi8BOCvXsmJKicTQkbiGljoMm8slKzcO7O3dXSsu92LQ+sWJvQqP8yX52H7sn8
         egC/yPjUJV5D09TtUVGPG1aOxSM9s9A3en8TZ+FUeQIqMwNutDd+dOrtDhvFIWdeNB/s
         AHK84QRrnmX8kjxccWXGYn+xHcTCx64/nI+jf/btRRsuwYPsceORdGnXcX/U5E5C5a5f
         CimhbwPhgA/rD7BMSNw4LCiWAy8EAZkZGWUbGmCKyQr1Q3O03nsCEySLOJywIvO4gO/M
         HxLrfZrqn1rLdAm454FWL0x+Jt7yXfTFKxYRav3FJDY8b8lohC2H3mIeNZRMQocpvxBr
         0vcg==
X-Gm-Message-State: ABy/qLasDqR+6KuGrNY15pPgTGo5Jb93Ko/jxzajNBPbIkDXsZieuRBY
        c/+EL1Uj51tDW3zKWjXD5OWQ
X-Google-Smtp-Source: APBJJlGzCogIFERRjIx+VpmC//4EhKcKHx8QpAXPFzwqgevqujREi5EgDa0YwOUI/YLUbkn0NOz/gg==
X-Received: by 2002:a0c:db05:0:b0:63d:a05:bd30 with SMTP id d5-20020a0cdb05000000b0063d0a05bd30mr2861267qvk.5.1690405658760;
        Wed, 26 Jul 2023 14:07:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q11-20020a0ce20b000000b0062ffbf23c22sm5388475qvl.131.2023.07.26.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:07:38 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:07:37 -0400
Message-ID: <b627b11964094e47a0285ef1c4b734bc.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] security: Fix ret values doc for  security_inode_init_security()
References: <20230726073905.1175826-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230726073905.1175826-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Jul 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for
> inode_init_security hook") unified the !initxattrs and initxattrs cases. By
> doing that, security_inode_init_security() cannot return -EOPNOTSUPP
> anymore, as it is always replaced with zero at the end of the function.
> 
> Also, mentioning -ENOMEM as the only possible error is not correct. For
> example, evm_inode_init_security() could return -ENOKEY.
> 
> Fix these issues in the documentation of security_inode_init_security().
> 
> Fixes: 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for inode_init_security hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
