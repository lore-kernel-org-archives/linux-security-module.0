Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DCC83F01
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Aug 2023 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjH3WYT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbjH3WYT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Aug 2023 18:24:19 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8C10CF
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 15:24:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d9ba95c78so3405717b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693434239; x=1694039039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjWmqDok0J1WfVl6IlIiwasRztrJpGXO0N2RYmQkhlE=;
        b=FK9PLMVBb8bhNF9axFbLDEctH6cMDug7YHP+JINH2NWPmizxsOUJrRVDzSSWf0/Aty
         1effRL48crTRGByHebGHClJdY791G/xB3q5W+MmcT1pXEo2ild1P4nux3BbaJkDOHdQ5
         kp/HZmxdN8hP3zR7nnh6R8rN+9wz9qcxeI3Wa3fpRIy/LYwL4XQad0Mia6EdWtGTiZzX
         EFNXTnlHAFtNbb0TGPgxv9zu6NDpEpaiWbJ4CuHE/VTpxXhAwW871+ebunJm76zxUA8W
         diwBYDQKMPLepcfcSw7K6/LmkG/aE/FLovfSkOJ1tiTnj7ioThjijEH+i+Sit0Cuajwu
         udrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434239; x=1694039039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjWmqDok0J1WfVl6IlIiwasRztrJpGXO0N2RYmQkhlE=;
        b=aJruJKHuuqhBtXM5LKJn5DnF91tu7eZv1KF+AxBZS1V9D3n2lUy5tkRMPEdCoRC4Xk
         yA44QjDxu37sdRNcpjNKRUzmDOHJPPfksGM2vpLcZOLVXnNdPRHIPwuuYHGnBdTXEsIC
         CO7f1hxRsObxcIYJMCnuPdH5wu1nrrIr52nxdzgRoRv9t//J9SXULcqs6M/2fZZ3HD15
         UzRdchtXnJTgIG4yf3xcBvF/nK/z562AKqRXqmGyk7V9kTx2GEG4lHgF8XmUy41tMZ3P
         do4WahJV0F7YpaeGuNSyHOkC2kn/uzWqU6ishF2pyck1zoEE9R6hThlw6A8RHageysc7
         F/og==
X-Gm-Message-State: AOJu0Yyqqt8URJOohRrBmg6ueL/K0PxzSONADlC/RJX60L/ZXJvGFQUF
        AD0Oe3cLp+cjhn50buRRTUY9rSY9KMU/JoqaDS+C
X-Google-Smtp-Source: AGHT+IGrEi6pt0g8LModQuWcTQ9oESq9pt27wk/7QM3vj0Gkl/gBXWjflCeUVKhjBNYNZStP5dOPT7d4NSwl0eq/5AM=
X-Received: by 2002:a81:9981:0:b0:586:9cbb:eef4 with SMTP id
 q123-20020a819981000000b005869cbbeef4mr3404191ywg.2.1693434239191; Wed, 30
 Aug 2023 15:23:59 -0700 (PDT)
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
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com> <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
In-Reply-To: <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 18:23:48 -0400
Message-ID: <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 6:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> > > > Your initial question was "what happens if the file/filesystem beco=
mes
> > > > inaccessible at some point and an attestation client attempts to re=
ad
> > > > the entire log?".  For what reason would it be inaccessible?  For t=
he
> > > > original single tmpfs file, what would make it inaccessible?
> > >
> > > In your reply that I had responded to you had mentioned that the
> > > kernel was simply being passed a fd and taking ownership of it, the f=
d
> > > could either be a tmpfs backed file or some form of persistent storag=
e
> > > as both were discussed in this thread.  I imagine a tmpfs filesystem
> > > could still be forcibly unmounted, resulting in problems, but I can't
> > > say that for certain.  However, there are definitely cases where a fd
> > > backed against an arbitrary filesystem could run into problems:
> > > storage device issues for local filesystems, networking issues for
> > > network filesystems, and good old fashioned user/admin intervention i=
n
> > > both cases.
> >
> > "I imagine tmpfs filesystem could still be forcibly unmounted" sounds
> > like an attack. Not being able to verify the measurement list against a
> > quote is probably a good thing.
>
> Okay, can you answer the question for an arbitrary persistent
> filesystem?  That was always the more important question, and your
> continued avoidance is getting me increasingly annoyed.

Speaking of being annoyed, I'm fixing Tushar's email as the bounces
are also driving me nuts.

--=20
paul-moore.com
