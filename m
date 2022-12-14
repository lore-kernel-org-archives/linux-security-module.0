Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9036C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 02:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiLNCnr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiLNCnq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 21:43:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C8617F
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5653948pje.5
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=0jeSheK30XGJEY2/8YVZb5H42sPDzyWChJv0LM5DXGQkr4Rp1tcJYsSYcwhaeHaws5
         13r/iVQG2//SX9o8YqZmdqMz4vnF7EVFbHuI2t0+noHned9FfCDXaMIHgHFFQthwDw6g
         nyzZqYHCrdaZW15mjKnhYr7BxncWpncnJ570HtD3Rn1euKPAxBUxeIHLhg+GpJAB8xxa
         G9wO/TWuK6fKHURvUyXokt/S1QAjKThkNqCxr/2nwd4eRKBNyBmU2o8mhpoOBi67ZThv
         tmekbr0XJowvGgDjDYyzPsqzAoKPHyxEvn2QAbV65V/QUBE9lUmrlThE1GlVS12k8R87
         1L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3zpX62kQveyNiO1OeyJ4tAWYrKdI77Jk/E75RXvoys=;
        b=NcRLgyIndrwYp/vWw+xPw8MLxE/4iCOrx8kuLLR3ew0wffEwz+6u9OX4mGpO+5k48A
         is/7TgF3GIu91N9Cx5sxsrlcKASqanB2X6hl37wOu60Dv2F8xPsQOz9k2d81XOuroBRd
         zRxPSxydJIk7FzVzgd5AjGdZxps8c8Wo3FFp3zxjfRc9Yuae/vdPsvdPe8B41/v+H2ei
         kgD2wEQ3ZNshDjmqjBKNJMeH6pUFkyGGCKKj0675eze3arG0ArtZtFIeDTwASE4gZxyZ
         1kLdGMkMIcJXLCIN4NCGnk+DESNMTD4mPlihp6RplbBV94NtNALXdcYacQic3Qt3hxaE
         QgOQ==
X-Gm-Message-State: AFqh2kpPxxfhmM1rJrubfYhwYXsgo5pFGAp+o+2CqOm8tynHGi0jtqF7
        eCx5B994/Z86f5TTH0zzrO3M6HEpBC+Bzo4bbZD9
X-Google-Smtp-Source: AMrXdXsAFqasEGUKk60MS2TQ0dx9fzOfbpL9oe4Ce2NTauHwaDuuWdH3Aa3wRVZtRYkllfhLAVvVDdYUy6Xfi1rkrsI=
X-Received: by 2002:a17:90a:1912:b0:219:8ee5:8dc0 with SMTP id
 18-20020a17090a191200b002198ee58dc0mr98556pjg.72.1670985824675; Tue, 13 Dec
 2022 18:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com> <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
In-Reply-To: <167098009860.3547.3800457811769489703.git-patchwork-notify@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Dec 2022 21:43:33 -0500
Message-ID: <CAHC9VhSv66DPsJ+5ewmHQ68D3uFh76TpNC9kGXcns_rV-tbaig@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 13, 2022 at 8:08 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (master)
> by Paul Moore <paul@paul-moore.com>:
>
> On Fri,  9 Dec 2022 09:29:35 +0100 you wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > The fs_context_parse_param hook already has a description, which seems the
> > right one according to the code.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > [...]
>
> Here is the summary with links:
>   - [1/2] lsm: Fix description of fs_context_parse_param
>     https://git.kernel.org/netdev/net/c/577cc1434e4c
>   - [2/2] doc: Fix fs_context_parse_param description in mount_api.rst
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

It looks like the bot has a few screws loose as this went up to Linus
via the LSM tree :)

-- 
paul-moore.com
