Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C207DFA3744
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Oct 2022 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJaOTM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiJaOTJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Oct 2022 10:19:09 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0042613
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 07:19:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id g7so19481581lfv.5
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 07:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YeQoshPqr+iAzkzAQwRvHC3XBU4pyfzaDjaROS/ac8=;
        b=XviBpLR+PuEIIXHs1gEP2bnWBw9kYSsMJ2+wYvnJJuUU0TrAEICrGgcHD4qE6am5cX
         E4818je+/V00rRHtidX+L1LWQZSf2NwqJogyrJY3maRHH8ceQF/H5kmTXRhLM5FJrQ2v
         JbP9gFyFHoZU4/fdWxK4BZjVTzAw51ITqoILOpXkLKfQzKK9w86AfRY849NO8twxKp/Z
         VdIAa4+pygWb0hSu4u1u+V9Dzd7gJ4o7FlpzSBSrttQnx/s+LqRAS7EnGXeRqAtUrY1U
         PjXjBKpHj5RU0fvlUfCr6Dopv7HlZ307K1OzYXZBA0Luyy9cNHAL47d13cGPcDeSv/SU
         CiPA==
X-Gm-Message-State: ACrzQf0reRNMZqDZ9hJJzxw3Lpg5u7HXUqnF4r4nC2+sruuI1fdufm/M
        vGVwjNUdrimQh7IEiXRXkAUnP++VB3NJQBR02fh5Fw==
X-Google-Smtp-Source: AMsMyM67+w/8Uf2xaS2XMui69+FV+Miob5BHPl1ezmYxMRfuK/GPj3BLPHH5MQo48XLqVkRquCXmYYfve7RQ42nPnZ8=
X-Received: by 2002:a05:6512:1599:b0:4a2:70a9:fe79 with SMTP id
 bp25-20020a056512159900b004a270a9fe79mr5578491lfb.298.1667225945785; Mon, 31
 Oct 2022 07:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Mon, 31 Oct 2022 07:18:54 -0700
Message-ID: <CALQRfL4Ws255bv_ptCt1qS3cbxjwUsawxAuTyV1pnLwg+70_NQ@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     serge@hallyn.com, akpm@linux-foundation.org, ezk@cs.sunysb.edu,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Acked-by: Andrew G. Morgan <morgan@kernel.org>


On Mon, Oct 31, 2022 at 4:25 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
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
>
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 463d1ba2232a..3d61a0ae055d 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -426,7 +426,7 @@ struct vfs_ns_cap_data {
>   */
>
>  #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
> -#define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
> +#define CAP_TO_MASK(x)      (1U << ((x) & 31)) /* mask for indexed __u32 */
>
>
>  #endif /* _UAPI_LINUX_CAPABILITY_H */
> --
> 2.25.1
>
