Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F7C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 08:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKMIvH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Nov 2023 03:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIvG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Nov 2023 03:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D810F4
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699865416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abJq3b4SxArGIzdH6oN3k/sACWtPDA4b9f3Ex7vpiIc=;
        b=jJADADId2DuCzjk+Gml9FFqGqLEfyNxDmi1onKtKB8JUtWWobKAZ7KfUMoVZiYCR35ONcY
        jSHUw98ayqpKheMLA2Xsmm1fPVWU/kTv9ThIfX1FbFVMFjSNmVPD8PcYgRClXnISZEYzRx
        tAjOgAr+U2Lp85s+spLRBwqZP88YFsc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-tbeMXOFiOHOk-eM3OtFAjA-1; Mon, 13 Nov 2023 03:50:15 -0500
X-MC-Unique: tbeMXOFiOHOk-eM3OtFAjA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27ff8065e61so4818905a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 00:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865414; x=1700470214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abJq3b4SxArGIzdH6oN3k/sACWtPDA4b9f3Ex7vpiIc=;
        b=E0QpZyG4WrQW+TitX+JKOT0w3bHdCUid58XmG5PXXjV8iw3y37BSbFWW0qwAxSryQH
         iisu15AjGgPf19r8QZSbEfix02YT5qDK2gs0jNWXGAHWAga1Lx5o4OHsSJwxgmkaoXWj
         BQlmmnIouEgOkcYHT8p3gDk5bom+jwFfjFDKWgDZPedByM+4flhpCpnc6yL0wJcHUuiD
         vSvxj/Sh8WadSXF65c9tKbNY0f6WOuIqfxqKiUfn0pkeuMsHOvjEmsbgwvzsJW9wU+x+
         cZDovTih48eKqCi106gci69eOxQMkakwrXR/TRTGrhwAeeOH80QIf7dbZvpkfMldjDz2
         cKrg==
X-Gm-Message-State: AOJu0YyrJBZ/H5AvBB+KHAcfYkRhPmVqGpXroks+lTOIp1kb6wLbj9xM
        Av1kU6ZLHJiI0qXhwxtPZopwtSEscKcGgGSkFNHOl0T7pcE9BDV3TmgWeQ0k4CIh0A+Yt7A58Hf
        0EgDrKrGOo3qb5qHKArt6x9aGi4gNL10unm7C+GicAfmU7izO3mHp
X-Received: by 2002:a17:90a:f00e:b0:280:cd15:9684 with SMTP id bt14-20020a17090af00e00b00280cd159684mr6410466pjb.37.1699865414097;
        Mon, 13 Nov 2023 00:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLms+NRQJbWTq++B6OIejcvpHYuyFNppMncnz0QhKUjYCH64CKOAj1f2csMJ2ny7fAoEfld8lcYGI2echZ33w=
X-Received: by 2002:a17:90a:f00e:b0:280:cd15:9684 with SMTP id
 bt14-20020a17090af00e00b00280cd159684mr6410454pjb.37.1699865413819; Mon, 13
 Nov 2023 00:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
In-Reply-To: <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Nov 2023 09:50:02 +0100
Message-ID: <CAFqZXNsd5QCPQmOprf_iCCDNj8JKLjZWu3yA2=HtCYE+78F75A@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ligang.bdlg@bytedance.com, mhocko@suse.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 13, 2023 at 4:17=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >
> > On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In our containerized environment, we've identified unexpected OOM eve=
nts
> > > where the OOM-killer terminates tasks despite having ample free memor=
y.
> > > This anomaly is traced back to tasks within a container using mbind(2=
) to
> > > bind memory to a specific NUMA node. When the allocated memory on thi=
s node
> > > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > > indiscriminately kills tasks. This becomes more critical with guarant=
eed
> > > tasks (oom_score_adj: -998) aggravating the issue.
> >
> > Is there some reason why you can't fix the callers of mbind(2)?
> > This looks like an user space configuration error rather than a
> > system security issue.
>
> It appears my initial description may have caused confusion. In this
> scenario, the caller is an unprivileged user lacking any capabilities.
> While a privileged user, such as root, experiencing this issue might
> indicate a user space configuration error, the concerning aspect is
> the potential for an unprivileged user to disrupt the system easily.
> If this is perceived as a misconfiguration, the question arises: What
> is the correct configuration to prevent an unprivileged user from
> utilizing mbind(2)?"
>
> >
> > >
> > > The selected victim might not have allocated memory on the same NUMA =
node,
> > > rendering the killing ineffective. This patch aims to address this by
> > > disabling MPOL_BIND in container environments.
> > >
> > > In the container environment, our aim is to consolidate memory resour=
ce
> > > control under the management of kubelet. If users express a preferenc=
e for
> > > binding their memory to a specific NUMA node, we encourage the adopti=
on of
> > > a standardized approach. Specifically, we recommend configuring this =
memory
> > > policy through kubelet using cpuset.mems in the cpuset controller, ra=
ther
> > > than individual users setting it autonomously. This centralized appro=
ach
> > > ensures that NUMA nodes are globally managed through kubelet, promoti=
ng
> > > consistency and facilitating streamlined administration of memory res=
ources
> > > across the entire containerized environment.
> >
> > Changing system behavior for a single use case doesn't seem prudent.
> > You're introducing a bunch of kernel code to avoid fixing a broken
> > user space configuration.
>
> Currently, there is no mechanism in place to proactively prevent an
> unprivileged user from utilizing mbind(2). The approach adopted is to
> monitor mbind(2) through a BPF program and trigger an alert if its
> usage is detected. However, beyond this monitoring, the only recourse
> is to verbally communicate with the user, advising against the use of
> mbind(2). As a result, users will question why mbind(2) isn't outright
> prohibited in the first place.

Is there a reason why you can't use syscall filtering via seccomp(2)?
AFAIK, all the mainstream container tooling already has support for
specifying seccomp filters for containers.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

