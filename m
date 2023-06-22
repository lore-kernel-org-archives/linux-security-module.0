Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD9EB64DA
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jun 2023 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFVVKd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFVVJb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Jun 2023 17:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E6F1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687467868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX1SvHOIArwqc8jRFEPHXwp7AFuFWsZq7swPt5WqaFA=;
        b=bcc+bPORVXIAuYwg3MMJopAFRPFOHhGoQPTqKGJOLNubvi+LadocBNpTy+PF8XFabpstdQ
        /VlSuZJ31F3xWGWkEJdwTFTO7np2DLXrpE7QLWhoe5qFf2n+PLv7HFvT9HjcLhrvRncoy4
        egVnmxfkqx6n5pZma/nb4U4/rGfvp0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-iQ615TguOHm1ZT0mMxbaGw-1; Thu, 22 Jun 2023 17:04:27 -0400
X-MC-Unique: iQ615TguOHm1ZT0mMxbaGw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9068f47ceso115889535e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 14:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467866; x=1690059866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX1SvHOIArwqc8jRFEPHXwp7AFuFWsZq7swPt5WqaFA=;
        b=kXtPHLCAzT5Xaczp+ORX8HIhpCF0mP8FSAJYLoJ3Vt9I6RUiICoHdAPciFBW4F8aAj
         rIqX1S6D1+nlsbEUiGg1Qi5eRyYFfSeGh+055NCvoLlo2lh5j8GlGZF5Gh11jm+kAPwi
         jNmPWFxbUC5v76TD4ks4pyZIJebqaTdGvvWlBVSKOnalobK4KGIT6YkjyPnatClwoxq7
         VGtyhtCUW2ZH4ABBvNUvZa0+KF/Ljtdlpfj8wYUTQ5+A+89fM2bCX7Uah0dfqL4Fabkp
         dbPiDwi/miasupi4mqEPI0C0MBvc1yC265qcilWFNpZ+4Ex/a8rNXDa0odktb8rOH9N3
         LjbQ==
X-Gm-Message-State: AC+VfDwNjKj4cyANMRxd5UFuqWf6SoCrlCO1v0b3m9tz7SxACpaHpjv8
        ea574/4cD7JhMleKhinVqxDtdb+E8vxZSy640x2H7nD+S/RhmW43WO7bqQxUbxoaRjlF7Y6STRB
        DT/GKRndTX12fNC9UPc8rr0wnhQ7R17aOUnuwF2u5jgAvgf7AxGNF
X-Received: by 2002:a05:600c:21c6:b0:3fa:7516:baa with SMTP id x6-20020a05600c21c600b003fa75160baamr2687621wmj.13.1687467865848;
        Thu, 22 Jun 2023 14:04:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ffZnbzGgCIO/encZy3DdfUA7A2BLcol4LKXgTrzNDMV64YSRhKhkBOThfc80Lx6QhLRibI4omWToh2K0k3cY=
X-Received: by 2002:a05:600c:21c6:b0:3fa:7516:baa with SMTP id
 x6-20020a05600c21c600b003fa75160baamr2687588wmj.13.1687467865462; Thu, 22 Jun
 2023 14:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com> <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com> <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
In-Reply-To: <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
From:   Maryam Tahhan <mtahhan@redhat.com>
Date:   Thu, 22 Jun 2023 22:04:14 +0100
Message-ID: <CAFdtZitYhOK4TzAJVbFPMfup_homxSSu3Q8zjJCCiHCf22eJvQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 22, 2023 at 7:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 22, 2023 at 10:38=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.co=
m> wrote:
> >
>
> Please avoid replying in HTML.
>

Sorry.

[...]

>
> Disclaimer: I don't know anything about Kubernetes, so don't expect me
> reply with correct terminology or detailed understanding of
> configuration of containers.
>
> But on a more generic and conceptual level, it seems like you are
> making some implementation assumptions and arguing based on that.
>

Firstly, thank you for taking the time to respond and explain. I can see
where you are coming from.

Yeah, admittedly I did make a few assumptions. I was thrown by the referenc=
e
to `unprivileged` processes in the cover letter. It seems like this is a wa=
y to
grant namespaced BPF permissions to a process (my gross
oversimplification - sorry).
Looking back throughout your responses there's nothing unprivileged here.

[...]


> Hopefully you can see where I'm going with this. And this is just one
> random tiny example. We can think up tons of other cases to prove BPF
> is not isolatable to any sort of "container".
>
> >
> > Anyway - I hope this clarifies my original intent - which is proxy at l=
east starts to solve one part of the puzzle. Whatever approach(es) we take =
to solve the rest of these problems the more we can stick to tried and trus=
ted mechanisms the better.
>
> I disagree. BPF proxy complicates logistics, operations, and developer
> experience, without resolving the issue of determining trust and the
> need to delegate or proxy BPF functionality.

I appreciate your viewpoint. I just don't think that this is a one
solution fits every
scenario situation. For example in the case of AF_XDP, I'd like to be
able to run
my containers without any additional privileges. I've been working on a dev=
ice
plugin for Kubernetes whose job is to provision netdevs with an XDP redirec=
t
program (then later there's a CNI that moves the netdev into the pod networ=
k
namespace).  Originally I was using bpf locally in the device plugin
(to load the
bpf program and get the XSK map fd) and SCM rights to pass the XSK_MAP over
UDS but honestly it was relatively cumbersome from an app development POV, =
very
easy to get wrong, and trying to keep up with the latest bpf api
changes started to
become an issue. If I wanted to add more interesting bpf programs I
had to do a full
recompile...

I've now moved to using bpfd, for the loading and unloading of the bpf
program on my behalf,
it also comes with a bunch of other advantages including being able to
update my trusted bpf
program transparently to both the device plugin my application (I
don't have to respin this either
when I write/want to add a new bpf prog), but mainly I have a trusted
proxy managing bpffs, bpf progs and maps for me. There's still more
work to do here...

I understand this is a much simplified scenario. and I'm sure I can
think of several more where
proxy is useful. All I'm trying to say is, I'm not sure there's just a
one size fits all soln for these issues.

Thanks
Maryam

