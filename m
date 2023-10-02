Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA3E7849A
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Oct 2023 11:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjJBLHO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Oct 2023 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbjJBLHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 07:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349091
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696244783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYYchr75lPgIPVF4yIojNv4/SPtia6FPTBRWZDFa/Bo=;
        b=FYm1/FfITbibsxF+WYVPh+SjVvZYOW4ji1FysTHZ1mMgi3BEo7AapNZG8872R0ATNLWL0V
        JGfswoOa/6KAU/UH4PL5Fl7o+HTyv2+nVPQ8K5dTOhWG+Y+bS2SmLj2JKGHlFOnJZZ6338
        y37K5OvwCgiaROQ5ZnuHBL8ncgz5fFw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-UMtmYq30O4e78StSeDBEnA-1; Mon, 02 Oct 2023 07:06:19 -0400
X-MC-Unique: UMtmYq30O4e78StSeDBEnA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso330915066b.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Oct 2023 04:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244778; x=1696849578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYYchr75lPgIPVF4yIojNv4/SPtia6FPTBRWZDFa/Bo=;
        b=UWZNVV4GuUAckN2sFJOTVBTYXVx1ZWC/dq/sv2hB3T/MaMkrSa3qLtHdp0I3YL60bd
         VKeTfPUx570nRcP0NxIVGxZMImd5xhsX43OusZgSbg0HG6fRyabQljjaWDFddNJMW6Ea
         JcxFXKOCM4Y9/ETQzAuew8FWcoKkguWATixLSdMxxZErhVYyByCqdPRfsss2CjBR9C8S
         DyNK/iOefPAwJpTVaBQjx11X0F+UzIL2zR5v8XPDBEtRxu0cqb1blTW9VnIrov+iKtdr
         SBnWekdOz2D5pY92ppkDWo7g/BkQDHG/tm1TQZLmAQx1Q4Gc/PqFqmsQJqOCN29FtWnF
         /4xQ==
X-Gm-Message-State: AOJu0YzB3YKD8HjGKjJwFf6371qV4JQUItmn+3yQ4rIA+Vkg6YsS6Iqt
        ek7e3J4UWCrFiGRpvikDoyT5ozBNeg4q0yezu2JnwJYQ0j3ds0hwxbZfzWPJtD72oNAJhiK+Ii8
        EPCh6KgquVhtOEn4g5n9IMbTcgWJJigLKlfKq
X-Received: by 2002:a17:906:7389:b0:9a1:d915:6372 with SMTP id f9-20020a170906738900b009a1d9156372mr9245948ejl.4.1696244778127;
        Mon, 02 Oct 2023 04:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp+BfMhEWzXVb16vyxNML0UzJNiL7gyOvkLvcAWIYrSoBIAxKDqcE8idRquVxsjJRV7hR2hQ==
X-Received: by 2002:a17:906:7389:b0:9a1:d915:6372 with SMTP id f9-20020a170906738900b009a1d9156372mr9245928ejl.4.1696244777775;
        Mon, 02 Oct 2023 04:06:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-130.dyn.eolo.it. [146.241.225.130])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cce6f7d50sm16963982eju.64.2023.10.02.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:06:17 -0700 (PDT)
Message-ID: <5a56953293ae90a1e20a414a44f45a94ee971792.camel@redhat.com>
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
From:   Paolo Abeni <pabeni@redhat.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com
Date:   Mon, 02 Oct 2023 13:06:15 +0200
In-Reply-To: <20230928202410.3765062-1-kpsingh@kernel.org>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2023-09-28 at 22:24 +0200, KP Singh wrote:
> # Background
>=20
> LSM hooks (callbacks) are currently invoked as indirect function calls. T=
hese
> callbacks are registered into a linked list at boot time as the order of =
the
> LSMs can be configured on the kernel command line with the "lsm=3D" comma=
nd line
> parameter.
>=20
> Indirect function calls have a high overhead due to retpoline mitigation =
for
> various speculative execution attacks.
>=20
> Retpolines remain relevant even with newer generation CPUs as recently
> discovered speculative attacks, like Spectre BHB need Retpolines to mitig=
ate
> against branch history injection and still need to be used in combination=
 with
> newer mitigation features like eIBRS.
>=20
> This overhead is especially significant for the "bpf" LSM which allows th=
e user
> to implement LSM functionality with eBPF program. In order to facilitate =
this
> the "bpf" LSM provides a default callback for all LSM hooks. When enabled=
,
> the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> especially bad in OS hot paths (e.g. in the networking stack).
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
>=20
> Since we know the address of the enabled LSM callbacks at compile time an=
d only
> the order is determined at boot time, the LSM framework can allocate stat=
ic
> calls for each of the possible LSM callbacks and these calls can be updat=
ed once
> the order is determined at boot.
>=20
> This series is a respin of the RFC proposed by Paul Renauld (renauld@goog=
le.com)
> and Brendan Jackman (jackmanb@google.com) [1]
>=20
> # Performance improvement
>=20
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benef=
itting
> the most.
>=20
> Here are the results of the relevant Unixbench system benchmarks with BPF=
 LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
>=20
> Benchmark                                               Delta(%): (+ is b=
etter)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859

FTR, I also measure a ~3% tput improvement in UDP stream test over
loopback.

@KP Singh, I would have appreciated being cc-ed here, since I provided
feedback on a previous revision (as soon as I learned of this effort).

Cheers,

Paolo

