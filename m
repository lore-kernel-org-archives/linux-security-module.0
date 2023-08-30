Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C4C83F14
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Aug 2023 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjH3XWo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Aug 2023 19:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbjH3XWo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Aug 2023 19:22:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93079C
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 16:22:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ccc462deca6so86555276.0
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693437759; x=1694042559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LozI1M1nDgeznkAZtWGyHDj2+KgA5la438X1P0EaA5s=;
        b=cySp0sOZnTMwEbhJ68+qL/175Hj5P9FnMDeS30SO9itNjgIFtma1xTqfRkkjo1gkPN
         hgLsO10tLmwLtqVBRDp/Cf3qfANfQRdg2WM/abxsn3LVRf3QHskwhZZLgb6dqZfWoYWZ
         rdq10SZDqYRersp/Us6mq1rjs3lN4nybnrAOfBS/dfwBhm0FxvvIf5bzU8Eg7uJJ3YAs
         Kz+rnsozEPsnUpe/DDdFEIicFCzXWavhGxPC5yAAogi6/5KOKoclSDyLwd3cCgttdefP
         a7g9+o1G6/3s1Y9yGaqTAdJG20mrP/uOsT0017koLxA/27iPQaepngLpBHrDZadB/r5A
         6H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437759; x=1694042559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LozI1M1nDgeznkAZtWGyHDj2+KgA5la438X1P0EaA5s=;
        b=HPpBjox/29Z6c6/AkUQATxkRdbofELXOkbrq5y7CdbP3e3n/SNPrOnQ2DW6Iu2afV1
         Ij+k4rCsz/LB6zlCQUUeCXpt0DPKBskC9vXEpJAuSpW+F1ik66LCPIZoqvleYXtKRwKB
         bc65R3VKGBpwBqAtGsLY7GRT3VO+kdNnAP3zHlJOA4ncuSzU75KxBPIb3roOSiKLWt4b
         rMAiSSpoq1/uO7RH9S69Um9SmzbuKevNPx8MVfsoZNhfkcHMxyx9Vlh9fG0VNARA+rxh
         xW4iK9GF2m/KQ7LNAue5dvlw0SyPghf43U0q/gmYBN1i3A5TQ2kWTziwzqwqQTMhd0rb
         zRqA==
X-Gm-Message-State: AOJu0Yyuro4TCjXkoUavQpJ1ITEIMjo5Qliw40/qD03St69Fbey+stXf
        3Rmg+snqHq/D1Rrl12XvO1lzllT4l/Q4TLuIuthd
X-Google-Smtp-Source: AGHT+IEYKAHbwaesSvMzTZIyHDlw17HvTNL4W6R0cqZW/wSeiJ3txeiz9+OtAj/abZjPlHDQh/Cz2DijmHMOIjZaSOY=
X-Received: by 2002:a0d:cc8e:0:b0:561:206a:ee52 with SMTP id
 o136-20020a0dcc8e000000b00561206aee52mr3775183ywd.24.1693437758924; Wed, 30
 Aug 2023 16:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com> <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
In-Reply-To: <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 19:22:27 -0400
Message-ID: <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 30, 2023 at 7:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2023-08-30 at 18:23 -0400, Paul Moore wrote:
> > On Wed, Aug 30, 2023 at 6:21=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> > > > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > > > On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@linux.i=
bm.com> wrote:
> > > > > > Your initial question was "what happens if the file/filesystem =
becomes
> > > > > > inaccessible at some point and an attestation client attempts t=
o read
> > > > > > the entire log?".  For what reason would it be inaccessible?  F=
or the
> > > > > > original single tmpfs file, what would make it inaccessible?
> > > > >
> > > > > In your reply that I had responded to you had mentioned that the
> > > > > kernel was simply being passed a fd and taking ownership of it, t=
he fd
> > > > > could either be a tmpfs backed file or some form of persistent st=
orage
> > > > > as both were discussed in this thread.  I imagine a tmpfs filesys=
tem
> > > > > could still be forcibly unmounted, resulting in problems, but I c=
an't
> > > > > say that for certain.  However, there are definitely cases where =
a fd
> > > > > backed against an arbitrary filesystem could run into problems:
> > > > > storage device issues for local filesystems, networking issues fo=
r
> > > > > network filesystems, and good old fashioned user/admin interventi=
on in
> > > > > both cases.
> > > >
> > > > "I imagine tmpfs filesystem could still be forcibly unmounted" soun=
ds
> > > > like an attack. Not being able to verify the measurement list again=
st a
> > > > quote is probably a good thing.
> > >
> > > Okay, can you answer the question for an arbitrary persistent
> > > filesystem?  That was always the more important question, ...
>
> The original proposal, not mine, suggested using a tmpfs file.   The
> idea of writing the measurements to a file on a persistent filesystem
> wasn't mine either.  Sush/Tushar were pushing for writing to a
> persistent file(s).  No argument from me that writing to a file on an
> arbitrary persistent filesystem is not a good idea.

Progress.  Okay, so we all now agree that the kernel writing to an
arbitrary filesystem is not a good idea, and using tmpfs doesn't solve
the problem of general memory pressure (from previously in this
thread), that's all helpful and good to clarify.

Assuming Sush and Tushar rework the document to clarify the
motivation/purpose for the work, as you suggested earlier, I'm
assuming we can revisit this problem and solutions?

--=20
paul-moore.com
