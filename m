Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25297C56202
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD6B20791
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lac253Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgKLBdt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:49 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:45790
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbgKKX5U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 18:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605139039; bh=gbDRRLj3nC+66Gz+0gdW214wwNJkkNR+I4HxPH7eHqE=; h=To:Cc:From:Subject:Date:References:From:Subject; b=Lac253Ha5BRRVMK3K1EtMwfxGg/cgpLfIgMsgmaauEOYxoPhthPA39/b9rIqaLYp99KcdbNF0P/+D8TruGEnKeIEk0d/uvbmrO56T1XjCQJQwHTL/aiPERaI0NsDUTrzh1RwtcKs6eLBTYZVxNbYkHz9SNwchNTlwiSS7wGZAjG8kSi9yQshdlzsnhGbrEWbf+5QDaBS/ZzsFt9PnPrlDpw48gEBjqnZufrmDccK36D3RAI60+qB0bPb04Eyq+7nL0Utv8G2YQ3lP4uJYmiZZ3xkQyReMGKv47NtTsP4yFD3To5/V1HWgaO+2LfOLEIh+pkf2MiukdtIPC9PDlbP2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605139039; bh=94gNheKyuIADfvskxTyHdcrSbOiRDjycTA+547YC5Jm=; h=To:From:Subject:Date:From:Subject; b=fTyFKPIKBsLb153U0rTYFCt/EzwKcxVzEwgnmIwFPvtFco+EkeyhLbjJiyOCQ9uXgdjEHVR7fEM5Pr+VAJWnQhOVYMNd7hfdVNl81m2G3uwb/oWYT1Zh1V5qkmylzsIMMHdZ91JbSQQmWAk89UDSBh2mKiVoDQhn+GJqOUMZJOj3uuZlOi8dcG4BNIRSAysdgXOifSD/UYR2AjGBm/2suvEBoSROsaF+ihA8C6sqnjx96HDfVtmZF0UTFNwYJbAmOqmIRvjd43nGq67pxX0IdZseWDOPGkTr4UcN0BRHcbK5awLCg13elt2HlLPl7y5V3P92OpYbKzwxXg22LNsqlg==
X-YMail-OSG: H8fUJRwVM1mJBcCnxbktDbhZMeC6X_4kOngMMLVsXLjQnIs2q9nan8wWD74DyP9
 PbT9fW.TnVJLW1Ulq38wCM_Tl4F4OILSlT2NwVF6BTeQXNTCp6sCuvsWbnHxhB6tVbdVIcH5_PK_
 HKjU7KRaDxTJRM5EThleaY8nS5n5ENrIkaaCACvlPf.4_VrxKFpyeQa84ot2Tr0lkNw8DRMqQPt9
 O5Xfa.NrWPkJrsAlnhjR83979nAf9WoE_Iu3HMVRcZOKa_p.wPkvlMW.w5xGZAlfLXvSJkuBANvz
 MCxjnDYOQOT.AJ30qFgnbkqDL8QHk4vvB6q_paD3WULlcN2Sa_LeSZ0wiE9u1ooVdcRctSg1.jmz
 fA97PiqVfVMAQDEkWLnrH.sRhNBP6LulqHaIUvgzsStS.MbWuovL.dGO0LPCuSroEMKsyHVI33MP
 RTL4lQPhw_UMfuMDvxHNiUwzMFcI43pOSmLQ6MiSnP3vCS2jJQWXOPmtGEsyBu1NPIb2KIKjCZE2
 Zmxe.iGzIp_fqarE8Si_uwpohiQrXKS4qC5_NC4PwNFcnTpcQoi7SZOa0EPwiMul7bR0RerzzMIV
 BjSAxCmBdwNVbO11A00aZnFwV1Vnyv1EgDbx4xCxK1QMC02Y9xXfktienHq3J.xUulZMLTwUW05S
 g_5pftKdM21eXU4uBHBnqIPPMfAHWrutipqZ6gp2pC3oxNV9v61uBSK8jVuw55E2U6JTGJDwaMWS
 .9q8RdfXHtrI8sgGbmDkqZbtQOaWgz4UQj5ZnhCPS9K63ShIL_Ng4QBTjm3qmW9Ydn66JxkgecI1
 DiJkGvrox2pLTbgKPkYn9z06mBJWToY8LKM2W9Kd97YHtZahzLBn.Fukpt2HIa4..r_O1Ejeacux
 Qc92E0Uct4wmfgOkPP1gYEpaMik8N7E8JXXfHzdrlS1zy1bVP.Vjd12DNnIJxzznzkKo6heKAXaH
 4qUwe1dlNZQ5QXORBkPpcKIEFCDoaHzsDPykQ.PFnNNJ_2kzpNm8qvKGFzF_0Qom.bhXEnTyog.4
 0MYtwvbTdGyfVF648MYQ5ZX.kIeqKt4xTXXqjerEZ2HKxa6MUl_wMliPnCafz7YS5hKy8ySKWajr
 pENZLK5FAltQhJYQAoUKsWhb7KvIZV32vy4zkTc3t3kct3DcT7Zq44g.UVvDZrEXIhVQ0RZoZFa8
 .e0oHwbzuZ1yyCVxbNxm9rjeyr2iNNbYPCokH8q_pm7RIl.MXeR.2s8hnN6Tr.TXw9_ltmsZo9S_
 Xu3l4ANS9QY71W5Er7n.0IkeL9MLrOw6_FdmcXqv.J7dYbvsG6z4zso0NKUYdE4_bT_gzGBrILj6
 y8EQ3sGl935RRq.aHbfLtKYywTRBWvic0yLjrQ.p7Mm4wlg2h2qoMkPQsWVCVbkdtFOXibnJuHQI
 kZBeNnP1O1EcwTYjsLXQL5WDJ9SvzylT09wZOwN_nS5HTbxiWpy7o1VWzRJkStJ9KOuv4vNZCwLM
 4ZV.qNph8KNlVUGS8gvQTp.hf1x_o6WobhUYgXI3naTBbQ161g5yNme5H2KOYmtlSn0dcEogAU_v
 kalJvEqkPrIhWx0B3eqV_4p5lBKjlSQa3x6UG1fjOlUH5NTVVL8NA3Xln4v7vCCCVEL9YEYJQ29r
 sU0Y8yEIyjj_O3.2eyaS7VO5FuVA13oxtXloZcCOfOAcHlVaeQzfPN08930vd2kNYrkJHtmBcfdx
 HScy15rHyJd56FIWOQJu5oKoqcdgdsBU0e3KdnO_2su0n5lcKbIBXOtP6xyq0Wb5cvrw4BxQ0M0W
 K1kuHa7uR0htcuXqUeqTerv_GIg53cwtx9m5YP8TqUL5DDiS7hJM4WCr97dhRUwEYlb6jobd5heB
 hYvTJg5NNBCHruSSpA.DYi3RXmWGF_3.LT7kX31iaIJTk3EAp16MISL8l0wiMxUcuo.ieKLjdGmF
 6vw9GI8DXyN5lOgKnwgSHF49XkUiR6MKwHbtzGvuIT1RtWTK1xgNlwlzYZeHm85p_C5TL3R8.v2u
 pdOGjerjgz2KN.9RLBR1.pr4V63fqNufyhEntO08ReJrxCBwDQoQR0KTzQ9uMkBIh2FUrY4Kjvi9
 cBikjCUwtSsoftifR.c1Jow7hK.WLmqITr4J1sa17cGRT78edudNM2YOOxpYZmdEUm1Cp._P2CRA
 s65o_SbiMgov4r2LlwsFLUHmk.BOzlXqWTqc3p6lNGy7gzADBs5OT2zlrO2wWgf2bZsKJOxAvK67
 dcYXzkRIHI3ka7TyYEeHh6pqUtObZ9AZhBywLZVdfuK7CUKoAFufV5ReuAEsC0SFyLmhbPg8WP7Z
 u42XgwI5LBDldXkPhoJeOVLiHjdBUu8dyLoZJRHomHU0hZFSse3EKiQ0z1bbOg0fneGAB.HuLHg1
 _R7wlsambfVRL3KLtltEyllB9AXcmUWCIZfKOzu5W3RN.RoliRthmuumBI6bKRhDpcCKdWg66N0e
 DeY_QYyVsVRQaSqMdf368aQ5BUFQ6yyKSvP5hqTJH0yyhpuuSabBK_XuB1BcjaTaukZvnH.9WQCc
 CeyTEeEpbMnZtnH2TnGn02Tz9MqCrC9e.kxL5_8.uwQnGNmErI0VtQ3ANVCJZI8hyPCtc78cNxzD
 tj878Lmgx0GzAgyRtUMMgoCSeIZxrMZ1.ixocuJ5.aeoqcSjVjb1hBSVtHOzgh335RrJfsTdCzrx
 c723DI1HlJVT9MvOiNutg_WNtSTnUGrZpOy5I2qCl49bqdSIU4B7lI22mdFXVCc8PICV4rH3HoJj
 8Ns4X2inmkA0Z7wisp3gTn1NwQhpl9BQ._qoWnnlJb5FNfB0igHzQRWWWKNS1asj_Gd22JPiiz9L
 lIM8s52seslHycw6xokKPkCYIk3rC3t8FHvVUHv98DenoKQSUM8DKC.gtgSR.tTIS6UJF1JNhgXp
 qn1KAs0f4tNq0HI3C8mSqH.w0t0z66bAVwwTL3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Nov 2020 23:57:19 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID edb9b4c4f175c87ac7707af56e977ef8;
          Wed, 11 Nov 2020 23:57:17 +0000 (UTC)
To:     "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        smack-announce@lists.01.org
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Smack kernel test suite
Message-ID: <471fb2bc-646d-a7a9-6fd2-3e4fba2a6b8a@schaufler-ca.com>
Date:   Wed, 11 Nov 2020 15:57:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <471fb2bc-646d-a7a9-6fd2-3e4fba2a6b8a.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It is long overdue, but I have finally created a Smack kernel test suite.=

The test suite includes about 100 simple tests. You can find it on github=
:

	https://github.com/smack-team/smack-testsuite.git



