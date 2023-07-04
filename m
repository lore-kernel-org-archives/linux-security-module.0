Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44118EB64D9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jul 2023 23:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDXeY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDXeX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 19:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5E10DD
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688513613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUjWNMhuU7wC56K7OTDmC62p11rXMP5BQU2F88GfDUU=;
        b=a6PS8HqRx3y+ZAfTr/1MVVCy5c+v8rqFd0t1o1Z6qk1REhtZTZJSOSfZ8Ok10hjae3fxxa
        r6KfNe1lJnito8L45yHuNfeJuRDMpT6BGmchbRvHBAjCXWebDFeNHsqO7IIYjgjvjcUYhH
        o5HTYrAbjutSMnIsSzXE+6+NW3oXe4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-S2kaHIFoObKOR_lXvvk4Tg-1; Tue, 04 Jul 2023 19:33:30 -0400
X-MC-Unique: S2kaHIFoObKOR_lXvvk4Tg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso41864975e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jul 2023 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513609; x=1691105609;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kA4f+8B/kxLukv7a/BQg0loCO+oeIsR1MEG7lGSAPE=;
        b=HWLosNEX6q/NLzTMiMg7utJ+SrKiIGhfAnD0DZ1xF/JLso9UcVujQX5M6QVZTEo3em
         keEu8CdeHSc9iWL9dQWu4yXXSM9sjl1VRckfxj7xurSQJ2NHMRrdhlE8igBPxPfHp3mh
         GYsyjQXXL9ohsjQPv1OdPIh7TF/Zp+Am5fyz6hW12/PQG1Rg/F9zqKmoyf0z3+4u2Zw0
         cN9ivZdlVtCLW3en6m6WimqeGXa3oiU054uzvClFtWreTC1CoMRD2CKsTYc1hqCCq/Dl
         bca2cQreic1K4kz9XyTxCBL7aOvviMrsC7keTf5QWTKeMHWA6qodvX5xExU92KpIZZeF
         AhLw==
X-Gm-Message-State: AC+VfDyYutqNR7Jh4pMF3EFtbCOy7jyewqyRaigurR4y4ttwyhLqoS9o
        D+Ovij8Pz2xb6n87zXw609/bNshBP8nlotx9p4q/b57TYtmQmeEQGhU0UlNy8KHTN3ZXWMAsVR5
        mPZvjF04vmeULyRwpXApR/diHF8AxvYNBQhkJ
X-Received: by 2002:a7b:cb4d:0:b0:3f9:b17a:cb61 with SMTP id v13-20020a7bcb4d000000b003f9b17acb61mr14118012wmj.13.1688513609685;
        Tue, 04 Jul 2023 16:33:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oSNue88FePJzmOEk4Bqio+XxvPYnKACghZTixemR5QnwEnid0A1q6bnfFLewsGCaLxBQBcw==
X-Received: by 2002:a7b:cb4d:0:b0:3f9:b17a:cb61 with SMTP id v13-20020a7bcb4d000000b003f9b17acb61mr14117999wmj.13.1688513609211;
        Tue, 04 Jul 2023 16:33:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fbca05faa9sm425231wmi.24.2023.07.04.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:33:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3D45DBC1185; Wed,  5 Jul 2023 01:33:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
In-Reply-To: <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
 <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Jul 2023 01:33:28 +0200
Message-ID: <87pm57b6bb.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Jun 30, 2023 at 01:15:47AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>=20
>> > This patch set introduces new BPF object, BPF token, which allows to d=
elegate
>> > a subset of BPF functionality from privileged system-wide daemon (e.g.=
,
>> > systemd or any other container manager) to a *trusted* unprivileged
>> > application. Trust is the key here. This functionality is not about al=
lowing
>> > unconditional unprivileged BPF usage. Establishing trust, though, is
>> > completely up to the discretion of respective privileged application t=
hat
>> > would create a BPF token, as different production setups can and do ac=
hieve it
>> > through a combination of different means (signing, LSM, code reviews, =
etc),
>> > and it's undesirable and infeasible for kernel to enforce any particul=
ar way
>> > of validating trustworthiness of particular process.
>> >
>> > The main motivation for BPF token is a desire to enable containerized
>> > BPF applications to be used together with user namespaces. This is cur=
rently
>> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be na=
mespaced
>> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to=
 BPF
>> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can saf=
ely read
>> > arbitrary memory, and it's impossible to ensure that they only read me=
mory of
>> > processes belonging to any given namespace. This means that it's impos=
sible to
>> > have namespace-aware CAP_BPF capability, and as such another mechanism=
 to
>> > allow safe usage of BPF functionality is necessary. BPF token and dele=
gation
>> > of it to a trusted unprivileged applications is such mechanism. Kernel=
 makes
>> > no assumption about what "trusted" constitutes in any particular case,=
 and
>> > it's up to specific privileged applications and their surrounding
>> > infrastructure to decide that. What kernel provides is a set of APIs t=
o create
>> > and tune BPF token, and pass it around to privileged BPF commands that=
 are
>> > creating new BPF objects like BPF programs, BPF maps, etc.
>>=20
>> So a colleague pointed out today that the Seccomp Notify functionality
>> would be a way to achieve your stated goal of allowing unprivileged
>> containers to (selectively) perform bpf() syscall operations. Christian
>> Brauner has a pretty nice writeup of the functionality here:
>> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-=
unprivileged-container-development
>
> I'm amazed you read this. :)

I found it quite an enjoyable read, actually :)

> The seccomp notifier comes with a lot of caveats. I think it would be
> impractical if not infeasible to handle bpf() delegation.

Right, thank you for chiming in and explaining the context. I replied
elsewhere in the thread on the content, so let's not fork the discussion
any more than we have to...

-Toke

