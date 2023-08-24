Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF2C7113B
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Aug 2023 13:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbjHXNaz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Aug 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbjHXNaY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Aug 2023 09:30:24 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC827E5E
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 06:30:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59288c68eb8so3953037b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692883821; x=1693488621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP+QcejVj1IAxwt/Xnhj+6K+T+NnfjYzt0fpqA7S/o4=;
        b=ZrGUJEGXznceTqkt+A3CNZCJhBoUFFl4sdbY6ZhymJ+aMrvoTVYwRHfQU1SNcPz5p7
         dZ4XW6pJQAF5DqacJ7au0QpErHKMTWYurxLyMXGLt+SOtU0LWvj2N7vYyWj+fUDEw7VR
         NrDGlSFup4VNKvdG0q94TxRQ548l4HVOYqasoNOQazQQ71fANbbmx2kMIuBlM4uCGgmu
         2cRl+u3fahroEYoczplukhmWC4sOsPinJG9SkbGt3D6Y2rewRhyDRJj+OK3W5TEk1sNG
         LsOLcuu0iAwVBvg7Bp2pRuUjAs3wARIqdO0kH7LRw+phSXieA1ZiClPre8CmLbk4+sHr
         P4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883821; x=1693488621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP+QcejVj1IAxwt/Xnhj+6K+T+NnfjYzt0fpqA7S/o4=;
        b=hxOZuAhP/FJs5A5jqb2MYAJKo47HsQGxybfxVWnJGofbhnSHFZVa+cqtyXLeMLVLH8
         ai+RNZRumVAxj6kJdYBAX9S60tDPrXIekGcAbU3vFEuD4b9GT/fqZHKloREEwoSdj1IW
         EC1xvRCLFq9M2B0PLEQBJkKxCHXM4o6GJHYnn80whbHpIYBpJc2Qq4o7a8YzOkaff4Vp
         eFadaGh9TC9hHEbv96q33IwLEn2BEDBMu1HosMItTqIr5LM9e8rMfiVaIks2sVVk6VT3
         aos3mbBSmJHrLTeIyNryEOwkqVKMOBxvUHOZSbGLToTCdOvBTCUFRUf1+LQKam4vg0ab
         dhQw==
X-Gm-Message-State: AOJu0YwT6x8ervXm2+6C0DHLAJM1wWdp7MNJ8NJCTXFqBrToEX2eBzOT
        G+thFeMWxsSMjbt5MiYsHJruN+gvMQeq/TMO6Q6n
X-Google-Smtp-Source: AGHT+IGhXeLeT7QW6e6J9ev3sEFUT8aGAQb0iEvFjSXa+8fyJqa7ZqC9qEX1fcy6QLTFlKAqAtx5f7yTabzzlf9ZYA8=
X-Received: by 2002:a0d:db4b:0:b0:589:a095:76ca with SMTP id
 d72-20020a0ddb4b000000b00589a09576camr15838898ywe.44.1692883820964; Thu, 24
 Aug 2023 06:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com> <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
In-Reply-To: <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Aug 2023 09:30:10 -0400
Message-ID: <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 24, 2023 at 9:21=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/08/23 23:48, Paul Moore wrote:
> > We've already discussed this both from a kernel load perspective (it
> > should be able to handle the load, if not that is a separate problem
> > to address) as well as the human perspective (if you want auditing,
> > you need to be able to handle auditing).
>
> No. You haven't shown us audit rules that can satisfy requirements shown =
below.
>
>   (1) Catch _all_ process creations (both via fork()/clone() system calls=
 and
>       kthread_create() from the kernel), and duplicate the history upon p=
rocess
>       creation.

Create an audit filter rule to record the syscalls you are interested
in logging.

>   (2) Catch _all_ execve(), and update the history upon successful execve=
().

Create an audit filter rule to record the syscalls you are interested
in logging.

>   (3) Catch _all_ process terminations (both exit()/exit_group()/kill() s=
ystem
>       calls and internal reasons such as OOM killer), and erase the histo=
ry upon
>       process termination.

Create an audit filter rule to record the events you are interested in
logging, if there is an event which isn't being recorded feel free to
submit a patch to generate an audit record.

--=20
paul-moore.com
