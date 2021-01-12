Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F63C433E6
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398B522B30
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbhALKFp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390352AbhALKFo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jan 2021 05:05:44 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A3C061795
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jan 2021 02:04:58 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m145so467448vke.7
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jan 2021 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rS4sdXVHr4l3vGRPMuRvaL1eabkA37lCE2nh9ri+8DA=;
        b=f6Llr2Ei6o9IxbS05Jb89UXoWPqSI2kibVhcgOSycNIT9BHPBbZWtGxXn+WN4i5WCB
         AJOaz8a1xnVBZLXTssdcpIgtFblHkyYiljyiuxZ638ZbcdCEUWce4loVsjZ0tXWMhxu6
         AmEclYLBi87TEBoqp95L0D4aYhWwzlVJWZkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rS4sdXVHr4l3vGRPMuRvaL1eabkA37lCE2nh9ri+8DA=;
        b=pjfFzldJf6s0FYjdWSgL/5Ggllt0HoEzPm4yFxF4noEksi5FEwfnZFQ3ewVYqKzc7T
         +Y3Dj8tBypf+FXJL2UyMqEefqV+TiCjbd5n9I2tv3tabDYXqgYOsNOaIWQ/Q48IOplCl
         /YuX/sWq2Epd4ndwf9cbf4fTG2oAS+j/HzlKXEMySlZu/OjS6hdjgBF94Of0VVCv6Lbv
         f9NyJRbQfJy6cvGPPoTV4RM6UaRvSUVZgRneQIarlT531M6vy0lZiEWIuKlYLbRvxgGZ
         adqS2fdg9LofS9V5MQpFuPO5Sd99oQEhSV9IK0Djy73oV/QlShdlpui1pOlqzByr9PJR
         s01A==
X-Gm-Message-State: AOAM533xQqsxkQM7OKKWxKFwLhCzLiDsdp/oQ9YxsCZmwtZLqMLDQ+r+
        sMpJutaXvlvlHZb0Z3fB98DXIxFSZq3zIlYZRNTgOQ==
X-Google-Smtp-Source: ABdhPJztDdZxYIknYtDyA4L4qWH3qQH8eT1tvdwztKucGwlw6fqzlmexa8qFWsTe/ripf7WrljQs6a1FAY+W8sF9/m0=
X-Received: by 2002:ac5:c284:: with SMTP id h4mr3303695vkk.14.1610445897639;
 Tue, 12 Jan 2021 02:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-2-mszeredi@redhat.com>
 <87czyoimqz.fsf@x220.int.ebiederm.org> <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
 <874kjnm2p2.fsf@x220.int.ebiederm.org> <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
In-Reply-To: <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Jan 2021 11:04:46 +0100
Message-ID: <CAJfpegutxHPuEnUxapcwcwiEiND8Swdi7CSOMaU06qV9=uUdXA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 12, 2021 at 10:43 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> The following semantics would make a ton more sense, since getting a
> v2 would indicate that rootid is unknown:
>
> - if cap is v2 convert to v3 with zero rootid
> - after this, check if rootid needs to be translated, if not return v3
> - if yes, try to translate to current ns, if succeeds return translated v3
> - if not mappable, return v2
>
> Hmm?

Actually, it would make even more sense to simply skip unconvertible
caps and return -ENODATA.  In fact that's what I thought would happen
until I looked at the -EOPNOTSUPP fallback code in vfs_getxattr().

Serge, do you remember what was the reason for the unconverted fallback?

Thanks,
Miklos
