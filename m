Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80462CD5BB7
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Sep 2023 13:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjISNAO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjISNAN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Sep 2023 09:00:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BE123
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 06:00:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad810be221so744891566b.2
        for <linux-security-module@vger.kernel.org>; Tue, 19 Sep 2023 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695128405; x=1695733205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mCwVe8KpOpCfcH7OtboVsrBBV5wJbNiJa5LJSES+O00=;
        b=p+n/Pj6fr8fjEaTIQSufW8KDCkYxN9h54wJ18ZAKBy9HIKLLg5OJ4BRHlknSvJ7blX
         7O+tW+VEFciYb2CyqXoCxptMv82IocM3L4HfGjwtMNPJwGff+GPfGmEVcAJkMg6Uml5O
         2JpNMQwo6Mb1qDDuyEeet502BBgcWlF98418o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128405; x=1695733205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCwVe8KpOpCfcH7OtboVsrBBV5wJbNiJa5LJSES+O00=;
        b=jWheKeEuutFM6zHPLdpE5kvORazElxNj5fNoHM2nZ7sw8dtZkOKYknUhPXJlUxE59U
         D0vUmh3lNoeqYScDIkS63weQgX4hoXxBwDyH4sQaIkJctGk6uJTqkyJp4+5fqs8JpYz8
         HymJJ30YiSmO3H/i2Yywv64+1EjkWC8JTC2T6grOdf+8P+m4yuLsEfpnNiZFfLmJS/g+
         5DU9lQ75kLkez8Q9O99XliN2tKUyxr01qS5qjwhIkseMvg9XTqP1ADYmexVCgY/rnBRR
         WIUOoHmBaUgB1BOvq8ATccmkIgIuREvioyU2ekl4waiX9AAurN1lnjUYTTeSoU84jH8a
         Vezg==
X-Gm-Message-State: AOJu0YyedqJohhtjGcOf1XuoAp/e38XXkqmiEovwP38heILWWIDi9iqx
        Xe3YrSy4E48UO2eaeOIuKAzXbOThGnhSn5NH/fk0eA==
X-Google-Smtp-Source: AGHT+IHwoRikybyWt8+rL4a6pcU5rd0ZRZjLkNEDHmNUJ985g1YGHrlb2S1LF8RGk4U05TZ7H0Z04WQ8UuSIlqbUZuQ=
X-Received: by 2002:a17:906:519b:b0:9ad:e298:a5d with SMTP id
 y27-20020a170906519b00b009ade2980a5dmr10879940ejk.19.1695128405076; Tue, 19
 Sep 2023 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919-abfedern-halfen-c12583ff93ac@brauner> <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
 <20230919-hackordnung-asketisch-331907800aa0@brauner>
In-Reply-To: <20230919-hackordnung-asketisch-331907800aa0@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Sep 2023 14:59:53 +0200
Message-ID: <CAJfpeguv+Z6uys18_QYnHcbs_JpMNicRKGt50Scmp82kAOOFOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 19 Sept 2023 at 14:41, Christian Brauner <brauner@kernel.org> wrote:
>
> > >  with __u32 size for mnt_root and mnt_point
> >
> > Unnecessary if the strings are nul terminated.
>
> All ok by me so far but how does the kernel know the size of the buffer
> to copy into? Wouldn't it be better to allow userspace to specify that?
> I'm probably just missing something but I better ask.

Because size of the buffer is given as the syscall argument.

  long statmount(u64 mnt_id, u64 mask, struct statmnt __user *buf,
size_t bufsize, unsigned int flags);

If you are still hung up about this not being properly typed, how about this:

struct statmnt {
        __u64 mask;             /* What results were written [uncond] */
        __u32 sb_dev_major;     /* Device ID */
[...]
        __u64 fs_type;          /* [str] Filesystem type */
        __u64 __spare[49];
        char __string_buf[];
};

Such variable length structures are used all over the place, this
isn't some big invention.  The only new thing is that we set pointers
to within the tail part of the buffer, to make the interface work for
the multiple strings case.

Thanks,
Miklos
