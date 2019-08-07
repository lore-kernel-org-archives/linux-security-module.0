Return-Path: <SRS0=7sjm=WD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4697C32751
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Aug 2019 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7822086D
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Aug 2019 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565206042;
	bh=o79TWZ+mUVuZGi4UUX5AuOgFw205pM5vxugxm6d3TmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uwp1K++wn3o6pEnaVFVcrDxrLHxxcLUqmWD3I2DbH+U1DYPbcvLCb86DJwE+FMQTO
	 KZ4rnwa6EcyEsKEtgJm/oRXnwN0Md2SZr/8s+wa/dtewxvjhGFTRkCIkr59dZC8Ap9
	 +s/Fh1tQ7+ZPc6kv1m9yx9rMbVnm0xItK4Zx596o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfHGT1V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:27:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37865 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfHGT1V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 15:27:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so32336151ljn.4
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLI/dZuWbaqL8omdl6ybUU9iyiQUmASMTLmgNEnkQ7Q=;
        b=ImvNRRFcTrYx/WRpkCnnrWjmGQg9PAYGBVto/5lqBFb/EMbjAW8t65uvZqHGT5g7hd
         tZYCxn5gIBrBLMW7CGWjPe7IatUD4Zhj0qTB+RjqpVkCDxuhV1gg34iUSHAHn7QbK1t4
         jEMt4JR9VdyxIT5nLPURsnE1QCskKKlq+OONo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLI/dZuWbaqL8omdl6ybUU9iyiQUmASMTLmgNEnkQ7Q=;
        b=Zn3Rws4ParFW8K8gvFR+rcrYdAM3fA9WqeJ0O0aPISswZObvNKAOasoNgd8r+LKbL8
         MIalfAaRH2yBLWkx5ra3F+neG9I84YGuN96TPuc0uuChV7FKXbKnD5izdprC4REbVzI1
         8uCWE51Hnp4vUNGwCfIJ1iU8DmzMJAcJHB9HZmtRec6wapVO+g3qCEWMVkT3wnnky8Ay
         ydk3O4xRosoPRNXf/9250fFNRT2Ey0johsB1k+h0ct8tIvgOVhN2eO/4LNoOQTGLmPBf
         8ur6F/oavLnJKULLh3bWtOdI4vdovheLsOVouhaL3yLqewMej5ElKZn/c459ElCnO31C
         ebzw==
X-Gm-Message-State: APjAAAV2uF+ocKbgWyS1wlQ/JBUNRXyjXeaXYTkbUHRIlhQUFZKF2NgF
        EwmJue45F2nLB0lqi0MLiTnokBlu66w=
X-Google-Smtp-Source: APXvYqwOy5Nm0lynHjrIrW3Xs8zjDtNVWTng81Lrpz6AHiXlfoTt37wr6n480/ZR8aNRT7RIh7/ptA==
X-Received: by 2002:a2e:b167:: with SMTP id a7mr5914426ljm.26.1565206039432;
        Wed, 07 Aug 2019 12:27:19 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s21sm18655557ljm.28.2019.08.07.12.27.18
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 12:27:18 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p197so64846830lfa.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 12:27:18 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr6999381lfp.61.1565206038089;
 Wed, 07 Aug 2019 12:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local> <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
 <20190805191136.GB4887@chatter.i7.local> <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
 <20190805192727.GA15470@chatter.i7.local> <CAJ-EccPFnR7fTFee3s_1Er+-zbhD8AqaJu_ifTLwHUykKmwJLg@mail.gmail.com>
In-Reply-To: <CAJ-EccPFnR7fTFee3s_1Er+-zbhD8AqaJu_ifTLwHUykKmwJLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Aug 2019 12:27:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEet1xGS14_x9hcbgXuYRFwqkTuw2AbM-UYZ=mc3Zmhw@mail.gmail.com>
Message-ID: <CAHk-=whEet1xGS14_x9hcbgXuYRFwqkTuw2AbM-UYZ=mc3Zmhw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 6, 2019 at 9:32 AM Micah Morton <mortonm@chromium.org> wrote:
>
> Unfortunately I didn't have the mental model quite right of what
> happens during the pull request. I was thinking along the lines of my
> commits being cherry picked onto your tree, rather than how it
> actually happens with git merge where my tree's commit history needs
> to match yours perfectly.

The "cherry-pick" model is what "git pull --rebase" does in reverse
(ie it pulls the exact history from the other end, and then rebases
the _local_ history on top of that).

But the cherry-picking model is entirely inappropriate for any bigger
project. Yes, you can do it locally on your _local_ small changes (but
see all the docs about why rebasing is not a great thing), but it's
entirely unmanageable and doesn't scale in the big picture.

It's why all the projects that were based on patch series were
complete and utter failures. A "patch series" only works locally. It's
not reasonable to scale and distribute.

Git fundamentally makes history a first-class immutable citizen, and
it's a major feature and a core design thing, and it's the _only_
thing that makes distribution possible. Whenever you rewrite history,
you fundamentally screw up a distributed model.

             Linus
