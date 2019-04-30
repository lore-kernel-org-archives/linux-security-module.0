Return-Path: <SRS0=l2r+=TA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22037C43219
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC742080C
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hp1gxzUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3V3U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:29:20 -0400
Received: from sonic308-8.consmr.mail.bf2.yahoo.com ([74.6.130.47]:34071 "EHLO
        sonic308-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbfD3V3U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 17:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556659758; bh=N5gTb/la1xwUFzbT9jPdDhRg6XMgokkcoXr4TBJvQKE=; h=To:Cc:From:Subject:Date:From:Subject; b=Hp1gxzUwO/8l+AyaHeSy7biMPsMY91bx8Klpgp5KJK6cbaHTQ9AbCZc4nS7bh5SCNt7M22ADre5oVmZqGsu+RfqYkbMNEGWd+ulrqnWjlaAST86vp8Z5hFB0VoBkf6Xw85uviuZ90EvMKQSqEqjRKSvgXwc+/uwNCiXsbl9k0UEwNdZl1vZ0kWkxdvvDKvg072M7NQvWztvlmAW15QcvbE75YderNG4OxzHNFB2ahC6JOupIMaTOx2rxtkCeX4YcykC0y//YquF/jGKMucNidR9H5xKKjgt7OyyR/diiwmuSqm76kekAI01Thd/LfPA53siGdqrzU9aEw/Cw/MVpGQ==
X-YMail-OSG: _AYyzWQVM1l8sD.AcedcWcnhbW2Z1A2vwTwehYHGcXIZu5l22GPHBikNaWE6mn.
 uzHEEOOu_nysXyWxl5jonAg6.VLr5EBTPC34NlbmECwzs9XzUIP_iaa2byvhNR2OIosSieXp46vD
 W8jQ4xTA13rVJ18a.DYr.Qev6ffnsp0vhhwV6UnT5WNhTQGD2saCqf487Sw_LuaFEhGdfsILPQfQ
 NwVuxXKCJFSrO0aLUfBwdiG3cqjHLQNjm.Vb28yTYVlLlVr.dNbZsAlTTTO9OF2soPT5MFCpTjw7
 jlWIxUDa8SZz9HVIH0d2CQYcHF8eGYbe7Nh9_iyQKAGnuzqrU2XqHkPUTsf8Vz6fJ2WJbaDF48oz
 yImbLUF4TAZw3hCEraYa4MweBo.1mP9HYuiknfxHfOWZ3lE8Q6ybvxOmspQGBWLL7VZQyB0R5Q4y
 wKnIiIWJ5mXFMnEXEClb3gNulCbgoI_Z0HoP6yqQsdEiqMKhY95FQQ6SwM5f74oskEzg1Re51Uvo
 W1B0EwcUr3Hm_8AsnYZO833nyS9Faa3U9xv.t5wjJsNsw55Zl7t7mWuKDbLE89cl5I4VSxEYoTtp
 8xQEZBpFMC0DZvpVQldvPSYT1X3YlpuIfA4UZl8Fiou3gax5vxxre_6cYZgeySMa0sgZxTV8a5gM
 RbVhEN39llMm4_vC7NGGXoluO451H7Pdwe.pf.j8C9RxvDCl6fJibWSDMwvgG3bjRVSB0GuNHav8
 LjO.zkq35dusJaq6STGsw5FIAukLbu6pQ7fY5aGopLve4PhwNyEwUj0UhQSg1.FJoztrqAWqiZBj
 9XM0VdVLV3nPGOk8A9fbq0bQxEDmBMuQQiPEPtRME3Id.I4pVJd20DyyvklyS9.9d5T9k8eTo9zf
 BA8KsHwQHngAEh3BEfV3m7rkuR8lynJma25SD9EJ8sDw.0ItQ7Fqw4.rITdiUa7Pu7CTKyubce.j
 DaesC.11LKLcakjqs66uFhCxeUXcLyViEkqa8zSJccP_9SLDNHp4utUEzU_rD4L_S.aLb0TJxSLM
 DrzsHJ7xd26jvo0AzSVPn5wZ4zdbkFoIhCvb1dRPnWh9O8bNiBMJwCxGzRAh1fCGbIi6C4gTBP2v
 X4.Fpx95360kI4KLn4fz.DYXnU7129u_o.dJeqEEbo.32TZkmMq9GQFpR.pG.ek45ITFIywfm0la
 YeEssdtg7wno93ggHxXzYDJfQoW3lYsfpzV10KC_ulR5EQ64sOlIIa28fjJtTRVlkbdQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 30 Apr 2019 21:29:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ec1f171c48426cfdbd6956f8ab8748c8;
          Tue, 30 Apr 2019 21:29:13 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: Repair for 5.2 build issue.
Message-ID: <b1d1d0b8-51cb-657b-c8be-aa365a29c8a5@schaufler-ca.com>
Date:   Tue, 30 Apr 2019 14:29:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, please pull this repair for a build problem with the last change.

The following changes since commit b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:

   smack: Check address length before reading address family (2019-04-29 17:32:27 -0700)

are available in the git repository at:

   https://github.com/cschaufler/next-smack.git smack-for-5.2-b

for you to fetch changes up to 619ae03e922b65a1a5d4269ceae1e9e13a058d6b:

   Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)

----------------------------------------------------------------
Casey Schaufler (1):
       Smack: Fix kbuild reported build error

  security/smack/smack_lsm.c | 2 ++
  1 file changed, 2 insertions(+)

