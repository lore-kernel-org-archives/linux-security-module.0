Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A8C00145
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Dec 2022 21:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLLVch (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLVcg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Dec 2022 16:32:36 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E63899;
        Mon, 12 Dec 2022 13:32:34 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7ACFE1048; Mon, 12 Dec 2022 15:32:33 -0600 (CST)
Date:   Mon, 12 Dec 2022 15:32:33 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] LoadPin: Allow filesystem switch when not enforcing
Message-ID: <20221212213233.GB15511@mail.hallyn.com>
References: <20221209195520.never.357-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209195520.never.357-kees@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 09, 2022 at 11:57:41AM -0800, Kees Cook wrote:
> Hi,
> 
> Right now, LoadPin isn't much use on general purpose distros since modules
> tend to be loaded from multiple filesystems at boot (first initramfs,
> then real rootfs). Allow the potential mount pin to move when enforcement
> is not enabled.
> 
> -Kees

Reviewed-by: Serge Hallyn <serge@hallyn.com>

to the set, thanks.

> 
> Kees Cook (4):
>   LoadPin: Refactor read-only check into a helper
>   LoadPin: Refactor sysctl initialization
>   LoadPin: Move pin reporting cleanly out of locking
>   LoadPin: Allow filesystem switch when not enforcing
> 
>  security/loadpin/loadpin.c | 89 ++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
> 
> -- 
> 2.34.1
