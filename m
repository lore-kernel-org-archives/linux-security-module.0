Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D449C0015E
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Aug 2023 19:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjHFTZq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Aug 2023 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFTZq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Aug 2023 15:25:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890521712
        for <linux-security-module@vger.kernel.org>; Sun,  6 Aug 2023 12:25:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583b3aa4f41so41765417b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 06 Aug 2023 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691349943; x=1691954743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gliq7oie3LEOPmQqP9ycvn/fUioyPMBESEqrI1hklI=;
        b=XsFxGX3idnkDAfHP/F7EAYS7Mk3JswB8rCovNtfTfC6A3fjQ5TAyQmE+7pMTQfG6/t
         XTHSEQJWi3JAh4Clf4CFDxvrD9zLx5cAurpobni/pju+iHNIfST0/jPAkY8U2aj81DD8
         9dHJnk8WSAPZYiGPZGCxJ5OKmGpWQiag8cr03Iuv2AeDhPQl9Nj7B5Pp4bHbqiZBbTVw
         pAfj99cOor/KX/AIShEdEQjeH0KzypdApXMObO8HbSKIjV4JUa4zOouBrQP1cMvEfkK8
         B8iD1uqZsvJBfIWLeADlb1llgqcdyBbxVZBmVPgNNWE3YDHwJMqox5rrXFOvoVZOsiX2
         iIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691349944; x=1691954744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gliq7oie3LEOPmQqP9ycvn/fUioyPMBESEqrI1hklI=;
        b=HTXBrKfUqRXswzafu+jyaGy395mXO1DigAjxGvAUrSOKY+I9xkRGjO+j9u4Is0Ucn2
         9qW+HmTSTTKn/beO6hFMa1nc52g5w6/UYLFpWXRxCDWoVVFBObsaYaLUMr3XY2uw2AEq
         TQ6Xa1BCexhb0F6tMfJzocVQk64T9oqtvwJ7S4jnfJb/fqPKgt0VFEYyFv629V+EdQxZ
         wdxzWcUP6vfbY/Se77bUntZLG8/1MvHuookQpBqoUKihk4MB/UTpaqGy8X+MTnxV/Liq
         n4/r93hldY0uavWUY99j0pOk2fCjfVkMjJOhye54rXyqvpBm35FF3XnHPc44LPLCG6P6
         98Yw==
X-Gm-Message-State: AOJu0YyjwKWq+eQZWdIQazdt5UfrSYG8RS2bglqZOhSByDOwwXGig5Wx
        CnUq/RyneCZhLAIIUz5h/qQawZi2H2Y3VNpnVN+xh5zMK2StLc5Row==
X-Google-Smtp-Source: AGHT+IGfmZ+q0ZdXGLqgRShSBOF3a1wM37YOW2g03Yp7OEYhTKUBkF621ga8bqepdH7oN4Icn615vwZwYdE0qYrgGgw=
X-Received: by 2002:a81:720a:0:b0:576:d65d:2802 with SMTP id
 n10-20020a81720a000000b00576d65d2802mr8131275ywc.3.1691349943726; Sun, 06 Aug
 2023 12:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com> <20230806171622.GA17655@wind.enjellic.com>
In-Reply-To: <20230806171622.GA17655@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 6 Aug 2023 15:25:32 -0400
Message-ID: <CAHC9VhRDcJTMpzeWsNHbhkJEk0Vsj+zH_utTgmfzK6Teqzn81Q@mail.gmail.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a
 processon Host
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        "Dr. Greg" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Aug 6, 2023 at 1:16=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Fri, Jul 28, 2023 at 10:54:23AM +0900, Leesoo Ahn wrote:
> > 2023-07-07 ?????? 11:20??? Paul Moore ???(???) ??? ???:
> > >On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wro=
te:
> >
> > [...]
> >
> > >
> > >What you are looking for is a combination of LSM stacking and
> > >individual LSM namespacing. Sadly, I think the communications around
> > >LSM stacking have not been very clear on this and I worry that many
> > >people are going to be disappointed with LSM stacking for this very
> > >reason.
> > >
> > >While stacking of LSMs is largely done at the LSM layer, namespacing
> > >LSMs such that they can be customized for individual containers
> > >requires work to be done at the per-LSM level as each LSM is
> > >different. AppArmor already has a namespacing concept, but SELinux
> > >does not. Due to differences in the approach taken by the two LSMs,
> > >namespacing is much more of a challenge for SELinux, largely due to
> > >issues around filesystem labeling. We have not given up on the idea,
> > >but we have yet to arrive at a viable solution for namespacing
> > >SELinux.
> > >
> > >If you are interested in stacking SELinux and AppArmor, I believe the
> > >only practical solution is to run SELinux on the host system (initial
> > >namespace) and run AppArmor in the containers.
>
> > Paul, I don't get that SELinux on the host system and run AppArmor
> > in the containers is the only practical solution. Could you please
> > explain that in more details?
>
> It appears that Paul is extremely busy, so I thought the 'Quixote
> Group' would try and offer some reflections that may help with your
> efforts.

My apologies, yes I am rather busy at the moment, but I also stopped
following this thread a while ago as it didn't seem to be going
anywhere meaningful.  I happen to read this last email while I'm
waiting in an airport, so let me try and provide a quick explanation
about why running SELinux only in a container is a bad idea.

As you probably know, the Linux kernel has no concept of a container,
it only supports subsystem specific namespaces, e.g. mount namespace,
network namespace, etc.  SELinux does not provide a subsystem
namespace, and it does not generally concern itself with other
subsystem names.  From a SELinux perspective there is no difference
between a process running in the host namespace or a
container/namespace; both are treated the same with access control
decisions made based on the processes' SELinux domain, the type of the
target resource, and the access requested.

If one were to load a SELinux policy inside a container, even if it
were allowed, the system would likely behave in unexpected ways as the
container-loaded policy will take effect across the entire system, not
just inside the container.

--=20
paul-moore.com
