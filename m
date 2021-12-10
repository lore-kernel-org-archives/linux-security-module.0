Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A02C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 23:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbhLJXFI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhLJXFH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 18:05:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544EC061746
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 15:01:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so34230164edc.6
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL3VMM4Ho799xLlmGxbcvKft3KnTqnbiEYdAnIoFjrg=;
        b=mKy5SSxTjQWVA+4lrubuhCfFQaRhnDSuB9AdpWpaYyDkAO3SDcJquJ3Ie98ondbyJt
         Euvu0ylJA0SDmwcrFnBEtUClp6QxGnzvoq6EBWM+dtUz46p+bLxLxC97K0Yzi7PznlEc
         pK9o1jOctntsM2S2t5fP/Apjd+VFZ8vJd7QXXcnVKUgLtllAdjb0/ihYDPeEstD9XF8e
         VBpi4eFUSIVRi8QsUXRnJz3pGMhBSKYGBF0d/ABO6s3gv9qoiif89JWfmfQDqmWD3EbY
         9egtNZw5fk/LMhzhT+DlLizkO4GADpntywDWOO/2JgVd3qO9Tl8uQQ/K/9ZvzMsMUfrt
         0qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL3VMM4Ho799xLlmGxbcvKft3KnTqnbiEYdAnIoFjrg=;
        b=1R2zRWLYCzma1NTnhIOZniWKLobkhsqnVCpDecQ0njFUV8enTjx+S3k4jRQPWnG20O
         7pPG5PNyeJxxF1jr3Yq4a5tucIOxsjS1bdFhJT/mTSSmIXo7slqiQCKW9PQnXgiTzKjC
         hAyE0AmjZLLty4NH0YOARN56IRBMEK7MzX2BhTz52QsuMnlzDAmBCr3u0Y74J8cH/kgF
         IDp6zVnOiuyzc8QNcmiMsBocvofUGfim1crjt5PoCyJkJiNHRcxG3IMXTtVqhS4Mkr97
         xGhQmwT6VjpRaCjP8CwjD9aqSpvYoRhd6wDusmmUZpcgTnX/rLAx12ctHasdSXc3MsKP
         MrOQ==
X-Gm-Message-State: AOAM531+q5asN4BydR/8KSXfP7GV6T/+h+AvvWatTyeDCeLCSFHoExqV
        flxUNlXwFBRQB8GBUzzEkw316g435ZuDpi/5F43IIRwwJA==
X-Google-Smtp-Source: ABdhPJxLVCDw73fmRppFCPUmpn9ibZUO5BvWCbTous0bi6lgt0+2M2d6avoeMlUVtNx7hCS2WzlgAc8BYs8DP0P0rIQ=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr26670363ejb.104.1639177290361;
 Fri, 10 Dec 2021 15:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20211210072123.386713-1-konstantin.meskhidze@huawei.com> <802be0d0-cb8c-7fda-dd4e-2eb83d228ead@schaufler-ca.com>
In-Reply-To: <802be0d0-cb8c-7fda-dd4e-2eb83d228ead@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Dec 2021 18:01:19 -0500
Message-ID: <CAHC9VhTcbE0MYeNGwBYmWrk3NY4FQkDk33gzJjQv=wt6n6dJdw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Landlock network PoC implementation
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        mic@digikod.net, linux-security-module@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 10, 2021 at 11:57 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> As I think you've realized, *sockets are not objects*. There
> isn't a way to justify them as objects without introducing
> ethereal or magical subjects that don't exist. Sockets are
> part of a process. OK, it's not that simple, and it would be
> foolish to deny that a socket may have security relevant
> properties. But they aren't objects.
>
> I strongly recommend that you follow Smack's example and
> use the sending task and receiving task attributes to make
> the decision. You may find that storing that information
> in the socket security blob is convenient.
>
> BTW - not everyone agrees with me on this topic. I'll leave
> the misguided to make their own arguments. ;)

I'm running low on my lets-argue-on-the-internet motivation today, but
I feel like I'm being goaded into some sort of comment so I will
simply offer SELinux as a rebuttal to Casey's comments.  I think that
either approach can be acceptable, it depends on how your security
model works and your comfort level with the various tradeoffs
associated with each approach.  I personally prefer the approach
SELinux has taken (minus some of the compat cruft we are saddled with,
not to mention that restrictions handed to use from netdev), but I'll
admit a certain level of bias in this.

--
paul moore
www.paul-moore.com
