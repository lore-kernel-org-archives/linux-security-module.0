Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E469C65BA9
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6F21470
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 19:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H84jSiJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJCBrw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:47:52 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44694 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeJCBrv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 21:47:51 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5-v6so1252332ybl.11
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z++//P3YjInCGZ08dRZq3CLV98QJ86yU6u/kjrJS+oc=;
        b=H84jSiJrrfxdIWpeaTckpQZS2CitH9Cpm4oa0F0fAcAqvuUo9FMI55WQZII2ciETPI
         51fzaPxwBIWNjsKO58aIiDfpulTLpnVi0GiMazqY5EJ9qLwOB3Bv9PlYNafTvHDJlu/X
         m8hA88DSZuWHa4MAau8k9a3DqvhFiL0+4yXB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z++//P3YjInCGZ08dRZq3CLV98QJ86yU6u/kjrJS+oc=;
        b=JYY+4YS4N/kxUQ2o9JMvI82yh1WWZ+QDZq7CpifOR5AoHB7RVxJIH+Apds78OX1gea
         SEOYF0tVHxwgV4ccbIwcTtevbcdtDhIf1OxJkMAp/nYxewlFoFmG/fcKMMhWrQs0BzMS
         Hf4mHyVz2GfKrvWvJeTQZS9tmhbrYSCXgIwOystpS8ZWoLlp8NdD9Xm+ckrzcL3zXrmF
         qUgNxUMU3eZCGNXZErdjH8QAmIu2QilB/iqS6CFXNx5zxJSrrA8t5sv8P2h4tRNsJSwT
         ZDbagzwFOjqc4/0K7Ocm+Vfdhb8/L1haqVPF4p/HNNc8PZ6YxAuA/nrGeSTEo85egNF6
         XmzQ==
X-Gm-Message-State: ABuFfoh5JdsR9c0yi8k+YwNDK6VwDsvObBOQNZTgvYF0zilBT0WPsDea
        IYAd4r78oHDInTOORcwS/NfyZd8rSEo=
X-Google-Smtp-Source: ACcGV60YleTbrOpuWXPHB3WIcvsqR0Jgy8jfcFvFTdjDfOOh+ijqohxXmU5uky/8PMcqdH6NCHXoMw==
X-Received: by 2002:a25:28c4:: with SMTP id o187-v6mr1071156ybo.212.1538506981179;
        Tue, 02 Oct 2018 12:03:01 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id u22-v6sm13246338ywu.49.2018.10.02.12.02.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 12:02:59 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p74-v6so1257412ybc.9
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 12:02:59 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr1236460ybj.137.1538506979133;
 Tue, 02 Oct 2018 12:02:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 12:02:58 -0700 (PDT)
In-Reply-To: <cc2ff677-a45e-e171-7a71-7d8e202bcabd@tycho.nsa.gov>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <cc2ff677-a45e-e171-7a71-7d8e202bcabd@tycho.nsa.gov>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 12:02:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKSgURe-6bQjq0NSWhod3YFpoqaFzs24B6AEQJK3o=MLA@mail.gmail.com>
Message-ID: <CAGXu5jKSgURe-6bQjq0NSWhod3YFpoqaFzs24B6AEQJK3o=MLA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
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

On Tue, Oct 2, 2018 at 11:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/02/2018 12:54 PM, Kees Cook wrote:
>>
>> On Tue, Oct 2, 2018 at 9:33 AM, Jordan Glover
>> <Golden_Miller83@protonmail.ch> wrote:
>>>
>>> It's always documented as: "selinux=1 security=selinux" so security=
>>> should
>>> still do the job and selinux=1 become no-op, no?
>>
>>
>> The v3 patch set worked this way, yes. (The per-LSM enable defaults
>> were set by the LSM. Only in the case of "lsm.disable=selinux" would
>> the above stop working.)
>>
>> John did not like the separation of having two CONFIG and two
>> bootparams mixing the controls. The v3 resolution rules were:
>>
>> SECURITY_SELINUX_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
>> SECURITY_APPARMOR_BOOTPARAM_VALUE overrides CONFIG_LSM_ENABLE.
>> selinux= overrides SECURITY_SELINUX_BOOTPARAM_VALUE.
>> apparmor.enabled= overrides SECURITY_APPARMOR_BOOTPARAM_VALUE.
>> apparmor= overrides apparmor.enabled=.
>> lsm.enable= overrides selinux=.
>> lsm.enable= overrides apparmor=.
>> lsm.disable= overrides lsm.enable=.
>> major LSM _omission_ from security= (if present) overrides lsm.enable.
>>
>> v4 removed the per-LSM boot params and CONFIGs at John's request, but
>> Paul and Stephen don't want this for SELinux.
>>
>> The pieces for reducing conflict with CONFIG_LSM_ENABLE and
>> lsm.{enable,disable}= were:
>>
>> 1- Remove SECURITY_APPARMOR_BOOTPARAM_VALUE.
>> 2- Remove apparmor= and apparmor.enabled=.
>> 3- Remove SECURITY_SELINUX_BOOTPARAM_VALUE.
>> 4- Remove selinux=.
>>
>> v4 used all of 1-4 above. SELinux says "4" cannot happen as it's too
>> commonly used. Would 3 be okay for SELinux?
>
>
> Let's say a user/packager/distro has been building kernels for the past 14
> years (*) with a config that has SECURITY_SELINUX_BOOTPARAM_VALUE=0, and now
> they build a new kernel that includes these patches using that same config.
> Won't SELinux be enabled by default because SECURITY_SELINUX_BOOTPARAM_VALUE
> is now ignored and LSM_ENABLE defaults to all?  Is it ok to require them to
> specify a new config option to preserve old behavior?

Yes, I think that's fine -- kernel CONFIGs change all the time. System
builders are used to examining these changes.

-Kees

-- 
Kees Cook
Pixel Security
