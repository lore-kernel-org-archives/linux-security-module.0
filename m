Return-Path: <SRS0=lKIS=YU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BACA9EAF
	for <linux-security-module@archiver.kernel.org>; Sun, 27 Oct 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA05020679
	for <linux-security-module@archiver.kernel.org>; Sun, 27 Oct 2019 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572185046;
	bh=SF8ID9dlHeFbRYwBzozNy7Dlal4q4YlkPN2xgNlo7gQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UFG623pEO0TpBECzXNosP22VPW6WJ7pzSd9lFIcSJr1XI6yRnhDI1GLN0ZjdSva7T
	 yCvIcv4lNJbV1tGEykt7x1FGuAGrPqcGQwBMe/QGjTdRdMIQf3z6z+WLBD/KEDgZlL
	 LaabvwyW4zFxN6c131ZOakEwoK9EgoIP3UVfTuL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfJ0OD6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:03:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35805 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfJ0OD5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 Oct 2019 10:03:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so8570668lji.2
        for <linux-security-module@vger.kernel.org>; Sun, 27 Oct 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=UBVoDLidxhGRZnO3t3s9odW+975NWscpsgyn72pMoIFtMXrLI8gYCDX8RoEk4dUGpu
         XShVkulYmvYa4f4vPiGJkAOAAjj/NBHXSLZISLlhGaOzl5SAbZ6BhT9CpKJEgEzb8LhN
         G2c7dQQvyPPapIvGT5FeHB9zbcHI3CN4A0Ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=ECj9ZYwYUj0NzAf0yG4Yk7XRP5KadI0zhixiRmakWAsS1bMDyPDraw0vtLvMqt0/5o
         CYvJHOdS1hrRCziN3QsS6Tl0206V5Iq160cs21dfhGX5HW8ZJLufC87RN4pzOcu8wT6k
         tBxTZ6uB65FIH/NzPI3JVvkXuXeoQnmYifl1zIeyZVVop5hvwDpoOMSEmf9kVifLS8gK
         zITWyGVq8wjk8WJQlwiz6B/Nh8mtAbdBfnu0mbw14eNma8KfTZZwpk08AloU8xBPHep4
         mTlQeIsvTmZRtA6RUb5t2LsSLX6JndycFZXL/6pVHbLsCRTsDpA4b2DC3fj5J2j+PMZQ
         fOAw==
X-Gm-Message-State: APjAAAUIgz1NXGPUKJDc75CqbJFu22+E10G9p99i68slJI9Wg1X/ftpD
        AlCgfhSvjvFWGfw1G9GEXRmIzXUh42VQsQ==
X-Google-Smtp-Source: APXvYqw94yvxLzLyRkHH8mXRHgWD+HpMNXwUEyLruxhyr87dHsulhgVvRzT5nCD8SRu0vK91hAhs8w==
X-Received: by 2002:a2e:8e21:: with SMTP id r1mr1706645ljk.81.1572185034682;
        Sun, 27 Oct 2019 07:03:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s27sm4515301lfc.43.2019.10.27.07.03.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id t5so722580ljk.0
        for <linux-security-module@vger.kernel.org>; Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8760744ljp.133.1572185032112;
 Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 10:03:35 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This still has signs of that earlier series:

On Wed, Oct 23, 2019 at 4:17 PM David Howells <dhowells@redhat.com> wrote:
>
>                 if (rem >= ibuf->len) {
>                         *obuf = *ibuf;
>                         ibuf->ops = NULL;
> -                       pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
> -                       pipe->nrbufs--;
> +                       tail++;
> +                       pipe_commit_read(pipe, tail);
>                 } else {
>                         if (!pipe_buf_get(pipe, ibuf))
>                                 goto out_free;

with those odd "pipe_commit_read/write()" helpers.

They make no sense, and they don't make things more legible.

It's shorter and more obvious to just write

   pipe->head = head;

than it is to write

   pipe_commit_write(pipe, head);

Even when the addition of the notifications,  it's all under the
pipe->wait.lock, so it's all just regular assignments.

Now, if at some point it starts doing fancy lockless things, at _that_
point the updates might become more complex, but that's a potential
future thing that wouldn't be relevant for a while, and isn't a reason
to make the code more obscure now.

Hmm?

             Linus
