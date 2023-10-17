Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66226CDB474
	for <linux-security-module@archiver.kernel.org>; Tue, 17 Oct 2023 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJQRc3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 Oct 2023 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRc2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Oct 2023 13:32:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49F98;
        Tue, 17 Oct 2023 10:32:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so10429185a12.0;
        Tue, 17 Oct 2023 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697563945; x=1698168745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pVb3nd+X8dVBnTnMAKO6K124VfixR+DKVbfHkqiwnQ=;
        b=kpqBWV6Y2C4+j3/+WERZFhFHVfpfo1fQxmuCujnQFISOJYD4Ff6dQjD+FSXAmn/bs6
         XPSUYrEAptNtaL7mWErHbeyngGp5oirArw3Haniqb4K5tVp8I6KkB1dol3LMCuLOPyMK
         isFORZQLgnD4OIVxnq2EsPYx/tPrUvP/b6asOhF1OeZk/TauQ97ZR9092VadcyZWmqgY
         lRjjL7D511YpX/+FBJ3nKeIWMe4duFWWezR0qEhLWJczcJR1vAuZosMgKGIOCGmN+JN4
         bzKtvUOLkuURYaW5eDsfQim37s/gopl4Jg2/sb6ISO2yvfwMTjl3K4D6dy6/7Jd74ECT
         XogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563945; x=1698168745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pVb3nd+X8dVBnTnMAKO6K124VfixR+DKVbfHkqiwnQ=;
        b=t2YDcTVZBhAu0SPV4/JKo6PE3hU0XWZyJpwF+l27vP389vwOGRtIQaB4ZDr4PB5kgy
         C3T6EVFi2uOCnOJrr8W+BQEdCSBpJOSo8wxj2BhXOnW/1UQMqxrSZu+HGyZ1nF2oU27d
         R4tJnjCyie3Sko2c0VFpMG5gXz7z4175LWAeTHGNMyPwGJyOomlzase0c4fagVl/RFeH
         OQmsqGfrNQldSVzdDqRGtesnT9ltncfHds8HBHKGIIQSaQs6SkXQviT9Clb+hW3Ndu0k
         z4Ht3RXVRpuSaWoFWVfmlCshZcAg8gsHnIO3yDkz8EfJBOlcFm5D9c6HTu1DWnFTugAG
         Kw8A==
X-Gm-Message-State: AOJu0YxJi1PFIf3Jwa6lsPSXQn7/PBPUn1czjEOVDtHoM/57Q3XNkWMS
        I58BEW57bC/0E8qD/eZK7Vhalw4jE2qTQi9Ycc8=
X-Google-Smtp-Source: AGHT+IEJFlx67yTO5zvCdPDh2En50wVFcfRoncVmwrd9zx9wYk80D7kZAhcK06adauwCd3qynz7L85kCUjn4EidmQ5Y=
X-Received: by 2002:a50:d09b:0:b0:53e:f4:ef85 with SMTP id v27-20020a50d09b000000b0053e00f4ef85mr2226865edd.10.1697563944308;
 Tue, 17 Oct 2023 10:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <20231016180220.3866105-18-andrii@kernel.org>
 <ZS5ptHMhvMAkB+Tb@krava>
In-Reply-To: <ZS5ptHMhvMAkB+Tb@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Oct 2023 10:32:12 -0700
Message-ID: <CAEf4BzZEoAAfb3BdDavAjHAsQSEsEOwHA7ELUMGqskinH19HTQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 17/18] selftests/bpf: add BPF token-enabled tests
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 17, 2023 at 4:02=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 16, 2023 at 11:02:19AM -0700, Andrii Nakryiko wrote:
> > Add a selftest that attempts to conceptually replicate intended BPF
> > token use cases inside user namespaced container.
> >
> > Child process is forked. It is then put into its own userns and mountns=
.
> > Child creates BPF FS context object and sets it up as desired. This
> > ensures child userns is captures as owning userns for this instance of
> > BPF FS.
> >
> > This context is passed back to privileged parent process through Unix
> > socket, where parent creates and mounts it as a detached mount. This
> > mount FD is passed back to the child to be used for BPF token creation,
> > which allows otherwise privileged BPF operations to succeed inside
> > userns.
> >
> > We validate that all of token-enabled privileged commands (BPF_BTF_LOAD=
,
> > BPF_MAP_CREATE, and BPF_PROG_LOAD) work as intended. They should only
> > succeed inside the userns if a) BPF token is provided with proper
> > allowed sets of commands and types; and b) namespaces CAP_BPF and other
> > privileges are set. Lacking a) or b) should lead to -EPERM failures.
> >
> > Based on suggested workflow by Christian Brauner ([0]).
> >
> >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef7=
85e@brauner/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../testing/selftests/bpf/prog_tests/token.c  | 629 ++++++++++++++++++
> >  1 file changed, 629 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/tes=
ting/selftests/bpf/prog_tests/token.c
> > new file mode 100644
> > index 000000000000..41cee6b4731e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> > @@ -0,0 +1,629 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > +#define _GNU_SOURCE
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +#include "cap_helpers.h"
> > +#include <fcntl.h>
> > +#include <sched.h>
> > +#include <signal.h>
> > +#include <unistd.h>
> > +#include <linux/filter.h>
> > +#include <linux/unistd.h>
> > +#include <sys/mount.h>
> > +#include <sys/socket.h>
> > +#include <sys/syscall.h>
> > +#include <sys/un.h>
> > +
> > +/* copied from include/uapi/linux/mount.h, as including it conflicts w=
ith
> > + * sys/mount.h include
> > + */
> > +enum fsconfig_command {
> > +     FSCONFIG_SET_FLAG       =3D 0,    /* Set parameter, supplying no =
value */
> > +     FSCONFIG_SET_STRING     =3D 1,    /* Set parameter, supplying a s=
tring value */
> > +     FSCONFIG_SET_BINARY     =3D 2,    /* Set parameter, supplying a b=
inary blob value */
> > +     FSCONFIG_SET_PATH       =3D 3,    /* Set parameter, supplying an =
object by path */
> > +     FSCONFIG_SET_PATH_EMPTY =3D 4,    /* Set parameter, supplying an =
object by (empty) path */
> > +     FSCONFIG_SET_FD         =3D 5,    /* Set parameter, supplying an =
object by fd */
> > +     FSCONFIG_CMD_CREATE     =3D 6,    /* Invoke superblock creation *=
/
> > +     FSCONFIG_CMD_RECONFIGURE =3D 7,   /* Invoke superblock reconfigur=
ation */
> > +};
>
> I'm getting compilation fail, because fsconfig_command seems to be
> included through the sys/mount.h include, but CI is green hum :-\
>
> when I get -E output I can see:
>
>         ...
>         # 16 "./cap_helpers.h"
>         int cap_enable_effective(__u64 caps, __u64 *old_caps);
>         int cap_disable_effective(__u64 caps, __u64 *old_caps);
>         # 7 "/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/pr=
og_tests/token.c" 2
>
>         # 1 "/usr/include/sys/mount.h" 1 3 4
>         # 27 "/usr/include/sys/mount.h" 3 4
>         # 1 "/usr/lib/gcc/x86_64-redhat-linux/13/include/stddef.h" 1 3 4
>         # 28 "/usr/include/sys/mount.h" 2 3 4
>
>         # 1 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/mount=
.h" 1 3 4
>         # 96 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/moun=
t.h" 3 4
>
>         # 96 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/moun=
t.h" 3 4
>         enum fsconfig_command {
>          FSCONFIG_SET_FLAG =3D 0,
>          FSCONFIG_SET_STRING =3D 1,
>          FSCONFIG_SET_BINARY =3D 2,
>          FSCONFIG_SET_PATH =3D 3,
>          FSCONFIG_SET_PATH_EMPTY =3D 4,
>          FSCONFIG_SET_FD =3D 5,
>          FSCONFIG_CMD_CREATE =3D 6,
>          FSCONFIG_CMD_RECONFIGURE =3D 7,
>         };
>
>
>         ...
>
>
>         # 21 "/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/p=
rog_tests/token.c"
>         enum fsconfig_command {
>          FSCONFIG_SET_FLAG =3D 0,
>          FSCONFIG_SET_STRING =3D 1,
>          FSCONFIG_SET_BINARY =3D 2,
>          FSCONFIG_SET_PATH =3D 3,
>          FSCONFIG_SET_PATH_EMPTY =3D 4,
>          FSCONFIG_SET_FD =3D 5,
>          FSCONFIG_CMD_CREATE =3D 6,
>          FSCONFIG_CMD_RECONFIGURE =3D 7,
>         };
>
>
> it's probably included through this bit in the /usr/include/sys/mount.h:
>
>         #ifdef __has_include
>         # if __has_include ("linux/mount.h")
>         #  include "linux/mount.h"
>         # endif
>         #endif
>
> which was added 'recently' in https://sourceware.org/git/?p=3Dglibc.git;a=
=3Dcommit;h=3D774058d72942249f71d74e7f2b639f77184160a6
>
> maybe you use older glibs headers? or perhaps it might be my build setup

No, I'm pretty sure I have older headers. I'd like this to work in
both environments, so I need to fix this. I'll try to make this work
with uapi header, I guess. Thanks for reporting!

>
> jirka
>

[...]
