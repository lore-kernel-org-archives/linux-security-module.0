Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EBC00A8F
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJXSXg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSXf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 14:23:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0604111
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 11:23:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ac9573274so4396374276.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698171813; x=1698776613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhPdOnDAT6+PH0Vz8+OhielyBKDSwn2hQuYPBjz8d74=;
        b=GoBMniGdumoQamnCW981sYPNKX4w3n07WuWq2knVER51Gc5Y7j/PQkY1mforczzlua
         t/H+c1wmbpIVoX6Bl5WjQKy3UDWumv22J8txGIMAYH4lsxAfrdEG1MHKxyW/bwFcW7zZ
         efy0cilMUzI+bke3LuELpoNSzX/pjD9AzGa8J3eL4+ZJ71cGIaGJTZHiz6vDuBvvmh+K
         ke8VL+eBHQAXdnOf3n9/aReOaw4Gcw53UkMnkLEx+4bQ4skHqn86sfnagYJiX3E4LkGI
         1XX8pY+sAXDhetrHi/U9Ii22D8cbB7i6MWLDC4w1bZCkVsaIQBw5XMdIHwK1Mj8qx/cL
         oC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171813; x=1698776613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhPdOnDAT6+PH0Vz8+OhielyBKDSwn2hQuYPBjz8d74=;
        b=lo8My/i3dM1BohISdDig9ghmTzKgmvxbFK9NhNgP5G3s4GC1mdx4rOgUjnmKDU2gqo
         SZsbCm/a1uFvkxOJ291LLipp1un4gPdfIEku4edzm2sydO/pMljofQoFC0G7+NGfToPC
         ftJo6QYHEX5TGtLfw3uin8S+rXArPN6XSBt44jx94zU2qIHR1dlHsG1+FnN1dZI99h/K
         a6F4+KV0LiNDu8lv83D5VqrZOJhEAyUPobITc3mf+l+4molw4pJBJAHTSGJTkD84o8bp
         3ycPE+F91xhJ8bLyeor4KyAIUoCZTUutmIyIzq6HwIct7SDyajsQVtw1gso9pnT5+LuS
         1uvw==
X-Gm-Message-State: AOJu0Yxpg8rsdNyBalqxAQSc8lywHQiOdvcecba8tQNV3eERCQBh9egF
        m/zNlf5kOHVX0nwxnMZXvjTUBtIYsR3xkApdoQrY
X-Google-Smtp-Source: AGHT+IGYicwo5fgU8AO29MEj/Hqf7OL3O4Fu0oZpB1YjJyeL4usUQIL7t8AbMBYxOoSYtknsoEYzmYx0zZzWthpg+eM=
X-Received: by 2002:a25:b322:0:b0:d9b:4c61:26f1 with SMTP id
 l34-20020a25b322000000b00d9b4c6126f1mr12961292ybj.24.1698171812890; Tue, 24
 Oct 2023 11:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
In-Reply-To: <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Oct 2023 14:23:21 -0400
Message-ID: <CAHC9VhRxR3ygxskpfbukHeM5wmX0=SifvLny2eiezWvwAyB9tw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 24, 2023 at 1:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Oct 16, 2023 at 11:04=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:

...

> > v7->v8:
> >   - add bpf_token_allow_cmd and bpf_token_capable hooks (Paul);
> >   - inline bpf_token_alloc() into bpf_token_create() to prevent acciden=
tal
> >     divergence with security_bpf_token_create() hook (Paul);
>
> Hi Paul,
>
> I believe I addressed all the concerns you had in this revision. Can
> you please take a look and confirm that all things look good to you
> from LSM perspective? Thanks!

Yes, thanks for that, this patchset is near the top of my list, there
just happen to be a lot of things vying for my time at the moment.  My
apologies on the delay.

--=20
paul-moore.com
