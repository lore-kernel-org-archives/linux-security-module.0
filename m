Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D525C0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3562064C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bQ1q8Xsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3562064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeKBAnI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:43:08 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:35558 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbeKBAnH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 20:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541086777; bh=u/NAman+QvDB4pNGwn3umVJwDofHOSBKDHdIZstyBI0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=bQ1q8XsiMj7FtvNc7hDzPRzsizsP/PJXUE8fv1SwwZ2Lt2o0cmrLyR0bQOzGHsdZYFCpmQg9w0w3yMZ8gGJ2dA2VQjo55KtjpT12UCFx+lsJVI/Dv/5O+nnrw3nvwnX4kgzri7ezlbXTHamKuTvOPQFakphkoZ0k+pbTgNA5ll6wSiVgbCe7WGgc0XFAlHBzcJlfLMp6n1yMdrjUSY3VGtqJHrtSpt3qcj6T3gV8NEPSPiUbiyFdO7kvyeyllaengKUqm55gGEatoxD8FB3P566txrEjitKNc2wKVgver9OT4kAsOwWTRw2gWtNeqcaExgAnQ39qVbNs0S8qZCMd3w==
X-YMail-OSG: yyVo4xAVM1k84XYIjr17dEqzVff4eJVBpiTS89mPXfkwaPoCvmLb_qGouJhYulY
 0ZYKy7yWcTMXkGypbrnDCl4Asd0fu7PJZ6qFNJMbMD8o6850yH0OmJdn1W01J8NZtfQQlTmXKwkw
 wTO_ISYlswbOojMgLhdLWG3A_tS7jRIw1Y2VmSJ.PBW2mdDfEjODhzZiyyKmIWHWVf_T_zbWZEKI
 wECadunQuLMoGy3fFqTj6moeyb4kZb.5ijRjY89_WUdWUa_2A3E15RwLOFecSCvxRRCKE83Mtfns
 NvtMA3oHanBhI1goTUpGFzU8aqW7Z5GIiAsbRLlkKCOL441kUWoQhtAm1.G2RmeT5Xw6dVet1NIf
 fEUGCrXzPEaqr4.3x1PNLtqMB2SYX7_2lPhvsoy5mjt2L8xA7vnp6bE1U6KpNV9KL0qzVwVKdtHZ
 AXKF2SDhaUL0y8Ic3dlcc72H6KfZ0bDEuIl2.dJN218xzSHchn8rIdkE9RFJTOhCePW7TuvFZkea
 Sfhw_vCyshZJNXVU1OQtgwoRRd59JtCBJbFR0zsDrt8Twn.IB2ASXvPVkQMFRVgPaDolPEtFc_.L
 eJorMRLVgrcmarMZQ7oUhMzRHhoVSFS1qcfUmhAzkPrSX_JJeHo1twFhlHd4Hs.0pOFJDssC1gnZ
 AKKjWHg3vB25bJg8RejSwL8b8B1VO7PeCgkxeG8Uf0mpl.wSo3ShCItPsu1H8h4FfNlE_PgXJu9H
 nSIpYFQNlWZvpTMvHI8xhoqXPW_y.Wb1QunvYKaD_V28lvRrp0hS6_FU1WE_1X1mRmopkBgkYPQb
 MJ52mdYSmGkSaDO_y24FjA6cjebyd8vcQkTXTVNtRDxd4YXg4Nuu8TJBBq7AkKiWn7KtOUCQGGpf
 TiXBK21DfVnsDxpxcdKLAWCRIsLGcVn7S9Kk_uoL0F6Oe3RSV3WBZmpdXT0CxqMIi388scAeB8JD
 96kgNkGqyTwyP8plc7OZEXgIYj1u.CAzs3ZgvlAjGD.aq5GBTphyAfD31Swm6j.rDIbHegSy_Vm6
 REgb7v1VbXekDqErPZqjJ4ft7pGP.1O_aJIxrlL_xDzMUEriYVQ8m934FqOFVu4tDhLTMHfNwI7X
 rKm2p6bM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 1 Nov 2018 15:39:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 429b2332824fc73d3f76757b8ec123df;
          Thu, 01 Nov 2018 15:39:36 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Micah Morton <mortonm@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, jmorris@namei.org,
        linux-security-module@vger.kernel.org
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
 <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com>
 <CAJ-EccPCxi1Fn-TVnGHBADKuoSi3XC0_UAkXRk49+iTjoLoecA@mail.gmail.com>
 <20181101061322.GB7132@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2d8b8ee8-0087-b9c2-f20d-90108e0b18bd@schaufler-ca.com>
Date:   Thu, 1 Nov 2018 08:39:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101061322.GB7132@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/31/2018 11:13 PM, Serge E. Hallyn wrote:
> On Wed, Oct 31, 2018 at 06:12:46PM -0700, Micah Morton wrote:
>> On Wed, Oct 31, 2018 at 3:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 10/31/2018 2:57 PM, Kees Cook wrote:
>>>> On Wed, Oct 31, 2018 at 2:02 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>>>>> Just to be sure - your end-goal is to have a set of tasks which have
>>>>> some privileges, including CAP_SETUID, but which cannot transition to
>>>>> certain uids, perhaps including root?
>> Correct, only whitelisted uids can be switched to. This only pertains
>> to CAP_SETUID, other capabilities are not affected.
>>
>>>> AIUI, the issue is that CAP_SETUID is TOO permissive. Instead, run
>>>> _without_ CAP_SETUID and still allow whitelisted uid transitions.
>> Kees is right that this LSM only pertains to a single capability:
>> CAP_SETUID (future work could tackle CAP_SETGID in the same fashion)
>> -- although the idea here is to put in per-user limitations on what a
>> process running as that user can do even when it _has_ CAP_SETUID. So
>> it doesn't grant any extra privileges to processes that don't have
>> CAP_SETUID, only restricts processes that _do_ have CAP_SETUID if the
>> user they are running under is restricted.
>>
>>> I don't like that thought at all at all. You need CAP_SETUID for
>>> some transitions but not all. I can call setreuid() and restore
>>> the saved UID to the effective UID. If this LSM works correctly
>>> (I haven't examined it carefully yet) it should prevent restoring
>>> the effective UID if there isn't an appropriate whitelist entry.
>> Yep, thats how it works. The idea here is that you still need
>> CAP_SETUID for all transitions, regardless of whether whitelist
>> policies exist or not.
>>
>>> It also violates the "additional restriction" model of LSMs.
> Does it, or does the fact that CAP_SETUID is still required in order
> to change uids address that?

Yes, it does. Reading Kees' response had me a little concerned.

>>> That has the potential to introduce a failure when a process tries
>>> to give up privilege. If 0:1000 isn't on the whitelist but 1000:0
>> As above, if a process drops CAP_SETUID it wouldn't be able to do any
>> transitions (if this is what you mean by give up privilege). The
>> whitelist is a one-way policy so if one wanted to restrict user 123
>> but let it switch to 456 and back, 2 policies would need to be added:
>> 123 -> 456 and 456 -> 123.
>>
>>> is Bad Things can happen. A SUID root program would be unable to
>>> give up its privilege by going back to the real UID in this case.
> Yes, this was the root cause of the "sendmail capabilities bug"

I'm very familiar with that particular bug, as Bob Mende's
work to convert sendmail to using capabilities was done for
a project I owned. The blowback against all things security
was pretty intense.

>  - a
> privileged daemon which could be made to run with slightly less
> privilege in such a way that it failed to drop privilege, then continued
> ot run with some privilege.
>
> But the key trigger there was that an unprivileged task could prevent
> the more privileged task from dropping its privilege.
>
> Is that the case here?

I think it is reasonably safe to assume that there
are many instances of programs that don't handle errors
from setreuid() in the reset case. Without privilege
setreuid() can be used to swap effective and real UIDs.

>   It might be...  If one of the uid-restricted
> tasks running with CAP_SETUID runs a filter over some malicious data
> which forces it to run a program which intends to change its uid and
> fails to detect that that failed.  It's not quite as cut-and-dried
> though, and if we simply do not allow uid 0 to be in the set of uids,
> that may prevent any such cases.

Alas, UID 0 is not the only case we have to worry about.
If I run a program owned by tss (Trousers) with the setuid
bit set it will change the effective UID to tss. If this
program expects to switch effective UID back to me and
the SafeSetID whitelist prevents it, Bad Things may happen
even though no capabilities or root privilege where ever
involved.

It would be easy for an inexperienced or malicious admin to
include cschaufler:tss in the whitelist but miss on adding
tss:cschaufler.

