Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F78C04A95
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiJYNpq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiJYNpq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 09:45:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A6183DB3
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 06:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDEA5B81D4C
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 13:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67939C433C1;
        Tue, 25 Oct 2022 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705542;
        bh=S7b8l0tO/WX4aJRDnq7j/BmRts7xtWVdTNO0cj1/nK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LH+wRHMN/j2Ud2/7+U0Zr1hkYfLCl9kclGL5Klt7yxynuUWLZMuJC8y+HV1tDhook
         tJYF3JdEhrynsZ4tS1aXSZukPOaVyWDC1gvE1fXH0QDuRvqcLRsEgL1DvPwCDudC80
         3S96zTQn363t/4h0tt5HsKIk3vFOOJOgn+KoeOPHmuI9k+93/KiCCUH2jRuqFQXUBz
         +r2yYeHiU0jdZmpDfNiITTuZdihHZi6TllDekiRxGwXibPhVLcw9qmdDJkAogUDAZ4
         xwgWU3i3YZf+z1jyRWHkC8YhrwXCFuhxA65TUsMui3NWOWgSEbGp023VsIYYCHIZ3V
         pKX8lW/8/TNPQ==
Date:   Tue, 25 Oct 2022 08:45:41 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, serge@hallyn.com,
        paul@paul-moore.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: commoncap: fix potential memleak on error path
 from vfs_getxattr_alloc
Message-ID: <Y1fohadXVWj3Q89E@do-x1extreme>
References: <20221025104544.2298829-1-cuigaosheng1@huawei.com>
 <20221025130459.kk42edsz56vsd3ur@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025130459.kk42edsz56vsd3ur@wittgenstein>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 03:04:59PM +0200, Christian Brauner wrote:
> On Tue, Oct 25, 2022 at 06:45:44PM +0800, Gaosheng Cui wrote:
> > In cap_inode_getsecurity(), we will use vfs_getxattr_alloc() to
> > complete the memory allocation of tmpbuf, if we have completed
> > the memory allocation of tmpbuf, but failed to call handler->get(...),
> > there will be a memleak in below logic:
> > 
> >   |-- ret = (int)vfs_getxattr_alloc(mnt_userns, ...)  <-- alloc for tmpbuf
> >     |-- value = krealloc(*xattr_value, error + 1, flags)  <-- alloc memory
> >     |-- error = handler->get(handler, ...)  <-- if error
> >     |-- *xattr_value = value <-- xattr_value is &tmpbuf  <-- memory leak
> > 
> > So we will try to free(tmpbuf) after vfs_getxattr_alloc() fails to fix it.
> 
> Hey Gaosheng,
> 
> > 
> > Fixes: 71bc356f93a1 ("commoncap: handle idmapped mounts")
> 
> The Fixes: tag is wrong afaict. The control flow isn't changed in any
> way by the referenced commit.
> 
> The logic changed the last time with
> 82e5d8cc768b ("security: commoncap: fix -Wstringop-overread warning")
> but even that commit wouldn't have introduced the bug. It would've been
> introduced by 8db6c34f1dbc ("Introduce v3 namespaced file
> capabilities"). So update the Fixes: tag with that reference, please.
> 
> Otherwise I think you in principle have a point. Not sure if we have any
> filesystem that in practice would fail after permission checks have
> already passed with the first call to ->get() but then fail with the
> correct size passed in the second ->get() invocation. Sounds super
> unlikely but not impossible.

Looks like several other callers have the same problem --
evm_is_immutable(), evm_xattr_change(), ima_eventevmsig_init(). And
ima_read_xattr() expects the caller to handle it which seems potentially
problematic, though currently only current caller does handle it
properly.

The documention comment for vfs_getxattr_alloc() needs a warning that
the caller needs to free memory even if an error is returned, because
that is very counterintuitive. It probably should have been named
vfs_getxattr_realloc() ...

Seth
