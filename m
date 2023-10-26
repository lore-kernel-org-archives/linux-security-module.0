Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A079C0032E
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 02:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZCn4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCnz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 22:43:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC3A4
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 19:43:53 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-457c441555cso210321137.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698288232; x=1698893032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n6Q3Bic/Lrumtwoi5KdHuryOnqTwMj862KK8rxBeLc=;
        b=eJjCv/AllSGb1NX63zdJCxQOYrV4Lkn/Fu8j9OdCOefKM+zbv9X1UqbsUR2X7zslfx
         0Ik0pBiYB3S+uZhYI20Y8im8QJEiWEVTa+DvhTEwS70jOoUqb2kkjjQviBn0pCFwYmYq
         VQhbTJezxTN+T4b/ePUF815+J7p6ScuMa2VbJ7ytOm9BVyCOLZceu0TvZcyI3HNmps0x
         wAmDbSCI4czwr0BCOnD67vX7598Q9np2Iedlnd9Pj1p2ALQgwFyX7Vda0K78H+bzcA+P
         2EhPzNoB6aFca1AGxvVfg7uZOJ2j2uyAQwUR+BYKtxC5FijcUZpr5fb/9XrOra3sJ2ii
         z01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698288232; x=1698893032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n6Q3Bic/Lrumtwoi5KdHuryOnqTwMj862KK8rxBeLc=;
        b=tU0c8GabwTrJmkKitkBldWukF21Fuju6YqZzJZgaVWTTWfDty/R12l5fQlft4l4q4r
         mght+ev41HYSUcGl8nmAzMEdCOWCPa84lTklJlDD2wmix3w/qb8h27hCUics4ea500i2
         fvQ9IaIBWHM9GQHr1GZo3WnhYEX8FEDERfD+CvfAeAukkkM15UedcJ8Q0Ng8Uz0MGODu
         E3Nv+J55ZxCiG7G5WjhGIxg5G070XjMAV09qB7KNVRNBfE3qrfc2HogTCuwFkGnWrBDE
         ufvl32snOVZ8cTpRdoNFSOsz9p8G5paswZOLOOunPGE5WEq1IR79tHMHjUAkYNnqE+dP
         9hdg==
X-Gm-Message-State: AOJu0Yz8qt5pS8LEueFCKUgoZTUioqQfkY/Gz+LipU8gobVPdTycN7hH
        0fX5t5KnOojE+rIO7zIYHyu2F9Ney83pxaNHIgN3wYOseoYn5ZQ=
X-Google-Smtp-Source: AGHT+IGVxqtfZgoMgOWW1BjXOllMm5ecp08Go0LnnT1X2wOpKXpGHUHuzDJTGd8OkGxiEdXgsaSFDZZfbRutANoAR4c=
X-Received: by 2002:a67:c210:0:b0:457:a913:e89d with SMTP id
 i16-20020a67c210000000b00457a913e89dmr13359591vsj.12.1698288232443; Wed, 25
 Oct 2023 19:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com> <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com> <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
 <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com> <CAHC9VhSVcfsCM6GjxJrSPCXV3PYRahXJi5HiNyKGCt8f_fOpmA@mail.gmail.com>
 <93b2ea72-a9b1-4d50-bc4a-3d60d91dd44b@huaweicloud.com> <CAHC9VhQ3kKGWNUx=+vEZ58CUJo2YKVu4rrOjE+w5x9jKnP9MWA@mail.gmail.com>
 <fb6e908e-55b4-4264-a50e-31de4ce538f5@huaweicloud.com>
In-Reply-To: <fb6e908e-55b4-4264-a50e-31de4ce538f5@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 22:43:41 -0400
Message-ID: <CAHC9VhS4jPm58Wtpq6DBrmAqNBSrZN8+ubvqoXo7LjFWCs-gDA@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 25, 2023 at 10:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 10/25/2023 3:14 PM, Paul Moore wrote:
> > On Wed, Oct 25, 2023 at 6:36=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >> On 10/24/2023 11:18 PM, Paul Moore wrote:
> >>> On Mon, Oct 23, 2023 at 11:48=E2=80=AFAM Casey Schaufler <casey@schau=
fler-ca.com> wrote:
> >>>> On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> >>>>> On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> >>>>>> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> >>>>>>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> >>>>>>>> When IMA becomes a proper LSM we will reintroduce an appropriate
> >>>>>>>> LSM ID, but drop it from the userspace API for now in an effort
> >>>>>>>> to put an end to debates around the naming of the LSM ID macro.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>>>>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>>>
> >>>>>>> This makes sense according to the new goal of making 'ima' and 'e=
vm' as
> >>>>>>> standalone LSMs.
> >>>>>>>
> >>>>>>> Otherwise, if we took existing LSMs, we should have defined
> >>>>>>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
> >>>>>>>
> >>>>>>> If we proceed with the new direction, I will add the new LSM IDs =
as
> >>>>>>> soon as IMA and EVM become LSMs.
> >>>>>>
> >>>>>> This seems right to me. Thank You.
> >>>>>
> >>>>> Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
> >>>>> the 'integrity' LSM to reserve space in the security blob without L=
SM
> >>>>> ID (as long as it does not register any hook)?
> >>>>
> >>>> That will work, although it makes me wonder if all the data in the '=
integrity' blob
> >>>> is used by both IMA and EVM. If these are going to be separate LSMs =
they should probably
> >>>> have their own security blobs. If there is data in common then an 'i=
ntegrity' blob can
> >>>> still makes sense.
> >>>
> >>> Users interact with IMA and EVM, not the "integrity" layer, yes?  If
> >>> so, I'm not sure it makes sense to have an "integrity" LSM, we should
> >>> just leave it at "IMA" and "EVM".
> >>
> >> The problem is who reserves and manages the shared integrity metadata.
> >> For now, it is still the 'integrity' LSM. If not, it would be IMA or E=
VM
> >> on behalf of the other (depending on which ones are enabled). Probably
> >> the second would not be a good idea.
> >
> > I'm not certain that managing kernel metadata alone necessitates a LSM
> > ID token value.  Does "integrity" have any user visible "things" that
> > it would want to expose to userspace?
>
> No, it doesn't. I already moved the LSM hook registration to 'ima' and
> 'evm'. Also the old 'integrity' initialization is done by 'ima' and 'evm'=
.
>
> DEFINE_LSM(integrity) exists only to reserve space in the security blob
> and to provide the security blob offset to the get/set functions.
>
> Maybe I send the patch set, so that you get a better idea.

If it isn't a big ask, sure, but I still need to get through the last
patchset you posted.  I do apologize for the delay on that, things
seem to be very busy recently.

--=20
paul-moore.com
