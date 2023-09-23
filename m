Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E4CE7A88
	for <linux-security-module@archiver.kernel.org>; Sat, 23 Sep 2023 16:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIWQRM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 23 Sep 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjIWQRM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 23 Sep 2023 12:17:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FC92
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 09:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B42C433D9
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695485825;
        bh=sXwMHapT60zp7/X1EhptzXah30IxTwwQSFqTWPMJi9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXMf2z8dEUNLSHyiW+iopsnbI6UVPgQ5w624dJ8Fxdp+sPAVsVuqaKs095oIGR+Rm
         VoeE9lxJdahYLj4p6RSyq2eZD3OTsMihCW8uVHHV9YFsznIBbRmXPojGbNJO7dZKod
         0tvXz6SnWBzwh8qs0zvvfXmFGuH91AMgL58Z1Hxr8zf+5pD2IySFvggEqwvbejjnQ/
         pprb8bnYea5365/BNd5N/4Ynb5Jaq56SC7jXGMoNe0al3AKljYZsMwCQAVdR1bbJRl
         W78fRVRGqEoJucMd1X4M17o2qzliG9fSvxYKg3gTbv/eIt8Kx9MVXua6zUlL8DBYka
         R/Njqr0IhsMTw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso1025077a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 Sep 2023 09:17:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxnfeKrvd34c3/O0EIxcwmwM6WLG52svvMsVpE8B+xVM19cFdjc
        mKOCDqbOYzpsuGbMVoGWe81DSSEYL2z/rG3LKxhhMg==
X-Google-Smtp-Source: AGHT+IGMZUUCg0IdMgcHSdRNeWQItm39WLCzEbzcsffiN48vC1uee4g6T5rZ1FfyneM71wcpfcAN4BpHCtMJFNZOXcs=
X-Received: by 2002:aa7:df0b:0:b0:532:ec54:bfff with SMTP id
 c11-20020aa7df0b000000b00532ec54bfffmr2386943edy.16.1695485823423; Sat, 23
 Sep 2023 09:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922145505.4044003-1-kpsingh@kernel.org> <20230922184224.kx4jiejmtnvfrxrq@f>
In-Reply-To: <20230922184224.kx4jiejmtnvfrxrq@f>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 23 Sep 2023 18:16:52 +0200
X-Gmail-Original-Message-ID: <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
Message-ID: <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 8:42=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> > Since we know the address of the enabled LSM callbacks at compile time =
and only
> > the order is determined at boot time, the LSM framework can allocate st=
atic
> > calls for each of the possible LSM callbacks and these calls can be upd=
ated once
> > the order is determined at boot.
> >
>
> Any plans to further depessimize the state by not calling into these
> modules if not configured?
>
> For example Debian has a milipede:
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor=
,selinux,smack,tomoyo,bpf"
>
> Everything is enabled (but not configured).

If it's not configured, we won't generate static call slots and even
if they are in the CONFIG_LSM (or lsm=3D) they are simply ignored.

- KP

>
> In particular tomoyo is quite nasty, rolling with big memsets only to
> find it is not even enabled.
