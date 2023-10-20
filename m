Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A075C001DF
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Oct 2023 21:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJTV4e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Oct 2023 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTV4d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Oct 2023 17:56:33 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25101D45
        for <linux-security-module@vger.kernel.org>; Fri, 20 Oct 2023 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697838990; bh=pAE3HNmxsR+/70LYiFn6rv3areWPnvojUZSQTQ/QPiM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PszDSzIsNZvlR5FF91cpoRuoQR8Ad367I4JfmzKYVrEN4Dvihm80nawN6dbGcCypYcmZUR/h9Le3FE03mm0UZEt0drz63HQSJBSqvfSJoKkw/Y7PMKYnuJ0TnEFD8atq5LF7nLfnCYHSuANmGQQ45ZM8Q2zRtXXfAndvCeZ8GV+gp3PexECkTBfq83/7QvmpMWkRwsHkbLhOwHvLIoO495qPtoaHRvogQ/8QuFd0EGUTnFi2y4D3nPHzGT8y2u/c3VLor63RuDb0x1FpCHDLqf+NN6ePsGPf2o4mXlpmQcAmsVrcjVZvfYIx4SK2iBYlloUokNmV315UjTyaxR1uCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1697838990; bh=19x8ECL3f4roGQiATYQSqes/rs2KU7T0pfLwjqdbHB8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WhNDdqZIZ0W9UPP59iUytc/IUGoqoUOUWqYHVrGl9a0emrfzjoktm2uq6u4OMXNfBldqRl1Mj+nFtL9ZuR8HYW/vmH2wEs0ipqq72kpqwZ/r/gWteljiHWPA+aNaBAd6X5o8fBagAQFtdeEaN8gysmSFQfqXkVI3eLUcQzNIxpBcYtIXcnhqFvUS5+LQEYebhT8jKeGfUqYSCQVJsMaEzUbp6uheSAUqwMqE/oVEgFc8WTIcpYRBVESytM2HwTAOTk9JUmED7GQ3OA72Ul9eif9ns6HQEhYQEyySJljyjnM1fTqGZdwgSiI5JPQ7q/kELuHjVbeNM0YxRcEZYS0pUw==
X-YMail-OSG: 8.tWE8YVM1ljOUSDM2c2AJYGGCLIjqSomXgEvdXccLy0.5uZizeq6uxuRED61T6
 3oKB.OwoN.mRf2UGUpPjDSvHvxuJj6AxtfPMjaNI.qmGG2kzkkBsnl.45BOlkoPnf9wj8_X8PibJ
 BlqjWlXDifhNqv6aSCigScn9XC05zAY2AVdQi9LdewzUkoSLoset2hHafc4aJC.e4HclhwA2XzGG
 oFrXDRg2XV10Xp.uZnKEcWIN18mwWYfo_cl.gQyT6WAxaw4Bh5o9bn3UIGnNuOAjluIucp2Q_8li
 goIclEzckr4n18ye_JFfwzUQBFuBNztHbrtHf.qGzRRLU7ajIN1zPk6J5Jn6MeUvEjRU4LZboO5B
 M8QCaiqrSAN3yhq0eDHtuj_DCdCjpMsNP2ozPyJ0eE1f0TBeud.Y9ZYgwFNx7jvXj_l4HHeaD2LN
 sZC1TFnfAZ3gcBG2CT8c19SOb1mDfw3SYBrHDc.RttjXaP85WgkBdYYKNbDjIbe.HlWnjynnq9MC
 5k4DgjUe.yPdKp1Q6Nw4QccRkI2OGryEKGX.ZyFoazsvlH134MnS8E4ACgTQValeZPgAq9waE_F9
 oFR9dLyutUL3rccKeZXy2Pq0GBKsZ_jxE4hEmBHQjiKKhj0.RnwMT.LZtTye06BP8EPjOthiQ8YO
 MdZu.urBSQs2s4MXyjSlIsLGlBcB91ZcURkW1eb0UamaiMRTzDck0bBwDKQIsTO3qnrKgcL1r8ui
 5UX23me6CAQ9iAtPIzxsSxOcgosQ2xqn5hJSx_yRraIwNpYQZ2VjWOkI5q_0JSdRIlpkEzH3J1I6
 MtSD712diqlxjboGD2.SykuaifonzKoKp2sDFf9JKfKOIXPq3PeUucwtAjRnQv54PV0qDjuhmphb
 BH7vZQRJ8MT2q7hku5l8mt.ol0mC3GgmrKMQ8f3FFrctZpxMURnZgUv9n.dZ9wGL7pJ58gik_Wuc
 qZDz0CK9bI5NSA57b2QhdY6cWX5FXybcjSjoF5bpXIPZ1PSL_peuaMhFqJdoUmj_8Gq2KdMR9Jbg
 fAzUhe8SFr4vOLpza2FGNLqZagZVJEGUEBMIQlXcLj_zX1cyjoJ6L4B0XOIhu5dGrT3.Te1mqPj4
 HWKrnuEqZteXtJp7.QgN8LIK9f7Fp3xTH9qDyNgNdVrNI0yadLjoC.fJ1ZMfxDxufr4vI7QKK8cc
 1XpN7dk_ADSUQ2sFXtipozZIwb6oMvvzg3Q8cKG9rFETduMoEFGHvYQRq9hmcOoTKkBpURPUD7w0
 zec1cdIHwb.wVv9C8ozzXV0Ssvh.xJGqdXcEYciCOk.0JzmIpYFloe1gW2k2on7APtQL798OI6gZ
 r_FXhOOdPVkzYb43S.b4vN82hZ4S1jaggNLd8qFLSpuA9sgxZvS2oHNe_4LSxMpGqNtkLW93rF4l
 jYjMaKQREgteFx33GS.nVNScGSH6JzGo3ImlchtW6Csv7oY8lHF77jtUj51EWV.7rUFMma6Q68jI
 Uobbq4EnhZCqGMl38eFfBAPdql0.RErPPEmq4kQ4MPxiAQu9N5Qwe6i7ZmtHNNlAY72lXPWAlNRf
 6vyzdu0poQiRWcLWEPvkih7auSgqEN4EqxBYeYptMR9sBVsXVxK_ugrlgPqNI3ZEU5m6ZdhXgLYY
 qMFGrQAbKUKDOMAgYQ98Nb81I40MU._Hdx2OQxo8hjGoyA7YO3FXRDwJifWbZaKJ7amyW7nDzIXN
 5uvGN2GmpK02tiDOLJAfMf1amDq9o1wa1koYoCujKMreslsnXZAfPgStF.d0XfekT5q1NN.dRRbB
 8GMrKd0tuMxH7VdJUvWKS89xb5ITRGi30f94Vbadk5H0lQq9qFoEVdCA3AVxrWyHhA7C6gYm.PPK
 uIz.Srsx0na02P_5ODR3Hkn47.IA5aKjI9CAZoOLRufhYHt.th8k7rSsOAh.7luWhAdLDg4QGYXN
 C5MiKmEwXW1x2gienHCi_xI3J12ZjTasVhJnvdTVvAmG_3mxdx32yohnWd3ynAzMSjFk2sphM54B
 FqSv2z6yBTIrebOxOKHTdxcSmVSQn3VrVVPbEJeYsZcfws0zOgcfN1G40xeTLJtdLjl06Un4rNmg
 tufY2oE69x.OXfcW76OD_665C7kMKEXFP0K2dVGZwrB8LtXGhukuG.U24clu0ZmDHa6K3pY1DX.m
 QuiH55TAK3XdVFqTQota0_s86MfQsx_Ok2EEL1MIOBViqpjk72c4I3Nurg4GxW9Go7_M8_6z5YVJ
 ackEk56a7DtCpFnI2DIRVb0UaPrjlcfjTa.FfHem17h16z.DxsehUL8yTvRimzxKAT0cJlK9FK9f
 _neKavgIeeg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 093840f1-5a1b-4e5f-b43d-164e81cefd04
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Oct 2023 21:56:30 +0000
Received: by hermes--production-ne1-68668bc7f7-mqln8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7d51f71c4754dc41c637c9276aa294d;
          Fri, 20 Oct 2023 21:56:29 +0000 (UTC)
Message-ID: <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com>
Date:   Fri, 20 Oct 2023 14:56:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231018215032.348429-2-paul@paul-moore.com>
 <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
>> When IMA becomes a proper LSM we will reintroduce an appropriate
>> LSM ID, but drop it from the userspace API for now in an effort
>> to put an end to debates around the naming of the LSM ID macro.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> This makes sense according to the new goal of making 'ima' and 'evm' as
> standalone LSMs.
>
> Otherwise, if we took existing LSMs, we should have defined
> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
>
> If we proceed with the new direction, I will add the new LSM IDs as
> soon as IMA and EVM become LSMs.

This seems right to me. Thank You.

>
> Roberto
>
>> ---
>>  include/uapi/linux/lsm.h | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index eeda59a77c02..f0386880a78e 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -54,14 +54,13 @@ struct lsm_ctx {
>>  #define LSM_ID_SELINUX		101
>>  #define LSM_ID_SMACK		102
>>  #define LSM_ID_TOMOYO		103
>> -#define LSM_ID_IMA		104
>> -#define LSM_ID_APPARMOR		105
>> -#define LSM_ID_YAMA		106
>> -#define LSM_ID_LOADPIN		107
>> -#define LSM_ID_SAFESETID	108
>> -#define LSM_ID_LOCKDOWN		109
>> -#define LSM_ID_BPF		110
>> -#define LSM_ID_LANDLOCK		111
>> +#define LSM_ID_APPARMOR		104
>> +#define LSM_ID_YAMA		105
>> +#define LSM_ID_LOADPIN		106
>> +#define LSM_ID_SAFESETID	107
>> +#define LSM_ID_LOCKDOWN		108
>> +#define LSM_ID_BPF		109
>> +#define LSM_ID_LANDLOCK		110
>>  
>>  /*
>>   * LSM_ATTR_XXX definitions identify different LSM attributes
