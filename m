Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CDC88CB2
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jun 2023 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjFLOdh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjFLOdY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jun 2023 10:33:24 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CA2D6B;
        Mon, 12 Jun 2023 07:32:30 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-43b2c7d9b52so1108525137.3;
        Mon, 12 Jun 2023 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686580345; x=1689172345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GjAlexkK/LPJDcqg5PxGpC7NQi0Y5N1w3HwyDVEmMM=;
        b=pekOE2Z0Ow1FSrGncEFrNfHoC49MOdwwYPV5ikKYB7aNIxlSEMao1jwbz51S820U5r
         k1nBEH6Q7fhYaLQAFc8i6gIbfg3QqW6gGBZIoVI4KZJ7ymjtMET1dCcaSOVKrfze4dG+
         EfUhdTHvwlTU0AH2VSMJ41vbIzrbjylIF0+2sP8/WAhl+k66Vm5F12J/mSw1WRQXRlig
         d1eAyc7p1r3RTCJNLUxnySdov3EZttar/pyoxHwvMBHrZbSL0FL5EIxKBQ9RTrC91+G1
         ZwVsQJWsXyzHFL1B6Yq6o8jPul6TebMsZQuX2Yj+ovpAfNmjZiACiHztwbIKuSzETdxz
         UN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686580345; x=1689172345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GjAlexkK/LPJDcqg5PxGpC7NQi0Y5N1w3HwyDVEmMM=;
        b=RqUWqQQ7/2vPM/iK7ljM4gpOQnhQziUj2l4Sx6egsgsWqBiBmScabmTkx0Py7LdUoY
         lSv1B9Vd9yDOfyQ0tVcPae/e1pdKWg0GRYPyyFKjTce+AEGgfeAF/6Nquwn8ktXQoR4J
         GGPBFdZrsHGzYRj+0AThAWZ2iP4SbVo6t6PJWhLAsP9tznB/c3okS9nBeZEA4OzxhgP8
         6dqjRMLtkTGPfdI6NAObnBCwEmBq1eOzR1k2C1QpsLKdqMwtRKbpyDAEUbjp749d4Kr5
         XylxUR1F3k6jTofYJ3phkZrL8MJjF4iNDsr4JgCJ9FJW8vwPp1OhbSKdqMoXI1BLMQ8f
         v8fw==
X-Gm-Message-State: AC+VfDxqQeqJYK+5eCD0/J/NvQZPxk00FerJ2K2D6hb+eH0XV7Se+VsQ
        9wjnwOpOr2SAi9jNcSVosO8+5sWvlJiHlgALmFA=
X-Google-Smtp-Source: ACHHUZ6hZsvOqtQ1U34CdZxRSST0+YmSj9VUpNha1JZalPfHBi790GC1d1zytiz7euDI2tWQI7788PKLbkhg7fLrNWA=
X-Received: by 2002:a67:ff0c:0:b0:43b:5823:6664 with SMTP id
 v12-20020a67ff0c000000b0043b58236664mr3649895vsp.3.1686580344827; Mon, 12 Jun
 2023 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <CAEiveUdNrHfVXzF_6ogChifKyje3kA07pd8mpP+s24AEbKD7Cg@mail.gmail.com>
 <CAEf4BzaDDqfODPS9MM5twXiXdDCAMs2U2-XK+gGPuSpnGFh=pQ@mail.gmail.com> <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
In-Reply-To: <CAEiveUeDLr00SjyU=SMSc4XbHSA6LTn4U2DHr12760rbo5WqSw@mail.gmail.com>
From:   Djalal Harouni <tixxdz@gmail.com>
Date:   Mon, 12 Jun 2023 16:31:58 +0200
Message-ID: <CAEiveUeG7FZy3AdzKQC-VPiT1mxYJtwaV6pHSxr5-BYSnW+X1w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 2:02=E2=80=AFPM Djalal Harouni <tixxdz@gmail.com> w=
rote:
>
> On Sat, Jun 10, 2023 at 12:57=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
...
> > I'm not sure I understand the question. Unix domain socket
> > (specifically its SCM_RIGHTS ancillary message) allows to transfer
> > files between processes, which is one way to pass BPF object (like
> > prog/map/link, and now token). BPF FS is the other one. In practice
> > it's usually BPF FS, but there is no presumption about how file
> > reference is transferred.
>
> Got it.
>
> IIRC SCM_RIGHTS and SCM_CREDENTIALS are translated into the receiving
> userns, no ?
>
> I assume such which allows to set up things in a hierarchical way...
>
> If I set up the environment to lock things down the line, I find it
> strange if a received fd would allow me to do more things than what
> was planned when I created the environment: namespaces, mounts, etc
>
> I think you have to add the owning userns context to the fd or
> "token", and on the receiving part if the current userns is the same
> or a nested one of the current userns hierarchy then allow bpf
> operation, otherwise fail with -EACCESS or something similar...

Andrii to make it clear: the owning userns that is owner/creator of
the bpffs mount (better this one since you prevent the inherit fd and
do bad things with it cases...) lets call it userns A,  and the
receiving process is in userns B, so when transfering the fd if userns
B =3D=3D userns A or if A is an ancestor of B then allow to do things with
fd token, otherwise just deny it...

At least that's how I see things now, but maybe there are corner cases...
