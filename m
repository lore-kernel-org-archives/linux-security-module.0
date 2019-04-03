Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C8C4360F
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345DE206DF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KE6YlQeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCWB3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:01:29 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:35700
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCWB3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 18:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554328888; bh=iDPL1qacOQ7ZYSjPKc5YNZMfvODfglArvAONb336GFo=; h=From:To:Subject:Date:From:Subject; b=KE6YlQeLjP0iioVeq2THdNCmG3gzXefCVNrpzCP4nBCXJaj8tP2YA2HL0ED6uqB/jK8dGih3G6Q/XHbNJRzeeYGv/OcIMk6GlYDG1OG6Lq0UaVZHKMNWHhyzQajjNQNjIjAGEiVow9xON0DC9Y/zVPNFxWoAanSS1JevWmFJwi7+ORPCnUyEwAACAO8Dim2uA0AYzAVSXVuzVB6WR0CS1h+Dpqp2W1Fq/Qi+IXDTtPPx7KEti3wybrsgLidK36YGIXDKSosir9tW9A8HPCqw4iuDKXvYtg4vl5Quj4+Pwent5RL7APioBkBUmDvdudvP1Zbg9QPdRDArhqqCVTlYaw==
X-YMail-OSG: 0kZx084VM1mVfkSuEzOgfGtHb49zBsr6V2Lfa5K1KpRdEH3QwC8JOnS2AFYMlnI
 K4TiiXyQRo0T9J516sy9gG0YZ5yFvRcxUQs1GuNXVWhvJQbKYHSJbNtylXVx5MjttlJjWVx6_qoS
 1dSoHAEezHzyeYb9AfiIWLjU2r6tCRDQZ_qK5.BaNSs2DDQZyg6YdE92jZ5sfRpKmVbEMNcloHF5
 pUkxPvclWgKphmB9PfFpkhws_LbW1xSuMz_7LIhagEBgGtJIVAMt9mMmroofN_Lxoy7aR.h7X3ci
 jvMWGqNms7oC49h2OqWrYigxIi_YNr2iTd3B_vWoVOEHcwO9VCDtDE3jtyxv2Vb6F_IFclGFmZSM
 H3aPbNtFT1BZ0.o7ly61Lxwkal5Tnj5j8Dbm60GpUeQsyHmubCZIfNjro_.4trl2STbzPnbR20Ot
 gsqay4u2ZcDDNUX25klsK9AklwDqhLSxxEKrl8sqPqt3Uk4dpev6BRbfdh.wNSkLuL6Ik0Tj04AY
 AEreV37_RyN6dQX09eHjlyp0ZytU9rs1WkB0q3iMz4Gb5_LC6RYD06g6DSTRNoUnDoAizQoYRX6S
 0ROHsnqPvIIJ0yVbip6YmAgNBfhjOlWfJ5Xy9Dvvu7T6DXFiu79qsC1jKGLqArOK8.Vd45rrNxVa
 YN6C5OIxISpJjMqcwLB5Po6atj4KtND6sf9XEFmRMKQHxDgUaOZ2UWXq.gPlhO2XqU7QcrR2hUfT
 uKG8r4BxGBCET5_NBT5l.WHL0QvEiLB2LdwDch8O4_TbmcJzifrT9Yz_0LYmb5r_ugjWjEYMuBxX
 LjViWWSsCwIM.AJJJleVODRxDOS8dpbU7O91zW6NrWgUJuCrm13lB5.VqKcxNZAPqIO7Ej.Olrvb
 hcZDK3JRGkaSeGMfWx0A7IVVXlj0t8ppzPFMsiyRb.ejjesuUFRwzKMBjsDRMklKre0SOCow08Ad
 IPu3qYm2VX.vGfELMei9g4h_KgXCU70YP25kIyaBK5eAePGc3iHDQP8pPJlIEnHCqLoxhg94uwr1
 nXK.3Ez4MWztirl1BCAENsCz0nDFUCMJtWLR1DCMxwCdMlQ6H3tfiR.LC_SqGvCOnCUep9QP5Wbq
 5b.cbGTHiN1GbS4NohQ61InSGhT0NjOBZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 3 Apr 2019 22:01:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f4d8e8d57a4f574ab187a28b601d90b6;
          Wed, 03 Apr 2019 22:01:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        SMACK-discuss@lists.01.org
Subject: [PATCH] Smack: Fix IPv6 handling of 0 secmark
Date:   Wed,  3 Apr 2019 15:01:21 -0700
Message-Id: <20190403220121.1868-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Handle the case where the skb for an IPv6 packet contains
a 0 in the secmark for a packet generated locally. This
can only happen for system packets, so allow the access.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index bd45c9139d34..b9abcdb36a73 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3907,6 +3907,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		if (skb && skb->secmark != 0)
 			skp = smack_from_secid(skb->secmark);
+		else if (smk_ipv6_localhost(&sadd))
+			break;
 		else
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
-- 
2.19.1

