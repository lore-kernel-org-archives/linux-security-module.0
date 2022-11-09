Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03658C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiKIXel (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKIXed (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:33 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CA2E9D0
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 15:34:32 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t62so204851oib.12
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 15:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXS9MQPdcmgJY+EAqnfOGCHBzGHHvIikozxUjDfYtaE=;
        b=GaM82nIY9C40LQ1/RGMLX1U+cZtVw34qLtDGxSVGU0CcCpJv7d1R4KiH+Y6EeJxdYn
         Um7JDSTp4vB5LdkQizSVM37pcrdnUcaGdSxxFi3dKtAmY/xTiowC45el6e7egLEC4o5t
         opUX2yj2c0kIdzSnMfVbRtC0NPSuE/pvoY8kpOpTHnPdFV87LlVmBaWiNsdpOOvM+Dnk
         Qlj+B/9iDYO06cOqeEHJftH4PoW5+Sa0Bc7M8ZFCvQCzVpyGxzb5hbnR5/Bta3ra6k+4
         mStPVLSDBse05LBEFLDk+te8ZgYyxQDqZm1i507VfT+BLpJjlYoUMuu82dbxkjr7Ml1A
         fBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXS9MQPdcmgJY+EAqnfOGCHBzGHHvIikozxUjDfYtaE=;
        b=VzHF7dXlwAdxj1TolxVeqWBnvRKBDiHb/CpWFCkhVO5kSvKGor/Is3KWF0AvGioaxN
         q5wF0/PqPWYJFHR2jzv7XrlrI0k3LeyYERGiUXFD09X0OyzSUnqIX1TzUR2d1yXfivgM
         608IUt5BRCESZRcSiLmDgklxGAvz71kPHeJrF2rx2LdAW+Gor0pH0w3XWMaeaDlBzmJj
         0DH/uFGxJVD5yK378z5AmI8BoIQXWf1PcaXiWIORirCHhXleR1StVM7UOAE9mGs5Gc1K
         5hoFEmi58UmYjOb0gj92VgIwe7sOoqYKBGcSxH2cmsee/80+7FuVAF8tj+PERg5OYWoq
         2Xaw==
X-Gm-Message-State: ACrzQf0JT0CeWtSzaKwZY+8MjgFcz9uFu0N+cZBCzP6/QaZBX6J+hBnI
        OHQavG7ow1OmzTmvc6whMicSLvIEdQaYjMoJ/+Bv
X-Google-Smtp-Source: AMsMyM6TjUpsQIXI5cARZVmGqCvDmYQLxaSyjADOqImV5Vmi0pMiLjwzwN4Ld6s8w5576mOzGn108NdoR2Gkjaxy2Ko=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr20276345oiv.172.1668036872142; Wed, 09
 Nov 2022 15:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com> <Y1jNGMKfb+NUPrJS@kroah.com>
 <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com> <Y1olXIbTGx9NnthU@kroah.com>
 <d545ef2a-5cc5-2848-e699-ff791d34d7c7@schaufler-ca.com> <Y1q8SzpcdWgm/fLq@kroah.com>
In-Reply-To: <Y1q8SzpcdWgm/fLq@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:21 -0500
Message-ID: <CAHC9VhRv=o98MsYzYLZ+uHhvr6GxiX2tgkK07EEFdHnxWMSP7g@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 27, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 27, 2022 at 10:08:23AM -0700, Casey Schaufler wrote:
> > On 10/26/2022 11:29 PM, Greg KH wrote:
> > > On Wed, Oct 26, 2022 at 05:38:21PM -0700, Casey Schaufler wrote:
> > >> On 10/25/2022 11:00 PM, Greg KH wrote:
> > >>> On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
> > >>>> As LSMs are registered add their lsm_id pointers to a table.
> > >>>> This will be used later for attribute reporting.
> > >>>>
> > >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > >>>> ---
> > >>>>  include/linux/security.h | 17 +++++++++++++++++
> > >>>>  security/security.c      | 18 ++++++++++++++++++
> > >>>>  2 files changed, 35 insertions(+)
> > >>>>
> > >>>> diff --git a/include/linux/security.h b/include/linux/security.h
> > >>>> index ca1b7109c0db..e1678594d983 100644
> > >>>> --- a/include/linux/security.h
> > >>>> +++ b/include/linux/security.h
> > >>>> @@ -138,6 +138,23 @@ enum lockdown_reason {
> > >>>>
> > >>>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> > >>>>
> > >>>> +#define LSMID_ENTRIES ( \
> > >>>> +        1 + /* capabilities */ \
> > >>> No #define for capabilities?
> > >> Nope. There isn't one. CONFIG_SECURITY takes care of it.
> > >>
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> > >>>> +        (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> > >>>> +
> > >>>> +extern int lsm_id;
> > >>> u64?
> > >> u32. I doubt we'll get more than 32K security modules.
> > > These should be bits, not values, right?
> >
> > lsm_id is the count of security modules that are registered.
> > It seemed like a good name for the value at the time, but as
> > it's causing confusion I should probably change it.
>
> Yeah, that's confusing.  "lsm_num_availble" might be better.

Yes, this really should be named something else.  I'm partial to
"lsm_count" as it is shorter than the other suggestion, but this is
hardly something to worry too much about.

--
paul-moore.com
