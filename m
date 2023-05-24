Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6BC77B7C
	for <linux-security-module@archiver.kernel.org>; Wed, 24 May 2023 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjEXVn6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 May 2023 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXVn5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 May 2023 17:43:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C8C5
        for <linux-security-module@vger.kernel.org>; Wed, 24 May 2023 14:43:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so2870a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 May 2023 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684964634; x=1687556634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cOVTbGx45JvQe7bISLPr9dxfTGNroVmeLZqE3iaMIHE=;
        b=kgvdR8dsXFc7L6OewJXKnWm7UljoC+7BF9kyTeeSAYcFUwAZwaPTybTncucn9F/g/S
         pz47HB4iGqTKXa9DrD4tQz6tTQp7GSaQ7XrfTY+44J2/oFPvWZ/GhfgCs3d2HhVZu2JN
         vw0PJIY3AFUGcaLUZspnCl1p9uLYasXydLqp/iU9onG/xEqCrq5+KKKRMyl1qUgUyr5o
         0H3m3WPYLf4fZR4ynHqhQaKm+Xq6ejWJODzgGHL+2mV+saWzbAafuaRIb1ulvxf1+D8X
         5bMPIlwsB0J/IrY+djx9swJIDkJpQKjoX07OymbZCpWUT7WM233lTZ3PhzPE1o2kA95B
         V0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684964634; x=1687556634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOVTbGx45JvQe7bISLPr9dxfTGNroVmeLZqE3iaMIHE=;
        b=O0g8z6hIseEREGHGd+8lb3mSWBCZL0qJPEwOWmwxYULQTnSoae8lHTYVE7LjGVysoz
         fPvy3CHa7Y5LnXdJU6Yd1clDCQZY64R1cgnYTtosmCEFDgb+KucMvyJUiyUgacoplMSO
         ce5fk1FNacn66jc5DJsveFp0Vb7ju1rJYpaSncoNV2rSBFDrkjsqL1M/0OrrefIsoquY
         G00pZDV1tRFh2f8JFNtIl/KAsHjIwTKPH9oBSWzvJj1BwduFghUlFpRl7HzciA2qaOqx
         aJAq3BrFr0N+2K6JtYkvhG3YT87lG04rhC9dCRQjIs2mt5xPXcT3hnqJcElnQAOHCGo8
         Gf4A==
X-Gm-Message-State: AC+VfDxLGFBrcYYtwDueJhJ1fw4CwSzQtmjC8z0gSna2GbXk9rNDFsSr
        brvRmFD8weMfd7OfOJbizxes0QHvqliK05JHGG+IJA==
X-Google-Smtp-Source: ACHHUZ5/wDbK7kIVQj6FIKSO8KY2BmJ8WZmL8dnGx2kkxVh+2/BWmwqPsgMw2hdMTdjNWBcwNXyLmVVS2P/GMOCCh1Q=
X-Received: by 2002:a50:9e2a:0:b0:507:6632:bbbf with SMTP id
 z39-20020a509e2a000000b005076632bbbfmr42200ede.6.1684964633887; Wed, 24 May
 2023 14:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org>
In-Reply-To: <20230510.c667268d844f@gnoack.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 24 May 2023 14:43:18 -0700
Message-ID: <CALmYWFv4f=YsRFHvj4LTog4GY9NmfSOE6hZnJNOpCzPM-5G06g@mail.gmail.com>
Subject: Re: [RFC 0/4] Landlock: ioctl support
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sorry for the late reply.
>
> (Looking in the direction of Jeff Xu, who has inquired about Landlock
> for Chromium in the past -- do you happen to know in which ways you'd
> want to restrict ioctls, if you have that need? :))
>

Regarding this patch, here is some feedback from ChromeOS:
 - In the short term: we are looking to integrate Landlock into our
sandboxer, so the ability to restrict to a specific device is huge.
- Fundamentally though, in the effort of bringing process expected
behaviour closest to allowed behaviour, the ability to speak of
ioctl() path access in Landlock would be huge -- at least we can
continue to enumerate in policy what processes are allowed to do, even
if we still lack the ability to restrict individual ioctl commands for
a specific device node.

Regarding medium term:
My thoughts are, from software architecture point of view, it would be
nice to think in planes: i.e. Data plane / Control plane/ Signaling
Plane/Normal User Plane/Privileged User Plane. Let the application
define its planes, and assign operations to them. Landlock provides
data structure and syscall to construct the planes.

However, one thing I'm not sure is the third arg from ioctl:
int ioctl(int fd, unsigned long request, ...);
Is it possible for the driver to use the same request id, then put
whatever into the third arg ? how to deal with that effectively ?

For real world user cases, Dmitry Torokhov (added to list) can help.

PS: There is also lwn article about SELinux implementation of ioctl: [1]
[1] https://lwn.net/Articles/428140/

Thanks!
-Jeff Xu
