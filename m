Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB2C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0617321744
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 17:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ata+1fw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHDRtQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:49:16 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:42289
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728597AbgHDRtP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 13:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596563354; bh=9CN9OOEMnPfpZeDCm4a2IWZdvQhL+vpZWFnAuWsKyjM=; h=To:Cc:From:Subject:Date:References:From:Subject; b=Ata+1fw+ljE+JqoL14DRxyaBOV95k+KaphQNOvu47RiSGU4nZHeY1L2OFQM6GiLGBBNZH742UaSsWcaHhK5j+6v75f0ktLibLDWMNGByj+ZO5zfWMkS+2ME3oJZiE7yRsv9IoX/yTgu1VYaJ6r2jLgWYBNxHAEgSmKD+eFQNyqyu4uGwZRP7zZWV3V4Lk+KbzQlwPZiviTu9eEESHlRy3yAa8Ek4+AviIP+ipOwVsaVTmVIS6uL4h7/s8EwuNYccDHVgohK9ssQjgVRKbuTly/6HViS3PgcK4O12zrTfRb0LjQbo6QRHm1Yv2h8Bh0rDKanNqhtaU0N5zlP97qcE0A==
X-YMail-OSG: TZ1u4LQVM1maeWRg0odaZljk2Y.gCDjZDl5ldg7rep5NrOFL_DFiC8jED8YcJ2l
 f1OJII7WnLopN6W48NqmJfA.e7cbbl7qHVWWmbuJcy6I7cfnqWBmPIs5k7WWmUQ2DccgNOsSRLt5
 wzr30rXbqbye_oYS5IRsXz4PEQED9WtstKJ2czECp0XkurJQZBb2uu2qVx3tw.FCzkkWnSlFuO10
 n89AoeSL4Uut.91ZaHlqTj.tie7Edm2nnHEr5A17Jzwe37qpSAZ4kxEXHp8xDupXcZPppZAAPbIq
 GgdBPo7X2UfuqV06HC4oKcYSdyJ7mZY_eLs5jj7.0eEZCQdSRqf5s.IaL95e_Q3FXS5OGw7vzBQi
 PbGZOGwxaPGEWpmA5OlcxJo8Wjpe9Ldq34b.9ALUbNVGQc6.7XaYrN0VknfXbQl5SelfdFQwLzt9
 zU7AAJ4Gpwg5dGG6QNy6ozd0OgdYY6WvcaeOlrVN_R_xdB72CuK7OpU1maSF3EpNXCs06o5QTY6h
 ik50VUFtHLXqC0mxW6cLuRE2OP7H9dr8yfVOwWNR4_HvW_N_HpKgflDkZ6XDQZxDT5fPwSYiPGtJ
 NnitxDXoMHlnBQtSTmIcwkl6nScVt1r5pjzm_6d0r34YOdlDmKNMQgMnpMEr5Py6A_AFQoBQhYRF
 I4pyVacAPkKtkUFwP.t.IDcd3j_uNQsgG.1SYzY4clR3K7ZgGv0n_vsHG0t_VcSTb01seGus5ful
 Hkk3aKY17w8w8hMhS66ECTE91oPQcxW0ib7HmRAIxjMeF4gcgMKVMZpJ_ypY_IHpwFmjesT8nGQJ
 25.u9fybSqk7W88UHAli21ALg52k1D1OsoDyJTCpCROCMHdsWaAlCF9OYOA3Ofjxd7tCuKsGYn8a
 R7LfePhUhYxdnuFBODI1BlHruRrzmEnieOKMONyj5Mwd2W4oV92pH2wpVFFncQPrFdJBJZ986wQx
 QZDKeubPGLfjl4tE71rblOAPI_ohzBRkjD43frp9NbBPOlKcUSAZyDWlyovUciwuXNURAjhHBjAK
 uvAtS_K.FCmlPdPufDXxuE8hGzTpqxtYs1m4xUsWEf1JLmO5qutRZGzoCJ_oz8BKJFXJcwaGp6kF
 JPMCq_KgEwSyZioXR._X6yuIQ_hWfgQX5lmI2EPYTUIamIRA_qtC9QnYC3mjZ3z0JgyHwdbDGv3d
 p2bPm_CPui.tkH_nNgXG4CxHAJqh21RCvOsz5q0Md4_5RUSxx44b3tY8CEXO.gl4T_60U2y9Nz0i
 9XMbsA4Sh5t2Iq28.w9SyoTRz6m2qAkSAONO4RX1n8ZsGhzZ.QgjS.fkMoUq9np4LFvMc4MesRRw
 vcJQV_xmUI6MjTbmea48LfhM6_BvyEHJVrjcd079VD8E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Aug 2020 17:49:14 +0000
Received: by smtp418.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4161dd1e2f88195a64a81452e29391ff;
          Tue, 04 Aug 2020 17:49:10 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.9
Message-ID: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
Date:   Tue, 4 Aug 2020 10:49:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16397 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

Here are three minor fixes to Smack for the v5.9 release.
All were found by automated checkers and have straight forward
resolution.

--
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next smack-for-5.9

for you to fetch changes up to 42a2df3e829f3c5562090391b33714b2e2e5ad4a:

  Smack: prevent underflow in smk_set_cipso() (2020-07-27 13:35:12 -0700)

----------------------------------------------------------------
Dan Carpenter (2):
      Smack: fix another vsscanf out of bounds
      Smack: prevent underflow in smk_set_cipso()

Eric Biggers (1):
      Smack: fix use-after-free in smk_write_relabel_self()

 security/smack/smackfs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

