Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E7ECDFA1
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYNF4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiJYNFX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 09:05:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2BC21807
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 06:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E2D9B81A9C
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 13:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0589C433D6;
        Tue, 25 Oct 2022 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666703104;
        bh=N7uqJ+CGk49Z44tFva+K2sjK+Cgv5kaX4FPfGJVtftM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhW1nQ9tKDDwb+RTZhX0fmLczWHmhcXYb2vt7ArEsqKxkwW9EJCVC9Wd6NjQplPpp
         fKnMpLe/BNHWUbQtn31o4Oo+NkL3ZoGLRh6iAQR7ywhOdpkf7A51wIm5mgaDK0dJc6
         xUnderqYTZ8JWupPBQoQIppZkt7AYv5vOlXc0eAtRa577pteM3P6EIha+FhSXiJfgP
         LofR6CNHOGBe3jK0eqTaRwSMnJQm/1Z9VSGNo2lN3LLhPZjw7SeaqSW1egrmkZiLNO
         YJCo8yMjYO35NO+XjVHFAzaA7s8voCJjgaykAbb2XcRQcm5bmLX8YYByuKuWYQdeci
         fHTK4d93fKMpw==
Date:   Tue, 25 Oct 2022 15:04:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, paul@paul-moore.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: commoncap: fix potential memleak on error path
 from vfs_getxattr_alloc
Message-ID: <20221025130459.kk42edsz56vsd3ur@wittgenstein>
References: <20221025104544.2298829-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025104544.2298829-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 06:45:44PM +0800, Gaosheng Cui wrote:
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

Hey Gaosheng,

> 
> Fixes: 71bc356f93a1 ("commoncap: handle idmapped mounts")

The Fixes: tag is wrong afaict. The control flow isn't changed in any
way by the referenced commit.

The logic changed the last time with
82e5d8cc768b ("security: commoncap: fix -Wstringop-overread warning")
but even that commit wouldn't have introduced the bug. It would've been
introduced by 8db6c34f1dbc ("Introduce v3 namespaced file
capabilities"). So update the Fixes: tag with that reference, please.

Otherwise I think you in principle have a point. Not sure if we have any
filesystem that in practice would fail after permission checks have
already passed with the first call to ->get() but then fail with the
correct size passed in the second ->get() invocation. Sounds super
unlikely but not impossible.
