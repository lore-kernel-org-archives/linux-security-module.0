Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6FC4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Dec 2021 02:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhLFCtV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhLFCtQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Dec 2021 21:49:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD0C061D5E
        for <linux-security-module@vger.kernel.org>; Sun,  5 Dec 2021 18:45:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so36981185edx.2
        for <linux-security-module@vger.kernel.org>; Sun, 05 Dec 2021 18:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAcTNxIoqCQKh3qNem4ztjrqCuOStoYB0zt6jOti2fM=;
        b=703KD5Dy4S07b9NOPcCmckxiV0xThMuw4v47XWcKh8lVlj3SkIuvNeZdbm6rtttJel
         CN1ckcWbD8/lbxT4Jwj+Y9gry7ibQtpUGc2tCO4pCZdTKs75VlJ4X/lX3aLz6kfxqH5s
         RVGGKWr5b9VnjrWfNG1lQe32LNCc7grW0slWsI2NP7mNnelc2IvDa0o0W+HAIGDA6yGd
         1PQHfOUJspyH3RGay4LqaD1Y2PpsBDnBH5I5x5jgc2eX+fBsApvjdfVlTLnwgcAQkZr/
         MBjazrjlZfjHGuF5GqpAmlnUYYIi+g3zgn5RR1ZcD25u2wOZvz+9wxnZc14HbFsN7+/J
         A1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAcTNxIoqCQKh3qNem4ztjrqCuOStoYB0zt6jOti2fM=;
        b=vL1BezBfyC7sBZKDjsSEYwrBW2CUr9Os00uoPjslYcrJwhUIHFA6X+6MsRd8/cRGnM
         aXf/Fy3w7aWfhXU4yZF5n8I/cuRZjmYiYvPndCuTGfLndatbJFs5QzlT/DaSTj9xrrH6
         JD5F9E0v99U04kW8LnLl1BCt6xWzXeEKANkma0bL7sw6fwsyTrBXeJIf5XQNOV4IcWYl
         zcIeNSlVORVNwVUZbuqoBtrMGuO0kVDv8Uk/pOzPId+8nPhqrA1w3dSabKx+snArq+Xv
         c76ZdfyazdohCvXQrQOSnHrRTiuGkzIq6+WizhK78vChXMazjp/evR1OBk4ZnqZC5a/R
         qRCg==
X-Gm-Message-State: AOAM533UuF2cg+WcFvOZpJuJVeNmvdclyhXfvaT38sqLXiuD6FtcJz4M
        0XHoCLn6GG007RY1/9qrRcij9hgD+X381xRVkjqr
X-Google-Smtp-Source: ABdhPJyE9y+VM2HvH+c1uVgAwAlchDezHWdVaNNETBQPLD1t/75CgFz9OPD/I9SGTBk/kp26WnSO6nK1FyFfZCw6tW0=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr50498858edx.244.1638758745874;
 Sun, 05 Dec 2021 18:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-27-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:45:35 -0500
Message-ID: <CAHC9VhQxS4W_WEcLavy9QY_-85sGNMY+DOgx_Ch_GpR8D_9qnw@mail.gmail.com>
Subject: Re: [PATCH v30 26/28] Audit: Add record for multiple object security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 23, 2021 at 9:12 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>
>     type=UNKNOWN[1421]
>     msg=audit(1601152467.009:1050):
>     obj_selinux="unconfined_u:object_r:user_home_t:s0"
>
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> A AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  5 ++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 61 ++++++++++++++++++++++++++++++++++++++
>  kernel/auditsc.c           | 37 ++++-------------------
>  4 files changed, 72 insertions(+), 32 deletions(-)

My comments on 24/28 and 25/28 should also apply to this patch.

--
paul moore
www.paul-moore.com
