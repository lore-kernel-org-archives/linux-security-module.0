Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F0E71D4F
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 16:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbjJEQPZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbjJEQNP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F253406
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 08:47:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99de884ad25so210132166b.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Oct 2023 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696520852; x=1697125652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIbClnluXXm7tzBo8R0egubgbNZCa9FUtfT45WqWEaw=;
        b=A34CFJbJNOQHh16uipq42ogpUAnfu4V8c8TuMTe/W6ZS1fj+RCy9MC+AIcWpP+Va53
         BrKyct1gSCxej2UGQ7ePhqm1IqeTUBo3LST6tXYw94/POs4sNnk3OzFmEeWubPXegQ06
         Y+qEX7z1Ug88Eb3dLZARoAga7Mza2twAsUyrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520852; x=1697125652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIbClnluXXm7tzBo8R0egubgbNZCa9FUtfT45WqWEaw=;
        b=inxtDtPxW+u68308DC10o4O89TYWz+6HdcCKL2BLr/iWJQx6yhY+4R3DuUYh4GxCH6
         3N9vTYJ0wg/MhvBiYvyCyuVmpX55bkgQKV05/PtQJYYi9WntCHBi9Zdpc5b1nS91ZQR0
         qFAiqVpQd7v5H0fQ10m5LlIUNSy+emEGIcunt+FQGKSW3548uh5y0gYe6IsNe42vPijz
         z1r4HIn1RRnHB3itZMPdGL96DPEsdEC3A8BHWFP77SbFDi6T/XXCoCUtkdOd4OvEUdOW
         qttox96HUKHm+UiQkdDp/ZEcOKUBrgTowJ8jBvjDlrK6T+dlcsmpEgLFrqnbu3s4akQL
         DX7A==
X-Gm-Message-State: AOJu0YzHoelC7Vgttz3uM8Fq9AtJ+5RtGWTR5ZxQrtcQRJ/A1cAOgXMH
        ivMEcAG3y98KDW4NIUYIn3gcHXZ0g8rcpuHyhedPKA==
X-Google-Smtp-Source: AGHT+IGsngpSrcqd6kKV9Bco2sKwkS1oFAFzCv5dVv+U0Wu/XKkes83ujmyHOcp2jA+PoEmRR/awY7L3W30UVlh+yEI=
X-Received: by 2002:a17:906:cc50:b0:9ae:7611:99bb with SMTP id
 mm16-20020a170906cc5000b009ae761199bbmr5442107ejb.59.1696520851931; Thu, 05
 Oct 2023 08:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com> <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net>
In-Reply-To: <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 Oct 2023 17:47:20 +0200
Message-ID: <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Ian Kent <raven@themaw.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 5 Oct 2023 at 06:23, Ian Kent <raven@themaw.net> wrote:

> The proc interfaces essentially use <mount namespace>->list to provide
>
> the mounts that can be seen so it's filtered by mount namespace of the
>
> task that's doing the open().
>
>
> See fs/namespace.c:mnt_list_next() and just below the m_start(), m_next(),

/proc/$PID/mountinfo will list the mount namespace of $PID.  Whether
current task has permission to do so is decided at open time.

listmount() will list the children of the given mount ID.  The mount
ID is looked up in the task's mount namespace, so this cannot be used
to list mounts of other namespaces.  It's a more limited interface.

I sort of understand the reasoning behind calling into a security hook
on entry to statmount() and listmount().  And BTW I also think that if
statmount() and listmount() is limited in this way, then the same
limitation should be applied to the proc interfaces.  But that needs
to be done real carefully because it might cause regressions.  OTOH if
it's only done on the new interfaces, then what is the point, since
the old interfaces will be available indefinitely?

Also I cannot see the point in hiding some mount ID's from the list.
It seems to me that the list is just an array of numbers that in
itself doesn't carry any information.

Thanks,
Miklos
