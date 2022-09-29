Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D7C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 19:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiI2TPj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiI2TPh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 15:15:37 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA722A42E
        for <linux-security-module@vger.kernel.org>; Thu, 29 Sep 2022 12:15:35 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c22-20020a4a4f16000000b00474a44441c8so770893oob.7
        for <linux-security-module@vger.kernel.org>; Thu, 29 Sep 2022 12:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8IbasIFnxsejYaRakKMDBw+Uxz+TadwpxPchTJjqrxs=;
        b=6UI3OArnfid8IKiXqa9PxPke7bVg+BIu9iBaLi/CVKSn6KxGVyKWnHlbuztUik/xqa
         rRJ7OVKR3Zry6HIPDN7tCqKVf4NO9MIQFxZQM75WbOYglFmJspaPt+Lh9YnlDXNuASTm
         QzE4TwdVDmvd7InI96FLlAzNzpWcxA4t6yeyxZ6xP11Soor1eVc0Iqzlh2S6lehvj/LW
         3Usk39z6dUJMcdKyWnbN+Xb+vjdU/a+JfW/bKUcGYTQCDNkvGNtatJNeLh2VzY4ZB4Xt
         /7faKzCb7e9g/VeZ30AF93fdL44NW2cma3I7Lt2RH54o3zTspRfxXDBTvatenLC6otID
         w7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8IbasIFnxsejYaRakKMDBw+Uxz+TadwpxPchTJjqrxs=;
        b=KIYcFN0MxiTYYMqStTQZ52eOlfniMcaeBgKXdp01vuoj5S18UlGlROk1HCWLIWlcG1
         ZLNbW6BM8IignOkxOX+sQ+F2pPpA+eLa9w5HVluqfY/5KooPvxU9wv9a+NFiUEWtoDX6
         ZDTWGlyhiJd5WRLxPHb6bOQNEiQNzRe3Ya5x0xn+qrETTRGlTzH7fHh486ZQzy1D7ZgF
         X3LcTYVH9yweZAO5VIBVMJapyAzafQGwjcC4yhZDw/eUTAKTrCPpJGmioeGcGyjQQ9qb
         UzON+Of5u6sl+CxHPysth+GPVoXoKm5PGwo5PZAqNxGe2hWXX6smLUUfAX8vT6E8G/jY
         RQ3A==
X-Gm-Message-State: ACrzQf2j+19fydmwU5xUTuYcy2g8LQCxr9i6sUSrUGvrio7L1psTL0mU
        jNkx4w4AviRHZ/Rdw0XnRlwwfIPrNLy8aax6oCqS
X-Google-Smtp-Source: AMsMyM7RMLrJCM78VDgsZEoSRlahTnnSzhtFRKGCXtD3ylFH7T9Vjjc9QK6mk9h6rCOVzsjleunPvCxt23iK41VHsOc=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr2029445otq.287.1664478934964; Thu, 29
 Sep 2022 12:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-10-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-10-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 15:15:24 -0400
Message-ID: <CAHC9VhTiGru2XAbjf=hqh+S+Hz8XH1aSP0mks0pjTxT55YfA2w@mail.gmail.com>
Subject: Re: [PATCH v4 09/30] security: add get, remove and set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 29, 2022 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> In the next patches we implement the hooks for the few security modules
> that do actually have restrictions on posix acls.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>     /* v4 */
>     unchanged
>
>  include/linux/lsm_hook_defs.h |  6 ++++++
>  include/linux/lsm_hooks.h     | 12 ++++++++++++
>  include/linux/security.h      | 29 +++++++++++++++++++++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
