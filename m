Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4648C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB86C611AD
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhJSSxd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:53:33 -0400
Received: from namei.org ([65.99.196.166]:52136 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbhJSSxd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Oct 2021 14:53:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id CB4549DD;
        Tue, 19 Oct 2021 18:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org CB4549DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1634668881; bh=s8oEnm2LDkhWTm6y8sz4iuGoFRVTD3eWbvtiFGSrcy8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KprYpU83RHNdwut0CewWIvdgiDj+Cvnwxn53S+VYtCSstzR/26yP0eUNdTf3wSbaJ
         EBIR4PsF9iUp0Yf6c4do2o/LRyKHdMCgbZcw79y+IE4OTtW0Ac51O4+ARp1JumFZbp
         gVXG2yxg9hmaSwZFvmhH8sym3gMIobxIglgn6z/Y=
Date:   Wed, 20 Oct 2021 05:41:21 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "T. Williams" <tdwilliamsiv@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixing returning a userspace address for return value
In-Reply-To: <CADN=F_=tijrY7Lwv2coPcXS04uzEQsUL70=v3wHceGe9p6W7pw@mail.gmail.com>
Message-ID: <7df6e94f-a4c7-d181-7f9a-165e95b493@namei.org>
References: <CADN=F_=tijrY7Lwv2coPcXS04uzEQsUL70=v3wHceGe9p6W7pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 19 Oct 2021, T. Williams wrote:

> Fixing user memory dereference bug.
> 
> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>

Casey, can you check the logic on this?

> ---
>  security/security.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 9ffa9e9c5c55..7c41b5d732ab 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1737,6 +1737,8 @@ int security_kernel_read_file(struct file *file, enum
> kernel_read_file_id id,
>         int ret;
> 
>         ret = call_int_hook(kernel_read_file, 0, file, id, contents);
> +       if (ret > 0)
> +               return -EINVAL;
>         if (ret)
>                 return ret;
>         return ima_read_file(file, id, contents);
> -- 
> 2.25.1
> 
> This commit is to fix a userspace address dereference found by
> syzkaller.
> The crash is triggered by passing a file descriptor to an incorrectly
> formed kernel module to finit_module.
> 
> Kernel/module.c:4175 : Within the finit_module, info.len is set to the
> return value from kernel_read_file_from_fd. This value is then
> dereferenced by memcmp within module_sig_check from inside load_module.
> The value is 0xb000000 so the kernel dereferences user memory and kernel
> panics.
> 
> To prevent this adding a check from within security_kernel_read_file to
> make sure call_int_hook doesn't return an address which in the syzkaller
> program is what causes the return value to be 0xb000000. Then the return
> value of security_kernel_read_file is returned to kernel_read_file(also
> in security/security.c) which returns the value to
> kernel_read_file_from_fd (fs/kernel_read_file.c) and this returns the
> value into err then being set to info.len causing the dereference when
> info is passed into load_module.
> 

-- 
James Morris
<jmorris@namei.org>

