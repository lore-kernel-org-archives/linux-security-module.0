Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB7C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0AA60F4C
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhIWQcU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbhIWQcU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Sep 2021 12:32:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE8C061756
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 09:30:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x11so404581ejv.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONmm5NF0sTCuq08PfKjP3e5s+2h+dHS5i02JXZAQd4o=;
        b=RiP/n1swGU2Eoz6qWQhh7kbzPMhmmDfQSS2q9WyY3LF2+kfIpXzTQiOiYr3B1tev7r
         NLxmjVmGSdhGTzgr0G7kTbCyvBkwBBzEhrmQ3kiuiq9jVa/JOM8bokLgGqz2xg3ZNDxs
         Mm8I34V69UuKjHFpK91sn0EG2kLbZfUYIXxOV+IW51qOFpVNal9kYrGLMFWCOcZXXf+7
         gA37gZJFHYFhPBcNW7iyiO5S3xXrnmoJ9bGM9IupmsWBCClVS6mw23gd+o7+KBMsRxtX
         oPtm/3o94fW6S3Z5nDijBUcU9UqK1F+nWvzVxbyL9+GR+6RZ1e8LBVzSKwcVUgmv1NoJ
         22Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONmm5NF0sTCuq08PfKjP3e5s+2h+dHS5i02JXZAQd4o=;
        b=Ddd9HqQEmSD0211dfVpxeZ2/DfUy7I5kWP19r6u4YCcTEZh+T9r62U8oRVhZ3mpW+X
         5T6o0JCfWhfolcS0z7Ss0jcFmu/VAyreuMjC2X92qXNMP4uWs9eS76pvAsGUm+4QhdSi
         cdfwyujz5NpeLhi8FlsSxXEAl+71NXdjUVQ3eFxOWZBnW0ul02h6Co72CBViWh6jl8R9
         x/p8dY1ZKt8wth9gT6sCTVudZGrrGu6YqUN0kalNZn6wqnqUJ2/HlIJ0v5V3wpLt5mft
         B22Iws3midxo5MfZg40dWe76kQPNt7rtW+sY+8H8pK2NYGw+bwvemzJueJC+gsXOQGyE
         3yVw==
X-Gm-Message-State: AOAM531lphev5Rmaj6Hk/djwE1vxKk837Kcdwl4H7ul1q7hM8Q/zmnVY
        uUzCmXUaJc57u3W/ZQluwxzZSvdTcrThyIdTetrixN3iyw==
X-Google-Smtp-Source: ABdhPJzIEieT/0x9HdrnVl/ABPEXnEuRFGu2mEVwhn01wwxQSa7H1o2BaIv/Sdb5NHuTI1AHBqSSvevuwfrosEqTjqY=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr5796124ejj.157.1632414646813;
 Thu, 23 Sep 2021 09:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <163241206546.71956.16494958077958683533.stgit@olly> <0d144c68-ecd2-872b-1c93-02cff28a060c@schaufler-ca.com>
In-Reply-To: <0d144c68-ecd2-872b-1c93-02cff28a060c@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 12:30:36 -0400
Message-ID: <CAHC9VhQA7bEr8Rz9aDXQKKkvf6hqzw9SK80VRy5GpHZO-CyahQ@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: fix subjective/objective credential use mixups
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 23, 2021 at 12:20 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/23/2021 8:47 AM, Paul Moore wrote:
> > Jann Horn reported a problem with commit eb1231f73c4d ("selinux:
> > clarify task subjective and objective credentials") where some LSM
> > hooks were attempting to access the subjective credentials of a task
> > other than the current task.  Generally speaking, it is not safe to
> > access another task's subjective credentials and doing so can cause
> > a number of problems.
> >
> > Further, while looking into the problem, I realized that Smack was
> > suffering from a similar problem brought about by a similar commit
> > 1fb057dcde11 ("smack: differentiate between subjective and objective
> > task credentials").
> >
> > This patch addresses this problem by restoring the use of the task's
> > objective credentials in those cases where the task is other than the
> > current executing task.  Not only does this resolve the problem
> > reported by Jann, it is arguably the correct thing to do in these
> > cases.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: eb1231f73c4d ("selinux: clarify task subjective and objective credentials")
> > Fixes: 1fb057dcde11 ("smack: differentiate between subjective and objective task credentials")
> > Reported-by: Jann Horn <jannh@google.com>
> > Acked-by: Eric W. Biederman <ebiederm@xmission.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

-- 
paul moore
www.paul-moore.com
