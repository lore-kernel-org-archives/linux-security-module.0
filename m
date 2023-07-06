Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFDEB64D9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jul 2023 11:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGFLdq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jul 2023 07:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFLdp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jul 2023 07:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7478D1BFD
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jul 2023 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688643166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EHgreaHSArQejpZwUzj9BVjiALWLnZxUNJL9dz55r4=;
        b=ipGryLgjXX8/Csq0az9lB8E81zy77GrB9dgGnN8ymKF+nFIpGsZ7FNEpxdhc0nat+UIpMJ
        ldDTNkGgImxth50w3J5m8/ZHBmsVNIM8pCt01HAEa3YE8x5TwluSw/TAg/KoB7Oamj+Qcs
        0vw+kbVdd47z2KP7WFlDyODnwlsPJxg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-ZijJOgUwMnOUp4Hj6_B9vA-1; Thu, 06 Jul 2023 07:32:45 -0400
X-MC-Unique: ZijJOgUwMnOUp4Hj6_B9vA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31286355338so312552f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jul 2023 04:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643164; x=1691235164;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EHgreaHSArQejpZwUzj9BVjiALWLnZxUNJL9dz55r4=;
        b=jyp5DwqXROY2T2uSVAo+FfB5GIB19PEOn63e7jWXS+KOwj/pYkw486UNKTrhWI66+n
         EX3HRqN3ZwPj6BZyzguZJ2ZQ7D75cJo7XVYCEg6KocQvfEJvIY6i6J6hV6KlxpRqBGvC
         nfaXF+hSyiV7zVa4AOr+VhZ7gx/BW39eJ8s2a9ORBZzXOVSXi+IBXeOUJi2GfHrxnZI7
         gbaGlXN53S8SLichaFsakT95fZVkyAaP68fRemDUudDUlJs0vzl0tDqUTsGaUwDKxdL/
         tjAfRHtLg72EUNL988Wl0ecdh/+dQs4g7dz0NGeYoJYSeVgaLcwi83Zlnk+/M3YgRn20
         9+vQ==
X-Gm-Message-State: ABy/qLY2v8GQe6Gxh8LkpQXul1KCPL0ecncgrkbwgMJl0zKvQTrIoNLS
        4cCMXWA1VqiO9V+J4xXzM8LjcWTOZ1vuifUHtX1zWY0yh2zTF2WCHAEbfNkbukr4Hm6XI5+HWHJ
        ySoQQsNlWH/MXHgyZqbFcEbnT1r5l9aBgewYA
X-Received: by 2002:a05:6000:1247:b0:313:eb29:4436 with SMTP id j7-20020a056000124700b00313eb294436mr1217119wrx.67.1688643164257;
        Thu, 06 Jul 2023 04:32:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwkRaxQNkD99ye545exOl5xhJyn9xK840Txrw0fb8M++KI1XK3XNcHZmk3ooEOtn36Sg1SYA==
X-Received: by 2002:a05:6000:1247:b0:313:eb29:4436 with SMTP id j7-20020a056000124700b00313eb294436mr1217103wrx.67.1688643163824;
        Thu, 06 Jul 2023 04:32:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d43cd000000b00314427091a2sm1620675wrr.98.2023.07.06.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:32:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97148C59677; Thu,  6 Jul 2023 13:32:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
In-Reply-To: <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner>
 <CAHC9VhTDocBCpNjdz1CoWM2DA76GYZmg31338DHePFGq_-ie-g@mail.gmail.com>
 <20230705-zyklen-exorbitant-4d54d2f220ad@brauner>
 <CAEf4Bza5mUou8nw1zjqFaCPPvfUNq-jpNp+y4DhMhhcXc5HwGg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Jul 2023 13:32:42 +0200
Message-ID: <87a5w9s2at.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> Having it as a separate single-purpose FS seems cleaner, because we
> have use cases where we'd have one BPF FS instance created for a
> container by our container manager, and then exposing a few separate
> tokens with different sets of allowed functionality. E.g., one for
> main intended workload, another for some BPF-based observability
> tools, maybe yet another for more heavy-weight tools like bpftrace for
> extra debugging. In the debugging case our container infrastructure
> will be "evacuating" any other workloads on the same host to avoid
> unnecessary consequences. The point is to not disturb
> workload-under-human-debugging as much as possible, so we'd like to
> keep userns intact, which is why mounting extra (more permissive) BPF
> token inside already running containers is an important consideration.

This example (as well as Yafang's in the sibling subthread) makes it
even more apparent to me that it would be better with a model where the
userspace policy daemon can just make decisions on each call directly,
instead of mucking about with different tokens with different embedded
permissions. Why not go that route (see my other reply for details on
what I mean)?

-Toke

