Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5148CC4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiLMRoz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 12:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiLMRom (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 12:44:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98604220C2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 09:44:38 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3b56782b3f6so202519917b3.13
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=WZ1mKRQBVKmDwustjDGt5j+lf+imbCmjpXPsg1BBATOLjJOwG70Wy78s8BR04q3Gdq
         6x0b8plbylv5t6lB95U7p/M74lW+sMEBPSmdvx4l+L+ANQFN/U8Uyh0ytjcXcuSBjnPC
         jFj5+j3oUZw+Z1DQEPds2syc7iY/qe6YjRUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOv+J0r/3B6i4POUYOzSGaAf/iSJPPOP/x/UlxsbTvQ=;
        b=c9DNMCZmEiSh+IDQvxT7566aEc2n7jDm44fI7Y9xMcOUwBXd6AaeFGq7FQc2f0AD19
         BEGGcbDLy2bGZwyJVPWe4QC9+USCJedI641EwmJKAa4BfP8hn++2wjkS+sJMojYwfwff
         FHxiv0BvjbxAah8XkavFECGC0POsxhe8kKVNB/VuqqLpR6j31Tve0e8KJHNQYKzS5xip
         CIOYsoCqpB1CWmzS7JnpK8dRP5dDIZNPLlBvYpJZzu0ApUeiiRqfykDa3Mnmht9vCYEe
         qZYx4VpiZaekIzlPQEIcfJKfdjSVUj6ETXuP+bNp19ez2sEB4CcBWIZo4OalVrVdS64E
         3eVg==
X-Gm-Message-State: ANoB5pl37pUzlBwXYTtmiL4I1XExVJR2VwiZdWOk96jo83ENNbjSTSqN
        fxtLYYLe5YiA3aZW//c5RMTdIOTTuf6xVIGi
X-Google-Smtp-Source: AA0mqf5WKZUObo8cU5UeaBGLrzBbHi4g/3a7hjr8o5pZ7/lTGq0qRC/t6uv2wlYbMBQmc362I6Fzxw==
X-Received: by 2002:a05:690c:884:b0:3ed:aa4:2a72 with SMTP id cd4-20020a05690c088400b003ed0aa42a72mr17426658ywb.39.1670953477389;
        Tue, 13 Dec 2022 09:44:37 -0800 (PST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a241600b006fcb2d3f284sm8402890qkn.67.2022.12.13.09.44.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:44:36 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id x24so225226qkf.5
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 09:44:36 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10744372qkg.594.1670953476176; Tue, 13
 Dec 2022 09:44:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
In-Reply-To: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 09:44:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Message-ID: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v6.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 12, 2022 at 7:05 PM Paul Moore <paul@paul-moore.com> wrote:
>
>   Unfortunately, this pull request does
> conflict with fixes that were merged during the v6.1-rcX cycle so you
> will either need to do some manual fixup or you can pull the tag below
> which has the necessary fixes and has been sanity tested today.

I did the merge manually, but compared to your version. They were
identical except that you hadn't added the documentation entry for the
gfp_flags parameter.

That said, I'm not super-happy with that merge - it was the trivial
straightforward one, but when I looked at the code it struck me that
the only thing that actually seems to *use* that gfp_flags argument is
that

        if (oldc->str) {
                s = kstrdup(oldc->str, gfp_flags);
                if (!s)
                        return -ENOMEM;

sequence. And it strikes me that this is not the only place where
selinux ends up doing that whole

                str = kstrdup(ctx->str, GFP_xyz);

dance.

It feels to me like that thing shouldn't be an allocation at all, but
that selinux should use ref-counted strings instead (and just increase
the refcount). It's in other places like context_cpy(), but having it
be a refcounted string would also potentially help with
"context_cmp()" in that the string compare could be a "is it the same
ref-counted pointer" and maybe hit that case most of the time before
it even needs to do an actual strcmp.

Hmm?

Anyway, that was just my reaction to resolving that conflict, and
obviously *not* for this merge window. I'm just saying that if you
agree, maybe that could be a future improvement, making the whole
allocation - and the whole need for that gfp_flag - go away?

               Linus
