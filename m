Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11269EB64D7
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jun 2023 07:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjFUHhf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Jun 2023 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjFUHhb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jun 2023 03:37:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A47199C
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 00:37:26 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E7E683F72E
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687333043;
        bh=0BBJ0LDi0w4ZdUZcsI0xBEfRtekbhARUXPQztwGEa6I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bA07XX8lI9kcmbHrwiHipI1NMtkWCzNzFXi0BdP402DZhVAMB+VJ3r1SqBM+fl/Zo
         2BZVCfXRbVh0ErsAsJunHZbWc4fA0pjYDBWH5m8ikaiTknHF+gg+Qs6OBduYTE97kV
         TAN6C2pKaJv7WA1fk4XIVX9ILpmsdnex0l6g/erGe8JtBER04LpxhHkGy8P8gfd897
         H/pDeAmr4jeqWr5GnQbA0Gd+9FheKmzOFMOkWuA/FsFlaHczMPCYb/OOwlGekQRt0S
         UYxbD+fcXXCmAzFI9ZfTWIjM/Wr/gFQUvsBLwehzUZPOndfnmT58ACoWojnc+R2xrD
         J2nlXy7C67ZVA==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso6948252276.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jun 2023 00:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687333042; x=1689925042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BBJ0LDi0w4ZdUZcsI0xBEfRtekbhARUXPQztwGEa6I=;
        b=iPX4wWhBbKADMkC72AhLXAKcsRcE49Op7Ls0sxK52vO5NmNHIfpd3voYh+eE1PQJMn
         SKdw6AZC3ROGTOtyybTmC7q8mk2LW9xDeywUlOt6s1ML6Pab0F0GOTsl1+AtdVqA202K
         hlDo511p5RqaJnpnyYtuyxzIx+KL/r0eaWNNcLtXJp1MUuQjL5TZTt1aqDYb9ahHdHXe
         ey6rPt0acERJ/h79tlZJiheHjr82tRQ1UTNXxVlSYHNzaGk8eBuXq0wU8uzZ/oKYg6oS
         UsEnJxqnzqhkn+NhMTZ9RsDajN1ofEqLIN2shFyiV4o1wR3QHg4cO0U2CHsFJUtlpXXH
         tn+Q==
X-Gm-Message-State: AC+VfDy8osPfpcJhQ0iboWVFWPI59xvVNuX/HWT4AV0hOWmbP4D+VCmu
        W39EAe0sZr9tvw1Vm0FbNoajtsjmdUb3A7404wgDNyAmShxwF7mDXEkvkqnd0dYpiqwWmXtRUjK
        QkS6FTF9hX4X4iq4j8I7KvNsLLZV80KCzCJjnhqVyK5L+RxkpEHmfuHFs8ptt7PuByQO+ug==
X-Received: by 2002:a25:ac10:0:b0:bcd:783f:2e1b with SMTP id w16-20020a25ac10000000b00bcd783f2e1bmr10541316ybi.42.1687333042486;
        Wed, 21 Jun 2023 00:37:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tHDZFYaXDSVRucwgmdoRG2vE6TNCRinWiLzj7V6nqen5yfIorS73/gMsFYgOCmS4sSxlKMPYPmux+4ZsBA/Q=
X-Received: by 2002:a25:ac10:0:b0:bcd:783f:2e1b with SMTP id
 w16-20020a25ac10000000b00bcd783f2e1bmr10541309ybi.42.1687333042247; Wed, 21
 Jun 2023 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
 <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
 <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com> <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
In-Reply-To: <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 21 Jun 2023 09:37:11 +0200
Message-ID: <CAEivzxcbqQj+_Ouo1_csbzc2NHewpQW7zb3mo1Dkr07obK6zKw@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Paul Moore <paul@paul-moore.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 21, 2023 at 2:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 8, 2023 at 2:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > > >
> > > > > > pr_warn message clearly says that GID should be printed,
> > > > > > but we have UID there. Let's fix that.
> > > > > >
> > > > > > Found accidentaly during the work on isolated user namespaces.
> > > > > >
> > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@can=
onical.com>
> > > > > > ---
> > > > > > v2: __kuid_val -> __kgid_val
> > > > > > ---
> > > > > >  security/safesetid/lsm.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > I'm assuming you're going to pick this up Micah?
> > > > >
> > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Dear Paul!
> > > >
> > > > Thanks for your review!
> > > >
> > > > Gentle ping to Micah Morton :-)
> > >
> > > Micah?
> > >
> > > The right thing would be for Micah to merge this via the SafeSetID
> > > tree, however, considering that it's been over a month with no
> > > response, and this patch looks trivially correct, I can pick this up
> > > via the LSM tree if we don't see anything from Micah this week.
> >
> > Searching through all of the archives on lore I don't see any email
> > from Micah past August of 2022.  I'll still stick to the plan of
> > merging this via the LSM tree next week if we don't see any response
> > from Micah, but beyond this patch we may need to consider the
> > possibility that Micah has moved on from SafeSetID.
> >
> >  * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org

Hi Paul,

>
> This fell through the cracks in my inbox last week, but I just went
> ahead and merged this into lsm/next.

Thanks!

Kind regards,
Alex

>
> After the upcoming merge window closes we'll have to revisit
> SafeSetID's status as "supported", we might need to demote it to
> "maintained" or "odd fixes".
>
> --
> paul-moore.com
