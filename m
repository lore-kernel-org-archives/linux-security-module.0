Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5309C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Nov 2022 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiKWVCT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Nov 2022 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWVCQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Nov 2022 16:02:16 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4D27B3E
        for <linux-security-module@vger.kernel.org>; Wed, 23 Nov 2022 13:02:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3235539pjs.4
        for <linux-security-module@vger.kernel.org>; Wed, 23 Nov 2022 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXNu/5sdUu54/3xRezmFfaQGf0ULUrlzhHPjZKuz8hc=;
        b=LqP9vDAGHjunvnBSFzK6eHm6pcBhE2DIK3H0IJR5r3jwfC2cCMe4ioodlRfla6K8ar
         S75OMcY0z0zUOw5jbgCBHNTf+0YQYjAmUB6BZHuQQmfHLsURmNfPM7CizRBIQ+ZmzYIe
         PF++GGxmPkHkyTWxbA7tqvN+nOGQtTyaGoFeeqSmvsF07UIdO8ccXA2YA6v7bhzdy/Fk
         IfcxcTpKt/nyNqj+V8QCOUuBGZXyQCON3ReZ0t3YlqsubrXHGS+X6EgBAWCNrIft0uPw
         ydfB8IpzcHMVvm6Ht/VgUetjk1h5YZmcI2rXIr8zckY05ytS3XRUzFt9/JHXfpJ2/U9+
         Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXNu/5sdUu54/3xRezmFfaQGf0ULUrlzhHPjZKuz8hc=;
        b=ETKWpr+VvbbvwiT5cpEr34N8Wj/PbQYrGALAldCYTnSteTwKtzsUEcF68JLqkumVKa
         r7wOWLLySumWknS4/J5skbopECF8ulO8ZYYI49FeKn5FvS6wGp/1XTlc4O6qHomvuCJs
         y1lcVJPgwv0R85HQtKXVYGO1lAY0Ja94hDNPUEwHcExQEZ0ixXDXrnHKNrn1Qxfderux
         YX19WZlnzLJk8eeoy6x2C8CvR0xrtvvjWwXAoQRo6zkw67HcaNUB7EYozWlVpdWI7qYL
         ToNQJ4hjO9N9HvsBD1nWOp3+GlC5wZy/bMDyBjgVYnwW6LhVue5+tWyDcYhObEYj/Bjw
         /RRw==
X-Gm-Message-State: ANoB5pnH+zwkic69LzKsIVCGrt1qWhIOaAbmX7PRN8/9aE8W1XwoftZ8
        oYn6t5V6Lm3DnOg+XIJS/8rtJuIgrRvf+y7b79mtGMnsvnHX
X-Google-Smtp-Source: AA0mqf7yEFdm4U7MIuJ1kv2Y49g9b4lHCnYve95PMyFP13hr//coM5n8qZYIl69e2iSOsVg9xJNzbNLzvA6ZrEsPIQY=
X-Received: by 2002:a17:902:6505:b0:186:e568:3442 with SMTP id
 b5-20020a170902650500b00186e5683442mr23431706plk.56.1669237333841; Wed, 23
 Nov 2022 13:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221122103536eucas1p28f1c88f2300e49942c789721fe70c428@eucas1p2.samsung.com>
 <20221122103144.960752-1-j.granados@samsung.com> <20221122103144.960752-2-j.granados@samsung.com>
In-Reply-To: <20221122103144.960752-2-j.granados@samsung.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Nov 2022 16:02:02 -0500
Message-ID: <CAHC9VhTs26x+6TSbPyQg7y0j=gLCc=_GPgmiUgA34wfxmakvZQ@mail.gmail.com>
Subject: Re: [RFC v2 1/1] Use a fs callback to set security specific data
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, ddiss@suse.de, joshi.k@samsung.com,
        ming.lei@redhat.com, linux-security-module@vger.kernel.org,
        axboe@kernel.dk, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 22, 2022 at 5:35 AM Joel Granados <j.granados@samsung.com> wrote:
>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/nvme/host/core.c      | 10 ++++++++++
>  include/linux/fs.h            |  2 ++
>  include/linux/lsm_hook_defs.h |  3 ++-
>  include/linux/security.h      | 16 ++++++++++++++--
>  io_uring/uring_cmd.c          |  3 ++-
>  security/security.c           |  5 +++--
>  security/selinux/hooks.c      | 16 +++++++++++++++-
>  7 files changed, 48 insertions(+), 7 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f553c370397e..9fe3a230c671 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -21,6 +21,8 @@
>   *  Copyright (C) 2016 Mellanox Technologies
>   */
>
> +#include "linux/nvme_ioctl.h"
> +#include "linux/security.h"
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -6999,18 +7001,30 @@ static int selinux_uring_sqpoll(void)
>   * IORING_OP_URING_CMD against the device/file specified in @ioucmd.
>   *
>   */
> -static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
> +static int selinux_uring_cmd(struct io_uring_cmd *ioucmd,
> +       int (*uring_cmd_sec)(struct io_uring_cmd *ioucmd, struct security_uring_cmd*))
>  {

As we discussed in the previous thread, and Casey mentioned already,
passing a function pointer for the LSM to call isn't a great practice.
When it was proposed we hadn't really thought of any alternatives, but
if we can't find a good scalar value to compare somewhere, I think
inspecting the file_operations::owner::name string to determine the
target is preferable to the function pointer approach described here.

Although I really would like to see us find, or create, some sort of
scalar token ID we could use instead.  I fear that doing a lot of
strcmp()'s to identify the uring command target is going to be a
problem (one strcmp() for each possible target, multiplied by the
number of LSMs which implement a io_uring command hook).

>         struct file *file = ioucmd->file;
>         struct inode *inode = file_inode(file);
>         struct inode_security_struct *isec = selinux_inode(inode);
>         struct common_audit_data ad;
> +       const struct cred *cred = current_cred();
> +       struct security_uring_cmd sec_uring = {0};
> +       int ret;
>
>         ad.type = LSM_AUDIT_DATA_FILE;
>         ad.u.file = file;
>
> +       ret = uring_cmd_sec(ioucmd, &sec_uring);
> +       if (ret)
> +               return ret;
> +
> +       if (sec_uring.flags & SECURITY_URING_CMD_TYPE_IOCTL)
> +               return ioctl_has_perm(cred, file, FILE__IOCTL, (u16) ioucmd->cmd_op);

As mentioned previously, we'll need a SELinux policy capability here
to preserve the SECCLASS_IO_URING/IO_URING__CMD access check for
existing users/policies.  I expect the logic would look something like
this (of course the details are dependent on how we identify the
target module/device/etc.):

  if (polcap_foo && uring_tgt) {
    switch (uring_tgt) {
    case NVME:
      return avc_has_perm(...);
    default:
      WARN();
      return avc_has_perm(SECCLASS_IO_URING, IO_URING__CMD);
    }
  } else
    return avc_has_perm(SECCLASS_IO_URING, IO_URING__CMD);

>         return avc_has_perm(&selinux_state, current_sid(), isec->sid,
>                             SECCLASS_IO_URING, IO_URING__CMD, &ad);
> +
>  }
>  #endif /* CONFIG_IO_URING */

-- 
paul-moore.com
