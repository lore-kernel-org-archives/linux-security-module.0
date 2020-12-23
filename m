Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B48C433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F66C206E5
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Dec 2020 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgLWAoS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:44:18 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:43450
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbgLWAoS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Dec 2020 19:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608684212; bh=N68+AYAdVrOEguPtAI62OQ6I1lQV7E57rwyr7F+n4Y8=; h=To:Cc:From:Subject:Date:References:From:Subject; b=cdyn77FlL9GrrPCS2aBin2lMj0zHi5XSo9VcNJhCReIDkAn1ca8XLI3DU+Di9a4+BiLzTRpNdP+dcljzDNVQQIhct+WUtNZuPo7Vx9miYQ1Vw4SFpNeVZDIKuZjnY0EwPXRWKIxMlEYJuZ//BEeHpWTtHgGaFBdf2QHZrJ+c66gNnRyYvKYZrOxAkbORjHl69a8Ic6BcG4+KJ6/N4fk/DacucdXF2XhL9KxQqdn1/grfTVWxVTeFcV/PeuP0o0hm5k/QChOLXl/xlfzmBnv3HP4eEL0A64l4VDSXVa1ygb1ableb2yoCczxNswBdNhYYHCKtUwfXmSGLh3BHQHO5JQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608684212; bh=JcMSfnphoNswQsAaDPMCfPLdzRrW/H+LLWn32+Co/7i=; h=To:From:Subject:Date:From:Subject; b=muKME7YRT/VsGZRV05Prbc9/tL0b5Vt0/Q32SXg25QbppsMK5bxZ4EuXBr2nq19EvGLc1IcewwvRh+/20OuoimJSeqV7yMadkyXsstorweS7bjcq2Oxs4yDWfQ9nAYH/zpKpPcLKjzgIN44FDf57R0gBWYg4c9mE51sOu7UrGQ2CaTC8u8xGu2w6tavIgDATcz6OFZ0V96oQM+/X/CvhEvDE+QTz7xYcvDSH4gVszBw487Xr8XZncZqt7xrtzHD3DD5UIl2UJsUkSD8P72II1XUt0T/9TFA+rddblvPTICs1kOH/Pd0RMSZsBzv5L815HZGlZBfT2u9lpYaqcTeCEw==
X-YMail-OSG: 3PvlXKEVM1n.GmGDoQNJK5jkQ54k5okhgatBb_FmIXBQXR0Fc0QSVO30KJ3EbZb
 tqd15AllONnohYXM498nvGH3KWZ5UZXozTFS5icz4mRWGfG.0SuXs61R4jNZMpi9Z7tIFiRMJSN0
 DloXzbi.9jsD_3QGf2.k2iycNL14a03Zxi0CjJ3y9788so1uB8DZ.AsWYHb.K9JI1TPML6MfLdd0
 4xgK9j9RhcnGD5hsmLmhNtffXB3hx7nlnNRRFSbf0R8OiA5sbUCSGfCt5ZYbEVzB2A.84Qnyx32N
 Y40q_XniKyZRJwFVngGxCxzsIhV9_cfe7D0RWx24bRHqidex6SLsrm3ZWsEJqhFAM0o3i9EroSJs
 KUh4kb3BFw_9KCtp6a8GcRYpyYOru7_eioT5PE0ejBVg6p4zEuoRRuZa5Mzeqo3SHtVB4cZwKVtN
 4UFZjCQaXBS1SXKgM0NZbzG594VB0FZ0Q0cGi9DlGOGuESlwtIlNE6HpZcB1xujaLWlLWcg9bjsh
 8rdKSnGTZ267AyoiYEXHoR5yaf5LodIHMNlbCRVFg4PG84aUZjg3hpV9lAcVImiU_JBsxccEsPR_
 hbSmU0gyT3dPyVAUydAja78_uv4P97FITEtjeiqrs9V3b.b8NrZ34dK4okYAz66VRXlzyV.p9zmw
 tCgofBGpaVx3TTKg60Ny7yr8jpjwR5jQt2.HtmeiptiyK7DIdy7uajRcE3ScKhoNRzpoRfnd83Qd
 bXq1XMo4d83N8cbuKWgno03yUtZRbdsQefo4zmcO40h592zyFlLg9DjD.D_.G_A5u7YGNZj5uum6
 TbyKk8iVNc.0NncWJTT0MkR4CzrNTFtwHUhRfTSfXm1BTo5gufFL2QQfBN6pdAXCaQowLwjSbJSj
 LTJDvLI3K2dOm1ZzUrvA5T4U6C29iJerlYEY8OznlVkOWudTiE6aYvxUgwveCZMk1M2oBscvS7Wj
 yj_qo5jN4PvTpIAaU9jzYO0tShQeTxVNF19KKmTLT.3.zVgKbazqKvuLOF.nByVuWC0bYH4w9UUN
 6frfXFlfa9e5Gk36SAcZccNcyrjCELPsClHc78zC8EX1JsDqitYNSScEkjr6p6yVAF3u7tSmadMB
 H74BNRkLnWepmxgyCdwYErI_SYU4fnWGWBb5JY5Te84PH4lxlHRIxcqlM7sb5BxFWNDkHQLZFhZO
 iSm6lDs4._FEg_mXb3235JcmP3Q145grz7FOPk5pqy5aKBc1jN4GII2_xVmkuQtC8udIrn8Bf27M
 moe40QpX1GUadaMA74.Aq4ETEnjmQ2vh9t2dpSa2AV0bDmRovE2A9qPp_34AlhBkJZDReB9krBmr
 GcnFwKw3FkfEUAV7cYxRE_MkQ9YaVNH4CB7MRMXz7a6PuDaHvRwWVxtJkOxkf3EVG2oDa4_SpJHQ
 l75xZvxE_NRduVBzzLiuNfFMXy0Magbjci.VPmiEt8gNyqEojiW3DF.u20qzz2hi2GGCJ94jA50f
 yRz2BDbeeos8RITQRKhE0hl3mPP1uW2Mr.lQLc6L0tdnViWyS2MO1WGAxho8OBEFtajx1FAThsC9
 tIwbtQ1EtRBA_QGoQAgsZ8eqcj5GB1YVk6apeYWKxXSYKLLgeac1lCdmoSllkn1BgqoDFNnILkt.
 6yLhtl5J9Uv_MB2_k289NWSt71znJmVbCZfqHbrnpj4SW35lJkeyCyXm6Ixe.L6VhF_1U0KJXfK_
 vtR3oz34n81VIdLWBEQu5T9tnu3MEA_qY2lEqI7CzkXgO401XtydXh20XuAVUeGowNJI61O8kBQg
 toqp1ogJjzCqiI6molmqb.AM2orw8MJxSla_4A_Lk4QTLCpS06rw_P03XExj34hADJZB_avud2j1
 _VoSMcjcM_1Es063Rn.OqO3SadnDL5k_PmY7Y6jVxRvDOynqSyyYBzU0O9JugiyKkJExSOYVU6nZ
 RPo.AmDBIqTwCzLJeKSztDofhnQGf25YLiEP5To8aGKBfnMk2z9ZfP9Oo1cAxykG5n7YKfoOm4eq
 krIZNgrx7IFXpVkEWOhg5aZ2UhNzzLhtnZ8720N3B8nWDMz0.a0FM8XdF_EHpz4KI9eI2_Z8IYqy
 ZojNMLQpslYkUOit39mbOfLwqLgL4eShKl2qMm86GKzaJ.z0Nro1JwtV60hv1AcmO63tXsp1NWUi
 9L64giYbUeQd5MiDf_Hx0ILfEUFkNgGcR1rPKJ9DIOoa202VSPFXm3Pcc5ul8UqNdtGTMJkEv8bc
 Wq0WZcZE5SyZZ3p93W56XgXC6qhzYYfcW0Uhneo7OBY3RoxnIn9vr39B000XG1vqjI0YCUjcDsGb
 cvqgue5IussfAH9zuRZ8cwDqhVxvvpWOzEuFTbomp2HDky6ORH_Si1HBEvLS26WG67HPtC48K8P3
 gGrkVixZnrIM7nAKgA5PTI_A.FmmHoyaHDifxPWkr5XhOwYfa4Tm4vKoYY55sULM_NrvJO2LxDFG
 U7AcItbU2x2kcp3Dj2qp7.9Jln4_YWsIz_dncjw8xqkb9qqvnhOLOrWBfqnRhxfLPd.A7DWG8ZS0
 y0XuaFYBgzX1J2dHM9a.mdtfbi9pc2Lkj5Bet3IU.GeuPi65DJCMJf8wblrWuSMfAhTO9MC42sRb
 9LCUR2ooEIpqzSWshpm.3s._Z0JcbcN3vCIR1Oxt.aibtgUNFE_pVpMXTAthkow.Wt7OBEqswrZN
 HB34.lgL9N5fXTJHs5cC_GTgipFF5tYIrlwOdDr8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Dec 2020 00:43:32 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3bdd598f8bc27446db9757c9c3c1be42;
          Wed, 23 Dec 2020 00:43:26 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack additional patch for v5.11
Message-ID: <b73e7af1-25d3-1e68-c810-3858abc489d7@schaufler-ca.com>
Date:   Tue, 22 Dec 2020 16:43:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <b73e7af1-25d3-1e68-c810-3858abc489d7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

Sorry for the 2nd pull request, but this is a fairly important fix
for the privilege handling of smackfs in the face of io_uring. The
novel use of kernel threads in io_uring invalidated an long standing
assumption regarding the privilege of kernel threads. The fix is
simple and safe. It was provided by Jens Axboe <axboe@kernel.dk>
and has been tested.

--
The following changes since commit 9b0072e2b2b588ad75c94f2c6e6c52c8f4bd26=
57:

  security/smack: remove unused varible 'rc' (2020-11-16 17:26:31 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next smack-for-5.11

for you to fetch changes up to 942cb357ae7d9249088e3687ee6a00ed2745a0c7:

  Smack: Handle io_uring kernel thread privileges (2020-12-22 15:34:24 -0=
800)

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Handle io_uring kernel thread privileges

 security/smack/smack_access.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


