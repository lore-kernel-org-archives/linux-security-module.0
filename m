Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF4EB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 13:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGGNFp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGNFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 09:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14CE6E
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spbb5kMkZNfk5QvmXSW5ZU2UZzQF7gxn+0EuFzvWeok=;
        b=G3st5tnFDJnY2JmGwoyMJJyP8sXxS/VaAPSzKXZsTQbi9lBYGIhhCGslo63tkPpQxQOkPm
        9lOaQ2YZy8x2d4xPOMF5+LQdQ19e4JZoUKk5tcqJjlfdTzd7WoSmZ/FnWKr9eJ8HkkjE2x
        XCNzXJLz9sSGEk6YDmKySi52R9OSmAA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-f1YAzrO5P4O4cW0AZLuniA-1; Fri, 07 Jul 2023 09:04:55 -0400
X-MC-Unique: f1YAzrO5P4O4cW0AZLuniA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbffd088a9so3004915e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jul 2023 06:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735094; x=1691327094;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spbb5kMkZNfk5QvmXSW5ZU2UZzQF7gxn+0EuFzvWeok=;
        b=DNbhxCCX7aYRvhghQh91csG4PRyXiXq0dCvfJIaGYIXXj7rmSzBLEBa2v6rctJ1199
         8vxd1Hzo5frhPlNguwP1zZdSfcc8/PLTC9wQbbwhVsUKsee9LI0X33qmhZK9JzdrGH08
         gIA3QRL4zaw1CZ37u76HsBgYREy0mzA/+wu2hYMWmD5ASsY8AytwH9yF5F71yrNwWQN0
         f0ANsf3J5i7S/PWk/trLxi5i7yH4eOyTkguYtmRJW9kkruPoXnRzODtcNSKzbMal7klr
         y9Lpsj8X/vaP5qDobS+Md3TavW69NyrLcxDs3pBb+uAh/55FdR2XZJzqGQIfP9UfbOUV
         6m6Q==
X-Gm-Message-State: ABy/qLYIJG2WSXxWrDX22bWHucIYMgCRojgg2tknCyNQYlb9P0O4pyxx
        0U0uEpc8to4Cahl05I4x+1Dm+k2ypcRXAvjF2//M5EPVEi2iH6eKEYffdf6jVZLWMUH7RHRNJ+0
        T2KDn1qCQFHxDcEaLAMa1mY9gDwksknWmgyzM
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2850689wmc.33.1688735093860;
        Fri, 07 Jul 2023 06:04:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF90VvveDFzTN1MQrOvnaykAYXVLdJCvIKpc9PxsXc0M8lpyZ+5l5tClUkOMEubknZgQtjM4A==
X-Received: by 2002:a1c:7207:0:b0:3f9:ba2:5d19 with SMTP id n7-20020a1c7207000000b003f90ba25d19mr2850660wmc.33.1688735093412;
        Fri, 07 Jul 2023 06:04:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003fbc9b9699dsm2381013wma.45.2023.07.07.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:04:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7F015C59720; Fri,  7 Jul 2023 15:04:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
 <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
 <87a5w9s2at.fsf@toke.dk>
 <CAEf4Bzaox7Q+ZVfuVnuia-=zPeBMYBG3-HT=bajT0OTMp6SQzg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 Jul 2023 15:04:51 +0200
Message-ID: <87lefrhnyk.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jul 6, 2023 at 4:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > Having it as a separate single-purpose FS seems cleaner, because we
>> > have use cases where we'd have one BPF FS instance created for a
>> > container by our container manager, and then exposing a few separate
>> > tokens with different sets of allowed functionality. E.g., one for
>> > main intended workload, another for some BPF-based observability
>> > tools, maybe yet another for more heavy-weight tools like bpftrace for
>> > extra debugging. In the debugging case our container infrastructure
>> > will be "evacuating" any other workloads on the same host to avoid
>> > unnecessary consequences. The point is to not disturb
>> > workload-under-human-debugging as much as possible, so we'd like to
>> > keep userns intact, which is why mounting extra (more permissive) BPF
>> > token inside already running containers is an important consideration.
>>
>> This example (as well as Yafang's in the sibling subthread) makes it
>> even more apparent to me that it would be better with a model where the
>> userspace policy daemon can just make decisions on each call directly,
>> instead of mucking about with different tokens with different embedded
>> permissions. Why not go that route (see my other reply for details on
>> what I mean)?
>
> I don't know how you arrived at this conclusion,

Because it makes it apparent that you're basically building a policy
engine in the kernel with this...

> but we've debated BPF proxying and separate service at length, there
> is no point in going on another round here.

You had some objections to explicit proxying via RPC calls; I suggested
a way of avoiding that by keeping the kernel in the loop, which you have
not responded to. If you're just going to go ahead with your solution
over any objections you could just have stated so from the beginning and
saved us all a lot of time :/

Can we at least put this thing behind a kconfig option, so we can turn
it off in distro kernels?

> Per-call decisions can be achieved nicely by employing BPF LSM in a
> restrictive manner on top of BPF token (or no token, if you are ok
> without user namespaces).

Building a deficient security delegation mechanism and saying "you can
patch things up using an LSM" is a terrible design, though. Also, this
still means you have to implement all the policy checks in the kernel
(just in BPF) which is awkward at best.

-Toke

