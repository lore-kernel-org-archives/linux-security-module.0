Return-Path: <SRS0=zj7v=NL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CBFC0044C
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Oct 2018 22:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E852080A
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Oct 2018 22:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BnaX/epl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E852080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbeKAHiE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:38:04 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:44269
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeKAHiE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 03:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541025479; bh=p48GQJIKHI4vEw/U4J+lo1P720SfvWjIKYZaSP33cE8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=BnaX/epl03mSI4+1vwEPqs/7KHE4IIYWxx0ICRYHRqj+rqRz9/yMHHBnuOhd9gIUxUOBchHL+EV8zTnhAQd2cBa6blC7tMVODcS6SC8wuhwmjdnaCWvAH2ZKO6/pxq9/Bu+PQAasUIEYepkW1WYyP3nXoM6QqdPb6XSZCnHwODLvce8FQGgMVVqZt01SW3OR+WI1HL9o3kjVw0ohZYPBQxsQudCfgvAPs+vvHIrbEaoojJ+NsmT1ST7eKl53rqgxVL4b4u0dsvE9nGlx8cDPjLargR9WNgOsecSamEi+Yp9LssCB3zWG/+3Slk7S5XOlRZaLQk9rhQRdGnQpeIaRNQ==
X-YMail-OSG: y2_50yYVM1n5PNVWYdj1uflOHw_1elTpA_HHcQSvqgjfnoUJV66cDMr1qjN0Qj.
 lFkxuPW8IviNm0lk.GrFpnboz9.0OuDRO02eZQVYhv13T1kCguh9n4ylOaE.ceKJA8OYY2cWV3_u
 fC1F0fltij6GotdnN_o9v.v4usksIhZPwZ0S0F3G2OGwRIP3uVnCcONBaF4uXnWbAlDsoPoDkDxn
 gxHKA7GPLEyBIQ1rBRGLjdgrFadh_C3a6FDbHZVk9ndt5UBB6PudDKS7qVtcjrlDqH.hAGLkQ0iy
 HGkMXQGqgplVKhyuWBmmBwlJsuQJR54YlDmGpx99rSh3XqfME8xX4aJ.DHV9eGUwi8eB7Ii3bvPd
 IcftjDG0qLnopSzkXu6Cl_GWhFH7wet0PPEXykxKbDP5vdRdDbTwD4ODcG20e3ySTFNJZT3T5CSS
 j_BVMb8uO5LBB19VPFTiHOaXtcvXM6Zi8JjUYp2ABecMC80eND7ARv5Pr3Hh6ZQBmNjdWYhXyNSr
 sRqGYqouv2D1yuuT9j60YNsb7fIAWGYKJc2F1NFWgUwhbpLPQhJI6KZuMFtjhwvoqdvW11J5N93G
 6HBeIS6kSOhI4MvGpnAVsXTTnw04sJaRTdzr4ufKs.aYAR4pdZLne8mk75iAP49TGYwQepfZJImx
 x2xmqV4d_pFPAEGgNj01nsgSdinN41ZqQLW94XkTJfp_QI6f8DREJTgTyhttRMH6vIHgqH_P9cUT
 alrxnh2WqjuICDjyry6WOBVD4o4mSR_ZR.BhT.sLkYXyIKOTaAsQIOFA6wRDFxN.6gWC.3kaJf9Z
 jPFJdqfEyh5F6Skb87z_B4hfxTtDbDWvxGgyz7valVa0QCsJ_PIOruX2bmWtR1i97f75LifCoM9M
 6Vm7bMusxL5ofntWNNqLua6r_OcVQ4q5JjoI5k4rHD0nmqxtmR6Q7vkPjj_ibpzS3DGyaoa.DU6u
 Bg7vQPn0058r7mSQmRfts8vCcBq4II_jgYtB7UIKNw_sorAW8nKh9stKX4rCWGDhtkdt8EX_pSzt
 dgv5JZTwpn2xS.rKcXkR4JJDCPy.V0yHxSAqr6FR.xueJoj9v2veA2TCR4qj_A44b1xxRKeeUIy_
 RXFPGhaI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 31 Oct 2018 22:37:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8bb62704a1f9e960a5aa489e631da62;
          Wed, 31 Oct 2018 22:37:56 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com>
Date:   Wed, 31 Oct 2018 15:37:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/31/2018 2:57 PM, Kees Cook wrote:
> On Wed, Oct 31, 2018 at 2:02 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> Just to be sure - your end-goal is to have a set of tasks which have
>> some privileges, including CAP_SETUID, but which cannot transition to
>> certain uids, perhaps including root?
> AIUI, the issue is that CAP_SETUID is TOO permissive. Instead, run
> _without_ CAP_SETUID and still allow whitelisted uid transitions.

I don't like that thought at all at all. You need CAP_SETUID for
some transitions but not all. I can call setreuid() and restore
the saved UID to the effective UID. If this LSM works correctly
(I haven't examined it carefully yet) it should prevent restoring
the effective UID if there isn't an appropriate whitelist entry.

It also violates the "additional restriction" model of LSMs.

That has the potential to introduce a failure when a process tries
to give up privilege. If 0:1000 isn't on the whitelist but 1000:0
is Bad Things can happen. A SUID root program would be unable to
give up its privilege by going back to the real UID in this case.

