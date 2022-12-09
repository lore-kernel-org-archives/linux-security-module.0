Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD7C4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLIR3T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLIR3I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 12:29:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C96D7E6
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 09:29:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fy4so5191469pjb.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=034e6aXc5fwWVn7G8vG+SaZPWqCX6o7xueBmeUitIAo=;
        b=rQ7AcbnKUrYvtNvh5YEHFUt4qfi3oZXzaQMILUfbeyl3Zgt1bhCdGFxPQAZNxQjk4L
         ZqFzkPYtzhkQ/wAKPM8WylMyw0iYwX/ybdFp38hvhrCG/KnTw8RwxJgfB0BjKuZTUJSf
         F6VCaNN1M/cx2BCvuH/+mbkzGat/b4CtjLK9xoGuVlbBN5yB6VhOdmDpFyhhmDt9E2Sv
         EuSmWUHno0BgAANPkcRCN69P1P0QppoWhcI42uft/jYBZn48yFPKz82OcEeNR6L4swgp
         ViR9sCr07hxo/v+/GsePIRxZXMuGmPpe04RVQRDI1AHVahI4lTKy5lrrFCAz2+J4nw3F
         NNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=034e6aXc5fwWVn7G8vG+SaZPWqCX6o7xueBmeUitIAo=;
        b=k6K9vMT2kSu5H0Vlvi5nDRHdSohxFu44GXMBXVHrbRNRJOsp9/oPxyt/HL7riF1n1E
         u0cHyBbCyuvB7QshzXef16rQ5jS6E8srCODdA7fb0ZMubqQWvgQxHM6Xm1YdwobJJ4Yg
         /WBuLQIqVxZrLyFK+V5dCc5Z7HXbdZbfBx+lPgARaHjSqcn3jhIGJcufM5q6TDs+dgJP
         BRyY4wHk04VQIzikif0JZD2N0/tE5etnY3zhB72+UA3CNIeQsXJNdoOjBNxKrzYr71fJ
         mAdRPjCyP9DTtxulTA2Jk337mhbwzgPXKo7qdNidTnUZw2N2ywHc2CU0E2Q505oA6X4I
         0Wsg==
X-Gm-Message-State: ANoB5pnV34H3ulNUQ8RnEksXzSPZ+F8M80aVaix0fNCI5HBzst8n6Fkm
        u0WxWkN/HThwmKGgesonMMrfMAPMQEOesPEQthxX
X-Google-Smtp-Source: AA0mqf55vDvD0XlojvFe+sHxcQ/CjVBdp2MNl8uBQtS5gamKa8U/V0fzvoC6+i8XO/cxnQbhqCfBO1kZu3x0cdpCiwg=
X-Received: by 2002:a17:90a:2f22:b0:219:8ee5:8dc0 with SMTP id
 s31-20020a17090a2f2200b002198ee58dc0mr31085363pjd.72.1670606947501; Fri, 09
 Dec 2022 09:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 12:28:56 -0500
Message-ID: <CAHC9VhSKeTqR+m5g2Nacp9ZJbvD3=OADGMEfDRX4rsH8HmGO9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The fs_context_parse_param hook already has a description, which seems the
> right one according to the code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 3 ---
>  1 file changed, 3 deletions(-)

I just merged this into lsm/next with a 'Fixes' tag pointing at the
previous comment block commit, thanks Roberto.

-- 
paul-moore.com
