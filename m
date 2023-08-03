Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B283C41513
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 21:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjHCVgh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHCVgg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 17:36:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C52C30F6
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 14:36:35 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a7781225b4so152764b6e.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691098594; x=1691703394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H65YV0mXsBrDwaLhfjAIVPFHC4txE29o4v52O46fpYE=;
        b=JGQXuiFPLwMGt3r+9wI79MIcQcAuVaR0Zi+sM8EXzPXO8IxBuAk3wnY+KTKw4erASI
         yyxN2se2O1ojtjXoroa8ZSwQEpYjJ233bwqQY793JIE9iJ7vVKPUHEa0NsCuOGxeKk4J
         H9gV3fxFwP/2tpBdF6pzzEml+oSLLWgW5Bkpr3nSilADN4ckupwPZQIxmy7iXY7lo+vv
         qRB/ZHjCKAjevOT6nsE8jaZwYChEI/uSQ2pLO0iSQnkKsKIxJplbU68k8UxHb0clYA4X
         4NnCjhCWZ9sdo/s2aECVGanJ9EULZGXPJRNBVUehSnH3fvrgB5LSj0RREdFKCpxFxeIJ
         9gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691098594; x=1691703394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H65YV0mXsBrDwaLhfjAIVPFHC4txE29o4v52O46fpYE=;
        b=lTP9cby65IBWyIB64b/ELXZKETcgZkKvUtqUtCjVAfi5AR4XLJ/W4pMva3inwWpQA/
         HxWh1cxtVrl6Kwa6LPkEPAVO6yYC74iqGGe8Jb0kbfrHF0JE1gHyUxsye0bXEpn4A9SA
         rk8SVxiFcfsLrR7kGnnNGZdWB48h23AMAPWQzE3Cv3MoEciuJTqCApWRsmOl+oVH2BO8
         LlaWIuv8SbRTIwYKUxJOhVRzliXywdqgpuc9F0k4He37K/0NlYBmXN6icB5Oo6BzJ0Dx
         AtYQmHG1scxmqihTF8k/0IPFqO3LPv/CIdKVgE8UTpluY2UIux6dvgYLjYsb2b5cqce5
         oVkA==
X-Gm-Message-State: ABy/qLa/RKDHK1njYEuVHhw9sDc3V/aQe5RL5OosxzUfEmG125Fd8UBz
        /bavjTn90naniAybIABI7MLuuGDsoXT4+RRdDQGH
X-Google-Smtp-Source: APBJJlHI6Vnodk0t5RxWsdDsJDmgJUvqD5T9v4GV8qFm0Kj2mSxwy1/T2ArUNHswC47JY+o8XXXDzooAAfddc2j8zLM=
X-Received: by 2002:aca:2117:0:b0:3a7:146d:85b5 with SMTP id
 23-20020aca2117000000b003a7146d85b5mr16968781oiz.52.1691098594544; Thu, 03
 Aug 2023 14:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <20230802.doki9xoTh0ai@digikod.net> <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
 <20230803.Ahk8eith7xei@digikod.net>
In-Reply-To: <20230803.Ahk8eith7xei@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 17:36:23 -0400
Message-ID: <CAHC9VhQ3ViRdnbVgP7FXFaGi1hSLYX2RJcFNrvJp-Y1Mt1fc8Q@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 3, 2023 at 5:44=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Aug 02, 2023 at 05:56:42PM -0400, Paul Moore wrote:
> > On Wed, Aug 2, 2023 at 2:38=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
>
> [...]
>
> > > > * There must be at least one LSM implementation of the hook include=
d in the
> > > > submission to act as a reference for additional LSM implementations=
.  The
> > > > reference implementation must be for one of the upstream, in-kernel=
 LSMs; while
> > > > the BPF LSM is an upstream LSM, it's nature precludes it from being=
 eligible as
> > > > one of the in-kernel LSMs.
> > >
> > > To avoid misunderstanding, I think it would be better and more generi=
c
> > > to focus on the out-of-tree nature of hook implementations.  We might
> > > also want to give some pointers for the reason(s) why out-of-tree LSM=
s
> > > use cases are not supported.
> >
> > I'm open to new language here if you have some particular wording in mi=
nd?
>
> What about this?
>
> * Every hook must demonstrate its usefulness and be actually used by
>   in-kernel code.  This is required to understand the purpose of the LSM
>   hooks, their expected semantic, and to be able to guarantee security
>   properties throughout kernel code changes (e.g., thanks to regression
>   testing).  This means that out-of-tree kernel code and pass-through
>   implementations (e.g., BPF LSM) are not eligible for such reference
>   implementations.

Nice.  I made some slight changes while adding it to the doc, take a
look and let me know what you think.

> > > > * The new LSM's author(s) must commit to maintain and support the n=
ew LSM for
> > > > an extended period of time.  While the authors may be currently emp=
loyed to
> > > > develop and support the LSM, there is an expectation upstream that =
support will
> > > > continue beyond the author's employment with the original company, =
or the
> > > > company's backing of the LSM.
> > > >
> > > > * New LSMs must include documentation providing a clear explanation=
 of the
> > > > LSM's requirements, goals, and expected uses.  The documentation do=
es not need
> > > > to rise to the level of a formal security model, but it must be con=
sidered
> > > > "reasonable" by the LSM community as a whole.
> > >
> > > I guess defining the threat model would be a good first step (and we
> > > should probably add this kind of description for current LSMs as well=
).
> >
> > I believe that should be captured in the "requirements, goals, and
> > expected uses" portion of the requirement above, but if you believe it
> > should be more explicit let me know.
>
> I think explicitly using "threat model" in this paragraph would be a
> good idea.

Okay, I reworked that requirement slightly, please give it a look

--=20
paul-moore.com
