Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DEC0015E
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 14:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGEOQ1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEOQ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 10:16:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E98010D5
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 07:16:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bff89873d34so6327296276.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688566584; x=1691158584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9hFKVuqjYzOELfxVX56G6dQ5WojeERU54T66aTbWrw=;
        b=U/Cdb4OwdawiWija2NBsOfjV99LLllf+s/VTHGdd5TlcBtiE3yXYY/EllIiTxHEmTH
         fxwRbaKGMcPAWZubuEm3KPjsv81IfMAhp/dJ61LeqUbbOgOM4cWGfdF9lugHN2qNCJ8t
         lDOcX7Y832ZTBHswEcyl8lUor2gYNgRs7CCD11tWP1wzf1yLRG+9LGHLIbMclP/+Ytu1
         niuCfC7sciAD/NFlt18+Bjdc+dWb5WzqIJRC8BtVgAlVhIAbHUtRcr65pa8PHt8aLgDw
         2Yo3T4+zShnW7RNNaJ2TSp+4xHsnU1xderKkTnZy3lO7yWoVRpMJPctsNz2Wy8LA43YH
         cmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566584; x=1691158584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9hFKVuqjYzOELfxVX56G6dQ5WojeERU54T66aTbWrw=;
        b=k6SQ3x+cJF16h9kWHtr4y9Gua66e5doV5CTnVeIOHKeQ22TSIt1v3utC6Ksqzww6uw
         Qe/63iyDqVk/atTtG7E3QydRV4+eVliVOawQj5urcNDB00jbdwEPd/H3jABsxAFqSwF8
         tkxmBCbtb59YeWldfWSM9JeJxs06TgB+vZ3GR3TT5tPAvaqjexKBCU3qftVXpD2rf8Ke
         /zxv5VZbqXkkLpumeXbCTSHRaIezY8I0/CkynQ/KBaERQe/USiR/0icWZcsPfPoqq5vR
         zVtFAzCFAzVo+bnQozIwgs0wiCmxVVzVP0PHILarUNp/ux5iVpvjJlpcmlTF8ZS0COeD
         TYDA==
X-Gm-Message-State: ABy/qLbs+2p7u8BJd/881QOt0SdDTnXv/t8WJpxNKxj7tRkKcFkoZGeL
        goXFgKHqqDZtUNBA/CVgqnRccV66VmZsrOwEXU3w
X-Google-Smtp-Source: APBJJlFBTkEy2ekUdbdG9ybzNh5X1RLcuYQIh/1Rpb3EgvtsiVv86w9iSwDV+PtSq/di2W2SlfJvs9Md/PLTe3DhnYs=
X-Received: by 2002:a25:a148:0:b0:c0f:c120:1a9b with SMTP id
 z66-20020a25a148000000b00c0fc1201a9bmr13988970ybh.53.1688566584225; Wed, 05
 Jul 2023 07:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
In-Reply-To: <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 10:16:13 -0400
Message-ID: <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 4, 2023 at 8:44=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over whic=
h
> > privileged operations could be performed using provided BPF token.
> >
> > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> > allows to create a new BPF token object along with a set of allowed
> > commands that such BPF token allows to unprivileged applications.
> > Currently only BPF_TOKEN_CREATE command itself can be
> > delegated, but other patches gradually add ability to delegate
> > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> >
> > The above means that new BPF tokens can be created using existing BPF
> > token, if original privileged creator allowed BPF_TOKEN_CREATE command.
> > New derived BPF token cannot be more powerful than the original BPF
> > token.
> >
> > Importantly, BPF token is automatically pinned at the specified locatio=
n
> > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
> > command, unlike BPF prog/map/btf/link. This provides more control over
> > unintended sharing of BPF tokens through pinning it in another BPF FS
> > instances.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> The main issue I have with the token approach is that it is a completely
> separate delegation vector on top of user namespaces. We mentioned this
> duringthe conf and this was brought up on the thread here again as well.
> Imho, that's a problem both security-wise and complexity-wise.
>
> It's not great if each subsystem gets its own custom delegation
> mechanism. This imposes such a taxing complexity on both kernel- and
> userspace that it will quickly become a huge liability. So I would
> really strongly encourage you to explore another direction.
>
> I do think the spirit of your proposal is workable and that it can
> mostly be kept in tact.
>
> As mentioned before, bpffs has all the means to be taught delegation:
>
>         // In container's user namespace
>         fd_fs =3D fsopen("bpffs");
>
>         // Delegating task in host userns (systemd-bpfd whatever you want=
)
>         ret =3D fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);
>
>         // In container's user namespace
>         fd_mnt =3D fsmount(fd_fs, 0);
>
>         ret =3D move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOVE_MO=
UNT_F_EMPTY_PATH)
>
> Roughly, this would mean:
>
> (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
>     mount option. IOW, it's only possibly to mount bpffs as an
>     unprivileged user if a delegating process like systemd-bpfd with
>     system-level privileges has marked it as delegatable.
> (ii) add fine-grained delegation options that you want this
>      bpffs instance to allow via new mount options. Idk,
>
>      // allow usage of foo
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
>
>      // also allow usage of bar
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
>
>      // reset allowed options
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
>
>      // allow usage of schmoo
>      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");
>
> This all seems more intuitive and integrates with user and mount
> namespaces of the container. This can also work for restricting
> non-userns bpf instances fwiw. You can also share instances via
> bind-mount and so on. The userns of the bpffs instance can also be used
> for permission checking provided a given functionality has been
> delegated by e.g., systemd-bpfd or whatever.

I have no arguments against any of the above, and would prefer to see
something like this over a token-based mechanism.  However we do want
to make sure we have the proper LSM control points for either approach
so that admins who rely on LSM-based security policies can manage
delegation via their policies.

Using the fsconfig() approach described by Christian above, I believe
we should have the necessary hooks already in
security_fs_context_parse_param() and security_sb_mnt_opts() but I'm
basing that on a quick look this morning, some additional checking
would need to be done.

--=20
paul-moore.com
