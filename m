Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45EE7D0AA
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjIUV30 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjIUV3Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82FA75EB
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 14:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F960C433CD;
        Thu, 21 Sep 2023 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695330261;
        bh=NTY7su3N/P2WqqRzczFkl8JOvt37OHhVmbjZ8iNmugA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AU8T9OUxruM0ffekGAIqSrplEPdTc9AqH7s03iPvcKKsgq+5U+/jN2cJbvYq3LKde
         giClDisO36MuXCiAae9jGhCm+mQaPox0kxug6ekce7jmvep68xhZ95+duhwffYiMHU
         mBQJITs6ME68Jg5uuyDx2biRR+1nWUJxxHpB6bASRKjf0ID7GznTQTRIi4Nwp6eOzR
         O98sKlGLbiU5q5ihJ1VNJo6T5xsq03RcbBJ8XBoKjom+HR095WcpjsXPb8qqMrKqj/
         JLnckei++nxjmzLb3oqCKw1Y/UFZKwhUyWKFn4QFYzZcciQktUYPIjA/PHZPFGvtMX
         qsuGQ7Zn1r3hg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c008042211so24402731fa.2;
        Thu, 21 Sep 2023 14:04:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywfdj3vxLuJm/8CTnk47Sm4B4y9KcK8VCgX+rgNTpML0u2YnCDD
        CQDABanC6cTUQVK8gUyllZitqZ/+SSxGXYuqzJ4=
X-Google-Smtp-Source: AGHT+IGchco3KaA/oi5PITa7B6FkBv6AT1muk4ex3g3wUPXLcjswGOqkbSw748chLyeUbgzglZ5fELGDRKjZXgn2fMo=
X-Received: by 2002:a05:6512:34cd:b0:4fd:d64f:c0a6 with SMTP id
 w13-20020a05651234cd00b004fdd64fc0a6mr4947234lfr.48.1695330259689; Thu, 21
 Sep 2023 14:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-5-kpsingh@kernel.org>
In-Reply-To: <20230918212459.1937798-5-kpsingh@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 14:04:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW41NBzB0JRj=TGuNwqAZDXcxeOLrJC0xHsJnayRfVuF-w@mail.gmail.com>
Message-ID: <CAPhsuW41NBzB0JRj=TGuNwqAZDXcxeOLrJC0xHsJnayRfVuF-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 2:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
[...]
>    0xffffffff818f0e89 <+89>:    mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:    mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:    mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:    pop    %rbx
>    0xffffffff818f0e92 <+98>:    pop    %r14
>    0xffffffff818f0e94 <+100>:   pop    %rbp
>    0xffffffff818f0e95 <+101>:   ret
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>
