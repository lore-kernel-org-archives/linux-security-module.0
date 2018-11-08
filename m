Return-Path: <SRS0=rvaM=NT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1436ECDE4B
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F6B20825
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 21:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TR/F5zV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F6B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeKIHLn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:11:43 -0500
Received: from sonic303-10.consmr.mail.bf2.yahoo.com ([74.6.131.49]:43858 "EHLO
        sonic303-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbeKIHLn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 02:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541712859; bh=JaZ3NfDCv5s6cZtPG57gt1sD3nfQ0/13IG+i047sDAE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TR/F5zV4PT1us2pEFY5En7xuwYXVJ5+QQNCiUFemSh9y0meajQM3YqcHf5W2cTtB5HwZHaZSxPB5X1NKMy0+pk27dymC4dCYrJyzOU8fvoeAevUzb7leq8hQKwV2BkP+4s7a5b9czp7uoacoZysLiOwHpsRvk4NJBJmR/qbjAWY+Txbq+8htlUgqz7dKMWxEs9B9yVMJkhIsCDEVzSW5C7JPplfkA8MzjB1dK3wxehO/ZjbulajZzHAqkg//8awjZBhr6/E35qPvzJ217HPuoWvAUMTdjvfkowtU1yvLbDdVu7g8TTiwrx8vc3rIhWlbrP6YiD3LrUvgINhCDhr2yg==
X-YMail-OSG: Gsa_PWUVM1nvkxGtVf51m69V8V5vTZxNWON4ZL8fre0VImwlyafZab_c9u4Y7LC
 X2gTZQOLPvpshsOsowxaRMUpDxoClpM_.uNX5cTdIw6eHQcTVCAT1Dk064vsNpkOmzf_daiXQzKI
 kcg_9O0klQJ.Z8LT4vW1l.g.QgbrHDxhgxJp8BkFaQ6DK5iyXOmZ_KxSYAfNRaESisCEd1U_APh8
 PXepqRCH3cKj8clyQUyUMZZcoEe3S7mWcagr4NvgBmssHil1XegrcGUdglR2dY7vsCl_I_h7F_25
 3n0wLyzVJHavfPypShJtnru3.JGIKDXm2jokpycB1Mle4gSJCgMoTiKtNfTqlMG.PUYDHK1si4al
 xMec8jn2CpgCBXzJUOL7Dhb6M2A1Xio7psXw2Aaw2auLOAWTQkUgbG3hWATEuQ9SAsLaaYTMHLwZ
 8KnT_Xvda1EcTi4qqKtznPb93u8WG2HFGlEd82goY5QyAXQrh9qlLW8_49VoVABO5qaZxSjm1D9a
 lTIgWL_2PQY2AbKpoN7hUZcMZzuFPP9TUR8eq3j2BVck7_GdgTeNyct6YUdO67AUQUk0LbBjzG0k
 SU5feIttjUujnvtILHSu.9AuZncbcbeqAYz7SgRTh8oJfyOwLq4FNA4CGMa8yQZPXuy9fTYfBf0k
 U01gVyjAsNlnhQ3ON4c3L6zcmDVulj2A9YrYZVA6uYLJYUFEjVaksGBm3VnddEMA9P_.e1FKhm9S
 jiMo0aHOUWi0S7p9NKmfeFvUhhpgmL6lf3AAtbOsiZCPVx9DYXgVRxbJo5zZChUyX9b_HPAisQs1
 77xHcPqhB.WqyTaA1TlUe342NwWuy52mq92thzExqUXOy.piZJ_LPGFxEiPqpmQIhq9tONFrgOlS
 X4Wq7sQpsDCVM5v5OIxBbMTAh4cQ_JS.8Yyfk47yGXe8vfkQOOpmXh6yJqG0w17epcc2q9WFBFU_
 PtK83ucoNxHUN4QZkqxaXkNN99QVCVgYkPfHJtVFxOEWUmCVpojFMZD_DTqN6yYw0sRH8VshpUZg
 GnDSCUYjsRJfWtqztQYjUeh0RsLCwbpOGMwRfIvW4tXJk2lXUsbL6IW5cJlF8BrF_g4bD9mTizPB
 j2bvhjg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 8 Nov 2018 21:34:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8a8172f4548d2aa4363053a67eae32fc;
          Thu, 08 Nov 2018 21:34:15 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>, serge@hallyn.com
Cc:     jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
References: <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com>
 <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com>
 <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com>
 <20181102183056.GA20738@mail.hallyn.com>
 <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com>
 <20181102192227.GA21498@mail.hallyn.com>
 <CAJ-EccMrP_agdiPNpCjA9V4iDt+LgA2K3uFV3qVJBVVow-cC7w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d041b6e9-514e-e481-be7b-ab1b52a667fb@schaufler-ca.com>
Date:   Thu, 8 Nov 2018 13:34:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccMrP_agdiPNpCjA9V4iDt+LgA2K3uFV3qVJBVVow-cC7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/8/2018 12:53 PM, Micah Morton wrote:
> It seems like the CAP_SETUID_RANGE idea proposed by Serge is mainly a
> way to avoid silently breaking programs that run with CAP_SETUID,
> which could cause security vulnerabilities.

It wouldn't be "silent". You'd have to fix anything that needs
the new capability instead of the old.

> Serge, does Casey's
> suggestion (killing processes that try to perform unapproved
> transitions) make sense to you as an alternate way to safeguard
> against this? Sure there could be regressions, but they would only
> happen to users for which whitelist policies had been configured, and
> killing processes should be an effective way of identifying any
> missing whitelist policies on the system for some restricted user.

I'll point out that seccomp uses the "kill what you deny" approach.
It would be one thing if it was reasonable to assume that programs
are checking their error returns, but we know they're not.

> One
> less attractive thing about adding a CAP_SETUID_RANGE capability would
> be that more of the common kernel code would have to be modified to
> add a new capability, whereas currently the LSM just uses the LSM
> hooks.

That's got to be a secondary consideration. If CAP_SETUID_RANGE
were the right solution the additional work would be worth doing.

> The other unresolved aspect here (discussed by Stephen above) is how
> to "know" that ns_capable(..., CAP_SETUID) was called by sys_set*uid
> and not some other kernel code path.

It sounds like you want a new LSM hook (security_uid_change?) to
put in that/those code path/paths. That would be a lot cleaner than
trying to infer the syscall.

> The reason we need to know this
> is to be able to distinguish id transitions from other privileged
> actions (e.g. create/modify/enter user namespace). Certain transitions
> should be allowed for whitelisted users, but the other privileged
> actions should be denied (or else the security hardening provided by
> this LSM is significantly weakened). Do people think the current
> reliance on comparing the return value of syscall_get_nr() to
> arch-specific syscall constants (e.g. __NR_setuid) is a deal-breaker
> and we should find an arch-independent solution such as the one
> proposed by Stephen?

The problem with inferring the syscall is that the mechanism for
doing so is subject to change and architectural magic.

> Or is checking against arch-specific constants
> not a big deal and the code can stay as is?

It's bad enough when we have to make LSM code check things
like what filesystem an inode relates to. I would say that
you really want a different approach.

> On Fri, Nov 2, 2018 at 12:22 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>> Quoting Casey Schaufler (casey@schaufler-ca.com):
>>> On 11/2/2018 11:30 AM, Serge E. Hallyn wrote:
>>>> Quoting Casey Schaufler (casey@schaufler-ca.com):
>>>>
>>>>> Let me suggest a change to the way your LSM works
>>>>> that would reduce my concerns. Rather than refusing to
>>>>> make a UID change that isn't on your whitelist, kill a
>>>>> process that makes a prohibited request. This mitigates
>>>>> the problem where a process doesn't check for an error
>>>>> return. Sure, your system will be harder to get running
>>>>> until your whitelist is complete, but you'll avoid a
>>>>> whole category of security bugs.
>>>> Might also consider not restricting CAP_SETUID, but instead adding a
>>>> new CAP_SETUID_RANGE capability.  That way you can be sure there will be
>>>> no regressions with any programs which run with CAP_SETUID.
>>>>
>>>> Though that violates what Casey was just arguing halfway up the email.
>>> I know that it's hard to believe 20 years after the fact,
>>> but the POSIX group worked very hard to ensure that the granularity
>>> of capabilities was correct for the security policy that the
>>> interfaces defined in P1003.1. What would CAP_SETUID_RANGE mean?
>> CAP_SETUID would mean you can switch to any uid.
>>
>> CAP_SETUID_RANGE would mean you could make the transitions which have
>> been defined through <handwave> some mechanism.  Be it prctl, or some
>> new security.uidrange xattr, or the mechanism Micah proposed, except
>> it only applies for CAP_SETUID_RANGE not CAP_SETUID.
>>
>> -serge

