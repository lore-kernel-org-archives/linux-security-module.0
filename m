Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590FEB64D9
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jun 2023 12:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbjFNMNg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjFNMNX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jun 2023 08:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA36270F
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686744733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FndmaWa4KFgSENV+ljsU/Xpl7wK4Jw75Qw/SCpt8dAI=;
        b=N57/EvMyUEtu9AkJNskoOxhxfuLmzUabMz1kO7spyKvymgogKPzt2FbBLTlgdlH5kbuciH
        5s2ZelP0/X6Yh9E1YJRr+zvLb2Xw/wQ8REYi7VqT4klLZPbf/AnsXgEz7oaWCICwJU7pJL
        DA3UISiB4fvHtt4rVwXPqhNT1DgV9Cg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-Wr3U5Nj-O1ia9At_PgKYpQ-1; Wed, 14 Jun 2023 08:12:11 -0400
X-MC-Unique: Wr3U5Nj-O1ia9At_PgKYpQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97467e06580so75827066b.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jun 2023 05:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744730; x=1689336730;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqI35d8McDvfvESnN6I+vtvR8s0ur8VarK3flkj92Do=;
        b=BLEN/JJvEBzQowCI7bLKf+LUS9KHq2w988d64AU1UTigTkBPn7gqesM1aJ+oIziK3L
         7NpVSXEYAGsKIXT1sZiCgfp1b42BwNBbqhvNF5fgj6VeBBxPAEuKwYjAHa9F7wzUXjTG
         p2tw1AJIPsxuH1xOjPiG6QII4tEsJ4PWAXGywAKx4mwEoM17ITW4fveLO30hrXo9EbRZ
         wkkdCCe6flSPuY2YNj+WzCzQJl0j+W8Rbke8n11lWIQhsM6NalDnprq2+Yj750Bx2hRo
         YoykdRT6UIGUqQg3Z4Qg36RAmxExjCWN+21DAYlY7PotjFmN3ygV3JtXk5vl0E2UnhW0
         vssg==
X-Gm-Message-State: AC+VfDzUVa8Noxw/lxXBp/+WRL219AxtwvDR6f8ITz6f6YcjxTnlrKep
        pRZuPqLCyJMQ4I+LVZr7qlI0HaKRMZBLSr7iSBdoByv4wGCPVGSVZJsH4V79bmw19a+ujUNZhfp
        9sphLy0BBWoMzktU3rMur5f88WXMtQkfIFz0O
X-Received: by 2002:a17:907:6d97:b0:973:d953:4bf7 with SMTP id sb23-20020a1709076d9700b00973d9534bf7mr17634813ejc.48.1686744730307;
        Wed, 14 Jun 2023 05:12:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Dy3Th2+3QKV30gEYSWV7XVPa+TAUXvwcdMExre+3DCvbHaQD3hXTisc5ZA8jGguvnDfQanw==
X-Received: by 2002:a17:907:6d97:b0:973:d953:4bf7 with SMTP id sb23-20020a1709076d9700b00973d9534bf7mr17634769ejc.48.1686744729596;
        Wed, 14 Jun 2023 05:12:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061cd700b0094f07545d40sm7867689ejh.220.2023.06.14.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:12:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 07E90BBEB67; Wed, 14 Jun 2023 14:06:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk>
 <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
 <87bkhlymyk.fsf@toke.dk>
 <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Jun 2023 14:06:01 +0200
Message-ID: <874jnal046.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Jun 12, 2023 at 3:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@kernel.org> wrote:
>> >> >>
>> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
>> >> >>
>> >> >> > This patch set introduces new BPF object, BPF token, which allow=
s to delegate
>> >> >> > a subset of BPF functionality from privileged system-wide daemon=
 (e.g.,
>> >> >> > systemd or any other container manager) to a *trusted* unprivile=
ged
>> >> >> > application. Trust is the key here. This functionality is not ab=
out allowing
>> >> >> > unconditional unprivileged BPF usage. Establishing trust, though=
, is
>> >> >> > completely up to the discretion of respective privileged applica=
tion that
>> >> >> > would create a BPF token.
>> >> >>
>> >> >> I am not convinced that this token-based approach is a good way to=
 solve
>> >> >> this: having the delegation mechanism be one where you can basical=
ly
>> >> >> only grant a perpetual delegation with no way to retract it, no wa=
y to
>> >> >> check what exactly it's being used for, and that is transitive (ca=
n be
>> >> >> passed on to others with no restrictions) seems like a recipe for
>> >> >> disaster. I believe this was basically the point Casey was making =
as
>> >> >> well in response to v1.
>> >> >
>> >> > Most of this can be added, if we really need to. Ability to revoke =
BPF
>> >> > token is easy to implement (though of course it will apply only for
>> >> > subsequent operations). We can allocate ID for BPF token just like =
we
>> >> > do for BPF prog/map/link and let tools iterate and fetch informatio=
n
>> >> > about it. As for controlling who's passing what and where, I don't
>> >> > think the situation is different for any other FD-based mechanism. =
You
>> >> > might as well create a BPF map/prog/link, pass it through SCM_RIGHT=
S
>> >> > or BPF FS, and that application can keep doing the same to other
>> >> > processes.
>> >>
>> >> No, but every other fd-based mechanism is limited in scope. E.g., if =
you
>> >> pass a map fd that's one specific map that can be passed around, with=
 a
>> >> token it's all operations (of a specific type) which is way broader.
>> >
>> > It's not black and white. Once you have a BPF program FD, you can
>> > attach it many times, for example, and cause regressions. Sure, here
>> > we are talking about creating multiple BPF maps or loading multiple
>> > BPF programs, so it's wider in scope, but still, it's not that
>> > fundamentally different.
>>
>> Right, but the difference is that a single BPF program is a known
>> entity, so even if the application you pass the fd to can attach it
>> multiple times, it can't make it do new things (e.g., bpf_probe_read()
>> stuff it is not supposed to). Whereas with bpf_token you have no such
>> guarantee.
>
> Sure, I'm not claiming BPF token is just like passing BPF program FD
> around. My point is that anything in the kernel that is representable
> by FD can be passed around to an unintended process through
> SCM_RIGHTS. And if you want to have tighter control over who's passing
> what, you'd probably need LSM. But it's not a requirement.
>
> With BPF token it is important to trust the application you are
> passing BPF token to. This is not a mechanism to just freely pass
> around the ability to do BPF. You do it only to applications you
> control.

Trust is not binary, though. "Do I trust this application to perform
this specific action" is different from "do I trust this application to
perform any action in the future". A security mechanism should grant the
minimum required privileges required to perform the operation; this
token thing encourages (defaults to) broader grants, which is worrysome.

> With user namespaces, if we could grant CAP_BPF and co to use BPF,
> we'd do that. But we can't. BPF token at least gives us this
> opportunity.

If the use case is to punch holes in the user namespace isolation I feel
like that is better solved at the user namespace level than the BPF
subsystem level...

-Toke


(Ran out of time and I'm about to leave for PTO, so dropping the RPC
discussion for now)

