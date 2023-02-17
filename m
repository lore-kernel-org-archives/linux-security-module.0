Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05FC6379F
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 14:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBQOHd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQOHd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 09:07:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E8656B2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 06:07:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j5so1349864pjz.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK9yBNPBQhHhhfH6W+SAE1t+VduCOBI8eWh9j27KlLw=;
        b=PNObomtXAV3bkpBF/03ut+KrT8pborwo3tyc2Lfspz49/McqET5DRRfku59g8vzRtS
         xTHqjfbfm96M0tBCd1JV+Z0I5gkoQPMLG4GffzRRvdYjcln3EjsB0gXORP7KmJ9MBJEp
         zUC8F1jsTqAhLDLzLIO4m8RoTWyx2lnVl/LUJpFjlSwRnk+k29lSslGnX/+qXLYa6nNB
         RACbwXs9KpqZztSOD7SQZbtNBKxmk5g/HZblnMZIBCAnPxw+Lm5D8x/40pWDGdYIRJgM
         Znt/6Xngrw0H4iNW4aVJimKOIsg6pLldzZPG6v5sV1DU4LJWJ3HoOpMlSc5onBNYdnWo
         VmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK9yBNPBQhHhhfH6W+SAE1t+VduCOBI8eWh9j27KlLw=;
        b=yzsRKl+jRmOdLsWkS0mfJGCv8nPOg8AckCIkkFbrPCsAEIz4DW6I9Ua+0Zid/uSPcA
         Be7OKxRv11gJ9CRFJffvXG6UykaI2dBWZDE0YMKkVU2d6i8XK9gLLIphHPTQaXz9Wxkv
         31mTaM5CjVrmlGOTNERtdQxbfNs77SUXVTJyf0P9SYwr4c10Y6f765zY54kaze27vGVE
         bwbFrKH2cE0tvvGbf4E16TjhP9svM7UTt2L7NyrKkSH/oFkjyeEqZeK0244hAwKykYFt
         JNJ63DnVm028ORTwEIHRoyk9rwpngLTP83MI/DLsi3TTUe9hMx5jftyjcndgeddxvMZx
         pTWA==
X-Gm-Message-State: AO0yUKWzXNMb2WZ+0sST0AZqOr6a/herqZ7ALH7dpTdvSK/HfNBU2Cr3
        Oa/06BfXnNWA0RnA8boprh8/53jMMh6X9SD4nJNGtF48cm1CoJc=
X-Google-Smtp-Source: AK7set9tc0vhMqXz79sa9fvJAndCXsQNm1EcU6i1ugmOGqaUwzMsoddMk9tcnPgKcmXPN3fJkW3c8+r+QsFx2zK/6ek=
X-Received: by 2002:a17:90b:4d0e:b0:233:c521:271f with SMTP id
 mw14-20020a17090b4d0e00b00233c521271fmr1788307pjb.139.1676642850515; Fri, 17
 Feb 2023 06:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com>
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Feb 2023 09:07:18 -0500
Message-ID: <CAHC9VhQoqLS_xc4f7J52Q_SzTa-aLvrcvaojHQvQbwbjH7iLgg@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 16, 2023 at 10:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hello all,
>
> The LSM hook comment blocks are a in a rather sad state; separated from
> the hook definitions they are often out of mind, and as a result
> most of them are in varying levels of bit-rot, some severely.  This
> patchset moves all of the comment blocks out of lsm_hooks.c and onto
> the top of the function definitions as one would normally expect.

...

>  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
>  security/security.c       | 2702 +---------------------------------------
>  2 files changed, 1710 insertions(+), 2616 deletions(-)

I just realized that in my excitement of finally finishing this
tedious task I accidentally ran the diff backwards so the diffstat
looks a little odd - sorry about that - the correct diffstat is below:

include/linux/lsm_hooks.h | 1624 ---------------------
security/security.c       | 2708 +++++++++++++++++++++++++++++++++++++++-
2 files changed, 2619 insertions(+), 1713 deletions(-)

-- 
paul-moore.com
