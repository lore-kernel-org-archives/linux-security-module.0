Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDC43143
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F402089C
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 16:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hVKPWYCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F402089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJBXSn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:18:43 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41784 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJBXSl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 19:18:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so1005094ywg.8
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=79+/1lnmQzDOwK5HjNBMwdoNS2u8Fqf6+NB+3YIyrKs=;
        b=hVKPWYCQf4YO1PzD8ic2zHzeBnAZmrxWciQlXzQW9jE5qrO3YTGORvqcIbtlfPrwRU
         0EE/v1d4SErKRtJ0y7iTO1Wrhw72FZqW796mUgEejUuDXsrRvUfD0wCEY8/YobRlevwi
         eJePZNVgA5yHLLC/7+1X1HX0Ri4k/wqhPkfTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=79+/1lnmQzDOwK5HjNBMwdoNS2u8Fqf6+NB+3YIyrKs=;
        b=HnFp/Ekkt2865MsSf4OrSCs3UaSlKiOzq8I/2Z+8HCSfKQgf5j3jmyClwazfjEulfS
         1QEVY7MnsRu7VckiXZc5qbbeDhxmJMU6o/y2PWlZQD60/RE1vsX81edPrb0Lc27Em0xJ
         p61OKFrRiNzAn4PW1Kbeir1Bpgm0N8tH5Azo9w3uGvMhh/9DmQZiLMnKAcBW6rQaeCF1
         8u/BwX03sQi9bGQhCqbE6uvM0rw467UqIQgxtmh3BU2AeDz//xyBN6c7SDbNwOu7hLZq
         mpJxnQavbOCVmq41bfXf9iiiwdVJxfGbpP4n1tqvV2HLcW+Zqe3Lw85PaUwcAnaP/Sq2
         WzZQ==
X-Gm-Message-State: ABuFfogSeQoBDKL34zlwL/E9Xd2dxJ+gm/Q3zHWNJyR3+aybJvOilAlx
        KD8LhMxsS7NpuHfcAgP6QdY6VB6JWAY=
X-Google-Smtp-Source: ACcGV61rKkxA7PU2WEJFiBW5xSrQULW5Div7HEfIaeUvijdjd2KMcE4RBmiTZN5E0itozVrLvpMY/Q==
X-Received: by 2002:a0d:f141:: with SMTP id a62-v6mr8731454ywf.202.1538498065856;
        Tue, 02 Oct 2018 09:34:25 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o195-v6sm6201231ywd.82.2018.10.02.09.34.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:34:23 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e190-v6so1044246ybb.5
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 09:34:23 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr8866057ybg.171.1538498062769;
 Tue, 02 Oct 2018 09:34:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 09:34:22 -0700 (PDT)
In-Reply-To: <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 09:34:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLLg-anBAPmfDzeQA--HYzYAGaRamUiJS8HTt+wMFp_qA@mail.gmail.com>
Message-ID: <CAGXu5jLLg-anBAPmfDzeQA--HYzYAGaRamUiJS8HTt+wMFp_qA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
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

On Tue, Oct 2, 2018 at 7:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/02/2018 10:44 AM, Kees Cook wrote:
>>
>> On Tue, Oct 2, 2018 at 6:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 10/02/2018 08:12 AM, Paul Moore wrote:
>>>>
>>>>
>>>> On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>
>>>>>
>>>>> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
>>>>> "lsm.enable=...", this removes the LSM-specific enabling logic from
>>>>> SELinux.
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>>    .../admin-guide/kernel-parameters.txt         |  9 ------
>>>>>    security/selinux/Kconfig                      | 29
>>>>> -------------------
>>>>>    security/selinux/hooks.c                      | 15 +---------
>>>>>    3 files changed, 1 insertion(+), 52 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index cf963febebb0..0d10ab3d020e 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -4045,15 +4045,6 @@
>>>>>                           loaded. An invalid security module name will
>>>>> be
>>>>> treated
>>>>>                           as if no module has been chosen.
>>>>>
>>>>> -       selinux=        [SELINUX] Disable or enable SELinux at boot
>>>>> time.
>>>>> -                       Format: { "0" | "1" }
>>>>> -                       See security/selinux/Kconfig help text.
>>>>> -                       0 -- disable.
>>>>> -                       1 -- enable.
>>>>> -                       Default value is set via kernel config option.
>>>>> -                       If enabled at boot time, /selinux/disable can
>>>>> be
>>>>> used
>>>>> -                       later to disable prior to initial policy load.
>>>>
>>>>
>>>>
>>>> No comments yet on the rest of the patchset, but the subject line of
>>>> this patch caught my eye and I wanted to comment quickly on this one
>>>> ...
>>>>
>>>> Not a fan unfortunately.
>>>>
>>>> Much like the SELinux bits under /proc/self/attr, this is a user
>>>> visible thing which has made its way into a lot of docs, scripts, and
>>>> minds; I believe removing it would be a big mistake.
>>>
>>>
>>>
>>> Yes, we can't suddenly break existing systems that had selinux=0 in their
>>> grub config.  We have to retain the support.
>>
>>
>> Is it okay to only support selinux=0 (instead of also selinux=1)?
>
>
> For Fedora/RHEL kernels, selinux=1 would be redundant since it is the
> default.  However, in other distros where SELinux is not the default, I
> think they have documented selinux=1 as the way to enable SELinux.  So users
> may be relying on that as well. I don't think we can safely drop support for
> either one.  Sorry.

Okay. How would you like to resolve this? Should SELinux remain
"enable special", and AppArmor is okay to remove the LSM-specific
enabling?

The trouble is with handling CONFIG_LSM_ENABLE vs lsm.enable=... boot
param vs the SELinux bootparam. I.e. CONFIG_LSM_ENABLE is redundant to
SECURITY_SELINUX_BOOTPARAM_VALUE, and selinux= is redundant to
lsm.enable=. Specifically, how should the kernel distinguish between
the four settings?

-Kees

-- 
Kees Cook
Pixel Security
