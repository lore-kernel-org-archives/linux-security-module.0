Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90493C43143
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 04:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D42C20684
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 04:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VbNZXoJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D42C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJBLa4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 07:30:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39035 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBLa4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 07:30:56 -0400
Received: by mail-yw1-f66.google.com with SMTP id v1-v6so268343ywv.6
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 21:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/iz8UGDhqnhQj14wynEEGVGj6CSwWszHDf61Vdh6eA=;
        b=VbNZXoJmnWC1w45hkLStsc8iddHSdBp2k4Mt/MM+ztPG8n/P3SWUZUltyFVtGDCw6P
         W8XX+xcaxke590MdOoIZix3BaFn6cwJpqP1Ss828Tig1csdWOSdA+TQHK2ntxvzfTM23
         tJYCzp5T/G3FXZylyqTiq/5E3xXK4sJV7whi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/iz8UGDhqnhQj14wynEEGVGj6CSwWszHDf61Vdh6eA=;
        b=T2sAFcAASwBMRukfO5eViFG6tf9PIH2+CCwHhq+N67bZtdfbIM0zO1r0eSN/42rI7J
         0PyxHwsSSRe1fpr+jbo3LEcnlsUILzHre/lwXokSuuzBVN3AaH+MYC8tMcQiE10X9gh8
         uToq6Ie8m8O9JTjFYnIS7lKFcZzu2leTt3OYE9FwirLpFwEcLBmh+UhjNzUBa0+oTxO3
         S/ggnyyxMAnxNBrV2Ava4HZyUcn6Kt9WQC/KMN6/to9JdGWybLxXHBeuDbQd783BBC6l
         O+zCZd2M/ojzXdjdeXyrKhebg3VNafRR9pwzm4H9rBuOIjfNfLphOkf7Nl5vhZZmFNqt
         cz3Q==
X-Gm-Message-State: ABuFfojEPOto2YHFU+U3A3IU9gFWQEdfnxduU0pGBSXJ+U2RcaPGKjjt
        s6zjPJPeOokASlxrsDceY7cETf+q4rQ=
X-Google-Smtp-Source: ACcGV62Swcswhvfd37ft/v2kdtiEphiV4YWKqcFnSR2B74RVwTiRPOnY5qakob46b70bWl7faxuxQw==
X-Received: by 2002:a81:af5a:: with SMTP id x26-v6mr7354493ywj.31.1538455779982;
        Mon, 01 Oct 2018 21:49:39 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id o131-v6sm3756732ywb.107.2018.10.01.21.49.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id j75-v6so262457ywj.10
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr7682701ywp.407.1538455778198;
 Mon, 01 Oct 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 21:49:37 -0700 (PDT)
In-Reply-To: <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-22-keescook@chromium.org>
 <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 21:49:37 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+ND4K5GvxJ1ieLr5E=Zsfb6mGQL8yTegOXv4V4qmuZUA@mail.gmail.com>
Message-ID: <CAGXu5j+ND4K5GvxJ1ieLr5E=Zsfb6mGQL8yTegOXv4V4qmuZUA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM
 enabling logic
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 6:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/1/18 5:54 PM, Kees Cook wrote:
>> Prior to this patch, default "enable" behavior was unchanged: SELinux
>> and AppArmor were controlled separately from the centralized control
>> defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
>> logic to give all control over to the central logic.
>>
>> Instead of allowing SELinux and AppArmor to override the central LSM
>> enabling logic, by having separate CONFIG and boot parameters, this
>> forces all "enable" variables to disabled, then enables any listed in
>> the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
>> any listed in "lsm.disable=...".
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>>  include/linux/lsm_hooks.h                     |  2 +-
>>  security/security.c                           | 32 +++++++------------
>>  3 files changed, 15 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 67c90985d2b8..f646cfab5613 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2279,14 +2279,12 @@
>>       lsm.disable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to disable
>>                       at boot time. This overrides "lsm.enable=",
>
> better:                               This overrides "lsm.enable=" and

Eek, yes! Thank you. :)

-Kees

>
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
>> -                     parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       lsm.enable=lsm1,...,lsmN
>>                       [SECURITY] Comma-separated list of LSMs to enable
>>                       at boot time. This overrides any omissions from
>> -                     CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
>> -                     boot parameters.
>> +                     CONFIG_LSM_ENABLE.
>>
>>       machvec=        [IA-64] Force the use of a particular machine-vector
>>                       (machvec) in a generic kernel.
>
>
> --
> ~Randy



-- 
Kees Cook
Pixel Security
