Return-Path: <SRS0=Yqxb=TI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B0C04A6B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A118021530
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 22:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfEHWyy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 18:54:54 -0400
Received: from namei.org ([65.99.196.166]:38122 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfEHWyy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 18:54:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x48Mspfu014222;
        Wed, 8 May 2019 22:54:51 GMT
Date:   Thu, 9 May 2019 08:54:51 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Tomoyo build warnings
Message-ID: <alpine.LRH.2.21.1905090854080.14157@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-76767920-1557356091=:14157"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-76767920-1557356091=:14157
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

I'm seeing these during a kernel build in my tree:

In file included from security/tomoyo/util.c:11:
security/tomoyo/common.h: In function ¡tomoyo_put_name¢:
security/tomoyo/common.h:1183:14: warning: taking address of packed member 
of ¡struct tomoyo_shared_acl_head¢ may result in an unaligned pointer 
value [-Waddress-of-packed-member]
 1183 |   atomic_dec(&ptr->head.users);
      |              ^~~~~~~~~~~~~~~~
security/tomoyo/common.h: In function ¡tomoyo_put_condition¢:
security/tomoyo/common.h:1197:14: warning: taking address of packed member 
of ¡struct tomoyo_shared_acl_head¢ may result in an unaligned pointer 
value [-Waddress-of-packed-member]
 1197 |   atomic_dec(&cond->head.users);
      |              ^~~~~~~~~~~~~~~~~
security/tomoyo/common.h: In function ¡tomoyo_put_group¢:
security/tomoyo/common.h:1210:14: warning: taking address of packed member 
of ¡struct tomoyo_shared_acl_head¢ may result in an unaligned pointer 
value [-Waddress-of-packed-member]
 1210 |   atomic_dec(&group->head.users);
      |              ^~~~~~~~~~~~~~~~~~
  AR      security/tomoyo/built-in.a
  AR      security/built-in.a
  Building modules, stage 2.


Please check.


-- 
James Morris
<jmorris@namei.org>

--1665246916-76767920-1557356091=:14157--
