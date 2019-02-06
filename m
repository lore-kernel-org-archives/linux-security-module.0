Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1DC169C4
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 16:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E88218AD
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KevaKXBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBFQaF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:30:05 -0500
Received: from sonic302-27.consmr.mail.gq1.yahoo.com ([98.137.68.153]:43673
        "EHLO sonic302-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbfBFQaF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Feb 2019 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549470604; bh=b+DqDn+y8qJpIdXaJROMfGbMY0hoTOlAvWr7uXl/j/A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KevaKXBC3CBzB8wSdTnqIL409OaLSMq3Ey7MsfgtwYKnKH0F9rsGEOl+0s4wujc4Rk3TanfDqVDk6/bIJ1R5x/p8WU9epom80bcJkBRhuPkRBKv0fInslIohbdnlUmAy61sl0HeXnHuAKNj23iiWQEk3fZKGS2A30ijDEYBGHr/yjAPJgLclFLq66sQELHZdUTh91sV2nKEN7Ykk6JG7+JHkPGDI8WDCq9TRfhqITdTTUt64WKppU15NqpnFuilGFto74HxJOqMoJ4zmjpbqn78w7P8IYryCOowZPhzTi14LWuYXitFplsiGbUU3ATqqf1a4w2sla6roOMkqsXUxyw==
X-YMail-OSG: QbN9V90VM1nmlA1RORWT_8eUnAtAekDN8jWlqxRnA7t7e3US07Ts0EnJG.qA8LY
 GMcO6P7KmNDH.HYpB6hBRH5D_dYZb__TKtz0e2Z2EoHDw3k_y0ztkGtlKxCgvfDhNsoNIpdU6zmu
 ena8EsiT1X.Rg7z8LgM8JKRhBF3_2V9UvgVO0QTpa..Uclwb.rCtBI4AGoIB7RBf2gYi6DON8Oe8
 nwPkyx6ztXWkSvSUEyYsXzvW.AH97x6zP_xQIDWrCDUIcw5ezyRJxZM_tyvl2mY2TwGYB.qKE_W3
 CKjMscrIhsFtm2LQtXIwMxZOMPmvbOuWfcuAaFyLukXhSUcKQk7lPXhkVpSSJxCO69fx9Z6a1Cbg
 5bUqbazDK9MkD126tmgHu029LS65pxXiphRE8izYseGbWz3kAIhssj4YO4I6nxoz.RddLy1naOhc
 PBbZFVyj8vsnpD.uXdgNcL9vF5DfZxfuOLWTi6T22HmSI.bveXXHZlxDNM71RF9AQCFu_htcWECT
 60uYLujRS7rol7ZfAQglnP14mLhrNnazXyGMxRW5nXTcHI1zqOJRw6jlow095MPuvX7XNHdOIcmu
 C6FriwVn1uFpsSh2y64m3b.LfXgnMXYKJZrlmeOkZYceniqcTykebGJ.IY7CMmya7xp_cbsIfH7S
 hmkHyvIX2QrLMfif3M2zp40IjgncUo9dKV8t4vNv8Cr1zyoOUr5Dm.BH6biQbCNk9CMpR5Bc2rO.
 6hvMtb1.myqd0zVePL1Jl8LoVMyyKy3kx1MxS11sar7XMvqPga8P4s2Tjfx4EJbYcgfRaBbZCDLq
 WVei78RBPetPT4grGUWoYS.GnfzLl2XvtHdUeEQXb258TMMfeq7P5sJ5ekwf3CknAjL1GC51_dXC
 5sB_a_kWM3tp0rVvGI8MqYS95MjEhzwIOnCTXDe6RPK2Yu9M7Fx71Xv8Q6TXLEc8koaT4wB_tKqM
 HPMjxF5T9m8HD1iygEVpSd9NO.WWgfj8tOKw0M0dJ4bmTK3d228drqTchmlo43tOSvhSpqrIn3WS
 .qIc_YjjZ6.jQDfuFpbtWXydH_eqAG_MRaYlrYkSp8OMSr1kQNgBnBrZOLJUSEMF5ykSGSVFQrnx
 U4qEO2RXlJjW80Es-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 6 Feb 2019 16:30:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6e4278c922cb555df14442c194170d34;
          Wed, 06 Feb 2019 16:30:02 +0000 (UTC)
Subject: Re: New LSM hooks
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
 <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
 <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
 <alpine.LRH.2.21.1902061207010.19811@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e1492ac6-d1b2-ce2b-c0df-1f30601747ad@schaufler-ca.com>
Date:   Wed, 6 Feb 2019 08:30:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1902061207010.19811@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/5/2019 5:11 PM, James Morris wrote:
> On Tue, 5 Feb 2019, Paul Moore wrote:
>
>> I believe that will always be a problem, no matter what we do.  The
>> point I was trying to make was that everyone, especially the
>> maintainers, need to watch for this when patches are posted and make
>> sure the patch author posts to the LSM list in addition to any of the
>> relevant LSM specific lists.
> Right, and there is no way a new LSM hook should ever be added to the 
> kernel without review and ack/signoffs from folks on the LSM list 
> (especially those who are maintainers of in-tree LSMs).
>
> Casey, do you have any examples of this happening?

overlayfs (according to my records - which may be flawed)
is a prime example. Inifiniband hooks were reviewed/acked
for SELinux, but there was never an attempt made to work
with other security module maintainers. Yes, they were posted
to LSM, but under the title "SELinux support for Infiniband".

