Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DEC433DB
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Feb 2021 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D29A64E38
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Feb 2021 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhBBTgE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:36:04 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:39412
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238296AbhBBTex (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Feb 2021 14:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612294446; bh=ffKmFpWMlYFAPTjEDC3llRKB9Lrhg7fxHnn8+PmK1m0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=r5HQ1K1QyvrzD13wHJKJ25vkrK22IY3kqRF5/HoKm5jBI0tIzKFL95Bqbk02g+dGH9jkyQQ//5ERzgHneVJ7UKApyyRJqgWA6Dc5sWAj7X5Q+MyaE14R1VlUDFrHiCdtbSipf0gkfHm2lVHwKco/ManTtofxtG2x8R4Czl3hqMSnI/vBaEgfVE/Wge91OSwfsiGFcXuTC9ji/aC4EtKTg598R37r03NqGqI7cqGdMwdxfYBSEc0+bWqvBOikZhMMXxLRgVM5G/7ohFLugcLUZKus6CUPcAY/lhIRXDzyDeePXzdtWHuCb7o7FkX/s226NGfjnG0nxQ7rIG7eXSXZKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612294446; bh=mphhD3eVyHt7Z1VyJUmuKI9b7eepkQ/mwIczOWfntjM=; h=Subject:To:From:Date:From:Subject:Reply-To; b=lg8MHYZQaSHmkcgY4ln2IQY09QKzxfoZTE6Jljt9YZmAlSrvhYpi/9birIjYUu+EYDQrE2dqBbrfw4rEv1Tl8yLMNd/KtU8Efd0piEyR0wnDN7kPeru0SdC+laMXqtORrMlS4EDkhI13k0DFUDgiRBUIGnx9L7dAiPqVUeMm6Pc6ZhyI7ubFYpHFten71RlVf0QOP/fBmJtGOIWsqH7Ck4I/01wtk00vJxCbfVDtYrdCuMwQS+GtjTZlaq9wFMfFsi4sV/9+erutDiOaCkdBVyOrfnulkbp3MwY0dzNeBOSNH8QSs/sNXxDYdl6d4DvpLCWpVa4A9NQ39KXLX6rouA==
X-YMail-OSG: 1oFZJugVM1ljBpgmA3l8tWT.ztvwgeVD3oSCiySgbhK4FE2A9NwuTNei.aRdkmx
 2OE4J8HBnk84_Fys6oOX0ib778.5S0z8hJIHHksdhYz.H42WtoQk0mKW0xF72WELhqGQXj8N4dlj
 KMZcSxDb2iA0FZzGykgZgDfzuqGa.xwjlkOZBzs0cMEjg8qGN6RXr7vGh3CX6wkegNoZEIAnHJn7
 seH5kHcqX35eC3g2NxkDQB.2dgwGyIGyC96lRbIzsCwWNTefszlDreodR.CQ6GB_ZG5a2aHZzfos
 yt6KtnghBE7aDGo9VUSYZ.rc7wQNWn.bolzG29Y2IpQVr6ABHY0ihG2rGd2ifwNeMDfZLi1n5jQV
 9ydLRNOEJGg2hO7CUlzkg1vPEckBGJarXQl9szZpHFHPvoXx4X_azZ3ruVIOoSD2EkHDVE9wP99c
 Ef1WMUWKYLSJNxIhfmes5wU80GYluxKoL5C0TByU0Wa7HcxAFkhLsEI8W02L4_UMYT80XsXCZmFP
 9l9duXpxYY6BezQ.gz1Gm1FEVBGPVn98RdVA7ujKvFO2RN3IyHo58V9y19hykx9Hzd5Xc_6_4emD
 X6JpvjxLsQZ_ddzhJxM6as0TNOcEMjRO_zcH7NFiLa_k1dDCvBX2HOt8qNo5E0n3MztFvRAG7jyR
 ROpIuAqj.AKNn2UP0yTULkafPsfE1sLb9X.hrBjkCyyuXKXp20uOwLSebF9uN0JJx3nadphHKJ_8
 QnGr6EK5gPaEInahKhN5WehcrMHP6QBD66eSsYAIlTaIqMsgV6XhcIJ25d3.KGjRYbRyBL8xTiOk
 TEdpfS.ddgz65UcpWYGk4MnPG.SJ6.YoLfbWnHDaTrZsSHvLZAhjZ._jzQ5lvYg5Y6Yj4Bi67xYj
 vkrgR2s0X2o7vJmWuGPObniuRJbOQaUZqjHCea9I5hU4DVX.QemCib8v1thLd8xTpgxdSPMU.2XS
 lMWJIPxaEZxhxv_BYY8RL8aLKBbEFtl1mXwPzJ9LU5fi1qLG5uJnspgQO6OS1oJ9z_B4K6An4sJv
 c4xeWL7YvlZdwE38rWNGjTMebzJP1p74nBTweZ9fgzx37IyaR2VIXA1Mb0pCm1k0I2rGznCHAJhJ
 fga_czAJVCXkD305RZnY6qSHCvUk8TFq3RLv3s9R7nFbxLRVFJVZ8iIpO4UyS5gGuwBEHjwSbRJx
 XEMVttVmnnwGj5A0.g1mVKoLG50HrzzS4qVxt_7FrBi_q6RAJcjeqoxl4fgSZWf5Ez8LgBFCEWrH
 cCoScuy.tlAXMOa7xZoRrmsOfvQak25lLB9gvXV0qI1.wTRR1jqJOnzJX5CEOwgW.3z9tJYU35Be
 36oQnxxn5SFzvgi8691.QzJzFeFrbINcIaRbFPJartZA9Ccq7gp2Qgy6nyciLczd9FiHNUU64Twj
 Z7c.SNvzbkEFJqTFM_PfYKw3e0Ar4w_3fiKz3tR62UIvpDuNagP1tJf5B0YurMkKJkdAwAZ6Yx2j
 Cv9gfHnMtbB9gKruRtRGREuh5fOT_6OA3W4G5c8HrWWuUnOL.bksDGO.DtnCUU91oAGbArXRJbgT
 Bn8kbC6zn5zg5DdLWhrRgPSF_QPnKGJ7UHJZfCWy7E8Tkl8m_qup4dhgRLBaCqR9MDPtUULb2Zm.
 5w87F8isOsYl9TZ2nUDO4h_8KLCOlUz7ITtj9hJXa6HQlwoWfMgVEXBS2FI794uWPrnOV3cIa7aS
 vg5HY9XfATtXkommizxR67Od4TCgmhpaTCZs5ctaqUwCPO1.tXArNqSK7bOxA62d83D_iKWbW92a
 x6s9AFuogcKOxPWkGcW.Uqz__qLOEH5_E6PPeo5wz_bXMBaUIy2wRHQZilc2FqgXpNr_ApFaTXSL
 2NyIY63AdfIEY3euja1XWYctfqgxmwbI6VU.DFc2YGyqXKQmw46F5nlcbEgVA0JE13EOmAf1h4d5
 I9arHAxki_4d9t3DZr6aY__ASIC_ZG9XUAGwDtjFsJBGwyfgh0ejEvg9.J.SevaH_.0EEggJu._I
 ie_1LwVfVKMn8P.Z.5BmCvd02_4hef_9VKe1ZZm17RcA8_xd3xHa_.dODLITB.VS_DDM.HTdee67
 nyZY7xek5FevkBreYusUOkCGBwWqTUlbvnmbVB6fk.Ez3dOx1LFPSWtuwLxOYeEVMeTb0iau3TDF
 yv1odvYLqLb6CrrlffpJs.HiMw5umwqnAdn0tep.8oFbMMhs1VMACB_MMWYE3wZXcef3KugEZy4a
 323I8bc2piz2YF2rFTrrkQYIcrLBFXMVzn4NIJggS7F54fDISYL_.63Qg8OMxFQCcggM_IS.UFRR
 JXCjpjKxW1o5GpS4cWIg8okvHu8FZv0Ed9yJKQjaNXYVHbwQ94eZKOpfgeZ0j4RPCfAsRy0bRoMF
 ZxVKtYHFCQxsXpHLWiJYxCeMoxuYB5kOQyNVi0oNQdoVOZRoLoHhc3S7QX7SoQjNh6JthGSUjC3m
 26hM8g5GuXYv2TlOpnoFTnKK0G.0u88JLM14t.f.NlV..N3x3vqk2XcdH1J8V3HIkYeCqWm8TW5Z
 MytNkUUqdfejApMyUYRixDYHf850bMyfgk15ETESI3AYH1P1pTsKlUr8byNX8qNEM8NOYR.DZEy8
 KOHURxfao0VORIGRiOaIov5lR4lPjsSmjTmsdPQ5.3443vqYFTgRe6V8xwIGf4kiBYQPjy5wmeUM
 8gkroJBZEWyD_hb3GP5wOoQbY7SMZR7vWmdGhO3si0Gk4nQWSL8YRDLzHfXwKSDA_DMo2De9nATd
 5F6BUINNaAGIjPT2DM9r7nrodDKi6ORFSr7lG7.4FAUmbXKve0TOAIgZTEfkQOyb7DmKSeZdT5yr
 9N8IxCQWThs_KkkkIAa_vx68sdAXKRu9NRAenjlLGbsj.6yMHGyMR.QN.3IFsn6qIyntzOr4wE8z
 k0oHV5McxWiANCfxabcRTFOmv3GpYipi1XZ9vMpefrEAgyatzaEDkldw0mdGFSBjqbjLrb4kGZF2
 VL6xrmPTAg6NwlJRkeLtl3r0dM3Tw_zj3lnyAA0xQ2kGXRK.DgsOi7ADPIdWe4CvqolO3J5Xf337
 HAcIyNPrdZLaN.tZwllLUovjlEZKAYSPmnhckO2BT8rfJgmgoWta3RaC45Ndiq3WeJe1Un0.ekD_
 5wqD6XA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 2 Feb 2021 19:34:06 +0000
Received: by smtp406.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7b895dfc98e0e9d57e2350dee38d396b;
          Tue, 02 Feb 2021 19:34:00 +0000 (UTC)
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write
 functions
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     andreyknvl@google.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <d0f9a341-281b-704c-04e4-4304ed17ba23@schaufler-ca.com>
 <20210202191318.1402500-1-snovitoll@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <58e65f92-51ea-2dd0-d7b8-a63019e3dcf0@schaufler-ca.com>
Date:   Tue, 2 Feb 2021 11:33:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202191318.1402500-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/2/2021 11:13 AM, Sabyrzhan Tasbolatov wrote:
>> if PAGE_SIZE >= SMK_LOADSIZE all legitimate requests can be made
>> using PAGE_SIZE as a limit. Your example with 19990 spaces before
>> the data demonstrates that the interface is inadequately documented.
>> Tizen and Automotive Grade Linux are going to be fine with a PAGE_SIZE
>> limit. The best way to address this concern is to go ahead with the
>> PAGE_SIZE limit and create ABI documents for the smackfs interfaces.
>> I will take your patch for the former and create a patch for the latter.
> Please let me know if there is anything else required for this patch.
> AFAIU, we agreed with PAGE_SIZE as the limit.

I am in the process of adding your patch to smack-next for 5.12.

I will have a separate documentation patch. 

