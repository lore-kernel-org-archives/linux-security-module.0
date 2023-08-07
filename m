Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC8CC001DB
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 21:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHGVxJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHGVxA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 17:53:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF40A8
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 14:52:57 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-586bacac98aso22373177b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691445176; x=1692049976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbatSTZTdcPYFZTHHpbiz4qGgfpEge2NxxVq5Y4//Ig=;
        b=LMFJxq1SS7gRwFlxGMP7DEFL4KwptA93nVOvbt0wX9ESWRb2QbGRJRXjdaPEXCiaj7
         14mTCm9oT+I1kh1pg3z2ozc0XnnRDHQu1BIj+vF1QLWKCWlKIVH3mKiRVwgM9BVWZx7v
         AceJ+P4F7j2KBz+F5styq+9gnjx+9XzSA88gLz66zalx4zbowGNSKI0TNxHRNYQzn+Q6
         q/CoDcJ/cFKUkZ39o/eh59+1YHo4EGMmmXe7t/0v8W5kE+5kNmT737pDA8kSWAXjOWUi
         V0xdfQery3gjptl8JL21Sh6DIpVysowedAnLTHgnZAvo1ur07pAF9x502AJ706E101lO
         eISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691445176; x=1692049976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbatSTZTdcPYFZTHHpbiz4qGgfpEge2NxxVq5Y4//Ig=;
        b=GoIOkvyhHELfWeleVL6zkmeJ5/+rKADt6Fm+Slm4rynI/cevr10v9rbtMhlcoIaQNS
         jrlYr67z0I7eSntbqXmGmXIorQxjr7osB9Q7eMQuSc6QZcYm0k1QhVwQmFUfTeVEMKAp
         n+QxLgu6E3mIM0SrrTIRCOxMIsizdBZ/ZqVSxtnUK1EXkRkIYpUyCDKwxTpr24Ve9R5F
         ABHn8FKjmk3D1ML9Yq6LBzEhbdaVuIf66d3zQTXiW/n5tI6IpmCjAKEhA6fyQtWPsalf
         /ErrdFTb1Gf+DLurcnW9EVmY2ZebRQPU5a02qX66NY8+XUex1c0WGqqwMFn+839ndmyh
         yVzA==
X-Gm-Message-State: AOJu0Yw6n82xRxJLAGxlQVwY451qvYvFSWs2nteW1yHbtJ8lbgY8Zg+p
        XGpDZW0NBlssSBYbhAScEFHVGyR9A22vDuG/vDnsfefEsgp/xZVR3w==
X-Google-Smtp-Source: AGHT+IEFOEMqjYNPhcq6oNY3YAPo+S6FqjZbDGAfQ4Z14G3ytMhFxUgzx8uU4FotXMzSKpZM8Fx5kb739I2OJfu6onk=
X-Received: by 2002:a0d:e24a:0:b0:577:31c6:b35b with SMTP id
 l71-20020a0de24a000000b0057731c6b35bmr8595851ywe.32.1691445176477; Mon, 07
 Aug 2023 14:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com> <20230804.at4Dei5LoiCa@digikod.net>
In-Reply-To: <20230804.at4Dei5LoiCa@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 17:52:45 -0400
Message-ID: <CAHC9VhSe=V-5QkR8UkXkqNt2Sf5fdx82mwXviy7hjpZ=PAJsQw@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 4, 2023 at 3:58=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Thu, Aug 03, 2023 at 05:38:23PM -0400, Paul Moore wrote:
> > On Wed, Aug 2, 2023 at 6:00=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > I've updated the README.md doc based on the feedback, and copied th=
e
> > > > two new sections below for easier review.  If anyone has any
> > > > additional feedback or concerns, please let me know.
> > >
> > > Another update based on feedback received (thanks everyone!).  Just a=
s
> > > before, I welcome any comments or feedback you are able to share.
> >
> > MOAR UPDATES!
>
> With some optional nitpicking, looks good to me!

Great, thanks for your help with the reviews, suggestions, etc.  I
think the guidelines are much better now than when we started.

> > ## New LSM Guidelines

...

> > * New LSMs must be accompanied by a publicly available test suite to ve=
rify
> > basic functionality and help identify regressions.  Test coverage does =
not need
> > to reach a specific percentage, but core functionality and any user int=
erfaces
>
> I'm not sure it is worth specifying the "not need" part, for tests and
> documentation paragraphs.

My goal with that was to try and not scare people away with a
tremendous documentation and/or testing burden to start.  I'd like to
keep it in the doc, but I understand your point.

> > It is important to note that these requirements are not complete, due t=
o the
> > ever changing nature of the Linux kernel and the unique nature of each =
LSM.
> > Ultimately, new LSMs are added to the kernel at the discretion of the
> > maintainers and reviewers.
>
> This paragraph sounds a lot like the last paragraph of the LSM hook
> section, but I don't have a better suggestion.

That's because it is pretty much the same paragraph :)

I agree, it would be nice if there were a little more different, but
given that the purpose is the same for each paragraph I'm not sure
spending a lot of time to make them read significantly different is
going to accomplish a lot.

--=20
paul-moore.com
