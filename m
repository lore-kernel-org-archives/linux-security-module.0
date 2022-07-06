Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B67C43334
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiGFUij (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiGFUij (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 16:38:39 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7AB1A066
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657139913; bh=qMlT1sfyIOKt9jSEGJ2PIEJGFPTv60Qeq8zjL0K+GZ4=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=e85t85RLoOMduveY0OlQcD24tBDf3j8U9W/HmfJyfHmydQijfGWuplcpCprV5i4vwxgGLDiMNZpFVrFpcJCYiVfrRtWRjouBFPfkP9bxXSvKw1NSAxTYDasGu0LEllEdutBFObD1CHKX7FQEHgqG5MVyvE1YpF57VC735dm1c7fUNpiz/2s/2nccqK8ZHKUuQolTZS+uCm1TH9vgtepNCYdfCZSqdGVgHfak50z8fVFoS6v/dZSsQ6gSMEu+DYistLAk6YflcDIE+RAURwRbwH+5UXKYCLJhqZCT/9orIt5ZLj2/DHGeZszK3XIhonSTFQUPN9bVPsUMAS/X8Xa1iw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657139913; bh=Gtqqye2h8n/R559w24sF4GgpqAomjX9UPEX0C5+jq5g=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=edb0EzatNvySHxC9CdNGZgtOvOw4lNhC+fV816IL6OEoxou7+sPXhiJKbv+ZaiZzGgEDku8LWF8e9Fpd4On8xPxY+50wLahKuOPrD+WkNIM6nw9XRL6p4EfErYj1oNb6fuafvlY9YjRpNOjxlL3JHkqFMCxxOObWezirErr2guZPIhhEqQaF3f+nNIsBPHDcMHsmdk3sHyVp0a4PMjTZzGhwRJfNAmHCFW7ge7RuyUE1M9WmU2/SX7dWYs+n1z5TInSCvVnIVkx8zyEBt17B0poSi9mCXrYPCh/y/JhH8Aj0JU9PHJqzHtq755I+XhzpFPAQnGYPcyoK9qK68XTArA==
X-YMail-OSG: mikaX0wVM1mT2v6Z6cO6InAh2xs7dWOEtCdCzW0RiNppO75sa50sqWREqd0h5Z5
 PE3DcDeO458tO9XLFH43B0d5VMLArjaE1VxgpGXRmtzf0O9oCUKdAwBXnhyaD.EHVNx3FBhG3qGb
 rORy3WItZHCEX8A9QnXOGzmqCNbbJs4aKmlvfGhk_phryfPLjMupXGJXIgJ.sDAEtgadTnmnJjB9
 fIWjsbHUxyGv.r0P_hoMDa8V76dv0hrgnWbX_nxsRLXTyNpoc4LQpz4fABoNlbh4dyqZP0o9Bs62
 Ysbtul1LZGHPG2k.xI3vdYIB_RVpjMJRkHKDDZEu9QqzFI1FuUTk0SniPn_gNufvGBoTMNhNr.82
 g7eOyp_zFehu3PCqxi45eWuAEfKZuleTRdPYShCA7iNhgWTLmIcbES6F8BHel4bJqMYfHFY0qVCR
 Qsjghi1Ge3pTLHYNZ3S3jOvg0nrseRk1xejSOy9d2Vb7QRYhY7MeIa95Wrv.qk3x5Tbw9K5Sq6nj
 kcVS2DXKLxpbYXcJDpwu2sXlNSUtG0CoPtR.OUaacNXIyJifeQLRZhcj12hgTQBwynbPFCkSwKAP
 S2zE_iJZfosH09vuroKZhP.kQP4B4CATWSFoA1q7f5LhIL5MWwriM4pV_q6Ye_ZaNWuK1XcSOGVM
 .QYgydhJh9bjQxL2E0c7EU0TKhfNX1aMJ1kGQT1H9KJWBD4GzcE_KJJ0KqLnVzPaanOgGzEUCUJK
 aarGRIMtEUJhqN8VKCDAXPjxeCoC9Tq6mJ9l3wOvYG87rjSJLg2MKMkiLLfhHlx2W3oJBHJympXt
 amqScWbutjKVttKaMGgOM_UeP7VCOij2bsIray5T93oLk1wFg.XTqLIzZComznWSO1Puf_qeWGY4
 GkcLD5apAXIM5KC04y3ynWPIsZiooNi4Cx8E3WaEudlUihRfYokn3wWsNDfym15M7tYOAs0.77Vd
 WveBpnvAleyrKXWGvv.Z4UzP4eIIp_cAwjGy3CipUehGS2SoTuruVdwZplifY0oNjx7oiypno1LZ
 wdYNvvgJxQOp1bVmbmPBclz8k5kOHQNohfezNA97FYbkge6jZgIasu3oTOK2DenMI1s5VsWJLuJU
 6HXCld2T7qPha.EX0YZ6QJMH3OwjtC4FoOFYy186cG6kRsyUl68.Z9M1Q1PA6sYKiqly_aDze8Ry
 oyz8uhhXWRLpef75vbKEJo9846IajMSspzUcyeDCYZ3adFJsxcjGrEV9lMYzGEDKT9bd6PJSp6E0
 isyWfEAM1rwLYFU8nh5dIHhzhF3tOFDUBRf10TOsvL2mKFPRpaB57r.bXlSANVkKu2AAeRtZqppo
 mpo3VE.LIrWqYbFs3PwxAesewyNb_C3khoh7bw8aEJ2UY3qKfI66TWYCYckzVOKWiYpIJqmFL_Pi
 9gLPUd_q9m..TgDNA8q4.YAJn8aWQQOGTqdxk6stR.Zhz6HgmzZXZ.lfAV2xNCqJpK9gDqLJCm6s
 NPQdgC7YATmsjnKylphVuf0Uq2Q1zzRE62yWxJaz1hrW653ex5VVAotQMUhooGPh88.uk8PFBxTp
 FGnnN7Zz.zCZiIGnOxWK.C8mhw6cjKsdX5kkA.L4fi.k17l_oTJeiRx6mN3tFesBqoKTqCiPnx0G
 zZDi1DsUufdN55gbSgVgJkIZqmse5XRk41MLoo8SjhHU8HyV.oBFP4MdLWIiv0D5X93EiXKAjsZC
 5J8t3IhKC.9XSemOx7eeQvrCeZDASjHbVgovO1pP2_MA8TZUGBoNxISmBVkMM.3vwrlkMhqT8dsD
 LuJS0E78FeuiNN.1hngDkUtqFtp140YqNwc_zcYgO91rdQ_4UMILCCDQrvUDpQPbNq0M2aq04efv
 yedaQ.KXNhnfa7RxdDd.eOA5ONx9QqmX002qnTlNXKB4.GH86aT7kImVftfC3FtJwFbTJHzRhqc9
 R4ZSZIcRRLJQR4ckf3Aw6F7hAS9VplpUBCkyG.zi4hMU0rZRCVa.yeE.hYfmUYTb1sGrbNdb6Pol
 cUle9DsHkB8esKXVrXTBjpp2iOBqhGfRGm_c.qlmQHbA.Ee0FGKmAoC75Rnu8No2IHDnqcSDn16B
 tdjDn3Zw_Htl9MnUNMb4ObUh19Jz.px30UAJrYpIQg80TM.epC0LrtmcfgiuYpsSW3ug25.2y0Sb
 8AgSpKqjKmuiF28l7x9N0iRuqWJ_kDOqS0kJ7mmmL6fq9rlOUHUnHUnz2YKl9JgLO87p5jDYrIAo
 2LgipKqgZ7H4YJe0N6cszlU7xNjM5udVc9lIYYZZ3sSOekZzHkfCB.JYwf7Ihm.l8ciPxKTiHDER
 9RE4pUzrB3ylY
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Jul 2022 20:38:33 +0000
Received: by hermes--production-gq1-56bb98dbc7-gxlbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 48867d5fce25f0ef3819f44c1eefcdbe;
          Wed, 06 Jul 2022 20:38:28 +0000 (UTC)
Message-ID: <35a2891e-64f3-6139-eb3f-5acc6dd406df@schaufler-ca.com>
Date:   Wed, 6 Jul 2022 13:38:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Maintainer update
Content-Language: en-US
To:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
References: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/6/2022 11:56 AM, James Morris wrote:
> Hi Folks,
>
> I'm now a manager and don't get as much time to focus directly on 
> development work.
>
> I'd like to propose that we add Paul Moore as a maintainer of the Security 
> Subsystem, and for him to take the lead on that, in addition to his 
> SELinux and other maintainer work.
>
> With LSMs pushing directly to Linus, this maintainer role is now mostly 
> about merging new LSMs and major LSM changes, and integrating bugfixes.
>
> Paul has been taking many LSM bugfixes through his SELinux tree for a 
> while, so this would be somewhat a formalization of things there. In terms 
> of new LSMs and major changes, this is and will remain a collaborative 
> process with the LSM community.
>
>
> Any thoughts, concerns, objections?

It was pretty easy to see this coming, and I support it completely.

