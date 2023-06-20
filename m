Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F73EB64D7
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jun 2023 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFTXon (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXom (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jun 2023 19:44:42 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFE1727
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 16:44:40 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-558a79941c6so3573684eaf.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jun 2023 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687304680; x=1689896680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JhARQ9cweedKu54WFLa7imeFpvKMsf5cPrYmMjsCxo=;
        b=FFhunJ7LgoJNSjaFSVkufg36g6PZSfHci6ASNalpiAcJmUYnrvkVhSODtH/I3fG6Sn
         4uYoL84rHy0Y/In7KXFx0pbgiHPfpPUXSRaN/WhfR8MnuK6lseaGZjVwo7ejdLszzklE
         3W2WkNhZEsaqjEIWTIx1bEwS0ErsdMQ0w4JlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687304680; x=1689896680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JhARQ9cweedKu54WFLa7imeFpvKMsf5cPrYmMjsCxo=;
        b=VCMHXtaYhNS8pOHT/kdEYV38D1+nHf4g0/dDppKOM439HGkAuU2Ac9Amse7f8Jb6pf
         B7E2hwPXsV8gZi4RGRPUwRCPvQlyDFnxjpcyLhk6G4Wv6WzYjXhLzT0YDS/uCkZ58wu7
         gsI8xnLpvCsesw60Tt9Rdc4BkhCYosGiOXwycPCVY6+K115h9Ed4Xr4sm2t7ZxSs9vE+
         JH+NeXEoUAdN5W2D3PmFKF1lC3EvkaJLUfq5MSikqeoWOPHsv9YlCHcz9boZmAvZk6kc
         bOIcEhSjborZ+pm+t0ixedHfnYO6Nlsjk380Qvoe1H76JOoHLMMoYrdbkeAIcsmO4SJj
         pfWg==
X-Gm-Message-State: AC+VfDw2KVdwFVbE3JfyIdSBKpGm5VyFrwxWhEfmBGZVChWavuzJNEmf
        qifGRBnKssuZSh6LuBcs1vEpoWzw+bYs2iGsWeC7mA==
X-Google-Smtp-Source: ACHHUZ7QD+hkkmhKGy0Hg+sAHcJQjqQxHJaZf9oJpA6HEkeuSh7I/a90F6q+4ljCtxs1GcAtLoDABs5QCGuzpa8fB64=
X-Received: by 2002:a4a:a7cd:0:b0:55e:54db:c453 with SMTP id
 n13-20020a4aa7cd000000b0055e54dbc453mr5733027oom.7.1687304680020; Tue, 20 Jun
 2023 16:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org> <CALmYWFv4f=YsRFHvj4LTog4GY9NmfSOE6hZnJNOpCzPM-5G06g@mail.gmail.com>
 <a932bbb5-7b19-2299-0ca4-3fa13d63d817@digikod.net>
In-Reply-To: <a932bbb5-7b19-2299-0ca4-3fa13d63d817@digikod.net>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 20 Jun 2023 16:44:00 -0700
Message-ID: <CABi2SkV79kPt+8vD=-9C2TDkVoNfkOxtaT2C470MWpV1EJvvpg@mail.gmail.com>
Subject: Re: [RFC 0/4] Landlock: ioctl support
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jun 17, 2023 at 2:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
>
> On 24/05/2023 23:43, Jeff Xu wrote:
> > Sorry for the late reply.
> >>
> >> (Looking in the direction of Jeff Xu, who has inquired about Landlock
> >> for Chromium in the past -- do you happen to know in which ways you'd
> >> want to restrict ioctls, if you have that need? :))
> >>
> >
> > Regarding this patch, here is some feedback from ChromeOS:
> >   - In the short term: we are looking to integrate Landlock into our
> > sandboxer, so the ability to restrict to a specific device is huge.
> > - Fundamentally though, in the effort of bringing process expected
> > behaviour closest to allowed behaviour, the ability to speak of
> > ioctl() path access in Landlock would be huge -- at least we can
> > continue to enumerate in policy what processes are allowed to do, even
> > if we still lack the ability to restrict individual ioctl commands for
> > a specific device node.
>
> Thanks for the feedback!
>
> >
> > Regarding medium term:
> > My thoughts are, from software architecture point of view, it would be
> > nice to think in planes: i.e. Data plane / Control plane/ Signaling
> > Plane/Normal User Plane/Privileged User Plane. Let the application
> > define its planes, and assign operations to them. Landlock provides
> > data structure and syscall to construct the planes.
>
> I'm not sure to follow this plane thing. Could you give examples for
> these planes applied to Landlock?
>
The idea is probably along the same lines as yours: let user space
define/categorize ioctls.  For example, for a camera driver, users can
define two planes - control plane: setup parameters of lens, data
plane: setup data buffers for data transfer and do start/stop (I'm
just making up the example since I don't really know the camera
driver).

The idea is for Landlock to provide a mechanism to let user space to
divide/assign ioctls to different planes, such that the user space
processes can set/define security boundaries according to the plane it
is on.

>
> >
> > However, one thing I'm not sure is the third arg from ioctl:
> > int ioctl(int fd, unsigned long request, ...);
> > Is it possible for the driver to use the same request id, then put
> > whatever into the third arg ? how to deal with that effectively ?
>
> I'm not sure about the value of all the arguments (except the command
> one) vs. the complexity to filter them, but we could discuss that when
> we'll reach this step.
>
> >
> > For real world user cases, Dmitry Torokhov (added to list) can help.
>
> Yes please!
>
ya,  it will help with the design if there is a real world scenario to stud=
y.

> >
> > PS: There is also lwn article about SELinux implementation of ioctl: [1=
]
> > [1] https://lwn.net/Articles/428140/
>
> Thanks for the pointer, this shows how complex this IOCTL access control
> is. For Landlock, I'd like to provide the minimal required features to
> enable user space to define their own rules, which means to let user
> space (and especially libraries) to identify useful or potentially
> harmful IOCTLs.
>
Yes. That makes sense.

> >
> > Thanks!
> > -Jeff Xu
