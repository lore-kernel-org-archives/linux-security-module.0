Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC7C77B73
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Apr 2023 18:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjDSSAP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Apr 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSSAO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Apr 2023 14:00:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401C4EC3
        for <linux-security-module@vger.kernel.org>; Wed, 19 Apr 2023 11:00:12 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54ee0b73e08so11666057b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 19 Apr 2023 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681927212; x=1684519212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohhihngiiHUModOekO8OzmWnKuYyRR5eDyeTIuWRDlk=;
        b=LUTGeHTfwzcWPm81gFkMAQyfTBKB7YiMlUfUYND+zPnNFGZaZJIKe0jwyMu67MVn96
         4689DhCrbR7XmxEoV18yp3dE3A2DlpEZHouKRmQknq+wXNYx7xKO8nuWYgj4vWnuKowx
         A/N2mIiuwYwYgUdj8EyjwbrBtE0KKjOmIlRiVTgCw9a7xeegNlfF7GPm9lTIOgd/BOOP
         Af8b88fcqTMNswnBKqAOXb1befia2yKmp6lIjyJ5gv4cQnh0l7GfDhkIVrn4rBexeVtD
         kLfuk0Jo3oQTKb7jByBPzZA9SgqMr7StgsSu90wE1zTjocLybCzTjQ+SLWKvS/x4xHpH
         7pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927212; x=1684519212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohhihngiiHUModOekO8OzmWnKuYyRR5eDyeTIuWRDlk=;
        b=hR/TR8hKZVSTrkZrbkhOVETHIGkOj+aAnSZB9l7GobgE/qJUUAkpqHcpyouvFlLl6N
         0kunq7nOoIgVcu454/1h3Q9jiPXOfE5LJkyeaGWkxXN9iEPQ0gzVqMqIuUnXJLrx87Dh
         OkepCIxAXrIlq5Zvh5d6NoIBmnH7cB760FosPNW07qllDRzGi/rNBFmKn8XO1kaBNCu4
         D0s1oIJerERzA1w0hhnrAWTyWn0QzlQdHtgbK5QZim7UzRE1KyIWRtFDbnXY56cQJLOy
         rMkRHFVRA7r3g5n1WoV0WDROASUpAFAS59CkXzj+v5uqy82JLOoiBuuLMlX3sIvfGWjV
         jMnw==
X-Gm-Message-State: AAQBX9e6rfY7MR+J9dKIn4vA+xhqOqkxlaCA0dpEwtZ2vln2Usp0lBzZ
        dS2ncHKIzs0WoxhmOMexPUx7XznEIv+XSyI1WEFw
X-Google-Smtp-Source: AKy350ZvDtMUbJjFH3OLohUCe5RvRTmzuBwXXKLfvC3rBwecsJ/pOto2y+FYaKZNsIe/cp23U+UDF0xXGnYUcaWWrDE=
X-Received: by 2002:a81:ab50:0:b0:544:9b15:e197 with SMTP id
 d16-20020a81ab50000000b005449b15e197mr3310247ywk.20.1681927211731; Wed, 19
 Apr 2023 11:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230418172656.33583-1-junxiao.bi@oracle.com>
In-Reply-To: <20230418172656.33583-1-junxiao.bi@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Apr 2023 14:00:00 -0400
Message-ID: <CAHC9VhTNoVTHMLwu0S5xVrNLe5cQcTpAEMb3fdn+GmoNuyNY1A@mail.gmail.com>
Subject: Re: [PATCH V3] debugfs: allow access blktrace trace files in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nathanl@linux.ibm.com,
        axboe@kernel.dk, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 18, 2023 at 1:27=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> =
wrote:
>
> blktrace trace files are per-cpu relay files that are used by kernel to
> export IO metadata(IO events, type, target disk, offset and len etc.) to
> userspace, no data from IO itself will be exported. These trace files hav=
e
> permission 0400, but mmap is supported, so they are blocked by lockdown.
> Skip lockdown for these files to allow blktrace work in lockdown mode.
>
> v3 <- v2:
> allow only blktrace trace file instead of relay files
> https://lore.kernel.org/lkml/b68c9e1d-71c8-adf9-f7da-1b56a3d4bfbc@oracle.=
com/T/
>
> v2 <- v1:
> Fix build error when CONFIG_RELAY is not defined.
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@int=
el.com/
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  fs/debugfs/file.c            | 10 ++++++++++
>  include/linux/blktrace_api.h |  3 +++
>  include/linux/relay.h        |  3 +++
>  kernel/relay.c               | 16 ++++++++++++++++
>  kernel/trace/blktrace.c      |  7 +++++++
>  5 files changed, 39 insertions(+)
>
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..973e38f3e8a1 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/poll.h>
>  #include <linux/security.h>
> +#include <linux/blktrace_api.h>
>
>  #include "internal.h"
>
> @@ -142,6 +143,12 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
>   * Only permit access to world-readable files when the kernel is locked =
down.
>   * We also need to exclude any file that has ways to write or alter it a=
s root
>   * can bypass the permissions check.
> + * Exception:
> + * blktrace trace files are per-cpu relay files that are used by kernel =
to
> + * export IO metadata(IO events, type, target disk, offset and len etc.)=
 to
> + * userspace, no data from IO itself will be exported. These trace files=
 have
> + * permission 0400, but mmap is supported, so they are blocked by lockdo=
wn.
> + * Skip lockdown for these files to allow blktrace work in lockdown mode=
.
>   */
>  static int debugfs_locked_down(struct inode *inode,
>                                struct file *filp,
> @@ -154,6 +161,9 @@ static int debugfs_locked_down(struct inode *inode,
>             !real_fops->mmap)
>                 return 0;
>
> +       if (blk_trace_is_tracefile(inode, real_fops))
> +               return 0;

I think it would be a little more foolproof if we made the connection
to lockdown a bit more explicit in the relay/blktrace code.  How about
something like this here, borrowing your previously defined
'is_relay_file()' function:

  if (is_relay_file(real_fops) && relay_bypass_lockdown(inode, real_fops))
    return 0;

... and in the relay code we would have something like this, borrowing
from your logic in this patch, and using some shortcut-y pseudo-code:

  bool relay_bypass_lockdown(struct inode *inode,
                             const struct file_operations *fops)
  {
    struct rchan_buf *buf =3D inode->i_private;

    if (buf->chan->cb->bypass_lockdown)
      return buf->chan->cb->bypass_lockdown(inode);

    return false;
  }

... where in the case of blktrace rchan_callbacks::bypass_lockdown
would be a simple "true", assuming it is safe to do so (we need some
ACKs from the blktrace folks):

  bool blk_trace_bypass_lockdown(struct inode *inode)
  {
    return true;
  }

--=20
paul-moore.com
