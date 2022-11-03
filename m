Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8FC433FE
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 11:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKCL6B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKCL57 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 07:57:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC5120AB
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 04:57:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t62so1638832oib.12
        for <linux-security-module@vger.kernel.org>; Thu, 03 Nov 2022 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zU7xV7W3lDGvmt7dPVBsWa/kR5kJOrP60v2hWR4Xi8Q=;
        b=1xNHxLqu/czmwQlGjhWq6I2fNJ9ctA3DFOvFZXmrwwEt0ajBrfgZ26Sg/2omNp27Pn
         GvLlGMygkfAyTtju6gmtqfbaY/V/KGCOCmFd4IrGXnmOn0LjaImFZvaGMvPtYUdx+evC
         I/8YhzZTS4ldIuILQACxN/tXy4O2+tnz2S4MkiRYD2UloKLMG+h93Gih6m4+Dwny9UMx
         QvbXiCx0sAqoRtU5eownIf1+CCWngjpAtUihYwBMIfDsapAiOrpkwoEIXyQdU9/MS5ok
         hB0jkYCL/487vDSKzmAgxL/6hXf77+hZMzYb6AGOML9TvozqienVcIzbfziWhgvfhtKR
         SiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU7xV7W3lDGvmt7dPVBsWa/kR5kJOrP60v2hWR4Xi8Q=;
        b=UaDtmOUJOQ0Y8drD6MVKy9iohaH5MlvMzBXcvu/x5SJ3h3qnv6Tz186+Y89tyevOVh
         DBTabqDCpO8/hCiv2I21IM50zn9Nv9PnXqFOXl9UVIa+wRY1GQl62v6DH8EjJhLE+nJI
         JX31gJsi/0N4ryLafNT5r07EA4HV9+mMg6TkYa2Xe/yJDT39wWC4OL53uM7opjpk/abc
         2NRCv57Y/MwV9Kio0N5DKwBF7Fv7JW7QC3Y/3j0aev9n8sThCE+MijPidOG9Zieuxm5V
         fXdCCfWNdIW6fwfdzEEzJvbWTyiLH0jhHl5uDdw+BWcd9/6uTYPdxjc38TD0ux5snm5r
         VJfA==
X-Gm-Message-State: ACrzQf2MUeeEN/kTAd7XAvXArchprNndR0kIPobHD34pMy58d7rNIAf3
        oKducSrL4j1rx9gb4oy8k9MIp9R7KjYCEGydtDdi8TLDPDlo
X-Google-Smtp-Source: AMsMyM6S0ge9klYW1+rr06imvdvgCk9qcSGviBGmcXqYN/Mn+/N0/xAQwFD8+iMqikJMh1KtyxawkaUHJ3nXSXeAysE=
X-Received: by 2002:a05:6808:2017:b0:359:ea7a:5983 with SMTP id
 q23-20020a056808201700b00359ea7a5983mr15273139oiw.51.1667476677051; Thu, 03
 Nov 2022 04:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
 <CALQRfL4Ws255bv_ptCt1qS3cbxjwUsawxAuTyV1pnLwg+70_NQ@mail.gmail.com> <20221101043023.GA7631@mail.hallyn.com>
In-Reply-To: <20221101043023.GA7631@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Nov 2022 07:57:45 -0400
Message-ID: <CAHC9VhSMFgifrUdMvogne+DC+gx_B9dW5mGsNZ8vstHpUsupOQ@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Andrew G. Morgan" <morgan@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        akpm@linux-foundation.org, ezk@cs.sunysb.edu,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 1, 2022 at 12:30 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Mon, Oct 31, 2022 at 07:18:54AM -0700, Andrew G. Morgan wrote:
> > Acked-by: Andrew G. Morgan <morgan@kernel.org>
> >
> >
> > On Mon, Oct 31, 2022 at 4:25 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
> > >
> > > Shifting signed 32-bit value by 31 bits is undefined, so changing
> > > significant bit to unsigned. The UBSAN warning calltrace like below:
> > >
> > > UBSAN: shift-out-of-bounds in security/commoncap.c:1252:2
> > > left shift of 1 by 31 places cannot be represented in type 'int'
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x7d/0xa5
> > >  dump_stack+0x15/0x1b
> > >  ubsan_epilogue+0xe/0x4e
> > >  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
> > >  cap_task_prctl+0x561/0x6f0
> > >  security_task_prctl+0x5a/0xb0
> > >  __x64_sys_prctl+0x61/0x8f0
> > >  do_syscall_64+0x58/0x80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >  </TASK>
> > >
> > > Fixes: e338d263a76a ("Add 64-bit capability support to the kernel")
> > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> Paul, do you mind including this in your lsm tree?

Sure, although just a warning that it might not happen until next
week.  Maybe I'll get some time this weekend but I can't be certain.

> > > ---
> > >  include/uapi/linux/capability.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> > > index 463d1ba2232a..3d61a0ae055d 100644
> > > --- a/include/uapi/linux/capability.h
> > > +++ b/include/uapi/linux/capability.h
> > > @@ -426,7 +426,7 @@ struct vfs_ns_cap_data {
> > >   */
> > >
> > >  #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32 */
> > > -#define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32 */
> > > +#define CAP_TO_MASK(x)      (1U << ((x) & 31)) /* mask for indexed __u32 */
> > >
> > >
> > >  #endif /* _UAPI_LINUX_CAPABILITY_H */
> > > --
> > > 2.25.1

-- 
paul-moore.com
