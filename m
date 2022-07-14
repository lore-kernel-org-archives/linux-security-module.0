Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CDCCA479
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 03:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiGNDA5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiGNDA4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jul 2022 23:00:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8921E05
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 20:00:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so782409wrx.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xwAXAvYI9FTbVDjyFeCH64OhB8MXdH0zkgpyggSvUk=;
        b=dMCsTIAFAcgVHxxSiOLpbduJW+c7ON7UybqBzef+4ZnZnGUYbSLHechQQdGPF7SLa7
         Xcl7s4pBFVoASRgo8sggxFSu0BuIzvYnjIauzoDCpmOkbiJ0k9J1yofYL6Jd4W4OpCIZ
         vZu+IImCn4t+odtM7993ooGtuwJET10zE1b7fZ+moMrtVjeylBBr/DN4V+ukrwSozaKX
         Mqln9AlXkZphrX0FvdbJulL0n7XymjCkeZFn/W0jQICg7syyUfDLs6lB6aymnFGRCaFw
         Emz39/ROBeBxLQ42xcazo+DFBJCTkt9AR+z/KHtFFfj9P2fu49qjTkTmUyCKmQd7LDPf
         1w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xwAXAvYI9FTbVDjyFeCH64OhB8MXdH0zkgpyggSvUk=;
        b=ollS8XdSSJQQvN8nmlom+MEMIp/OdD63Oqv2Nkt1ZjT2Mvt4GXTo8C8dYrmRGKB6mo
         EwJmiEDZmdw7AtcFLwduNw0P7GydLy02vTLS9le+3DBWGwyvXXgR2fELxE+fQ6mU4131
         PWmOGywwBlUMyrTiZgP2pS9Irqmiifue3osjOmLAi4ziT5gQiKli/krq2Q6rpZb6bd3s
         02b2TeZVegY5pfB2xQTj0oDrOwc5Wq2WMPB5VOPecfbF5XfpxBI0mbpyw+IIoDkWUhHb
         LD2lMx+bYf0Dp+5OfnBp8dT8o1QOrqQCwy/WI2SdXCF6hlJuU7Bjfl6ivBL/NJZ9zNvt
         erRQ==
X-Gm-Message-State: AJIora/Eeml28UVcXh7udt6ie9+0Z9bSNhYPd3ntB/2fFhbBdUd0Frpj
        /rtImoOErUQ2mOL1xfiUhgM27DyH+elRqBeSRMGF
X-Google-Smtp-Source: AGRyM1vvo+tthDYWScteO4hpZvrGvs19yHNivGyWRsakaG8eMJ8KqyISvXRV6JQGpJ44lzvE5fOckdhkSSV/DO8/okM=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr6001437wrp.161.1657767653490; Wed, 13
 Jul 2022 20:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220714000536.2250531-1-mcgrof@kernel.org>
In-Reply-To: <20220714000536.2250531-1-mcgrof@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jul 2022 23:00:42 -0400
Message-ID: <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file op
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, casey@schaufler-ca.com, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 13, 2022 at 8:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> add infrastructure for uring-cmd"), this extended the struct
> file_operations to allow a new command which each subsystem can use
> to enable command passthrough. Add an LSM specific for the command
> passthrough which enables LSMs to inspect the command details.
>
> This was discussed long ago without no clear pointer for something
> conclusive, so this enables LSMs to at least reject this new file
> operation.
>
> [0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com

[NOTE: I now see that the IORING_OP_URING_CMD has made it into the
v5.19-rcX releases, I'm going to be honest and say that I'm
disappointed you didn't post the related LSM additions until
v5.19-rc6, especially given our earlier discussions.]

While the earlier discussion may not have offered a detailed approach
on how to solve this, I think it was rather conclusive in that the
approach used then (and reproduced here) did not provide enough
context to the LSMs to be able to make a decision.  There were similar
concerns when it came to auditing the command passthrough.  It appears
that most of my concerns in the original thread still apply to this
patch.

Given the LSM hook in this patch, it is very difficult (impossible?)
to determine the requested operation as these command opcodes are
device/subsystem specific.  The unfortunate result is that the LSMs
are likely going to either allow all, or none, of the commands for a
given device/subsystem, and I think we can all agree that is not a
good idea.

That is the critical bit of feedback on this patch, but there is more
feedback inline below.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 3 +++
>  include/linux/security.h      | 5 +++++
>  io_uring/uring_cmd.c          | 5 +++++
>  security/security.c           | 4 ++++
>  5 files changed, 18 insertions(+)

...

> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 0a421ed51e7e..5e666aa7edb8 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -3,6 +3,7 @@
>  #include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/io_uring.h>
> +#include <linux/security.h>
>
>  #include <uapi/linux/io_uring.h>
>
> @@ -82,6 +83,10 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>         struct file *file = req->file;
>         int ret;
>
> +       ret = security_uring_cmd(ioucmd);
> +       if (ret)
> +               return ret;
> +
>         if (!req->file->f_op->uring_cmd)
>                 return -EOPNOTSUPP;
>

In order to be consistent with most of the other LSM hooks, the
'req->file->f_op->uring_cmd' check should come before the LSM hook
call.  The general approach used in most places is to first validate
the request and do any DAC based access checks before calling into the
LSM.

-- 
paul-moore.com
