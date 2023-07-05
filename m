Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34818EB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGEWrG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjGEWrG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 18:47:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB61993
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 15:47:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-577412111f0so1736507b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688597222; x=1691189222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiRVbzU08oyQvR0TryH1RBR9G2yTfyjwl0qT2qoUAko=;
        b=DYtGp3rs6K+XUasWKh1bGm5oQs3I7mkIuccVKpCD9C0pjIx2NTSlijl52ZmrIhmTU2
         q70/KbIrACuPqkKrtnfSOC/LtH5e6vzb15xQWGpMJ/hGT4PAfuCGskr/gCkJBiP7TlTo
         jzzWlR6sHfTqiCH8cyqZvehCOaQaoZMc3MLEeGEIkhQHQoXjrduBpYJFAa2MOUKEdLcJ
         ZGXji0zEi/8YXEk1crE59BdcALk4Sa23m0aWVmGMXtKJCxD6E1SMDQaGU9/3hskPm4py
         4MGTpQxSyQzP4Bn8gsngKfTYCXlQmzUqjKBAJa7mwUTFDrdMyQmYDRFUd/mxkrIQUKML
         suAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688597222; x=1691189222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiRVbzU08oyQvR0TryH1RBR9G2yTfyjwl0qT2qoUAko=;
        b=HND00B4SS55u5d20VKZfykfLx6NxvU+p8aNFkQ9y3BASCg4ZopAtGyaSCixNJNSXO0
         4pQaV05Df4zizD7N5/upcaReuSSAD0Lpkk1YmmNJXPV9t1/Z/8c4mzpzSF4Wtpa2Isop
         R64TUL481b+xRg79DHatij9xZZah4WlT2zZB2cfFLW5fDIWpn6WpSdrBi36oY51lvKhw
         51wuvvx4LNdjzk3udJsYQyW2MZGvhLzmR4MxfWR69Vn9ptLUPdsnCfaLL7IT/IKY29N9
         Z3JkxNK/tmgLx0hQpk4HAogre0xmpIwJM34Ua3frRF9dlbcl9viiRH6PKGuQswphua5O
         IGvg==
X-Gm-Message-State: ABy/qLaHcVmtmrtPIrHfjbKQQJattsWmdo3olaIkeoLNnrIlMPFnE1z8
        hsXmhKslMh4gId7FgUUcA11kvdq/NyzzhzuNlE2fGK40y0SFAxQbVw==
X-Google-Smtp-Source: APBJJlGZBWkUVQIO/ANgWviJnDuncwyghA6PZ/OWr9I3DbsrmR9/jfH+qx9RxyPTB+/9hhpjGorG2tszx4H3MNEC6kg=
X-Received: by 2002:a0d:d841:0:b0:577:189b:ad4 with SMTP id
 a62-20020a0dd841000000b00577189b0ad4mr409674ywe.48.1688597222458; Wed, 05 Jul
 2023 15:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230619123535.324632-1-ben.dooks@codethink.co.uk>
 <20230619175710.GA200481@mail.hallyn.com> <CAHC9VhRz0Y_D1Q=8xPKVJemYf=KUziC9s1TUJ86F+Lw+OrXdVg@mail.gmail.com>
 <ZJL+edmv267MHhdQ@jerom>
In-Reply-To: <ZJL+edmv267MHhdQ@jerom>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 18:46:51 -0400
Message-ID: <CAHC9VhSJ5+L4fG-1nPVnPeU=c4Tw22KJkVZnmMfDh-nF39NUzQ@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix sparse warning about __user access
To:     Serge Hallyn <serge@hallyn.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 21, 2023 at 9:43=E2=80=AFAM Serge Hallyn <serge@hallyn.com> wro=
te:
> On Mon, Jun 19, 2023 at 05:47:54PM -0400, Paul Moore wrote:
> > On Mon, Jun 19, 2023 at 1:57=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > >
> > > On Mon, Jun 19, 2023 at 01:35:35PM +0100, Ben Dooks wrote:
> > > > The two syscalls for capget and capset are producing sparse warning=
s
> > > > as sparse is thinking that the "struct __user_cap_data_struct" is m=
arked
> > > > user, which seems to be down to the declaration and typedef at the =
same
> > > > time.
> > > >
> > > > Fix the following warnings by splutting the struct declaration and =
then
> > > > the user typedef into two:
> > >
> > > I'm not a fan of making code changes to work around scanners'
> > > shortcomings, mainly because eventually I assume the scanners
> > > will learn to deal with it.
> > >
> > > However, I don't like the all-in-one typedef+struct definition
> > > either, so let's go with it :)
> > >
> > > Paul, do you mind picking this up?
> >
> > Sure, no problem.  Since we are at -rc7, I'm assuming this can wait
> > until after the merge window?
>
> Yeah, it's just fixing a sparse warning, no urgency.

Actually, this looks like a dup of 55382134366e ("capability: erase
checker warnings about struct __user_cap_data_struct") which is
currently in Linus' tree.

Thank you for your patch Ben, but it looks as if we had a patch a
couple of weeks before yours which fixed the same problem.  If you
notice continuing problems with the latest kernel sources from Linus
please let us know.

--=20
paul-moore.com
