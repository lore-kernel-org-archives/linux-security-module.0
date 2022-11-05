Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D2C4332F
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 05:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKEFaw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEFav (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 01:30:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547892528E
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 22:30:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n83so7203099oif.11
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0n6VWHessyNez9S2H30Uhwv/rtD1rXyD3rEi+AbFHx4=;
        b=LZHzpoe22Ms5tIUqZIQH96wZFoeDHF01qhZuhPVHXfV2nhOEAt7gjw0aKVR1HRks2d
         LCjheDmrWib7qW85tsA3dNszS+oJMamEOyy48TotAjbFp6BgTAiZVCQUE1ginWFk1diW
         W+pN4Nvaat5439tvGt7egZjeosZlx4QTsurZo7Kp2beoVkmAywlG0+AjSW34ZTLanwYq
         /a2HsArXiGoVZ8wBCK0zceDOgLxxmkbofl7Sml6YvIMYqqvA4+wGRraWiyH7f3BCZ+Lu
         n87unMfV6SV6PzSuw0j3oEfBHbs93GwXEnVxWc/Y7vziElRO1XeRkDe4/N77gAxUFrEb
         5mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n6VWHessyNez9S2H30Uhwv/rtD1rXyD3rEi+AbFHx4=;
        b=VUXCj4ga+Mm4n2d4VlTZEFGtbXmwi98jsp+UaXlF9+mz0QRZSLjeM08rYf9ktZfWlt
         foSXkd2tIBWFNdYfZoIslap0kiORCP7QWCrd/l+dM4GMkeMxilWC3ieInxiw5am2t1mn
         1PNIM2VKdWZG8dsb1MBFMh/YpInyuZ7ICryjF2+6mN4tauoT1phkFuF8dCEsJFSrc5gn
         xl2nPaXHXl6Kyaf78jL+pycdssXgyMLXfMdWHKXA/OST0vPsDSLro1c27HROyrnajfS8
         T7E6zUVxHeA1g1MDhFAa2pV7/SPEewZLW7RvK1iXq5wQsAYbXCR50ZBYfIVMG4PuNDzN
         pRtA==
X-Gm-Message-State: ACrzQf0eYCPxABVnDgge1OuS760Oy+D5CcBvpEx41LmRrKOuuL7fviyT
        kylbq9QNXf2AbqfXvQtWpM7Yqg8cQK9elLoaA1Dy
X-Google-Smtp-Source: AMsMyM4NAg/syXDr7MwY5mnwjCRTqScvoL8+5KzOgXIYGsVKeA2ZXX7US081nITxWvWjXjXlfFSlgyCu2KG2vTTohdw=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr7635305oiv.172.1667626249669; Fri, 04
 Nov 2022 22:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 01:30:38 -0400
Message-ID: <CAHC9VhQSP6vcGbeb77oSLdxFijW7AqMX51VPt-t7tPk4gcU7Tw@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, morgan@kernel.org, akpm@linux-foundation.org,
        ezk@cs.sunysb.edu, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 31, 2022 at 7:25 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Shifting signed 32-bit value by 31 bits is undefined, so changing
> significant bit to unsigned. The UBSAN warning calltrace like below:
>
> UBSAN: shift-out-of-bounds in security/commoncap.c:1252:2
> left shift of 1 by 31 places cannot be represented in type 'int'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7d/0xa5
>  dump_stack+0x15/0x1b
>  ubsan_epilogue+0xe/0x4e
>  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
>  cap_task_prctl+0x561/0x6f0
>  security_task_prctl+0x5a/0xb0
>  __x64_sys_prctl+0x61/0x8f0
>  do_syscall_64+0x58/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
>
> Fixes: e338d263a76a ("Add 64-bit capability support to the kernel")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  include/uapi/linux/capability.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/stable-6.1, and I'll plan to send this up to Linus
next week.  Thanks everyone!

-- 
paul-moore.com
