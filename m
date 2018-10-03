Return-Path: <SRS0=gg+Z=MP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39033C64EBC
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Oct 2018 00:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CBA2082A
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Oct 2018 00:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4CQvmW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CBA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeJCG66 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:58:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37604 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCG66 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Oct 2018 02:58:58 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so1576102ywa.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X5BnuAGhgfj4DUNsWuwoN0sZkV1YAJwtcmx3txcghz0=;
        b=D4CQvmW2TA1WvT7TeKvuETP4MpHuHFm4D7Fj859S51UPV57DvMYXoVD+/kPXRx9ZTS
         Wk++7esffUgh551V568wm99Of6FhfuGptyi6suZbHU2VacHbQfrPw/9lZOwIQo8uRqvX
         Nl7r5ZNpcOGQHiX0hN55oKhsDd4e0hLtJLIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X5BnuAGhgfj4DUNsWuwoN0sZkV1YAJwtcmx3txcghz0=;
        b=R82d3st3KrImGOXic34IckkSUsZLgMAwJVAVX8QJCMgEhh8q1OZNzkBYvYQ62f/fvi
         X1my0Ub8d1v8l+dohWmnCIeqcpFEHDLBshcvHT4jfbPhnPSa63PJynr0qZ7EzgGZOigI
         tHbz9fkLvcFjcHJT/ySGBSOgJVIbu+osvHPIVbKHf9S2vTmd8FqVWY2q+GmAvqjYKX/0
         4hE36VogvISQC1jme8Kt+5CT4SeO0q0IoaT1W8vqcSDPIc78KG0w1H1rh70BbdIj3YUq
         3q9p+XTOGqkXhnSjx4DGcQB4GRHi+g8gl8L3OkcpOEeiG04NiAjCFOAe8d7R2bPXfMkn
         Ao5w==
X-Gm-Message-State: ABuFfoies2E6VubPseVNNHConK9SxPEW2uWJAYTvEoU5ry7NHuq8OqCi
        PK8JaGb7E5o56jLmaKWtPWmQedo/HVg=
X-Google-Smtp-Source: ACcGV629XhCSIf6nbCgzDlLT6bFFta2T60d+7JCfAv23LbA6mb6PqPhcotgqxUULg8OL1KQ6ClEhtA==
X-Received: by 2002:a81:8a84:: with SMTP id a126-v6mr9867758ywg.104.1538525581102;
        Tue, 02 Oct 2018 17:13:01 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id z125-v6sm6899357ywe.72.2018.10.02.17.12.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j202-v6so1559253ywa.13
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr10168177ywd.124.1538525579097;
 Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 17:12:58 -0700 (PDT)
In-Reply-To: <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 17:12:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ-2V5ch-Qer_O0mg1J5-9SUmyJXsGYicZEMyg5KkqHaw@mail.gmail.com>
Message-ID: <CAGXu5jJ-2V5ch-Qer_O0mg1J5-9SUmyJXsGYicZEMyg5KkqHaw@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 2, 2018 at 5:05 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 04:54 PM, Kees Cook wrote:
>> That's not how I have it currently. It's a comma-separated a string,
>> including the reserved name "all". The default would just be
>> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
>> capture new LSMs by default at build-time.
>>
>
> I understand where you are coming from, but speaking with my distro
> hat on, that is not going to work. As a distro Ubuntu very much wants
> to be able to offer all the LSMs built in to the kernel so the user
> can select them. But very much wants to be able to specify a default
> supported subset that is enabled at boot.
>
> I expect RH and Suse will feel similarily. Speaking for Ubuntu if this
> isn't available as part of lsm stacking it will get distro patched in.

Right. Ubuntu would do something like:

CONFIG_LSM_ENABLE=yama,apparmor,integrity

And that's why I wanted non-explicit lsm.enable, so that an end user
could just do:

lsm.enable=loadpin

to add loadpin.

Perhaps we could have both? "lsm.enable=+loadpin" (add loadpin to
build default list) vs "lsm.enable=loadpin" (override build default
list with ONLY loadpin).

-Kees

-- 
Kees Cook
Pixel Security
