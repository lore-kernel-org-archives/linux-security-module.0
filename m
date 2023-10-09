Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A6E81E18
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Oct 2023 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378932AbjJIWyA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378955AbjJIWxx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Oct 2023 18:53:53 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E9B9
        for <linux-security-module@vger.kernel.org>; Mon,  9 Oct 2023 15:53:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d84c24a810dso5615963276.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Oct 2023 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696892031; x=1697496831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAItUfujL+mWM9AjntNyz6dEI1LC27fi7NkwloZDHY0=;
        b=P3AP2K7x2UukO6qS5KFMowt6zx012uVQtz0+IFTGvEOQgZ6bQ/XIPVskKIcWeUEkIs
         zagAWqFNIsj0sVamXPwgYmGGy04N7Rb0/gMMWN39Pl5EgnHcm/vE+MLGxVKeXj3ZpBSt
         wCE07Qhr3+9rHrwAcVU4JCPICnh7LynR9du4y0AOR0kCOVLOKeBAfv0w2etD8FKgnrE2
         IF80gHWcZ5G8zaLCZngezMcxB/nCRR7S4NNnEy4Jdre84F/tElyPuyPqHm0B82oFN8vd
         TgvoqMMKHyyH2GikKGlnvWCErOhMNnQ5YEsIdqCvhGnwtxsRs2VG+61uMLj++iF4nl4u
         M/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892031; x=1697496831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAItUfujL+mWM9AjntNyz6dEI1LC27fi7NkwloZDHY0=;
        b=pLeF9apLtlfJXi/H3Wetkzc3XY4YkM1XBjNdZAqXWMzBT5muB+T9P11yf5tepxv40K
         JKZBd05Mb14BNsGjK+KcdOU0GSHpipaZ1h3I8FvYCSSlfeGEJiA6UMIZjT+hQrFaHaw8
         u3ZPbUaDLanoi+d89sx5pTRSrShumGLZA7eJLMQUkylnbcYLt5o56lStPCrrQ8t4FqWn
         XpJfAoIeNqhlGJorB8iwE4qkOiHn9Qfq65jw8lBd61W0e3SBA9yzW7xNb6ykEDEvyD/0
         6kJRwHWKFxYW0NwOmMMnx67KImuwcJM1B/fLMJyvod/idtEUqCb1FaiBCgZsPmrqVhbN
         PwRA==
X-Gm-Message-State: AOJu0YxD74FADBCrOx1cLRy6LtZy/Vn2/0N7848UhrXYKSdNjrsE4ZPE
        H9d50OzDBcHXYo52FsQksDwjoYH4cSrPp/X8cW0I
X-Google-Smtp-Source: AGHT+IEPiXf9wuTcoTK3FORZIR49aCFr3p9oLJrFSqR5cezvxqmIqJ9VXVN+Ozcg5dWNg6hXIiJg/XsmuoYE2AW0rNM=
X-Received: by 2002:a5b:151:0:b0:d81:8da3:348e with SMTP id
 c17-20020a5b0151000000b00d818da3348emr14341516ybp.41.1696892031418; Mon, 09
 Oct 2023 15:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919214800.3803828-1-andrii@kernel.org> <20230919214800.3803828-4-andrii@kernel.org>
 <20230926-augen-biodiesel-fdb05e859aac@brauner> <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
 <20230927-kaution-ventilator-33a41ee74d63@brauner> <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Oct 2023 18:53:40 -0400
Message-ID: <CAHC9VhTTzOCo8PL_wV=TwXHDjr7BymESMq8G1WQvsXnrw627uw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 27, 2023 at 12:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Sep 27, 2023 at 2:52=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:

...

> > IOW, everything stays the same apart from the fact that bpf token fds
> > are actually file descriptors referring to a detached bpffs file instea=
d
> > of an anonymous inode file. IOW, bpf tokens are actual bpffs objects
> > tied to a bpffs instance.
>
> Ah, ok, this is a much smaller change than what I was about to make.
> I'm glad I asked and thanks for elaborating! I'll use
> alloc_file_pseudo() using bpffs mount in the next revision.

Just a FYI, I'm still looking at v6 now, but moving from an anon_inode
to a bpffs inode may mean we need to drop a LSM hook in
bpf_token_create() to help mark the inode as a BPF token.  Not a big
deal either way, and I think it makes sense to use a bpffs inode as
opposed to an anonymous inode, just wanted to let you know.

--=20
paul-moore.com
