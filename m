Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10CC3A5A7
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Dec 2022 22:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiLFWvp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLFWvn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Dec 2022 17:51:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C14A06A
        for <linux-security-module@vger.kernel.org>; Tue,  6 Dec 2022 14:51:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d82so7156367pfd.11
        for <linux-security-module@vger.kernel.org>; Tue, 06 Dec 2022 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUncIJZdU3nK+S56v04n1fL0wk5o09HIUop9m+sJlw0=;
        b=KCE2zO6WNGzf3yEIA1kux+zo1nW27TLp92iRh/dPKdvOZQ5vjFtjBb5EueG2bhihV+
         zh5QunEVtbIOtbScWf/RNta3+l4QrtzP/vM6YwjqwDjYy6jqw1x7LRzhyoH3WHnE+YjF
         MiQwtpMrw74Ydp+9+9VdILT+Wh+ToPbNiT7RR2M711doeBOyBTfBwk7Fd2dsve+InNmN
         clnJ74mLhrgnlF4s8QPHoTtibjRhHXX7TXwobGjYUgWp6fPTHnh5FJRVZ2kzNVq0N9OU
         5AeoUS8k6I2vRTqlLBlUB/vVm8zJblwAOMrslWf//wR1UO9uVaupfApokSCi7g8zle0/
         K/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUncIJZdU3nK+S56v04n1fL0wk5o09HIUop9m+sJlw0=;
        b=3MIbF+lD/WiTY+T+8FDaylceqGBe6S700cN2A4n4JRKlmPvh67VPhmvWhrUPu97lgY
         jofSRfAtDEDIwxxQ4nV5m0XvCKF1bBHcE4Ma4HujPkogvhtRcyNd6vzpCDke5moHIDys
         KNc3gbbit8ATvN87QfZpFyHYH9f4jFI6PTcHsk6rZqN7cJfFOyzzdac4N0EvEItpFKDa
         ICyYfzk2c/A8ckUByZhwHI0rHLdZlua9IabXxQF7xWwa/Hzr9P7koWPmhBRBdSfqJomg
         iyOish/FNP9BE9t5NSRKjuJ6JKtEmjJ2dQNMGQbqfMMpsMdX+JYiucEXyT8yaB8daWGS
         N9SQ==
X-Gm-Message-State: ANoB5pkSRbVJed8FYEITMFeQTwhoe1aHKW0/FUHGuMlvPypt6di2POlB
        WFjlgZYO2+2poJT9P6LgeMiT8cXfM6b41As0EUAb
X-Google-Smtp-Source: AA0mqf6adAzEF0ChixzTkY0x4g0CgQ1STvfi2SsvCkZO8jfjhkcWv0MJGFg1ZegGwq434nKkRrAWwbyAt2VvhoilfBM=
X-Received: by 2002:a62:1616:0:b0:576:af2d:4c5f with SMTP id
 22-20020a621616000000b00576af2d4c5fmr15934390pfw.23.1670367098777; Tue, 06
 Dec 2022 14:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com> <20221128144240.210110-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221128144240.210110-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 17:51:27 -0500
Message-ID: <CAHC9VhTuEH83tcA-Je7NMkxF8a1W=Bg+oLhLYeASKp70VqAy4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that if all LSMs return a positive value
> __vm_enough_memory() will be called with cap_sys_admin set. If at least one
> LSM returns 0 or negative, it will be called with cap_sys_admin cleared.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks Roberto.  Normally I don't like merging patches this close to
the merge window, but as this is a comment-only fix that makes an
important clarification I'm going to make an exception here and merge
it into lsm/next.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2831efebde69..c35e260efd8c 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1398,7 +1398,11 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by the LSM infrastructure to the
> + *     caller. If all LSMs return a positive value, __vm_enough_memory() will
> + *     be called with cap_sys_admin set. If at least one LSM returns 0 or
> + *     negative, __vm_enough_memory() will be called with cap_sys_admin
> + *     cleared.
>   *
>   * @ismaclabel:
>   *     Check if the extended attribute specified by @name
> --
> 2.25.1

-- 
paul-moore.com
