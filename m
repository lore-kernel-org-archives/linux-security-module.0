Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBFC433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 22:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377D860F51
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349760AbhIMWxl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 18:53:41 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:34087
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349783AbhIMWw4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 18:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631573460; bh=sYQ8064JvZAlfIQTcwo6O636nTsfvY3nO8CpK+HeHRY=; h=To:From:Subject:Cc:Date:References:From:Subject:Reply-To; b=SYX1P7ZuDT7Nn0KJXwFyz68H4tPWkJl6gx43IY43I+aKR8G7u60nqiPvPcxOdUUTzYGv7bfuEPKPrflvnrpREH15R6L8gKZLZCC/gRmg76l8IqtF+0hqOnXLDvv8y5aA7HdCPDFAPNUcootZI74RxA7N2UJdTAJ3qADkRnN0BwHp275WP9RCiaymTkkq9qD4ep/cFqJ6KkUb2q4mjzyqGW9gmCMGolQb6H5NhHlV16qJH8MSPgGUDM+LD7jvP3+/FvmLDPYqCGJQp1dtLnb4GBkoJhErMYLJpqSdydary6kjrAvsBhkWeHxv/0LihZj7qiEBQ4Rb28S4JLaMgYJfkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631573460; bh=w9sSIvLNn9YM43mBvwanETdU/DhbIl5sCUJlwjx+/qX=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=tVAeDlty4+4tT6S6W7u8wmCGwBZ8UAIoxuSYfmPcF5Hz4lFmhNxNL/AyQ6DytbMYJU6jgZWoozR6oJtNq3AUqabOKBReNjCWfEytyg7uIJ5WBfDYO0IUT4cXCA/+sVMHe1RN0Z9iXgigZCVk8g/1r7/gohb2OBM1ZIvDz71Y7lt6lkUzE+YGz2TZ1pubLrFykGFNzSUXvVHZxmarjQaRVPlg8x1kS/1PsjbkR0O/T9jiCni1TxhOs4oJ/65vZSlMvn6sV7l/U4ivRrlY2iDfOEcLXAJB74yDUkSqRqscvzUeWhf1egfh3xHVQbTy2IBafqzNecT0EcJ8u1NLkvxztw==
X-YMail-OSG: pOHZwhoVM1mq0TqefoDBJEHCXK8NihV6bVkejVhDHIQQhkC8DGv.RetJSVpKi9Y
 5UID8vzNNTTXIbA7ICwOXuncoo3E8cs16.tsRK0cCJ6MoQn3ui1j4Thc6eCawz1_uZ5BapgeLVry
 9RBd3vCH0x2d7JKdTo5_rk2cK4DRRvJ1.TyDQrgM8hjiyzyswMuRACrFAqUnVyHxdYUfcB.22w2v
 oG2FITOV0AVhXzRmNiK.I78hRXk8KrzPEBjzdB3Hib6aOViwu5b76kDf_CaLnMBIk6XzkcWhsQVl
 8pgqh_U2i0rIHs5VJeyArEnJD8mft1fHQXd4zJAh5dGuSifqy5k0aJ3.AaHy1s3kwe5KOKGl8hXI
 y8DOy6JM2URjlPj9ZNT4Cwf.mmuAk7dqYnEv_r7G6a7Ob3hNstDs4UfdHzJS0dWcVwTmzGsybFEn
 jc0_BkjAQrpoZgJ_4HJn3ZGZfDqbS.JT2kp1bR6egR3veiJaeaBEp6n8jorLuOu2DfNRD8qmmhkV
 fprObtwjAHP817kNYoYBe4QTnScRFF1nYVVpgtMBiu_NPQO3kVV8Kcfbeyh.qq_eh3LQyQ3xsW3M
 xulGgxeQxHQ4kYsAzEKIe96RUpICane.7re9zi_07DZly5pAX52eAgotZA.gj.wR_ffObwxI55lY
 VD_2Yg51bxCKMVecb2rWub4h6FmpNlW7Tfc17rwsqH6lIoICcUIRwg6w5C3gwmtoRGwLqgLISRBk
 MsXmE_9Zc9lHrxxtKMXU2XfIxyOd.V_9h7AhxKDH32ddDrqt4x8QxJiW1pDfeNDlhtDXdb4oW2NU
 ZgS9188wCegbn0N4K0H7u3dCldgmx4qCk4hnNJCc9kiVc_3EIyotRKwAIiWBGTHRUUq_XjSbPTFd
 .hmOheBrFEJG8WjKXaqUpBvbxcPndvvzLf_oCjyYBEyXxnbJ_yyDIVGNwT5NCnNfnowWhQc73QUu
 T18tRldys6YeKSx9YJXtMjuePS3..Yw.T6Tbas4HKd2nPVKX.fAuCK5QzongXWK18.4DMcFQweeN
 iaHnIFNreenideXtw73z_pTkgvQKZSDk1dF64TGqOFgKHK94DQc75R9nHxfaEhMfCojAFBg4.F6G
 _hmeO3KZqTjEDUnW38EFqPAsTEMKbzJpoaiIX6oLZe8pfuu5t8p6wvDk9J3mMOQN0LVA1lHIwDNv
 nPBcTMfPy3aMtGRwsLrCu4Vp_tSoufEfpVfJ.yATNp8lbDSyqWwwC3h5_DP50SZNFh03j3_LCqmL
 j0fwaFLye79GHatX1JsVhE9ii2vbh5sheaUfbasMLeypeeVXVdmLWJHfYQY8PCBCv672doHJe9Af
 Z59XQA3VsIgVFIsHDEr9ct_3G.Gs4.L1Y.bq4oFfFbR0x2udOsaQA1Vg.8JlCOiIaAlcIDjrln8E
 hxdm6NXhuTy2d1TXnrnhv.ECOgWobUWWeyBlZzpY9QeyBmFGrWYyNe9a6m46iVlcNAMZ8486hMvh
 Qo.0VT3ugFHr7wcRjdA990CnA.Pas3kSSe.9wv5ZKX7os9sfYBNOERtz6xv9rrt1LFqa8JUwDLVb
 9rdYIhN0A5j8fUbET_cQj.oFJMCxIJ0ZFoXwSHyo6CGD4gY_SZP20kOchqe7A__nntPYSiNIDEsp
 YD0qPFENrI_amlrE9msMbfY0knyqsqUgjdEqENxzQ76feQSO33bnHu1_KnmQ9U8MHtfkbU3tRGnP
 qqU_nDKH4yBIaKCdLhnMLdZ6mPsRUbcE.ZOtp4KwuzxHCOPQVWCDOBtbmkWBOVvCQAlGcV3r0aE2
 R_Dpw6gnan8d87jcUQ7wy.9R9OQhnqaHho0.ZokpgLMLiazjFvVkM5BW1xvge.oEqAjQ2WkLQBcE
 8k_THiF_SJ2tqhOUmHmnGPJZcdeBnQXj.XRmWqQ05J_.Qc846lGnx9F1b0Qf..X5H5G3dUoytpl3
 3S1ghCAPyZn4uKBw7VEoJj4UYfmyAEZlzFrArv3wzgAqiHnomZxHdnlhM0GsU8fPE_MJ.gCYHHxn
 vWKNA42zyupM8WAtB43RgTWljQTKIH4PKtGbb3BcxUPGNK_xw0jgOlZc3NzBprvQWoXwh1YYvE5N
 p3d77ItxfjRfkbVSB.PNi1OdUo9SDySPvS1ki_IklPb4csM69JF6OnsCeeriv8rU9FjdBxl0d_4z
 V7vdRLmxpKiTB3TYUjglqHIai7VJudYGvm.r1uwSveze_fnJNKoLsuwWObzmcxxB1otFdhPukslm
 3LKTOJGD0MkEtvuIU_i5o2rt7y1l8X9biF2QoNc3cdFpDq2qEoKLjjDxAY2_JRrjemxZbySnFTSk
 _5ian3HIos.G2dWMSDC9CzEbts7keOY9irftANliOA.OtUdj2oPmQPh90
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Sep 2021 22:51:00 +0000
Received: by kubenode507.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 31bf212b9f7aab4595d5b770d9482fa7;
          Mon, 13 Sep 2021 22:50:57 +0000 (UTC)
To:     Jiang Wang <jiang.wang@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Regression in unix stream sockets with the Smack LSM
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a507efa7-066b-decf-8605-89cdb0ac1951@schaufler-ca.com>
Date:   Mon, 13 Sep 2021 15:50:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <a507efa7-066b-decf-8605-89cdb0ac1951.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 77462de14a43f4d98dbd8de0f5743a4e02450b1d=20

	af_unix: Add read_sock for stream socket types

introduced a regression in UDS socket connections for the Smack LSM.
I have not tracked done the details of why the change broke the code,
but this is where bisecting the kernel indicates the problem lies, and
I have verified that reverting this change repairs the problem.

You can verify the problem with the Smack test suite:

	https://github.com/smack-team/smack-testsuite.git

The failing test is tests/uds-access.sh.

I have not looked to see if there's a similar problem with SELinux.
There may be, but if there isn't it doesn't matter, there's still a
bug.

Thank you.


