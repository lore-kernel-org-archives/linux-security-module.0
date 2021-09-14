Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEFC433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 00:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B100760F35
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhINASU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 20:18:20 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39327
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235818AbhINAST (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 20:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631578623; bh=ntjT0rcK1OmnRZ8ta15Sfc04v6zcyhqyHorTN6THSNc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=llehXd3euQAkNFHF29pjB1J3jABj8P9pgEDI0fzWdiPbWRzYPrppiWU2Trny5VuoWhQLQxtLMc0vVAKXFV3BOWfVpMK4PhXOCfll6k4QOqiVjTOEmJVJRzPdkrnlIdar+yXCwis2DAjzrBl3IqHHmC9Pkn4brYQ9fPZnruuXuNO1Jho4Yevu94ygwmY50x/e6ySiPGdFajBjI9exoZBHBiD8vd/1U59+6tCzB+gXgwRra/PrNpqmMoWj3pN+5P2jvxWOHzeDm0CMHcvIOkdmv5mBkYK0Zr6bw4giYKvWDWv12qSkdjBmtw1YOf0KlmrV64iCz7h7MiRiIzEYiNRKpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631578623; bh=hKtMDTuENotN/iosBlromYKl4uNO6mLK6InLs/lzkWl=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=oVqsU62nmGEQFOsFyPvgiBPBTcFguZQFoSaqkvn+jsuuz3ZWkgwrUXvWpF+jBsLMqoInk0Vp0fd6RPqlN3/uUTIigAjjaeRNyNKP/9rqNZNDUC8B/NDp7lOjSeYCyBVMB4ssiSUe3iusPM9vUqoyTbM/hwXRvAJTyariJDm4gj/WLSeMod5x4UaUmsGrbJhgj8bQ6y2XRUNHREWnhqWotHuOWCEP+t3vFKVPvJyAK+vtJrX8LJtlFAJKbQVp44Uz4acglRnNn4Ujc8OpWMsWjTvDa2P1vyJK3LewgPhDR9LKcx0+qin2Qh4RvIKO9NCMeLulonj/5Zi+KDW3Gam2Yw==
X-YMail-OSG: qW3xPLQVM1m2c1H81xahWx3qlSZu8F_Lr_Cl73rCDyNDum_TLDwSpW7z.sp3SyN
 mltje3Tok4StWvPhWZweyUcML_lhypm33YfNfZEnrkjN8MQyc0UA3yhZFxJjtg0Ic2icWjRPNjlX
 jM9ZEjfeY0M8IMEL1NJTQm1DAsDr615VcueO86q4RN2aaD9gvut_k7PWpkhavrfGKdVML6r4smYb
 mWOX6q8Pn5oEmZuWJPg70GzoHrdJve14Vw3ff1c3xOkcvCY9viEu3GwCPCElnbqsE_FCrue.BBJP
 9ggh6T7SAMaHoiQpaz.H2YLIJ_Yj.xynbeGnOCP9IBTbFKv1u4ZMd2g4W3MIHXfLSsnDslLCpC2p
 tORn7Q3FGuTx4iya_FnurvitGGBUVw4NSE85QW4iNwGSKs1gMT9GEJbgidxwlMK2ArBViveR4E4o
 D6nF9yuF9riMRMjTAIV8miLc5gytFQAQXeHB6LdpmPQR2b.n4OuLTgnV45xioVD5P4ekOkOSX3LD
 BoiHlU0mX06PQV9sROLHJcs0UgAr2epjaG.M6Wfk8lWPOaUH9NRT983Qtm7bee5rvcHqx3tUysJF
 vWMLhj8Ykkv.rzpLEuvTEiFZcyE_zsI53d1svD_bp2rNZPfnU78lnUmeTxgoOpFLjNeWx_qTJSvG
 BQm6tBm7aeqWAWOtDPCgNs1bs8y.mXmnkjL45tkpnYGxp6M9VH5qzzQzVHMe2O1uHc9nkecfUIsg
 q9g360l3GYfxlbwDbqYw9F9veROXatuk0_vcHbBP2QQIy4IsRHluH1NG5Uj9yUX0Ouu0k_mVq091
 ewqUoehVqcnuvm0fDVNX5n3LDAMj3cVRq0XtsqKcUTjGs5nOFBjDN2lq0P.U46d7nVfXQMO5ylvQ
 dlQ0FMfsFuDs4cJz4j_OhpzudwGQd17O37xzmFE5VDiLQZXVFzdlm7qJiJ.BxtC_7JFkHgI8ennq
 cNi_k57MkII3DYQHmpf51SvrVvPT5rSUCUrPOH3oGSg5tp1.zER8tQBtAv4MfdOzDdIjaFt9PU_F
 hWzEUFeCZDuDnh7r88si4zww4K6cy30J79J2xYvNxjBAWSNXBpVQQl2uqRbnyKinCxs_VDsgSRRC
 _XgvPtSZUxVeXvp0DGJH3RoUuE7iSEwd9hyr62k2d15HOYIBQ1L5LswrR2ATpBMieQLWPB4aLznK
 tm_YwNKBRZQ95N6NUKoSaFkHxphB79_BePaVIe.MZJoSEbUqRpPtiftZ8QYw76iV2xQYH5JsF5qs
 GGmq9h731_V.clodYOAyRM1YctNiFzdtUq5sMeXbLWH4ACDPishrrDDdeZcnBkRYGyPFbGqgq_Ci
 l4dA4Cz0nOR_G0aqt5B8mcHbMDJsynL0haQJNmARd07CF_SRnB4pYg8SoRrmqDbAkaildewQ5guf
 V6ZA24PaOym2MHzlK4GjzQBNhLVwweuKMhYHP6KERK.6bpKF4RWf7pwawfu98Y8bjNHz0dSCTLiT
 nf.2ycsfn.Im7teTv2bfZ2zBEQG0HtzofVsIzI1snqIyeY_CDKz6T8KsaVRGYD6A_b0n61PbASci
 utwqY.6l4JRm.puGzPr8rJ6fuhZDn.mfPy7JxZdQuZ8aZg4aiChkNmmMtecUj0UrtI5jrDI3r3Oj
 Mu89MFME.1tgt00Oz3Zyh4NL1_uZg7Srs4Vd9sqahOqEyd9Hjj.B15O0O68cDjlL7QAC51WulNed
 j7KA8zG8MNZ5xvjx9lUyJY56wRgMgGQa_BxDh.CvOTVG8wev8dYahF_c.zVhaaOpSwqpsLIFlCUp
 BRdmLejV2A14XtSfvjctqqQpNO8JudrE1vZlGwvh.2yDotdt413rzw7bZ672K8iSIE5npvRmmFMB
 C.hnd0EujWK.Yy6VUpIEvlRvQuUo6Oo0n8kX7kac7jl1OJ2aJRN5haCwrGmQVLrz7RP.rLBDo.u7
 8KAiTU1KIOClnQIsdCESwIvyFVPbHpNy3KGT40983yIuUq6lVaVARu6dunzEh1Gpfk0WPwMMxHCC
 0cwk293FW7m7_Rq5ASBE_DjIpJCBm9NF9nToZxSZ3ZbsArb250sGhAmmAw_JX44PJ4TESkmrCf9S
 IhFLe7CbYtTZ3.e409JlFVEDa.ctpMOWUHGuFzT15dCzgrFkxaStATq07q8MRsaPtytNCi1xYtpz
 0iqiLR_2DX_5JnqbhpmA7oH7Y1TQOVZ7DzqsSM86x5s0wFrEUpgzyDwex8beWPqBvyFeX5aYqjR9
 BhbrfkhOpqrYKUVBiujQ0S9LX1UDLjKEPw_X2HMWGauVrmG9cYRPbFGpEJyh0THGb.Kf2jaS5MaB
 BtBKVYo5QZ.whup9UEV5NtHzgtxVOhh0TgbYDlQCoKj3I0QUaNg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Sep 2021 00:17:03 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID dbd16c7549513381c3ce92384c0d1ee0;
          Tue, 14 Sep 2021 00:17:01 +0000 (UTC)
Subject: Re: Regression in unix stream sockets with the Smack LSM
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jiang Wang <jiang.wang@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <a507efa7-066b-decf-8605-89cdb0ac1951.ref@schaufler-ca.com>
 <a507efa7-066b-decf-8605-89cdb0ac1951@schaufler-ca.com>
 <CAHC9VhR9SKX_-SAmtcCj+vuUvcdq-SWzKs86BKMjBcC8GhJ1gg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b5f2cc8-4a3e-8e33-9161-4a68a61e9ad7@schaufler-ca.com>
Date:   Mon, 13 Sep 2021 17:16:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR9SKX_-SAmtcCj+vuUvcdq-SWzKs86BKMjBcC8GhJ1gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/13/2021 4:47 PM, Paul Moore wrote:
> On Mon, Sep 13, 2021 at 6:53 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> Commit 77462de14a43f4d98dbd8de0f5743a4e02450b1d
>>
>>         af_unix: Add read_sock for stream socket types
>>
>> introduced a regression in UDS socket connections for the Smack LSM.
>> I have not tracked done the details of why the change broke the code,
>> but this is where bisecting the kernel indicates the problem lies, and=

>> I have verified that reverting this change repairs the problem.
>>
>> You can verify the problem with the Smack test suite:
>>
>>         https://github.com/smack-team/smack-testsuite.git
>>
>> The failing test is tests/uds-access.sh.
>>
>> I have not looked to see if there's a similar problem with SELinux.
>> There may be, but if there isn't it doesn't matter, there's still a
>> bug.
> FWIW, the selinux-testsuite tests ran clean today with v5.15-rc1 (it
> looks like this code is only in v5.15) but as Casey said, a regression
> is a regression.
>
> Casey, what actually fails on the Smack system with this commit?

It's a simple
	"socat - UNIX-LISTEN:path"
	"socat - UNIX-CONNECT:path"

In one case the processes have the same Smack label,
and that usually succeeds. I'm trying to track down exactly when
it doesn't. The case where the processes have different Smack labels
but a rule allows them mutual write access always fails. I *think*
that's because the underlying UDS code is now requiring read access it
didn't used to. I'm trying to track that down, too.=20


