Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5FC433B4
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C5361025
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 15:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhCaPlJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Mar 2021 11:41:09 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:36458
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235520AbhCaPk5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Mar 2021 11:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617205257; bh=Z02XmX+0Mt2pXfYKNKZIJvP10maumL1eky6/lOZMiOI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Prra4wT0REJlAQjJ/8cst0bg+Dnxc8uvAf3dexHep1c9UHbUCAUeciCDUzcRRqn8i9GIxGflZkFzr5fc38cUmlZ6IvS7LhnkPHjOoo18fejHODkkznHtnd6SA0N5G/dJzalT7ZzKm7FUKqJPz+5DvORwONnPjQ16igiGlhvAiPaHj5uazXhUwdcRFj8CODUawlBJmifUgRjvL3kFpHcV22jqIC4krHDN3TFdZDU/wN5snPrCs87sy+BY7tN+Lk3Tf+nINGYWUZLu562EoJ+iI5l0uuS0+E4rYcNflKPGSVC9ER6wT60WVjF1CrgA2Y5NhxOyblW4aCv4cEhjsu2mKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617205257; bh=7SSWanaPq37y8uzdOXVAvUAQmjRxUXenlRDNejoJzxa=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=nEwzK8Ji/7Yz+1hWIrKLSOpkzJ4znDSoKwHYeWAGj7f3/8Ql5Q7lGd4TjAO8CZj9uqcpJZxc+qej5lSoXSBTu2/RmtwFjnBoVIiESagBjtZZOeNO+vcMmDC8sGZpoY6MQo0q/8YMz81mBdgriUm2nGASEeW9CM1uYeWHpdKG64bVugR/1h5GnFSjNN1uDiyi7YGkc8KYcmnLmNEcnyF1aTTLsE4KgNaRMdPFAo2T7pE7jbr+V/3xzQ4MURSiF+88WeszsrdHwJGGmHK7S2/lxcM/GG5Ndkc1YDX2zqnEWjmyLu1zKy+tQ2CpK7VQ8r9D3PlZWPoS3sb0SkMSd4o0gw==
X-YMail-OSG: Jz2huvMVM1kmgZwHsZ4oXA_c6hdu0VUHNzNvUtYvvSHwQQsd_BtJ4YLolictK_e
 KzOAzULFgRxVGfJBjuVn5a5fJykVZxZ5yMzM9aWOhu8rlObDiPVY2KsB86qgJK4ON3ZKvhwY8RrK
 R.j9E03PvP2Z4PuxI9iPj3_RXB3WGN_dpK5qNi7R4740I4sIIhJSX9g2PJgyCaWWQCcFJPyjFX0T
 eDxHE.m2uBq3Fv6uL6oiN4bKrfcL.y25a7__4cX.kcnUOJ_jwCxzHTgUY0OsgtAfmtkOEsziKW_q
 Fj.dUeCX92V5MENYkFQ5_.WAmPFHXciGpSGNP9bR1wGR858iZXlgg1uw6xKw_5mEBHR0FCWl4Ljc
 _66MKbUcYUlomXiJxdagZYQA17kuBY.B0T0C_Vw7e8GTmHkLBJ_QfEgIMLfOU0Ryz6ke1_KU46sH
 dePi4pTWkSkCvP4npvgEXq.MGGpF8RhoC4bEwI1zntWyvKHp.BrDhyHDb0zPaugZtksp.KWZmo2A
 PuDjhN4K.a__369d4E7iKex8QWhgWNEkzI5e7QuPAnnSZQk2znT4uwfHulOj8.RxHEggNK_wWKxr
 P_H.uVpaptraXDcxQ_Ve6ClSB1V39YV1haaNtaeOlYobnWojH5PmGVZtb7ZZez8gujifoZtJO.Vg
 OXYxOsiip_rj.z5ZvIwPOSda_HUuAHtV67JP_nDopdjkAl.qY2jWZtS2q4gVQ6s7iI3eJb4ISou7
 t2nOD6KhwNNLscrPXCzIONfaiU3fHrtY8sprovYvg_nI10bQlXyMR9p5KywFgaxxw5__sZtlUxLB
 RddlMQ5gJMbYQxa36UFjasL1mGB5aeTkaM4j4YDigj.f9W9u.uB29kSP2jffdig933R4H6nGTO5E
 UKGO8hpOmIL6CDJWtQ9RKCNwIOvSDF6AAwe487JAQAbrV8A6TMMZF4Ij2Yvj4aceNN1AgaAr.znv
 iFS1VO.jZf6rqrkv.BPdsO5JNttp3HFiQH91PyjgXDzioVgfPH..wmmYJgefdLyG_PU6dX7Zf_X8
 7enKkUaAv_67FFBhARpHb3pFj6BjjNYVcR_8vNlbC3z0fqfyqUT3j6wn5naiesLvGOn.lXua_Syl
 ANN5bcRyMU3_tRaeQD5NHT7PxCOI.T3efZWT2x0ngMjUTc4uQ4UXO8D1hKX4wt.aF9uQPze.QIN6
 PNtQYg28YvQncivGY5DPFAoOidE9Tb_ukmIuHUSo4o34CGer3qwp6h6mw8I_QPMZxKZ3J6QCTXfM
 PflLnjwSXc4mGAP3D99KCy.WtCGVPZuFnLqAyRckpZAnKJd0rXHVsJ5DEcYSL6Z.ymdwKXFqy1_j
 AZu4Jm5.jhyZcHECE5ql5SF7C.v_6rVk395hfD_KYN8exKXcmg0pKhHC8CGiRdxKFSqPusgXSbB4
 iX5_eTGloC6wFXuN3PG3b1YaLvrVPSf6Bk.Mbw7yh_mn8RQVoh2Cdkrk4K.YakU_jlTnoeaYzcvw
 jKI_L8Gq8_.X7n_zOwv67Rn1lSJ8qNPNt.uhUPGFIZkeRxCmKo.OMEnHndiMp_TThYJbDRYMGYVz
 gcsRgjpxD4SVJu67w9e2JLfiyfvLW33C.RF1Ni7XEeCoFR9AJ5418BeoMOfuPTTbfohRRj_2PRxV
 hEoNrEA3D1F6YRVwuXd.swkuIO96Bbr60LHdrBkrJtViOYjl25XfrrTTX9VIFYS1rhID5OYGEieN
 6p2vCTX0aZ_6qG3hq33PY75KTaT3EPosWrLIBlEiBY4E9SY2RMMpYSKvoft5YCxtApuUGstZCDJA
 _38ttkCXlrl2uIl.Dyi3rRGLN_ct0RYh2q8bAv3qTHT4Xg6fGPev392o3_P75xASKAYg9YLzh2W.
 Thk.1VP17QhkWRcjC0f_P1lbPcahJ6q8wOL9mkxelBvnFwiUXQtTVA8MjKHCD9E4GE5wE1_4gno_
 daQe6uaiB90LozR0PixxVDCNBb88nkalYsdR_f4MCZhKBKLGLelelzhJcfb89Q76jLBtYVmYrs5M
 IIrxCVJQiIFCBiaXQ4NEhYhzkM3HghGMSpZzn_KP2RvhumcWJhXtuqS_9.PYkUMgMKzxmeMDyHyR
 OS8CuYs8M8ghLbCM5MDcVGd2ogyCHSh6V5J4zeEDCQmOgaaMbJuMkn1KGctPf6bm743NmEwOdRta
 dMjYpVQpoFOh_nStbdCxL9EoSnC5DUS_ScX0_uAzdEgs1KCxwwuvZpUQFFrW94.3u.CRrWM1S7ff
 ercJ6XyNSn2zLKIBXsdVDGkl9zEtr8MAZ1HWHH78CjM8V0XnfHs55yEEPYMjGobrMnguHZ3mh9Jc
 Wn.IeSRBCZq4fu1jApgSKHNeQOvOWQ4EpSfgHgQR6Ye0EOsqTDqjOqXrcsbyF3XcY2jBIVyeOiGK
 dn4gWmxT1MKV37YavFEvmkIrETNcEa5MYGN_Y.JPfHz58zVCr_KaKZAqEEXcNnHc3lll1zmoSLdY
 twUmgaH9KIuSZAcloXvw5pOFMFMw.vPDDzwHKtWw4A_0ZSZVIEcetmC8cJnwQMglf3qnY4ZO1kAl
 kBmuLD..7ctlUPRmHQwpnt0cKBrQlvuHjjcqWmCwMABF02p4dwR1ON71zmGmxuDODapPTh0mQyEB
 jlOq11deChGTCWliHg2AYXkQeoKCCWvKqpoMu7m2qtS0vc6p1wtG8Of1umNQrL4IqWoqOvZ.p.az
 b89iR8lbFe1_6zpQs2f32s7Qi8xZRhIrABkO_IfLeKjPdDyNn35PfaHBP8gv311CVD15Apn13CHI
 EPQ8OLUCY1zaJoH3FRf7nYXYCiFGDDxkwmVh1We.8BLb3rIpmStFm.6ldCFeUv2f5tOaSOUHufKw
 y7RTwb2_sYfRkrjkq72a7DQ0hO21v0cqj_qfbcMNuhCgh7cKGP.h7Xj2d4g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Mar 2021 15:40:57 +0000
Received: by kubenode523.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1e30e9276f309eedef0c4632a5394e18;
          Wed, 31 Mar 2021 15:40:54 +0000 (UTC)
Subject: Re: Commit f211ac154577ec9ccf07c15f18a6abf0d9bdb4ab breaks Smack TCP
 connections
To:     =?UTF-8?B?5YiY5Lqa54G/?= <yacanliu@163.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <3f8328fe-e648-9d0e-729d-eb6787f11bf9.ref@schaufler-ca.com>
 <3f8328fe-e648-9d0e-729d-eb6787f11bf9@schaufler-ca.com>
 <9b85945.3cfb.178862aa787.Coremail.yacanliu@163.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <83947731-d800-9a1f-71f9-4460c46e322a@schaufler-ca.com>
Date:   Wed, 31 Mar 2021 08:40:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9b85945.3cfb.178862aa787.Coremail.yacanliu@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/30/2021 7:44 PM, =E5=88=98=E4=BA=9A=E7=81=BF wrote:
> Hi Casev:
>
> A quote from the listen(2) man page on my Ubuntu system:
> The backlog argument defines the maximum length to which=C2=A0
> the queue of pending connections for sockfd may grow.
> I think this implies that the 'backlog' must be greater than zero.
> In the test source file (tools/smack-ipv4-tcp-peersec.c) Line 60
> I found the following code:
> if (listen(firstsock, 0) < 0) {
> 	=C2=A0 =C2=A0 printf("%s-listen\n", argv[0]);
> 	=C2=A0 =C2=A0 exit(1);
> }
> That means that sock will not accept any requests,=C2=A0
> so client=C2=A0TCP connections hang with SYN_SENT.

Interesting. Prior to this change the code above was
accepting connections. I also tried code that uses a
backlog of 0 on a system without an LSM and discovered
the same behavior. That is, it accepted connections
with a 0 backlog before the change, and hangs after.

Is this a bug fix?

> In openssh case,=C2=A0it use SSH_LISTEN_BACKLOG as 128.
>
> At 2021-03-30 23:42:04, "Casey Schaufler" <casey@schaufler-ca.com> wrot=
e:
>> Commit f211ac154577ec9ccf07c15f18a6abf0d9bdb4ab 'net: correct
>> sk_acceptq_is_full()' breaks a system with the Smack LSM.
>> Reverting this change results in a return to correct behavior.
>>
>> The Smack testsuite can be found at:
>> 	https://github.com/smack-team/smack-testsuite.git
>>
>> The failing test is ipv4-tcp-local-peersec.sh, but it seems
>> that most TCP connections hang with SYN_SENT. Oddly, ssh
>> to 127.0.0.1 works, but other TCP connections timeout.
>>
>>
>>
>>
>
>
> =C2=A0
>
>
> =C2=A0

