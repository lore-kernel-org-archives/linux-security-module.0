Return-Path: <SRS0=sHE6=MN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7219C43143
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED79206B2
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Oct 2018 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bgSYRfBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED79206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJBFJL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:09:11 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33343 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJBFJL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 01:09:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id m127-v6so2620496ywb.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UUva3qayWTJuNRO5vFXagr7UNP6gpnhjrr3F5TYlkQo=;
        b=bgSYRfBLOAWqKUmuKkY1DNiSeeZjZ/x6tv1TSP+ME5eKcUc3EpCeI96Wf9AyhkH6o9
         TgJIGZJlztMAwnN/xmMyjqLRE2PJUDQ03SdGv1OhKOndOQkBmakZvPEe18/ZkRvQzVHT
         dOWqg2UbYRM84UGf4WePEGn/8SjGzzU+4gpOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UUva3qayWTJuNRO5vFXagr7UNP6gpnhjrr3F5TYlkQo=;
        b=HIRlp4z3FGJbTEJh9QukrU4JPqHBBVkFetwKbPn9Erl6wgCjqBRb79fJYoDwohdcAR
         LBsTiwJTURYY2BgJ/y9J2qhyTeZQtGDW4Z44PBBP9V08xihMwZ56+geqZeNALcb6V0dH
         37tHy2ncHpybQjeFphsT1TNViNKNxNKo1Z5ZsjCVwcYDfLYWSwZ3eDtiM0su9VNrUot9
         cDmnTXDXV0j7BIPMXFEtqDIIGftUOpTlHFtxkilCzNLcaPmzxq+BBWth3h2n7Q9tcvha
         YeRKl7cgtIHndj2fe4N9OCUeQt6PFxlZRfKdJIG1/500SaMrTleDsVj9BBdlp7mSrzh8
         2XIQ==
X-Gm-Message-State: ABuFfoiebsrC07TJAwvGgCVY69bxmdO+Cn4QCRFpP2ctfjN6SrcI+343
        yXfhMPWclEUBk9/V49HMtAnU4mp2ATs=
X-Google-Smtp-Source: ACcGV62C5enST6HHp6d4j8FlNv1xIX5VilP1/WvUKY1wM54/fA/5teE00gIxjXkgE07fDIGFOCd4FA==
X-Received: by 2002:a0d:df07:: with SMTP id i7-v6mr6962549ywe.174.1538432950533;
        Mon, 01 Oct 2018 15:29:10 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id f82-v6sm9323630ywf.58.2018.10.01.15.29.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:29:09 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id y14-v6so6228456ywa.4
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 15:29:09 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr2351311ywg.353.1538432948785;
 Mon, 01 Oct 2018 15:29:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:29:08 -0700 (PDT)
In-Reply-To: <822e8ef3-5035-736e-1bea-dcb4af5c36ac@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-15-keescook@chromium.org>
 <alpine.LRH.2.21.1810020747380.20364@namei.org> <CAGXu5jJKvb=3vu3_b-NNdr_=KwvgO9qa96Qo5qzSZuiy2=+Oig@mail.gmail.com>
 <822e8ef3-5035-736e-1bea-dcb4af5c36ac@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:29:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKm3yp8VFjTrRd1dibMVQeCmsHawNMyvtiCcEjxT7S57Q@mail.gmail.com>
Message-ID: <CAGXu5jKm3yp8VFjTrRd1dibMVQeCmsHawNMyvtiCcEjxT7S57Q@mail.gmail.com>
Subject: Re: [PATCH security-next v3 14/29] LSM: Plumb visibility into
 optional "enabled" state
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Mon, Oct 1, 2018 at 3:20 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/01/2018 02:56 PM, Kees Cook wrote:
>> On Mon, Oct 1, 2018 at 2:47 PM, James Morris <jmorris@namei.org> wrote:
>>> On Mon, 24 Sep 2018, Kees Cook wrote:
>>>
>>>> In preparation for lifting the "is this LSM enabled?" logic out of the
>>>> individual LSMs, pass in any special enabled state tracking (as needed
>>>> for SELinux, AppArmor, and LoadPin). This should be an "int" to include
>>>> handling any future cases where "enabled" is exposed via sysctl which
>>>> has no "bool" type.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>  include/linux/lsm_hooks.h | 1 +
>>>>  security/apparmor/lsm.c   | 5 +++--
>>>>  security/selinux/hooks.c  | 1 +
>>>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>> index 5056f7374b3d..2a41e8e6f6e5 100644
>>>> --- a/include/linux/lsm_hooks.h
>>>> +++ b/include/linux/lsm_hooks.h
>>>> @@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>>>  struct lsm_info {
>>>>       const char *name;       /* Populated automatically. */
>>>>       unsigned long flags;    /* Optional: flags describing LSM */
>>>> +     int *enabled;           /* Optional: NULL means enabled. */
>>>
>>> This seems potentially confusing.
>>>
>>> Perhaps initialize 'enabled' to a default int pointer, like:
>>>
>>>         static int lsm_default_enabled = 1;
>>>
>>> Then,
>>>
>>>         DEFINE_LSM(foobar)
>>>         flags = LSM_FLAG_LEGACY_MAJOR,
>>>         .enabled = &lsm_default_enabled,
>>>         .init = foobar_init,
>>>         END_LSM;
>>
>> The reason I didn't do this is because there are only two LSMs that
>> expose this "enabled" variable, so I didn't like making the other LSMs
>> have to declare this. Internally, though, this is exactly what the
>> infrastructure does: if it finds a NULL, it aims it at
>> &lsm_default_enabled (in a later patch).
>>
>> However, it seems more discussion is needed on the "enable" bit of
>> this, so I'll reply to John in a moment...
>>
> fwiw the apparmor.enabled config is really only a meant to be used to
> disable apparmor. I'd drop it entirely except its part of the userspace
> api now and needs to show up in
>
>   /sys/module/apparmor/parameters/enabled

Showing the enabled-ness there can be wired up. What should happen if
someone sets apparmor.enabled=0/1 in new-series-world? (See other
thread...)

-Kees

-- 
Kees Cook
Pixel Security
