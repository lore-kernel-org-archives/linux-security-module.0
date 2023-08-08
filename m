Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8998CC001B0
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjHHRqi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjHHRpj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949009009
        for <linux-security-module@vger.kernel.org>; Tue,  8 Aug 2023 09:20:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc9c01e154so12200a34.0
        for <linux-security-module@vger.kernel.org>; Tue, 08 Aug 2023 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691511611; x=1692116411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtPBjD5nO4Kh7oz9+OPpfIl2AMkC3z5v5j8dstfO/Ys=;
        b=ICyi5gqQ+n4U5vz+WigjnO7KgXZRFJ99oFlrZEzUqvja5GyH7goSLi4NsW4tiNgctW
         1bX5hHWgc5BXxZHcvMKB/LdCxXWUNFLyICWwmrm5SZyvKGpeXAnhyqvBaglbq+RDk97q
         4qiPt72a4v4TvPBm1LHesLAhfSo766d7Us9VoDGlshRfz6qz9RvPjWesVu1qdQPKcXmG
         zkAfmkwy9pCitjxIa+b3We2Eer5WkcklAYKp/afIvyj/1PTjbAPBn3/UBe9tmKP6SPxP
         sK3am//SYoUq2aA4OWFN6gKfbD0J4Z3x42bP/trjOaNwb59q3vuf352USbJJu/R1Mitj
         2AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511611; x=1692116411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtPBjD5nO4Kh7oz9+OPpfIl2AMkC3z5v5j8dstfO/Ys=;
        b=P8fhNiX0vadTi8pvzAX4MDg92+/LfsD6cku1OJEnKRYJv5iY1Wpc+8/3Y0LMkrDdFw
         fK4Un7D/xtp//p8wmQgyw1bgc+qysaKICOOfh1bmv1jr25Dp9C51tQSERSE/+TL1wBvi
         p8b+Rw+UB6CbgwFsVfsMWYnEPiY7ZFVEKZMcWSfM4NjhMey3Y49KhcMMujdc0XHnCdru
         rmFsS6bcS0SU+ZxZcAWhal8bI1aQSlO5HRyK6o6NT6Gjxsfiehntlv2xQgchBJ7wEsj5
         DKjscn0ozWOKExPnYCAjwh8fPMSxvPzqEx3n/vCM4mGf6N5nYUqLrCPZq5jcTisJ+SNb
         FZyQ==
X-Gm-Message-State: AOJu0Yxrvomi/MqNXNQIXn1S0imtgUNO62wTpYJu92frGusCwCrnRCpV
        OQV7f84/LzsLSFR2QgxK+kehJuQiUiUYpg9wsoEDsnnFVbtmOYTudg==
X-Google-Smtp-Source: AGHT+IF/JRz4aZIQWa2WepnDOzwFFd1ZxEtS4bEAC0j0D3rdTiHKJrP+/acga61+52VOdNPg2Otbk0y2AdC2UR4pjsU=
X-Received: by 2002:a81:8381:0:b0:586:a680:250 with SMTP id
 t123-20020a818381000000b00586a6800250mr15902ywf.5.1691505182583; Tue, 08 Aug
 2023 07:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com> <20230806171622.GA17655@wind.enjellic.com>
 <CAHC9VhRDcJTMpzeWsNHbhkJEk0Vsj+zH_utTgmfzK6Teqzn81Q@mail.gmail.com> <20230808064014.GA31533@wind.enjellic.com>
In-Reply-To: <20230808064014.GA31533@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Aug 2023 10:32:51 -0400
Message-ID: <CAHC9VhRy0=N+kJ8QETgQv8nkyA6_B+7t9QFiQCxC8MFU7A_E=Q@mail.gmail.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Leesoo Ahn <lsahn@wewakecorp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 8, 2023 at 2:41=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Sun, Aug 06, 2023 at 03:25:32PM -0400, Paul Moore wrote:
> > On Sun, Aug 6, 2023 at 1:16???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Fri, Jul 28, 2023 at 10:54:23AM +0900, Leesoo Ahn wrote:
> > > > 2023-07-07 ?????? 11:20??? Paul Moore ???(???) ??? ???:
> > > > >On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com>=
 wrote:
> > > >
> > > > [...]
> > > >
> > > > >
> > > > >What you are looking for is a combination of LSM stacking and
> > > > >individual LSM namespacing. Sadly, I think the communications arou=
nd
> > > > >LSM stacking have not been very clear on this and I worry that man=
y
> > > > >people are going to be disappointed with LSM stacking for this ver=
y
> > > > >reason.
> > > > >
> > > > >While stacking of LSMs is largely done at the LSM layer, namespaci=
ng
> > > > >LSMs such that they can be customized for individual containers
> > > > >requires work to be done at the per-LSM level as each LSM is
> > > > >different. AppArmor already has a namespacing concept, but SELinux
> > > > >does not. Due to differences in the approach taken by the two LSMs=
,
> > > > >namespacing is much more of a challenge for SELinux, largely due t=
o
> > > > >issues around filesystem labeling. We have not given up on the ide=
a,
> > > > >but we have yet to arrive at a viable solution for namespacing
> > > > >SELinux.
> > > > >
> > > > >If you are interested in stacking SELinux and AppArmor, I believe =
the
> > > > >only practical solution is to run SELinux on the host system (init=
ial
> > > > >namespace) and run AppArmor in the containers.
> > >
> > > > Paul, I don't get that SELinux on the host system and run AppArmor
> > > > in the containers is the only practical solution. Could you please
> > > > explain that in more details?
> > >
> > > It appears that Paul is extremely busy, so I thought the 'Quixote
> > > Group' would try and offer some reflections that may help with your
> > > efforts.
>
> > My apologies, yes I am rather busy at the moment, but I also stopped
> > following this thread a while ago as it didn't seem to be going
> > anywhere meaningful.  I happen to read this last email while I'm
> > waiting in an airport, so let me try and provide a quick explanation
> > about why running SELinux only in a container is a bad idea.
> >
> > As you probably know, the Linux kernel has no concept of a container,
> > it only supports subsystem specific namespaces, e.g. mount namespace,
> > network namespace, etc.  SELinux does not provide a subsystem
> > namespace, and it does not generally concern itself with other
> > subsystem names.  From a SELinux perspective there is no difference
> > between a process running in the host namespace or a
> > container/namespace; both are treated the same with access control
> > decisions made based on the processes' SELinux domain, the type of the
> > target resource, and the access requested.
> >
> > If one were to load a SELinux policy inside a container, even if it
> > were allowed, the system would likely behave in unexpected ways as the
> > container-loaded policy will take effect across the entire system, not
> > just inside the container.
>
> All reasonable and consistent, with what we had previously written
> with respect to there being no notion of LSM namespacing.
>
> To further assist Leesoo and others who may be following this, you had
> suggested the following earlier in this thread:
>
> Paul> If you are interested in stacking SELinux and AppArmor, I
> Paul> believe the only practical solution is to run SELinux on the
> Paul> host system (initial namespace) and run AppArmor in the
> Paul> containers.
>
> Which would seem to apply that in a 'stacked' LSM configuration of
> SELinux and AppArmor, there would be a possibility of using the two
> LSM's without them 'colliding', the equivalent of what could be
> considered a 'nested' LSM implementation.

SELinux applies access control across the entire system, regardless of
what namespaces may be configured on the system.  Loading a SELinux
policy in the host/initial-namespace during early boot helps ensure
proper labeling of system entities and a better user experience;
loading a SELinux policy in a container/namespace can lead to
surprising and unpredictable results across the whole of the system.
AppArmor is different in that it has support for
containers/namespaces.  Running SELinux on the host and AppArmor in a
container isn't so much about preventing collisions, they are still
simultaneously running and applying their security policies, it is
more about ensuring the LSMs, the admins, and the users all see
compatible views of the system.

Please do not confuse any of the above as a 'nested' or namespaced LSM
layer; the current in-progress LSM stacking is simply that: the
ability to stack some combination of LSMs in a few prescribed
configurations.  Talking about 'nesting' or 'namespacing' at the LSM
layer is confusing at best, and misleading at the worst.

--=20
paul-moore.com
