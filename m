Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21BC43334
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jun 2022 22:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiF3W0A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiF3WZ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jun 2022 18:25:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409B2CDF4
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 15:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9747B82C78
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 22:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A6FC341CD
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656627956;
        bh=tM0G24NVi0m2tyIVH7irgkid8Nrp64cFbylJfEA/+zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CZCTjvE/7FveJHL4CoZOgo+8fEQsJJd77t5GdpRF9vDEzm8VPuKqWrQPuxKoU1ytz
         reqJrEktB6AqatOXO7EhMXgJO1kkB6uVXq/f5jK+RJKUFZRDXlb/4hJ4nuY68ko2BT
         8ngEc07r2plRyWSi7eZ1Ceo6CqInLw6fMhIxZWis/xfvXJfLaI7juXCSmyOYUJUpf2
         10y4lKVaPqn25IgZRhetZdXFmoz+iR362fMnLUNvUDhkakpZ8madJlqJs/P5VtS6dj
         f+TYHZIVRCKxid4JwKJi1e9byZy2xAEGW0SCU0tJbaLw5K8N881ik3quRGHRtWHkyS
         cCaOFusKL+4Sg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-318889e6a2cso7459217b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 15:25:56 -0700 (PDT)
X-Gm-Message-State: AJIora9kWbNtHbrNsxIaCDA721kGNsZGML1AY5hWY1g0o2/0jDRI9Kco
        14okUE0hTLdb77QKygOGH0QKtyFfWoFhsSipEtbcng==
X-Google-Smtp-Source: AGRyM1uMVVdq3Kmug6m/pyl8us5tBZC8Vm2D0Q0eIOFcdR32jfJQiRpVxoYGfCem3o5Qs+AJWtypoXJlfzz8Tac/TAs=
X-Received: by 2002:a81:72d7:0:b0:317:917b:8a48 with SMTP id
 n206-20020a8172d7000000b00317917b8a48mr13524110ywc.495.1656627955534; Thu, 30
 Jun 2022 15:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein> <20220629095557.oet6u2hi7msit6ff@wittgenstein>
 <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein> <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
 <CAOQ4uxhKG7wDsh2qhtzcF7QYFRD51r500C9YKp2NrBPJtjphww@mail.gmail.com>
In-Reply-To: <CAOQ4uxhKG7wDsh2qhtzcF7QYFRD51r500C9YKp2NrBPJtjphww@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 1 Jul 2022 00:25:44 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6gZM5io54j+LcdyAiuK-pwOcwMaiknBhby+T_jG9cB0A@mail.gmail.com>
Message-ID: <CACYkzJ6gZM5io54j+LcdyAiuK-pwOcwMaiknBhby+T_jG9cB0A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jan Kara <jack@suse.cz>, Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 30, 2022 at 6:29 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >
> > > This discussion would probably be a lot shorter if this series were sent
> > > with a proper explanation of how this supposed to work and what it's
> > > used for.
> >
> > It's currently scoped to BPF LSM (albeit limited to LSM for now)
> > but it won't just be used in LSM programs but some (allow-listed)
> > tracing programs too.
> >
>
> KP,
>
> Without taking sides in the discussion about the security aspect of
> bpf_getxattr(),
> I wanted to say that we have plans to add BPF hooks for fanotify event
> filters and
> AFAIK Alessio's team is working on adding BPF hooks for FUSE bypass decisions.
>
> In both those cases, being able to tag files with some xattr and use
> that as part of
> criteria in the hook would be very useful IMO, but I don't think that
> it should be a
> problem to limit the scope of the allowed namespace to security.bpf.* for these
> use cases.

Thanks Amir, I agree, this does seem like a practical way to move forward.

Cheers,
- KP

>
> Thanks,
> Amir.
