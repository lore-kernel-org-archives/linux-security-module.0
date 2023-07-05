Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19AEB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjGEQAp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGEQAi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 12:00:38 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8D19BE
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 09:00:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579efc32377so46779407b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688572811; x=1691164811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb1GF7/QFy5DLYOoe3kcil6ESsrsreq6TCkS9MwOoaw=;
        b=Mz1utFwn7KVwoaC+nhwhg+E8n0bIozNEDOo1LzmGPiyFmD4is7pYhe1Jn1tuEEHyI6
         8DsQxVd2GEsHjBoOZyInJsfCPxbss9qx9VTkdy8qm4/cHkR1P8GNV1q98yQpZyMHHHQC
         ZbQVZwX54kOdLIa9Uw5G2bTBwYyUvV8LayD5GDnEojDBBlsvlDRsPQVHgpOC8avgDnpI
         e5k9Z/v4OR1jXEwvfVVaJZbQm8CEyjndtT+dIt54XzY9Cub1z1Z2DhxEFeNy24+/JLM+
         wUK/9pA/qsHmJia4dk1tPQ8O7j5vqIFF96hpv0jU8p6oc13ae45njwmLsN+AyYaLsVk0
         clnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572811; x=1691164811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb1GF7/QFy5DLYOoe3kcil6ESsrsreq6TCkS9MwOoaw=;
        b=FM/o57hAJ3uR65UT7dgRYKh28DR08jlB4zPwlhxuzGgSw4159qb0O8bA12kgmRdYbM
         /V97kI+dhQMmyeGJdM7tHKtNE/J/0BTUuu9Y+6eVfiaRzWkuMAkJ3loEvsa0KWv1DCD6
         IE1Xv4cTTn/fxeN/ucQL5gsTBQp+i3RILSCU6GmWLC/4UB1O0sZfUujjcfiviX7MNcAe
         enTzhjiILVBhDsqE0fSn1bkMJJp9UBZ9aayR370Qsi7YCzjFOrW+lPaMZvYsG3ywvAOC
         /CRrFtAd6wG9AbXaYtUIpLFr1EzmfzLtXDaKBanrbqZY4O/1XYfuF4GHqaanRLH+UMG2
         XxQg==
X-Gm-Message-State: ABy/qLZHzZCgOa/eq7WO8808PMyPiODhzfxpILS0YWXZFz1aRhW8K2cA
        32PK+GIfj/RbkFEm6ki5TR/vx4nN8cP+dWoZRiC9ajkpQMGEN04=
X-Google-Smtp-Source: APBJJlGhXDS/0EzVNGCoiJVcvbujQTAbAR64Dm89krmLzUStttkQhJYfcAsgf7DVM+GiQVhB7wTHpgDQ6Ufi5mKn094=
X-Received: by 2002:a25:48b:0:b0:c3a:d19c:4ad7 with SMTP id
 133-20020a25048b000000b00c3ad19c4ad7mr13917131ybe.62.1688572811037; Wed, 05
 Jul 2023 09:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
In-Reply-To: <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 12:00:00 -0400
Message-ID: <CAHC9VhTHjR_auRtOa_oOMd317g=2iFLamssX28AXz+UnyCqpNQ@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 10:42=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Jul 05, 2023 at 10:16:13AM -0400, Paul Moore wrote:
> > On Tue, Jul 4, 2023 at 8:44=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > > On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant to=
 to
> > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > program or creating a BPF map, from privileged process to a *truste=
d*
> > > > unprivileged process, all while have a good amount of control over =
which
> > > > privileged operations could be performed using provided BPF token.
> > > >
> > > > This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, whic=
h
> > > > allows to create a new BPF token object along with a set of allowed
> > > > commands that such BPF token allows to unprivileged applications.
> > > > Currently only BPF_TOKEN_CREATE command itself can be
> > > > delegated, but other patches gradually add ability to delegate
> > > > BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> > > >
> > > > The above means that new BPF tokens can be created using existing B=
PF
> > > > token, if original privileged creator allowed BPF_TOKEN_CREATE comm=
and.
> > > > New derived BPF token cannot be more powerful than the original BPF
> > > > token.
> > > >
> > > > Importantly, BPF token is automatically pinned at the specified loc=
ation
> > > > inside an instance of BPF FS and cannot be repinned using BPF_OBJ_P=
IN
> > > > command, unlike BPF prog/map/btf/link. This provides more control o=
ver
> > > > unintended sharing of BPF tokens through pinning it in another BPF =
FS
> > > > instances.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > The main issue I have with the token approach is that it is a complet=
ely
> > > separate delegation vector on top of user namespaces. We mentioned th=
is
> > > duringthe conf and this was brought up on the thread here again as we=
ll.
> > > Imho, that's a problem both security-wise and complexity-wise.
> > >
> > > It's not great if each subsystem gets its own custom delegation
> > > mechanism. This imposes such a taxing complexity on both kernel- and
> > > userspace that it will quickly become a huge liability. So I would
> > > really strongly encourage you to explore another direction.
> > >
> > > I do think the spirit of your proposal is workable and that it can
> > > mostly be kept in tact.
> > >
> > > As mentioned before, bpffs has all the means to be taught delegation:
> > >
> > >         // In container's user namespace
> > >         fd_fs =3D fsopen("bpffs");
> > >
> > >         // Delegating task in host userns (systemd-bpfd whatever you =
want)
> > >         ret =3D fsconfig(fd_fs, FSCONFIG_SET_FLAG, "delegate", ...);
> > >
> > >         // In container's user namespace
> > >         fd_mnt =3D fsmount(fd_fs, 0);
> > >
> > >         ret =3D move_mount(fd_fs, "", -EBADF, "/my/fav/location", MOV=
E_MOUNT_F_EMPTY_PATH)
> > >
> > > Roughly, this would mean:
> > >
> > > (i) raise FS_USERNS_MOUNT on bpffs but guard it behind the "delegate"
> > >     mount option. IOW, it's only possibly to mount bpffs as an
> > >     unprivileged user if a delegating process like systemd-bpfd with
> > >     system-level privileges has marked it as delegatable.
> > > (ii) add fine-grained delegation options that you want this
> > >      bpffs instance to allow via new mount options. Idk,
> > >
> > >      // allow usage of foo
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "foo");
> > >
> > >      // also allow usage of bar
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "bar");
> > >
> > >      // reset allowed options
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "");
> > >
> > >      // allow usage of schmoo
> > >      fsconfig(fd_fs, FSCONFIG_SET_STRING, "abilities", "schmoo");
> > >
> > > This all seems more intuitive and integrates with user and mount
> > > namespaces of the container. This can also work for restricting
> > > non-userns bpf instances fwiw. You can also share instances via
> > > bind-mount and so on. The userns of the bpffs instance can also be us=
ed
> > > for permission checking provided a given functionality has been
> > > delegated by e.g., systemd-bpfd or whatever.
> >
> > I have no arguments against any of the above, and would prefer to see
> > something like this over a token-based mechanism.  However we do want
> > to make sure we have the proper LSM control points for either approach
> > so that admins who rely on LSM-based security policies can manage
> > delegation via their policies.
> >
> > Using the fsconfig() approach described by Christian above, I believe
> > we should have the necessary hooks already in
> > security_fs_context_parse_param() and security_sb_mnt_opts() but I'm
> > basing that on a quick look this morning, some additional checking
> > would need to be done.
>
> I think what I outlined is even unnecessarily complicated. You don't
> need that pointless "delegate" mount option at all actually. Permission
> to delegate shouldn't be checked when the mount option is set. The
> permissions should be checked when the superblock is created.

From a LSM perspective I think we would want to have policy
enforcement points both when task A enables delegation and when task B
makes use of the delegation.  We would likely also want to be able to
add some additional delegation state to the superblock if delegation
was enabled in the first enforcement point.

I'm not too bothered by how that ends up looking from a userspace
perspective, but it seems like requiring an explicit "this fs can be
delegated" step would be a positive from a security perspective.  In
other words, just because a task *could* delegated a filesystem, may
not mean it *wants* to delegate a filesystem.

--=20
paul-moore.com
