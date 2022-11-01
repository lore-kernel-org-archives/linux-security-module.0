Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F6FA373D
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Nov 2022 04:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKAEa2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Nov 2022 00:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAEa1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Nov 2022 00:30:27 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FEC65AE
        for <linux-security-module@vger.kernel.org>; Mon, 31 Oct 2022 21:30:25 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9168B30F; Mon, 31 Oct 2022 23:30:23 -0500 (CDT)
Date:   Mon, 31 Oct 2022 23:30:23 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Andrew G. Morgan" <morgan@kernel.org>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, serge@hallyn.com,
        akpm@linux-foundation.org, ezk@cs.sunysb.edu,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] capabilities: fix undefined behavior in bit shift for
 CAP_TO_MASK
Message-ID: <20221101043023.GA7631@mail.hallyn.com>
References: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
 <CALQRfL4Ws255bv_ptCt1qS3cbxjwUsawxAuTyV1pnLwg+70_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQRfL4Ws255bv_ptCt1qS3cbxjwUsawxAuTyV1pnLwg+70_NQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 31, 2022 at 07:18:54AM -0700, Andrew G. Morgan wrote:
> Acked-by: Andrew G. Morgan <morgan@kernel.org>
> 
> 
> On Mon, Oct 31, 2022 at 4:25 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> >
> > Shifting signed 32-bit value by 31 bits is undefined, so changing
> > significant bit to unsigned. The UBSAN warning calltrace like below:
> >
> > UBSAN: shift-out-of-bounds in security/commoncap.c:1252:2
> > left shift of 1 by 31 places cannot be represented in type 'int'
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x7d/0xa5
> >  dump_stack+0x15/0x1b
> >  ubsan_epilogue+0xe/0x4e
> >  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
> >  cap_task_prctl+0x561/0x6f0
> >  security_task_prctl+0x5a/0xb0
> >  __x64_sys_prctl+0x61/0x8f0
> >  do_syscall_64+0x58/0x80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  </TASK>
> >
> > Fixes: e338d263a76a ("Add 64-bit capability support to the kernel")
> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Paul, do you mind including this in your lsm tree?

thanks,
-serge

> > ---
> >  include/uapi/linux/capability.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> > index 463d1ba2232a..3d61a0ae055d 100644
> > --- a/include/uapi/linux/capability.h
> > +++ b/include/uapi/linux/capability.h
> > @@ -426,7 +426,7 @@ struct vfs_ns_cap_data {
> >   */
> >
> >  #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
> > -#define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
> > +#define CAP_TO_MASK(x)      (1U << ((x) & 31)) /* mask for indexed __u32 */
> >
> >
> >  #endif /* _UAPI_LINUX_CAPABILITY_H */
> > --
> > 2.25.1
> >
