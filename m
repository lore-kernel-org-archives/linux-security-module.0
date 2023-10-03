Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC418E8FDC0
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Oct 2023 23:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjJCXjm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJCXjl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 19:39:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC7B0
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 16:39:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so1701189276.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696376377; x=1696981177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYi9a5Lcbt9IRltWB1OppQxmM3lJh7jtqs7RskkmtuM=;
        b=akr0BuFBDqIHKuvrOrenO3ynvmkxFhp6rWxp9depfaFddya30/J3nulma71DBsbDpf
         R0hxKh0LqyEomKXYG/8YIqkRjGdeb+ot7c0gUD3o//v8eTCwRE3GaehFQpu+LyUfjvX/
         oDt/t2MAFumJRJJ6yB5KJegCvC0vQ/tHdtwGsnmAFOX2fh0iosuJmUsAZROgX7n/UFLr
         n4D00lQSK+GMyXk06nQOZqW+Khl9rPMws1xEGWbbXwivrzrE2rnY4o/JrXkl4ITm0Fsv
         ZJbljqf4gX06jo+jv7Fy7VqKVu92VAvHcCra2Y3Hnk4N7tYjf0qkco2tiT3bCouXUXdY
         7nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376377; x=1696981177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYi9a5Lcbt9IRltWB1OppQxmM3lJh7jtqs7RskkmtuM=;
        b=FUrruGwUbs96V5RK7buT5RwGbzYnWOfgktBml0IFnpv3o4ysuz2mScOKZtJ151Af85
         hpMweNRMg2gODhufjz9+twEthP8WEGg0fC93cwoHMd4TGphNunBvmyMsVwX90O7wa2rC
         yE59ArqpZyWjwcUtQBruP06b09AM/0YmDWo/9blzpYN3pQHbuJNgGkpybPR7lC4WiZgd
         iMnjxjAVsh4ZdcI89lq8bAqZnEQnyze6LlX0BXd6ccnnKkBORWQcHe3ibTFQKpHIQnBa
         uuYOQhiK8qLYW0RcuYZdz2ZHlQW+Vl4NsEVdBieH/UcPcDfG0vtSLW+mlKjdIByIrDzd
         oIog==
X-Gm-Message-State: AOJu0YwJzFV20ZzOtygeWdapa8LuZVfFCTg2vOH2DC4/T/SVfV1XWAcQ
        fOeIL04pSHQAV8WuRSE7irsNQz7lTnGe99p5xmccPLNol5HT2ds=
X-Google-Smtp-Source: AGHT+IG/Dus7X+cunbXxgkUMUjQCjirv1MW6BUS7xU1MRXxm2CaYGpDUHnh1CG3uibgQeV4/s5V5YyIpR+DIBl+xXVY=
X-Received: by 2002:a25:2d05:0:b0:d09:96fe:ac23 with SMTP id
 t5-20020a252d05000000b00d0996feac23mr739387ybt.3.1696376376866; Tue, 03 Oct
 2023 16:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com> <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org> <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
 <202310021000.B494D0DD@keescook>
In-Reply-To: <202310021000.B494D0DD@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Oct 2023 19:39:25 -0400
Message-ID: <CAHC9VhQFywb+CG2hAuHGRkdo3iMEGVogrdV_S6dZhfWJ0ACvOg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 2, 2023 at 1:06=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Mon, Oct 02, 2023 at 07:04:27PM +0900, Tetsuo Handa wrote:
> > On 2023/10/02 0:44, Kees Cook wrote:
> > > On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-lov=
e.SAKURA.ne.jp> wrote:
> > >> Kees Cook said there is no problem if the policy of assigning LSM ID=
 value were
> > >>
> > >>  1) author: "Hello, here is a new LSM I'd like to upstream, here it =
is. I assigned
> > >>              it the next LSM ID."
> > >>     maintainer(s): "Okay, sounds good. *review*"
> > >>
> > >>  2) author: "Hello, here is an LSM that has been in active use at $P=
lace,
> > >>              and we have $Xxx many userspace applications that we ca=
nnot easily
> > >>              rebuild. We used LSM ID $Value that is far away from th=
e sequential
> > >>              list of LSM IDs, and we'd really prefer to keep that as=
signment."
> > >>    maintainer(s): "Okay, sounds good. *review*"
> > >>
> > >> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-48=
4129c4c0ec@I-love.SAKURA.ne.jp .
> > >>
> > >> But Paul Moore's response was
> > >>
> > >>  No LSM ID value is guaranteed until it is present in a tagged relea=
se
> > >>  from Linus' tree, and once a LSM ID is present in a tagged release
> > >>  from Linus' tree it should not change.  That's *the* policy.
> > >>
> > >> which means that the policy is not what Kees Cook has said.
> > >
> > > These don't conflict at all! Paul is saying an ID isn't guaranteed in=
 upstream
> > > until it's in upstream. I'm saying the id space is large enough that =
you could
> > > make a new out of tree LSM every second for the next billion years. T=
he upstream
> > > assignment process is likely sequential, but that out of sequence LSM=
s that show
> > > a need to be upstream could make a case for their existing value.
> >
> > Excuse me? If the LSM community wants the assignment sequential, the LS=
M community
> > cannot admit the LSM value assigned to a not-yet-in-tree LSM.
> >
> > If "Okay, sounds good." does not imply that the LSM community admits th=
e LSM value
> > assigned to a not-yet-in-tree LSM, what did "Okay, sounds good." mean?
>
> I'm saying that if someone participates with upstream correctly, they'll
> get a sequential ID since that is the expected process.
>
> And if an LSM is out of tree for years and years in some large ecosystem
> that has deeply hard-coded the LSM ID but now wants the LSM to land
> upstream, then it's likely that an out-of-sequence ID would be accepted.
>
> My point is that there is nothing technical stopping an out-of-tree LSM
> from existing, and that the political issues for bringing a large
> out-of-tree LSM upstream are going to have plenty of other negotiations
> around maintaining operational behavior, of which and LSM ID is unlikely
> to be a sticking point. Every release that some code (LSM or not) is out
> of tree makes it that much harder to land upstream. (In other words, the
> challenges to upstreaming a long-time-out-of-tree codebase are much
> larger than dealing with an out-of-sequence LSM ID.)

Tetsuo, just in case there is any doubt in your mind, I agree with
Kees' comments above and I reaffirm my previous statement about LSM ID
guarantees.

As far as I can tell this RFC isn't really about dynamically loadable
LSMs, it's about blocking the LSM syscall work, specifically the LSM
ID tokens.  As I've said many times before, the LSM ID concept is
moving forward and if you can't respect that decision, at least stop
wasting our time.

--=20
paul-moore.com
