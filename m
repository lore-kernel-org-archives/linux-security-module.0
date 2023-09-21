Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD45FE7D0A4
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 19:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjIUTCU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjIUTCH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD47B952
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:36:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B61C32776
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287593;
        bh=fvuvrEMuWsS5n+aGsOLqfaD8qATP5Zo1Pwy194y+UDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VFxR0Xm8lppYnQc2DtCt1zAm5qI6gc/hWD0XRDNpCZAs9ziVTFOyyXXkU+P2VHSyj
         iwm8MY2+VYo62YZOWN6PWor/JAy+6dMyJRdek7FmicgqySk3NnOSxj05b4e9byWw5S
         RRhJbKCq6x8QXpV0EuklENVbbc/9drRusGfcLg9Yqz3dAeseDAK+s98oZZCLjrmZxH
         OIJgt+zR5lkX0wGK+qXf//4XHKZSTCNm+5OU1knD8bK/ZATpSQrk8KBJAlkdruMt0g
         Obp26Jhtifq2XU1au7UIb4NNC0RgDBHL9z+t29rFlzNz0dLCFFRy5DWquyzbWrKiE7
         ITE5bZFmY9IIg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so1390707a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 02:13:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YygjbwyjyPlxx3KJYBFgSrhdF2riQv7K0RrhoBl0WWygEsxChPW
        AuY65VRQVpEeYhCAtNxLBKZnuRSQv4UOk0c0cXutmw==
X-Google-Smtp-Source: AGHT+IGZs/JgRQZYIsXmekaViv2Yqk40SAdhhYWpZYRBrN/Or5FrzsdIHPGeTx7ga8VqEmC31rT+zYyKvF9U0OGRTnw=
X-Received: by 2002:a05:6402:1205:b0:522:582c:f427 with SMTP id
 c5-20020a056402120500b00522582cf427mr7511577edw.14.1695287591558; Thu, 21 Sep
 2023 02:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-4-kpsingh@kernel.org>
 <202309200848.7099DFF1B@keescook>
In-Reply-To: <202309200848.7099DFF1B@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 21 Sep 2023 11:13:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7RvY7xpF0HjxR0nKFzGmuUyHD1A-Pc1-ChHy94tHbRjw@mail.gmail.com>
Message-ID: <CACYkzJ7RvY7xpF0HjxR0nKFzGmuUyHD1A-Pc1-ChHy94tHbRjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 20, 2023 at 5:54=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Sep 18, 2023 at 11:24:57PM +0200, KP Singh wrote:
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:
>
> I feel like the performance details in the cover letter should be
> repeated in this patch, since it's the one doing the heavy lifting.

Good point, added the results to the patch as well.

>
> > [...]
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Regardless, this is a nice improvement on execution time and one of the
> more complex cases for static calls.
>
> > -struct security_hook_heads {
> > -     #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> > -     #include "lsm_hook_defs.h"
> > +/*
> > + * @key: static call key as defined by STATIC_CALL_KEY
> > + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> > + * @hl: The security_hook_list as initialized by the owning LSM.
> > + * @active: Enabled when the static call has an LSM hook associated.
> > + */
> > +struct lsm_static_call {
> > +     struct static_call_key *key;
> > +     void *trampoline;
> > +     struct security_hook_list *hl;
> > +     /* this needs to be true or false based on what the key defaults =
to */
> > +     struct static_key_false *active;
> > +};
>
> Can this be marked __randomize_layout too?

Yes, done.

>
> Everything else looks good to me. I actually find the result more
> readable that before. But then I do love a good macro. :)

Yay!

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
