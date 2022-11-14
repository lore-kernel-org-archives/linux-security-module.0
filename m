Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B5C4321E
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Nov 2022 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiKNMgN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Nov 2022 07:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiKNMgM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Nov 2022 07:36:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7D248E9
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 04:36:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ft34so27847950ejc.12
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 04:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sU9x5ssg8XOYMe/rb8up2J+YLGp3IkvlIELqEyeyXlY=;
        b=NnWstm8DqlCqRdyMglLY7MPEfHjK68m/pRvlqV3oel5H8vqtXc3KtfhohAcqmB6ke5
         xIAoh3nDcghJ7DPQkq4B4QYfHnEbnKMgkpttObeK4MFq+jiRO5xIZJyJsZycus/ajUhU
         sEgbjUbiNBPFKDfWaa/cDrm/umRrNjbBJ3XBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU9x5ssg8XOYMe/rb8up2J+YLGp3IkvlIELqEyeyXlY=;
        b=oS8bT3oQmsjGHR3e0PmIJzGJKO5iJqLdFx5ao/OwbN9S3UoCdNG0Hy7urn01hwGvNJ
         2KTOkaguLOOyq8eJdURq4nKrAngCDogX7BDM7D42MVPKHK8cf7yLR1P3wY3y9J6K/ToG
         fiJkuiBQDAsVQvadm0xGO4jz6YBx+SFMqOCsnfs2SneGS5IabNlkSNGTS3BLCyznmUJt
         xY8DqLp7iOBYd9/T4RFAeHDIdzImFlS5ddvEWgzbPvyoXt4zTqmWjXuUeneC7HnhnOGo
         hGoQOJWP1jdXZLH/bXQHu4tS4mKLXc4aFwfrE41I73HVX5vjW3wM7BmQ3bHuvRCVTi7y
         2G5w==
X-Gm-Message-State: ANoB5pnjp0H/4T1jBAg5cA2agU7Vnd1jwv4o4+Spr3i3H5Fe8cQcxIrN
        /nzyCBPDigw4yVYbFWNHFqrrp2rIi6dtmG73ZEaqJA==
X-Google-Smtp-Source: AA0mqf7xxaXCQcsg9ZYGxFJ3RjLGgBQ3wnQMAUrceAXa9Wi66rhSV8regTVEEtLmw7PnnQh0JiI+9kMluq/F6yfI28I=
X-Received: by 2002:a17:906:a044:b0:7a5:a671:8236 with SMTP id
 bg4-20020a170906a04400b007a5a6718236mr10321692ejb.187.1668429365397; Mon, 14
 Nov 2022 04:36:05 -0800 (PST)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
In-Reply-To: <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Nov 2022 13:35:54 +0100
Message-ID: <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 14 Nov 2022 at 10:00, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Miklos and anyone interested in this proposal, is there any update on
> this? Sorry that I didn't find any..

No update.

Which part are you interested in?

Getting mount attributes?  Or a generic key-value retrieval and
storage interface?

For the first one there are multiple proposals, one of them is adding
a new system call using binary structs.  The fsinfo(2) syscall was
deemed overdesigned and rejected.  Something simpler would probably be
fairly uncontroversial.

As for the other proposal it seems like some people would prefer a set
of new syscalls, while some others would like to reuse the xattr
syscalls.  No agreement seems to have been reached.

Also I think a notification system for mount related events is also a
much needed component.   I've tried to explore using the fsnotify
framework for this, but the code is pretty convoluted and I couldn't
get prototype working.

Thanks,
Miklos
