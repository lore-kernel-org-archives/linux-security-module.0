Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA1DEB64D9
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjF2XQs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 19:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF2XQr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7930C5
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688080552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91kKsbqqc7jYgY055iTV0IwqhESp9QCO1epNn82efTE=;
        b=Tjczc8wTBTUMovde7UpklDkyQvSLBWZbtwlmL2V0/+KQ1a2lbTwwVEdYuO/kkC7fYCZcA1
        NdCLdHVmtdj4dTHla9LBSyhq52HiB836FmX/uEr2VOQrP/iW4rGh15K8bqbaS1fUu/fJmf
        Ow1GqInvFOUTIoa60nIhJE+F9frXwm8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Zpvf8uhsNuqK9qWyFFUwbA-1; Thu, 29 Jun 2023 19:15:50 -0400
X-MC-Unique: Zpvf8uhsNuqK9qWyFFUwbA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6a6cb42f1so11420321fa.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 16:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080549; x=1690672549;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91kKsbqqc7jYgY055iTV0IwqhESp9QCO1epNn82efTE=;
        b=N3lLxzj/67lkLwb5of6I1649XiDGq2dYHhAAv323HebyUlZ5ESNw7bAOFHWJuuZiUQ
         FAGdSbPvamUx1n4LWQyU2mEF4Be95TizJ1ClMjJnkWgPM7ESJqaROqGXfKlJok7igRuk
         kamDDuPOaaNWpkGpJIwHfKH2VqmLGcEhKf6Ze6GJO4x00l3NP2hAdqs5PNdWP+hXlRsf
         0/hiB/sr0Eqo4MgxNKpnyYWG/OC42dKLK1FMhDwzUO4VDzWBLzdvc0i/rbQ8ttyJOWZM
         RQURKULxsT0BY6iwlNarNXFPNIPtAnPrlbqR7qOulRjp5Rfd4yg0+vm21DwZ+g8kwiwB
         85JA==
X-Gm-Message-State: ABy/qLZdXogZj8zwmjFM4wpmmyWVd6KYcPIk6Q+K9HAbavM6pyEcK0ol
        qSfj0MhpMA8M9o+jlL2i7U+AWQjlrxRXbL1topfD3c+VC2ZaHNnwaT43DldF/rQiAXiFOlZk8ZM
        1swdOe2JralKU+RokJ0VbEMRKEgE47qM0B2iz
X-Received: by 2002:a2e:8893:0:b0:2b4:65bf:d7b with SMTP id k19-20020a2e8893000000b002b465bf0d7bmr890802lji.2.1688080549351;
        Thu, 29 Jun 2023 16:15:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0j5JPXJ+afvfBnjHnyRWpeEajAeSKnL8B1wwy7EfuSw22n3RTh7vm1r/MMfeD6OL7TEhWdQ==
X-Received: by 2002:a2e:8893:0:b0:2b4:65bf:d7b with SMTP id k19-20020a2e8893000000b002b465bf0d7bmr890788lji.2.1688080548880;
        Thu, 29 Jun 2023 16:15:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0096a6be0b66dsm7360812ejb.208.2023.06.29.16.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 16:15:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C3941BC051C; Fri, 30 Jun 2023 01:15:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 30 Jun 2023 01:15:47 +0200
Message-ID: <87sfa9eu70.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii@kernel.org> writes:

> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token, as different production setups can and do achieve it
> through a combination of different means (signing, LSM, code reviews, etc),
> and it's undesirable and infeasible for kernel to enforce any particular way
> of validating trustworthiness of particular process.
>
> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> arbitrary memory, and it's impossible to ensure that they only read memory of
> processes belonging to any given namespace. This means that it's impossible to
> have namespace-aware CAP_BPF capability, and as such another mechanism to
> allow safe usage of BPF functionality is necessary. BPF token and delegation
> of it to a trusted unprivileged applications is such mechanism. Kernel makes
> no assumption about what "trusted" constitutes in any particular case, and
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs to create
> and tune BPF token, and pass it around to privileged BPF commands that are
> creating new BPF objects like BPF programs, BPF maps, etc.

So a colleague pointed out today that the Seccomp Notify functionality
would be a way to achieve your stated goal of allowing unprivileged
containers to (selectively) perform bpf() syscall operations. Christian
Brauner has a pretty nice writeup of the functionality here:
https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development

In fact he even mentions allowing unprivileged access to bpf() as a
possible use case (in the second-to-last paragraph).

AFAICT this would enable your use case without adding any new kernel
functionality or changing the BPF-using applications, while allowing the
privileged userspace daemon to make case-by-case decisions on each
operation instead of granting blanket capabilities (which is my main
objection to the token proposal, as we discussed on the last iteration
of the series).

So I'm curious whether you considered this as an alternative to
BPF_TOKEN? And if so, what your reason was for rejecting it?

-Toke

