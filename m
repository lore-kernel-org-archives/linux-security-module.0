Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99470C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577DE2184C
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j17PHG3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfC2Toh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:44:37 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:39404
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729952AbfC2Toh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 15:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553888676; bh=TUWQVEsd3TNbPsZxCdPaZ1xaOcgLHZp5zP5mkhds0cg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=j17PHG3D7ZzxcBP48bXwhYbHR11cZHPWnVxFps3IAZoDv87FGgA2hg//wSzh827/Jyo/C69ecpEmF6kIUT+U3i1oUtlrt8dZHIFYq9xuJfUAUCkGfCWWCjCYfjkKWbtAfUPvAT9S2xrlkCUpi+uxrVAE1+WNHyrXdPPqQviLokPfs3twJoVlCWT71u+I8WbdADoGsTPqX1yobI0GXQNvy/joUDF0IQ6ADwMBWi0iJ4aS4OzlRrm1JvawMVNAjczWzV0gG68qE0ajg9+Zazjs1j/74FBe66ax9Cf7RXVcLq2lCR9o3Um6U67vNuvDAYz44QEJaU0IF2O6FnYDaToRng==
X-YMail-OSG: Ex4smNcVM1mERw5C18WqSjXo5gE4w3ViquNgXfFV18uXcwx8EWKDqmohxRGlt2b
 RZbMzN0uJYudOu3fOUrTZK8KkhL1mZSaHMwOfA_e99QT9h3DAcHyBewHVqu_KgRyhmI3rKHsiGiQ
 SKon0_hmRFa2Pn_KE7s5pCzyczkA6FKBoeJgKCzUC4dPEr8Lx.ttT3iVj8bk4RXehNQSOpRfqhXf
 6yNQyUMOBTtnEOF9AZdCEBF6uNc62tbXKIN4UCBgr3HNs9m5IBhqZwdx2gfrdAAx_dUK3QqJWOT8
 UqGoNRW4ynQhGcIWcgSswR9.IUd9dlKRSWg2hXINQFFuJg7iPzM_jzzxFWi26.hWM2lKpRjWsNLk
 vgwVxAL0nzNi8U6xTjraoGPO9FoLQpWQ1hmzyOkPvejPn6rk8P3WHe3jJYXcuZ8Gd6M9Lcjq5.sa
 47V.vL2ZCUTF05yeWcF1zQj_QI3jtatDNcKNs824ms4an0VD3NTEmObZXXtkAdof6a0auRd9pzlr
 QU040BzukwFy9dX.is9LPEg0549ycmXOxuo7TRTgDfpuOa0rmB65pz8IuMcj2.ra_.97mah9qmsH
 FDxyKdFuIyOs2d.VZvV65JRmMdP5Yy6FD1bfLiu3hDSMFKs6GskAy83a4cErm_S8IEKBcnYeXU0J
 sh5XeIWB8mht6v.v7Eu711FyRfQtAxDFEw3i9GjqEuL3jBAbfG9jT2QuaoeuKWIYRLwXsbyIDeQu
 ufONtDwfCvQYhLcEwaNeJyqrCGvKqLbloq4AkI.qIyznnU.dMqAVn6u9Csci2JcsrWojfAW3ho1D
 b1DQH6hqQ4mpSrmCPK4nqGSri1Sc19r3JWVbY_ZtTU4O8kD0dt6JP1JA18a.ApqiDd_.YgPfNdFL
 z3lcXmuOgQFDJBWZ9LayRCl0WlG1T3RCm0zKMs9uDAeg0OPVOT359Ep.7pi6Q7cddmCr3aicA3GZ
 TQXO7KTaXOwvfz4Y1TUZOuQQZmASpLZbKjJs4dqCvdnmkaLJtBPp3fht7zJ4f0aVztp9yySNnlzk
 N2BRLk2lf_y136y2GzieQwSDAUQE7X9pThzfgjJqrSQ7Ki3HBcGx9NnENId1eQ4LelassV0vNuUv
 U_wGt7.Lujt3swSPkIiKzqNEfQiNpTH4gILmsSOg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 29 Mar 2019 19:44:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f67f9db4b554a8ba7f0a33e21b5595cf;
          Fri, 29 Mar 2019 19:44:31 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] LSM: SafeSetID: gate setgid transitions
To:     James Morris <jmorris@namei.org>,
        Micah Morton <mortonm@chromium.org>
Cc:     serge@hallyn.com, keescook@chromium.org, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
References: <20190305154922.61040-1-mortonm@chromium.org>
 <alpine.LRH.2.21.1903300505540.689@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ac7638c0-911d-5c0c-014d-730e763454f3@schaufler-ca.com>
Date:   Fri, 29 Mar 2019 12:44:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903300505540.689@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/29/2019 11:06 AM, James Morris wrote:
> On Tue, 5 Mar 2019, mortonm@chromium.org wrote:
>
>> From: Micah Morton <mortonm@chromium.org>
>>
>> This patch generalizes the 'task_fix_setuid' LSM hook to enable hooking
>> setgid transitions as well as setuid transitions. The hook is renamed to
>> 'task_fix_setid'. The patch introduces calls to this hook from the
>> setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
>> govern setgid transitions in addition to setuid transitions. This patch
>> also makes sure the setgid functions in kernel/sys.c call
>> security_capable_setid rather than the ordinary security_capable
>> function, so that the security_capable hook in the SafeSetID LSM knows
>> it is being invoked from a setid function.
>>
>> Signed-off-by: Micah Morton <mortonm@chromium.org>
> Wondering if there are any further comments or reviews for this before it
> is merged?

My comments have been addressed.


