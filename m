Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184BC7EE25
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Jun 2023 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFISWO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Jun 2023 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFISWN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jun 2023 14:22:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE03588;
        Fri,  9 Jun 2023 11:22:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so3637688a12.2;
        Fri, 09 Jun 2023 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686334930; x=1688926930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPYRUAijCyFOS1o4/DTOSLa+L+AbhvQG12YJ0ZymqZ4=;
        b=lDIyTAVWYxO8f10uxD88uNLCx1xndHmU1647NPw2Crj6v44RqzpHSf45aMqFQSaYHZ
         i0Zhq76w2NCkzdIL6uvxGYfpfWsmkSboLLdV/Hg6rtj3N6Nl0i4yOmsZ7MxbKmS5JG6R
         uBqoFhETgoQlg6h0OjwQLZndOMvM5H04cEtxTFXS/DMnavwBXPJ1XbJD9gP6g5EjQqYj
         zwD96cR2LjdeTlphNSVI2eGzxUADljtkg/AV/cXnuCJCk+AFFzKGuHeOXwHMCofelC1J
         1H0RgQCAFdwblFDSb7jLrr1pXI4Dhts+1Cmf93DERCaqFqMRbVILydxoH1F6WXR79CW8
         2IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334930; x=1688926930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPYRUAijCyFOS1o4/DTOSLa+L+AbhvQG12YJ0ZymqZ4=;
        b=IA0iEx3g6McDRXNm5ejE87ds2BXukEwTnOPNkxIf59/d52NiialUmB6155jzRgvND/
         wTYpu9HhgG0vUoPW3a9/PrP+35KOAWXkBNP5tVONp23X0CCh/syEVPfeVRBGQMxFUXY3
         V5dNfkcmDquk73Rmf9yKLhdS5xkxrwDSSKnT+VeipLaaqufHsmp0MqDegj8a5XYMEBC1
         /xlCtzpSmjfl3e7K6s8xTqBA0Xei5xEzjRluqTzK1hNBztgqAV7g7Kr/FZCkEmL9+5vL
         keVCaFVdxomnxzy/kiz2nMhS/ok6B5kiTORCFByKCyyIYK2EuodmibCyqAy4ayM8j53P
         GJ7w==
X-Gm-Message-State: AC+VfDwm44DUkKxz+Hh9PxT02I0Pvg4g0xt82YMiwap6QXxbq5cnkreD
        XlNHssZdQzYY97UEvYT8bTlq5dv9Nx84A04DZ5E=
X-Google-Smtp-Source: ACHHUZ7Bgwbx210s4R1Yh+TPcVGIdRd/LaypGTtgDgG82EjtvXeGuq9oTzECg0s0uSB9xp7tfw1h5pkIl/2hCjjwjOY=
X-Received: by 2002:a17:907:2d86:b0:96a:ee54:9f19 with SMTP id
 gt6-20020a1709072d8600b0096aee549f19mr2908505ejc.48.1686334929953; Fri, 09
 Jun 2023 11:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <871qik28bs.fsf@toke.dk>
In-Reply-To: <871qik28bs.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Jun 2023 11:21:57 -0700
Message-ID: <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token.
>
> I am not convinced that this token-based approach is a good way to solve
> this: having the delegation mechanism be one where you can basically
> only grant a perpetual delegation with no way to retract it, no way to
> check what exactly it's being used for, and that is transitive (can be
> passed on to others with no restrictions) seems like a recipe for
> disaster. I believe this was basically the point Casey was making as
> well in response to v1.

Most of this can be added, if we really need to. Ability to revoke BPF
token is easy to implement (though of course it will apply only for
subsequent operations). We can allocate ID for BPF token just like we
do for BPF prog/map/link and let tools iterate and fetch information
about it. As for controlling who's passing what and where, I don't
think the situation is different for any other FD-based mechanism. You
might as well create a BPF map/prog/link, pass it through SCM_RIGHTS
or BPF FS, and that application can keep doing the same to other
processes.

Ultimately, currently we have root permissions for applications that
need BPF. That's already very dangerous. But just because something
might be misused or abused doesn't prevent us from making a good
practical use of it, right?

Also, there is LSM on top of all of this to override and control how
the BPF subsystem is used, regardless of BPF token. It can override
any of the privileges mechanism, capabilities, BPF token, whatnot.

>
> If the goal is to enable a privileged application (such as a container
> manager) to grant another unprivileged application the permission to
> perform certain bpf() operations, why not just proxy the operations
> themselves over some RPC mechanism? That way the granting application

It's explicitly what we *do not* want to do, as it is a major problem
and logistical complication. Every single application will have to be
rewritten to use such a special daemon/service and its API, which is
completely different from bpf() syscall API. It invalidates the use of
all the libbpf (and other bpf libraries') APIs, BPF skeleton is
incompatible with this. It's a nightmare. I've got feedback from
people in another company that do have BPF service with just a tiny
subset of BPF functionality delegated to such service, and it's a pain
and definitely not a preferred way to do things.

Just think about having to mirror a big chunk of bpf() syscall as an
RPC. So no, BPF proxy is definitely not a good solution.


> can perform authentication checks on every operation and ensure its
> origins are sound at the time it is being made. Instead of just writing
> a blank check (in the form of a token) and hoping the receiver of it is
> not compromised...

All this could and should be done through LSM in much more decoupled
and transparent (to application) way. BPF token doesn't prevent this.
It actually helps with this, because organizations can actually
dictate that operations that do not provide BPF token are
automatically rejected, and those that do provide BPF token can be
further checked and granted or rejected based on specific BPF token
instance.

>
> -Toke
