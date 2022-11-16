Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B929C433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 23:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiKPXeU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiKPXeK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Nov 2022 18:34:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1669DD5
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 15:34:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so3844207pjk.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ud1y37qUMgCM/gxdvQMw6rjpiQr0rPzHkykb2T1TOw=;
        b=jrbRsTzGFBtzJXH4NdouZxUiYyPKQAwY/xmJBh4NVbrtqvniX5UYfXIvowNG376O3f
         eLwtZTd6ba3W1ujHY9KXiw+svILo/W9OFO1m0UalP4EKpmsMfepiy/i6aa86EHCqWKyv
         qWDDUfVotm87pdBDO0Xfgi/+YAkeaCgX+rdo+EuhlYGYDIRpsDvKWmFauliHak4wVNLI
         DckVU+/rox+Oi5exTkkDEUKV2Mxw/H1pKQZSwIgdYuS8DxVPCnV8ODquNjjbEQLd89Cy
         sawoAYJG40gaeXZUtqg1vF9XmIjooLLPk2rc3kHLfhCY5MUl7GxaHbuv8P1UN8euweGp
         hkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ud1y37qUMgCM/gxdvQMw6rjpiQr0rPzHkykb2T1TOw=;
        b=6OpVROr/QoNayJ554bsZLj6CLnJAynG79vLFcwQxXnxMiH4jmY9KTHjZINqyrd6BTn
         BNaZGYJuDjAl2UQ74aZjGq5XOTcIKit2AYC0fSHCLcuhDj6Re8vj0hrQBSTMsPhKPfLz
         oUsb+5UxjXKf8dDWIEKkrfmZaK3P0tIoRXlkTSdGP6Gi9o4h76zLSzHuZtXULbA5hr/Z
         gCxnTWyt2fuzexv5EMwtB6bOoQqD62p9jXa/4wxYpQOtSDpMM3cfMKjoDeTDZoqNQ/TT
         Nlhdp6DEDeSqmesgPSD7VNH1ZKCxc8sEDRQ/t4quHq2jaf24lQ7GKlKZtZr+8ga5h2pR
         k1sA==
X-Gm-Message-State: ANoB5pmJBmBpvbm7Krp2QxGa1LN/wfLfORC3UZyq6YdiukUoiZuzyKus
        P6i6dEzrgYPoi5bKFP33ZgiYLFWn2uE1FPaBcQTK
X-Google-Smtp-Source: AA0mqf6autHIA7b+foED8yvIyyGbA11Im+/0A/6tknTVjps8BtDl7zzp+NqROZqk5yDoHG6fU2SESmQwmeAn21G2aCE=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr5961252pjb.147.1668641645195; Wed, 16
 Nov 2022 15:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
In-Reply-To: <20221025113101.41132-1-wangweiyang2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 18:33:53 -0500
Message-ID: <CAHC9VhRa16htUXSN0AXrbUwadRa-qQv+UX8ZO_8W_z2eL=6trw@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com, serge.hallyn@canonical.com,
        akpm@linux-foundation.org, aris@redhat.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 7:02 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
>
> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
> exceptions will be cleaned and A's behavior is changed to
> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
> whitelist. If copy failure occurs, just return leaving A to grant
> permissions to all devices. And A may grant more permissions than
> parent.
>
> Backup A's whitelist and recover original exceptions after copy
> failure.
>
> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)

Merged into lsm/next, but with a stable@vger tag.  Normally I would
merge something like this into lsm/stable-X.Y and send it up to Linus
after a few days, but I'd really like this to spend some time in
linux-next before going up to Linus.

-- 
paul-moore.com
