Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1DC433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 20:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518D720663
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 20:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OASr99Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgFBUiM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:38:12 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44899
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgFBUiM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 16:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591130291; bh=mQY4OCm3vmvzw2Qm7eiu6mSNB7BZAZIaCpxKoVRi0Sc=; h=To:Cc:From:Subject:Date:References:From:Subject; b=OASr99AwiG4+skO/GzOuyy4J2BFpzaa+eKK+TrjpSwrXs8nNqT+9m8jC0/G3CE0AeQ7HWWziT6t0XeyyrepQuv1e3PUGuyBHfFHyB6WByj/T6qzBPM1q6NRdnfmh75GYXlOvJcXpHNl4j5/a9RfuQ55deb/CTvHXYBvQLvQRF13YfaXcl00r0FbyuNEGQL5vu4u4c2IYPhwLy603kyY/FsIulNj3f0J27qmSeILIfJI7n9aDVa8qdhryhYPNg5EZjL5vjNL/INvzAfwbd2by6PxCTiyia6qxmbmkpxoRm5gtQlf+nQq1dlWbYWOQFQ6cu5/S/Ao8EVEunmVbSGvrUg==
X-YMail-OSG: KRXqfWAVM1nEix8rFr0jAKVqWHzAp7lum7nB4Hm5Pg_4oX9_WC3bkNwuTpVJN4i
 OwAKZXnfnYo2KNA1gh2e_VVjAaNfYFHLZ0fgu9lfPfb_6kcYh.z9.biy6Ywj7yszkj9Vj4IdQJOM
 fD5Ac4GyuYLZD9vUYR4r1rwl.JYhNbnN5ZYx73yrwh8yupzEH_5TYuNBDzlasRuZ1oYLXsXmqcL6
 7eshQK9mez4zsY55_lbKFk9UnU8sfUS4kM4T2Ks_cCG3f4Ego2CGcoNpjFj9xQ6FrWELQvaO.UM_
 fhM2Ct.3mFI0cjx_GXlaberR0DB09GcVqb00aMFbHm6bT1IYRAZQQ.0TuVqvNtuwpV0o.iDQoxCA
 txhfKvtGkGzShgdXYTkELyTzTmUMU1b_J7eGCAYDSk3PE.E2q8cmCq4ZmPLnyqnhpvMuItGdUIpk
 vK8BWWg7bMopqS6.PdNtrI2sNVUCrR9UmXoJsG0OkJpMsbD7BIH2oZuO5C1udQMcd5WLpIJ9WOf.
 31nsPySMVbguJKpXxgcRBMammhUB9UuDW16XgiWX5kGrT9QX2YRLjb4DQDSMrSQMfp26YUAMrV67
 YMC_Elwj__K_KAX29n7HXyPdUBht5iC5uIo.Yzl.QM5uuX7VwqRITYUgmAKpSOVii.K38XE59L6d
 CKUxTVTib3QGEq8VVVGAAZQ7ttiO_Zk6U_rT69TqVdHwUnMYW0wbYB2e_dChmUOQ8Woek4v4lX2l
 hXsJkA8F.NvaoQAYiEpVQqCsbiYgh2cqg7sU.2EzPGY4EGtizCIPqtKr4td.ihNVg5zL8jMuGTkj
 W1qjQRtWm3Pf1WKJbHmXEj8UNsJNP9hLn3fiyOTQkNyz_rxCYcH9ZcuphqvHQDs2UwTKJxHSte5q
 rd_VF0.i9yPBsBAGdD7empPqXEFa_x9anb7o2fC.LBAhqQ0gPdMk1nb79.fLC81fEQecuX7taEVw
 lQTDZIbytTLwn50NSkAEZWcVZtxKN71_6BiASXm4BNe6IKoJrh7P1m.zYAJeKbRjg1.UgNOA7CXI
 JohpUpC0bQkC2roG5Yb2Ek08s6yVUSDMyhPluXG3pZ6f6E326w79l7a6lL1QEH8yKGKoP9wtInOq
 75dfgZXJG7xXbJ0v4O2X9tMHj5UnYXNkZNqDfU0Pj35gQkWFci4XgDPOLeH8ocyujSox2qSPNWhR
 nCF.arnQtL5564kdZn63420SdQnwgaHlwlMPRDt2Oa25T2IUAJgIvjE40reuG77PZDYr8ccUTiBt
 TEi6UYwqci5zSjceVQTs3vGAp2PcazfW3.8TGuU5h3rtmjYqG11Fd4kG_HmmVYl3q3dnKoSUlALX
 E0ZzRdxq.eXqHThVtin9jBNi9xVEI4jvAqzH4wEBlvT8N19R4RKC.O0W_.I9l9XbGXF85zpFKNm0
 Tjuay0xkWGpQWK5gb9V5BQMaq5d89.oAIBy9idau5F.sc7Ps-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 2 Jun 2020 20:38:11 +0000
Received: by smtp432.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ffdd36828ea577c9400808e15e73e36d;
          Tue, 02 Jun 2020 20:38:05 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maninder Singh <maninder1.s@samsung.com>,
        YueHaibing <yuehaibing@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Subject: [GIT PULL] Smack patches for v5.8
Message-ID: <02d3f22f-340b-d51b-6dd5-c2011651a145@schaufler-ca.com>
Date:   Tue, 2 Jun 2020 13:38:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <02d3f22f-340b-d51b-6dd5-c2011651a145.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please pull these changes for the Smack LSM. There is a fix for a potenti=
al
buffer overflow in smackfs, a fix for an unused variable warning when IPv=
6
is not configured, removal of a pointless lock in the d_instantiate hook =
and
some dead code cleanup. All tests pass, and all changes have been in next=
 for
a while.

The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b=
48:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.8

for you to fetch changes up to ef26650a201fbbb4ba90b63a82bf7950f2699a82:

  Smack: Remove unused inline function smk_ad_setfield_u_fs_path_mnt (202=
0-05-11 10:25:37 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      smack: avoid unused 'sip' variable warning

Casey Schaufler (3):
      Smack: slab-out-of-bounds in vsscanf
      Smack:- Remove mutex lock "smk_lock" from inode_smack
      Smack:- Remove redundant inode_smack cache

Maninder Singh (1):
      smack: remove redundant structure variable from header.

YueHaibing (1):
      Smack: Remove unused inline function smk_ad_setfield_u_fs_path_mnt

 security/smack/smack.h     | 12 ------------
 security/smack/smack_lsm.c | 42 +++++++++++-----------------------------=
--
 security/smack/smackfs.c   | 10 ++++++++++
 3 files changed, 21 insertions(+), 43 deletions(-)


