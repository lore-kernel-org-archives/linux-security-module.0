Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3171EB64D9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jul 2023 23:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGDXVP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGDXVP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jul 2023 19:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB02E72
        for <linux-security-module@vger.kernel.org>; Tue,  4 Jul 2023 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688512827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xdaXSabQfTNuI1Aba0xmcCZY0slyepVk7tX11I81HQ=;
        b=geq8uZK4sSaUCj/555IN8NdCwfZNuMkNF4f2AWQcOP4Jta+pyZa2nM0uSUIzhpBne9TQnM
        m883CX7FOimAnUk07fLN0WD3bnZsbdlQnjg/VtpZcVN+hSPUpGVEIml86E0IQ0Yu9YHQqL
        PiGznV+zX8OtGJ5Z5HC/q8P8tGfWnHA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Ljlk9VNJMfe_rt8maDXlOg-1; Tue, 04 Jul 2023 19:20:25 -0400
X-MC-Unique: Ljlk9VNJMfe_rt8maDXlOg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314394a798dso54870f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jul 2023 16:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688512824; x=1691104824;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9aQAOPQwD+OOZUIe6eiLlOHucsE59TCJ7ry9WPFMNk=;
        b=LLOjf6QMKfCp7OOjS61g3vG/PgveSaSFDV36lM/ETNVh3pd07YCSml3hasa5okBW29
         UUcpuzVjo4/7FM9rnbk24S6oOb8Dez95Hb//KAHxFX7/aFW7ghnM1nkL7eXSo2ETvxD0
         F/nqdImcTMLRHzGiI/qKqFquzO3E4FxJEVmuBjYgFe5pml53HCcxkxH9TyOZBBVi5zPv
         eOymimVdoNMes6WleM09RyFGEwRalYMZCq2thmy6cbDu0PY5qB0WK7C4Xtb9axUAeFje
         pZbMdz+iN4t4zkvBuLhWZPYUnCjG+CHdK3l0D1Xcbi5Hqur+mtxRi1zZ6A+WfMkiEhsr
         sVZQ==
X-Gm-Message-State: ABy/qLZnFfxoMtDo139FeHSNEu7Mfy6V3ljbtCDUEfDP1Pa+91hFfJ2j
        temnZ6ZamkIEmdwj7vF+zEy2Sai8vgKFx5FXlGtdrNvyFkjqt2c7AQ9ctogrUszmFDUmZD31PJj
        W8gHf8zNzUlTBJDtrF6DMvZG8xoCjVlG58xBJ
X-Received: by 2002:adf:f186:0:b0:314:2c9:64c with SMTP id h6-20020adff186000000b0031402c9064cmr502229wro.6.1688512824447;
        Tue, 04 Jul 2023 16:20:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF31K1Xy7QDVAwBBfozwLbnZWVZMK5ZMAARsXvoc8RTwiD4V6KdIQYl/V6JyfsF+c26tycpAQ==
X-Received: by 2002:adf:f186:0:b0:314:2c9:64c with SMTP id h6-20020adff186000000b0031402c9064cmr502215wro.6.1688512823938;
        Tue, 04 Jul 2023 16:20:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm29664484wri.73.2023.07.04.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:20:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AFD6FBC117E; Wed,  5 Jul 2023 01:20:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
In-Reply-To: <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <87sfa9eu70.fsf@toke.dk>
 <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Jul 2023 01:20:22 +0200
Message-ID: <87v8ezb6x5.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jun 29, 2023 at 4:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii@kernel.org> writes:
>>
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
>>
>> So a colleague pointed out today that the Seccomp Notify functionality
>> would be a way to achieve your stated goal of allowing unprivileged
>> containers to (selectively) perform bpf() syscall operations. Christian
>> Brauner has a pretty nice writeup of the functionality here:
>> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-=
unprivileged-container-development
>>
>> In fact he even mentions allowing unprivileged access to bpf() as a
>> possible use case (in the second-to-last paragraph).
>>
>> AFAICT this would enable your use case without adding any new kernel
>> functionality or changing the BPF-using applications, while allowing the
>> privileged userspace daemon to make case-by-case decisions on each
>> operation instead of granting blanket capabilities (which is my main
>> objection to the token proposal, as we discussed on the last iteration
>> of the series).
>
> It's not "blanket" capabilities. You control types or maps and
> programs that could be created. And again, CAP_SYS_ADMIN guarded.
> Please, don't give CAP_SYS_ADMIN/root permissions to applications you
> can't be sure won't do something stupid and blame kernel API for it.

Right, I didn't mean "blanket" in the sense of "permission to do
anything on the system"; I do get that you can restrict which subset of
functionality you grant. However, *within* that subset, it's a blanket
permission grant. I.e., you can't issue a token that grants a *specific*
application permission to load a *specific* BPF program - you can only
grant a general "load any program" permission that can be used by anyone
who possesses the token.

I guess we could in principle extend the token mechanism to allow this,
but the kernel doesn't seem like the right place to implement such a
fine-grained policy engine...

> After all, the root process can setuid() any file and make it run with
> elevated permissions, right? Doesn't get more "blanket" than that.

Which is exactly why setuid binaries are not generally how we implement
security delegation these days. So I don't think designing a new
mechanism this way is a good idea.

>> So I'm curious whether you considered this as an alternative to
>> BPF_TOKEN? And if so, what your reason was for rejecting it?
>>
>
> Yes, I'm aware, Christian has a follow up short blog post specifically
> for using this for proxying BPF from privileged process ([0]).
>
> So, in short, I think it's not a good generic solution. It's very
> fragile and high-maintenance. It's still proxying BPF UAPI (except
> application does preserve illusion of using BPF syscall, yes, that
> part is good) with all the implications: needing to replicate all of
> UAPI (fetching all those FDs from another process, following all the
> pointers from another process' memory, etc), and also writing back all
> the correct things (into another process' memory): log content,
> log_true_size (out param), any other output parameters.

Right, OK, that bit does sound pretty tedious (although I'll note that
there are people who are trying to make all this generally more
palatable[0]).

However, all that tediousness could be avoided while still retaining the
model of blocking the syscall and asking a userspace policy daemon to
supply a verdict. This could even be done using the same token
mechanism: instead of attaching a permission to the token itself, just
make it an opaque identifier. Then, when a syscall is made that contains
the token, block it and send a notification to user space and use the
verdict that comes back in place of the token "value". The notification
could go through the same file descriptor (using read/write or an ioctl,
restricted to CAP_SYS_ADMIN), or it could be a separate one that is
returned alongside it on TOKEN_CREATE. The notification could include
all of the syscall args or a subset, depending on the command, but the
kernel can ensure there are no TOCTOU races, and no need for the policy
daemon to go poking into other another process' namespace.

Actually, using this model I don't think we would even strictly speaking
need the explicit token FD to be included by the calling application
inside the container at all? I.e., if the system policy daemon could
just instruct the kernel "please delegate all permission decisions for
this user namespace to me", it could - so to speak - issue tokens on
demand as each call is made, instead of ahead of time. Which would both
enable the policy daemon to make specific usage decisions, and wouldn't
require any change needed to the applications using BPF inside the
container (not even to include the BPF token FD).

-Toke

