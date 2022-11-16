Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A774C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKPCMF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKPCL4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Nov 2022 21:11:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6580317FF
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:11:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c2so15096063plz.11
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlG4izqruLI+eVPwVb56QneDoxM3cuNDHZ53g4ubPvM=;
        b=Ak9MCLAvA2GBPRXf0QBz6QKrrowDoM9d1dTD+sXsUAWbcp+kpQheB6n2mD1QlNNrfF
         FNfgRgVZY6B5+u0zmvXEYLoKORqQZh0IpXnG8CayJQ7ElwlsJOw5J+fGhTJHt9lO5B6G
         X9skKmfj5EQhfW2pDH63UN37Ub+EphKq4h+3t2sK0+PyIJKn9ICzFwKFwMd0gmdeYehb
         0WulDrrj+hUyycJkydMEdIpc+y/CkeKcRsCHlOoo96aak/WwMhB/Tn542xGRMx00reEI
         sJFjrxgOtZS1lemrcrZkR69bdc65tFvLq8CBRUcwXAt8QOEoehFQ9ovUQUcdnnrzIN+O
         rkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlG4izqruLI+eVPwVb56QneDoxM3cuNDHZ53g4ubPvM=;
        b=sofidHEENpKDik1B9tGUwuLBYIgA+WRifnfskmkMRdzjvDkJCypODOee9aYZl6N/eZ
         syL6IqS3HXRvxg5k0sov5QaloJkqYWE1rrCk9kWJWBrLycLQZOlVyGMAhMHMlCSpX6AH
         tavX/sKi0Ruzwj1sFrnbX8vwua5OZy+wh3tE4FIQZtydd7zbn1EcsLmcjtjGh12PT0vL
         7HCS4Hgll14vvoFCf6siSpjDChoWkZ0ieOQ/jZHS9TfAYelVq2D7MlM++N2JfqhC0StP
         sDigFPLQDq5x8VTQWT+3ztO1dfa7TlDO2ZmkPxhZ5FoUHpZes3HKVYl9pbihLZsOnqbV
         PJUQ==
X-Gm-Message-State: ANoB5pnqlxtUkKiT5gROBvLJQSJoNoZOU1Zk5988x/9gwox64nmPesWY
        M/uKkjT5o5KNaUulBP5oHepaY2uSW3KqsjIymaLW
X-Google-Smtp-Source: AA0mqf7co3DQZqD8OdQJKEOz+zPQP8Krnul8up1/TRUoFzIhYtr4pGe1QxnzuRC2rDaXkKuBQ9Hkzm6/dN0BeRSPgdo=
X-Received: by 2002:a17:902:74c1:b0:186:c3b2:56d1 with SMTP id
 f1-20020a17090274c100b00186c3b256d1mr6809971plt.15.1668564714386; Tue, 15 Nov
 2022 18:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:11:43 -0500
Message-ID: <CAHC9VhQjnwbFgAoFgTaLQP7YnNDNyP1i0i8H++HZWj930pW=-A@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that returning 1 from the LSMs means calling
> __vm_enough_memory() with cap_sys_admin set, 0 without.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..f40b82ca91e7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1411,7 +1411,9 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> + *     return 1 if __vm_enough_memory() should be called with
> + *     cap_sys_admin set, 0 if not.

I think this is a nice addition, but according to the code, any value
greater than zero will trigger the caller-should-have-CAP_SYS_ADMIN
behavior, not just 1.  I suggest updating the comment.

-- 
paul-moore.com
