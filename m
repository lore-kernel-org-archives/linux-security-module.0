Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC866CD37B0
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Sep 2023 00:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjIPA54 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbjIPA51 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Sep 2023 20:57:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90BA3
        for <linux-security-module@vger.kernel.org>; Fri, 15 Sep 2023 17:57:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC557C433CA
        for <linux-security-module@vger.kernel.org>; Sat, 16 Sep 2023 00:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694825839;
        bh=Ga+fi4Gy6AU/MYupajvx0TePB/WUzs/OP1+eut0Zc00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VAypbtTlYjx8R3lKqIUk2esZSRRbV9Q6uPO1tKBDpoNaHqqrUJQhjT6oyaThwWRK/
         vhzZhMLAxVfPDUqNZbsMlHa2/K1ASWv+EZIscgLVaWfbjaW4jQPPFjufynzCVmdkPI
         PGJHpfeTYBgs3oE+fjOnzV2l45reTWae54cbedOG5IsCgjKca0wXWIEmKTMYx4Qpj+
         Js2qGwE9jkP8PvoKbq4bWgEFW0WMP6NQ9xzYiG8qx3exi4QB4O8OPyw8sHxkynzMVR
         chSHa06W5yZRIv5YcBd8wAs00CPTJGX25e1k1wDmeuVKikJKd/9nzq4c7fusrXtnJF
         65hjHifHA7nBg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so5912855a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Sep 2023 17:57:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7iAEhaeKJBQftrDusq+RFsPTNsOgigPMnoGsCLyWgNOTtbNkK
        ODz4AqyPJLcYQ31eZ9N5U1gJkVaicIiPzDx+CcsDyQ==
X-Google-Smtp-Source: AGHT+IFTy7SlCGwO+siLInZ+tJhWrEb0/ogZK/CUqRl4QgMvH0PQl6ZhDO3AaS/WMkcIQLFmNVMv2vfnyNVrCL4Zf5o=
X-Received: by 2002:aa7:d34b:0:b0:523:37f0:2d12 with SMTP id
 m11-20020aa7d34b000000b0052337f02d12mr4759336edr.17.1694825838168; Fri, 15
 Sep 2023 17:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com> <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
 <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
 <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com> <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
In-Reply-To: <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 16 Sep 2023 02:57:07 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
Message-ID: <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 26, 2023 at 1:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi all,
>
> On Tue, 2023-06-20 at 19:40 -0400, Paul Moore wrote:
> > On Tue, Jun 13, 2023 at 6:03=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > I tried proposing an idea in
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.2=
026362-1-kpsingh@kernel.org/
> > >  as an LSM_HOOK_NO_EFFECT but that did not seemed to have stuck.
> >
> > It looks like this was posted about a month before I became
> > responsible for the LSM layer as a whole, and likely was lost (at
> > least on the LSM side of things) as a result.
> >
> > I would much rather see a standalone fix to address the unintended LSM
> > interactions, then the static call performance improvements in a
> > separate patchset.
>
> Please allow me to revive this old thread. I learned about this effort
> only recently and I'm interested into it.
>
> Looking at patch 4/4 from this series, it *think* it's doable to
> extract it from the series and make it work standalone. If so, would
> that approach be ok from a LSM point of view?

I will rev up the series again. I think it's worth fixing both issues
(performance and this side-effect). There are more users who have been
asking me for performance improvements for LSMs

>
> One thing that I personally don't understand in said patch is how the
> '__ro_after_init' annotation for the bpf_lsm_hooks fits the run-time
> 'default_state' changes?!?
>
> Cheers,
>
> Paolo
>
