Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B7C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF24D22D2C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 08:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbhALILb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbhALILa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jan 2021 03:11:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8142B22DD3
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jan 2021 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610439049;
        bh=J7r8JGyqvNMFR6iSDzi97sSGsc1Y6DMzrykLViXV6fA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CvDZ2/LgPHUnVjaBGRme6asm5oz3Pc849cEbV1EX62HTmsINZD/KsU3rAsQqnJxWq
         LJhtApFpvi4sNIOoNn+WC3FMI3aos94ZoapFeysOujdNADNbH0t9gmX2p1xrNA3dR7
         iIlgLDdbQgHwREmekY0l3390ilopJbd6AiRqf60oxCYUEQdkp6T4fx7jgG5NQjzY+N
         RFYvk1Yhvk/bQ/qrj7Hwpq/0e22z4NQasZ2Oip0yhtf8JN2EpQ7uaIZfnIeAGxKFpS
         8Ca+LMOnQAnNE1v/E6iJFSLVMtKglfvYIBKG6d9yMY8R7NB+D8OV3Idv9s8iQ2jmBz
         9M7GIER4Ji5VQ==
Received: by mail-lf1-f53.google.com with SMTP id h205so2018496lfd.5
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jan 2021 00:10:49 -0800 (PST)
X-Gm-Message-State: AOAM533W8L2iOtF7o6q/0t6PyvFRimNy0Jq/qEYgrc91JBTHTbEeU3Zs
        A6hKnqgEf4xnDjncl//am5DfAvfPuawP1YmjT1QpTg==
X-Google-Smtp-Source: ABdhPJwDmRryslYHSGTgg4xDrUBsNzdvYvy18GcpZHH/xo1M9Zu5sPiuBbI7vdYU1HbD+7t/PoptTXEzAj9WmlAQA0M=
X-Received: by 2002:a19:5ca:: with SMTP id 193mr1660670lff.375.1610439047740;
 Tue, 12 Jan 2021 00:10:47 -0800 (PST)
MIME-Version: 1.0
References: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com>
 <f4f21823-240c-394b-2222-bb8214e4ba7f@schaufler-ca.com> <f85cdd1b-1118-026b-c696-18863ad6352e@linux.microsoft.com>
 <391d332-4a31-2ed8-85a3-106f393dd1db@namei.org>
In-Reply-To: <391d332-4a31-2ed8-85a3-106f393dd1db@namei.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 09:10:37 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5H2+h5C9h-E3hmfLJZdqp29YK14JQsxN=4rcLcZs_0RQ@mail.gmail.com>
Message-ID: <CACYkzJ5H2+h5C9h-E3hmfLJZdqp29YK14JQsxN=4rcLcZs_0RQ@mail.gmail.com>
Subject: Re: Question about inode security blob
To:     James Morris <jmorris@namei.org>
Cc:     Fan Wu <wufan@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 12, 2021 at 5:39 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 11 Jan 2021, Fan Wu wrote:
>
> > > The inode->i_security should never be NULL if the inode has been
> > > initialized. Any LSM hook that finds this to be NULL has probably
> > > identified a bug elsewhere in the system.
> > >
> >
> > Thanks for the quick reply. If I understand correctly, I should follow the
> > first pattern if I want to use the inode blob.
>
> I don't think it's necessary, and if there's a race somewhere causing
> this, we shouldn't just paper it over.
>
> Btw, none of the existing cases are even using WARN_ON or similar to let
> the user know there's a problem.

I agree, for BPF, I will send a patch to switch to using WARN_ON_ONCE or just
get rid of the check altogether.

>
>
> --
> James Morris
> <jmorris@namei.org>
>
