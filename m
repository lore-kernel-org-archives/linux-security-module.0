Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E9C0032E
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjJZCyh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 22:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJZCyb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 22:54:31 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BAA1B2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 19:54:27 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b6f67c708eso197631241.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 19:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698288867; x=1698893667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGsrLDR8jIOIct2kJcAZdQgm4zTZ1wuXwG8NgNxnX/Y=;
        b=aDMuCoyTrBMReRTmcMuLRdyqyZW17FsPm4MPQ9lSrzcc+GEeoEcUeoXT+oin42omh4
         WaBqoDFbtMVX5t7nm0JmlUmidX7gU4FHzLyL8EUBH+VnFwU6aGdvnAVSSGouyZQevC4l
         7NP0AnFAIU5t6hflpivX5XE0mTnxe9WWNxfU4uNxO7sPk4dCgQEq6CGHUmGgZKifFJjS
         tQsnURyN57gaQhGVowKhRA0V6xgp3scO7GzjXFKQLhfjzFC/9YaxiJCfoT3DBpZ6aV8f
         qtDN8Hbp6M8ZuPISlGFjXz8zTx028YHbJMd9QNvAVMaYsYMgpKY0nL8213R0EBnTc8Ec
         W5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698288867; x=1698893667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGsrLDR8jIOIct2kJcAZdQgm4zTZ1wuXwG8NgNxnX/Y=;
        b=bj6VH1EhY+nB0sMtxFQWDN/+oOCQRSJm8tmK3TnFdAizHjk6tGwzoMPjVeKQW7Z5Ci
         4WJHxOdodpZmgUUg3AjvPtbafrFXQFnrbOijf+FfFodTEa/LK4wUJW9zba0vGDfTzfGP
         32TrSdhpBit9CZXMlUly1B30rvDMjQ3TGZw/GopJnXcXAuPsAPgurVQrWgrp9KY7hVmc
         lvhsmQDcqObSd66CnAMp6GrGBpDD3FN36vYNKXGnlWb5EJ7K5LvK9F0dcTxw7svSMND+
         jcm5+itYNZqGWrVVbgdcosY97nL9L2RWW0OCO/g7+DujgbyxRs0Ejjukd5vduZ/OwpDp
         efYA==
X-Gm-Message-State: AOJu0YzAdXUdx9gcYMdJxUGNUebo3kB2GoBVSoUGRIZrAdDnrX6Q/Ud/
        oFMvus+6CrqQcKwrdcsVgVitySTjyi6LM+kyEp4w
X-Google-Smtp-Source: AGHT+IFS0HEDGr98prK00wyCm9jQuCqJtI3quVYhzmXn9dh5KpzQ0maGFi0PTC8N4L9z1yoQfMhEG90dmNizuDz5OaU=
X-Received: by 2002:a67:c89a:0:b0:458:8a35:ad7e with SMTP id
 v26-20020a67c89a000000b004588a35ad7emr15997784vsk.32.1698288866921; Wed, 25
 Oct 2023 19:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com> <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com> <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
 <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com> <CAHC9VhSVcfsCM6GjxJrSPCXV3PYRahXJi5HiNyKGCt8f_fOpmA@mail.gmail.com>
 <93b2ea72-a9b1-4d50-bc4a-3d60d91dd44b@huaweicloud.com> <CAHC9VhQ3kKGWNUx=+vEZ58CUJo2YKVu4rrOjE+w5x9jKnP9MWA@mail.gmail.com>
 <fb6e908e-55b4-4264-a50e-31de4ce538f5@huaweicloud.com> <3e35d87e-bde0-4276-ae3e-761ee1d02c4a@huaweicloud.com>
In-Reply-To: <3e35d87e-bde0-4276-ae3e-761ee1d02c4a@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 22:54:16 -0400
Message-ID: <CAHC9VhQ9D1EB9mSRakrCQ9rKUC+Pi2in6MLbZsm6Y3vA5BkweQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 25, 2023 at 10:37=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 10/25/2023 4:06 PM, Roberto Sassu wrote:
> > On 10/25/2023 3:14 PM, Paul Moore wrote:
> >> On Wed, Oct 25, 2023 at 6:36=E2=80=AFAM Roberto Sassu
> >> <roberto.sassu@huaweicloud.com> wrote:
> >>> On 10/24/2023 11:18 PM, Paul Moore wrote:
> >>>> On Mon, Oct 23, 2023 at 11:48=E2=80=AFAM Casey Schaufler
> >>>> <casey@schaufler-ca.com> wrote:
> >>>>> On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> >>>>>> On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> >>>>>>> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> >>>>>>>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> >>>>>>>>> When IMA becomes a proper LSM we will reintroduce an appropriat=
e
> >>>>>>>>> LSM ID, but drop it from the userspace API for now in an effort
> >>>>>>>>> to put an end to debates around the naming of the LSM ID macro.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>>>>>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>>>>
> >>>>>>>> This makes sense according to the new goal of making 'ima' and
> >>>>>>>> 'evm' as
> >>>>>>>> standalone LSMs.
> >>>>>>>>
> >>>>>>>> Otherwise, if we took existing LSMs, we should have defined
> >>>>>>>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
> >>>>>>>>
> >>>>>>>> If we proceed with the new direction, I will add the new LSM IDs=
 as
> >>>>>>>> soon as IMA and EVM become LSMs.
> >>>>>>>
> >>>>>>> This seems right to me. Thank You.
> >>>>>>
> >>>>>> Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and kee=
p
> >>>>>> the 'integrity' LSM to reserve space in the security blob without =
LSM
> >>>>>> ID (as long as it does not register any hook)?
> >>>>>
> >>>>> That will work, although it makes me wonder if all the data in the
> >>>>> 'integrity' blob
> >>>>> is used by both IMA and EVM. If these are going to be separate LSMs
> >>>>> they should probably
> >>>>> have their own security blobs. If there is data in common then an
> >>>>> 'integrity' blob can
> >>>>> still makes sense.
> >>>>
> >>>> Users interact with IMA and EVM, not the "integrity" layer, yes?  If
> >>>> so, I'm not sure it makes sense to have an "integrity" LSM, we shoul=
d
> >>>> just leave it at "IMA" and "EVM".
> >>>
> >>> The problem is who reserves and manages the shared integrity metadata=
.
> >>> For now, it is still the 'integrity' LSM. If not, it would be IMA or =
EVM
> >>> on behalf of the other (depending on which ones are enabled). Probabl=
y
> >>> the second would not be a good idea.
> >>
> >> I'm not certain that managing kernel metadata alone necessitates a LSM
> >> ID token value.  Does "integrity" have any user visible "things" that
> >> it would want to expose to userspace?
> >
> > No, it doesn't. I already moved the LSM hook registration to 'ima' and
> > 'evm'. Also the old 'integrity' initialization is done by 'ima' and 'ev=
m'.
> >
> > DEFINE_LSM(integrity) exists only to reserve space in the security blob
> > and to provide the security blob offset to the get/set functions.
> >
> > Maybe I send the patch set, so that you get a better idea.
>
> Uhm, we should have updated security.c and removed:
>
>          (IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \

With LSM_CONFIG_COUNT only being used inside security_add_hooks() I
believe you are correct.  Do you want to send a patch against
lsm/dev-staging?

--=20
paul-moore.com
