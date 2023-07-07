Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFCCEB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGGVla (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 17:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGVl3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 17:41:29 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333971FC6
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 14:41:28 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-577497ec6c6so30401297b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jul 2023 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688766087; x=1691358087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCywU0D+3/mC/orLi42y2aa5cBZXMD/FTQ4gowI46nM=;
        b=a2sk5p94/kFl0oqnkX3NMRFsMBpOJbTY7UsHRKrhAxUCXR+r7VUAmWTw0aJdb7h9Cs
         Yt31MTDWraHPL6T+sKud+hO1BcTI5bgF0WFJ8ZSqozD5bIP3iC7ORHqwCw4RUhy+ppgQ
         PTeswAPyAke0CQfdG9qx/+JHqdKlvVclwBrN4H8mibRGw8NWbnuaVo4uBi2ONHsIh4At
         wsDhJQMwOMoomDL19Bh/fDKUG8zoCV7wEB7+acMAWAKDi7h155KFWT57KmWybcLF2Xkx
         lOxsqiROcOxKxGinKs6zM2vE9L5DV8DI8lxN4QarQek7lnJKqB8slqBWCof4jyA0RA9k
         WNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766087; x=1691358087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCywU0D+3/mC/orLi42y2aa5cBZXMD/FTQ4gowI46nM=;
        b=I7L45CsUNROzfoS8CNF6ZlsZQoS+KdmiqdNkdohacr/rQRfuY3+b9smAnBrWP2E52c
         snuyekYbD+CgfNIabITjgZYSrZva319YPEoFvE7Jz710xzXoYw82KwRVaA0eZCjQ/GHs
         Z7CHymxwHP9YEkIe3xwC3z++zvx14RoU8fqxk2CueRgOeriv8AZ9CAeMPDIlzrf7CbtM
         YH6XRmT4JxFIWZp8KyGfNwYXcRDh1aZzsGHULs9yRO7ot4uyBmSTYnsPIB5LaaEIg8xb
         pOxrzXJyXVfEfKaWZucLmH1VieKQl5/8PBNBqPq5G3ni80g9yM3Kbz7oJWyV3XGFk3yz
         FVOQ==
X-Gm-Message-State: ABy/qLZZ1AMEWxK65u5J0cJ0LY+m8JQKcU/NWVX6NgZPF5bAlIhZrSxi
        Z81EoW2V/Xp0tuNHW9qpbiKZbwxjhbLOVZEAEqtx
X-Google-Smtp-Source: APBJJlHntFJxotx6kBkXZQxAWiMdse0HK71N+MZEcjHya9Ljm9o6gCDknzyxawV5xGhhEhQnhsXWqTKYLUY9MXdN3nE=
X-Received: by 2002:a0d:d5c7:0:b0:579:ecfd:bb90 with SMTP id
 x190-20020a0dd5c7000000b00579ecfdbb90mr6441876ywd.1.1688766087341; Fri, 07
 Jul 2023 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
In-Reply-To: <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 17:41:16 -0400
Message-ID: <CAHC9VhQeBomz1T5EUkdy_qKp9TbHDM=GSRqid9xqWGPeNGk82w@mail.gmail.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process
 on Host
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Leesoo Ahn <lsahn@wewakecorp.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 7, 2023 at 12:50=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/7/2023 7:20 AM, Paul Moore wrote:

...

> > What you are looking for is a combination of LSM stacking and
> > individual LSM namespacing.  Sadly, I think the communications around
> > LSM stacking have not been very clear on this and I worry that many
> > people are going to be disappointed with LSM stacking for this very
> > reason.
>
> There have been many discussions regarding the viability of the using
> different LSM policies in containers. Some of these discussions have
> been quite lively. I have never claimed that LSM stacking addresses
> all of the possible use cases for multiple concurrent LSMs. If people
> are disappointed by how little they can accomplish with what is currently
> being proposed I can only say that we can't get on to the next phase
> until this work is complete.

The issue of namespacing LSMs is independent of stacking.

> > While stacking of LSMs is largely done at the LSM layer, namespacing
> > LSMs such that they can be customized for individual containers
> > requires work to be done at the per-LSM level as each LSM is
> > different.  AppArmor already has a namespacing concept, but SELinux
> > does not.  Due to differences in the approach taken by the two LSMs,
> > namespacing is much more of a challenge for SELinux, largely due to
> > issues around filesystem labeling.  We have not given up on the idea,
> > but we have yet to arrive at a viable solution for namespacing
> > SELinux.
>
> I remain more optimistic than Paul about the options for supporting
> generic LSM namespacing. I hope to explore a couple notions that I
> have more fully, but as they depend on the current stacking work I
> may not get to them very soon.

I remain unconvinced that namespacing should be done at the LSM layer;
my opinion is that namespacing should be handled individually by the
LSMs.  Just as there is no single security model across LSMs, I don't
believe there should be a single approach to namespacing.

> > If you are interested in stacking SELinux and AppArmor, I believe the
> > only practical solution is to run SELinux on the host system (initial
> > namespace) and run AppArmor in the containers.  Even in a world where
> > SELinux is fully namespaced, it would likely still be necessary to run
> > some type of SELinux policy on the host (initial namespace) in order
> > to support SELinux policies in the containers.
>
> SELinux policy is sufficiently flexible to support what would look like
> different policies on the host system and in the container. I think that
> the administration of such a system would be tricky, and the policy would
> be very complex, but it could be done, for some use cases at least.

The concept of loading a separate SELinux policy into a container, and
having that policy apply only to that container, is not currently
possible.  Of course there are ways to introduce additional security
domains within the container with SELinux, but that requires
cooperation between the container and the host.  There are also
several different approaches available today for isolating containers
with SELinux, which tends to fit very well with most container
workloads, but I get the impression that is not what Leesoo is
interested in at the moment.

--=20
paul-moore.com
