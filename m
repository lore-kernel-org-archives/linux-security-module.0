Return-Path: <SRS0=Wiv6=OW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D0C65BAE
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 22:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79662075B
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Dec 2018 22:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="popxbgXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79662075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLMWNb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:13:31 -0500
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:38699 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbeLMWNb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Dec 2018 17:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544739209; bh=4OF/TROwl7RBk3p2UCe+eBf6CV+ERPuHPQ0/+jBDSII=; h=To:Cc:From:Subject:Date:From:Subject; b=popxbgXztqQl3p+gYr7jUWM6ZpTpsrNUKkLE/glvmJvwgTPvvSGS7uZC/r070VEf6+CRP4qlt82q/9bEWrfaexr2jMjwIwWRKe+pB5bAT30+kFecSqnLYzMOi5dDAOC+q++5ZDpkLqhisFH8C9diRZDC1zmwJgVH1ekwMdrGBRkgiHFEK5uF5Wn3+cyy3CGdaZK3raXDwt1jjjNihZExK7qxXKNiAXTkGczjOwE+3vetOgEun5NJvi2aMoyqINh4VTR4X5LXsmFbU0piDlfO8CtGd+AuowL6pmXkCT/q8/Xgt95ASGPnKIO8nb3UJNj9jLAmf+LB6cwv2V9aBq9dQg==
X-YMail-OSG: wCGxS7wVM1m5i7ogFqhdQuHUAWgZrNF8_wRtIJBPjU6kgKpeoYwDpSwDnJEmTEr
 VMYqNHFrSIO4gqiwtWWjrbJsQyM0uucS337Hw9gWn6.DIBlRIGW6385Kh.5.FInFXEpXH6lBvNl8
 rsfAwhTwW2kwZGihF04QVeQRfz4Sw6CXeQFib7eT4lvHusWuBoqQz0Oqol9hd2D.weK0Sj1dCV0X
 IwkwYcThksTSKl6PwzCNDJv8wB4FvmFeA68lce4pECXqiyCWWmBadd3daQOnIBqo8ah9LdVseBpz
 v5uGShD8tJXKaW6vu12xdVgz.cMaeIeq95l4F7CS.fc15fhEjAxnc1D664YjdyNCIjJ.jZ3JZjdQ
 kryfFxXrj0QgdLRUEvuPLNSGAdr833NdR7rbfTzoIN9KX.PSvHCLO5Z51qYIHRIqKjXYlRAnmevl
 j5LbrWfVcyxlz4ELeMDQUVN5d25BGvtJCYxKygtS40C_tFJAaTIcZTNxTnzDVG4OadV1KYP1QbI3
 Xem.0Z3jgTNyQXHXgpjnoMSpLHXjwqRVfsD5EPcG0mt1QJ4jfHeXHlpG7XROUXL.CaLixA9hpSCo
 wJT5rtvMwSzee3BnU2uL.zmfXG3OF947g3e_hub.pH3BrDHdkO1gukhXsbqgwwrmjRqQ0zZEsby3
 2lJN7wSC4F4sp7bfQGdNsH4NqpVhXoJMv6iu1jceI6kRvsUP3dOmgOrly__J1_06wdTyaXM7oA4u
 TbtkSmjaa3i4FN3eB59k_VfplsRqZkX8BsAP0Vc14XVXGlXsN5Zmj_kgt0F0U3ip0l60vUYAT72f
 pN2C7SOHwBQkZ_EStir7_ZF5wZJy96i8GFddkOmIT9LjmpF1.5sj2ldRXxdjU7LC5GVDp37INoSh
 HVpS8_W_1hKQhvjZXSzqVIQU3lhUAxP7MnNnUkItcY9meR08_xhHjjGq5pU3azitw9LJo.6kmOcQ
 tXgiRh67yWW9c2xYgbWMutpjMeeYFcjMRdE.A74lrSgZiM5Mo.yTJ6BNR_sKd7b8BVUvStFSn5qL
 1yGdpxgDikpu1Ed4IdBCh5szPyNU0pquYuJBmNtZ4AV5HhrsB8dBWQEF1es7rtFuF8ebfNTve.ec
 31wnLrkCKCVmCEFuffgqEg0VqeXoEVzwN9v2.Qunuc6FZrhTlXYw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 13 Dec 2018 22:13:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e68fee55dcea247f6141ee24c87f325d;
          Thu, 13 Dec 2018 22:13:26 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Jos=c3=a9_Bollo?= <jobol@nonadev.net>,
        Zoran Markovic <zmarkovic@sierrawireless.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: Changes for 4.21
Message-ID: <8f3fc078-e6ba-afc5-be96-444117ac9d7f@schaufler-ca.com>
Date:   Thu, 13 Dec 2018 14:13:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, I have two Smack patches for 4.21. One Jose's patch adds
missing documentation and Zoran's fleshes out the access checks
on keyrings.

The following changes since commit 26b76320a8a550472bbb8f42257df83fcb8d8df6:

  Merge tag 'v4.20-rc2' into next-general (2018-11-12 09:07:41 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/next-smack smack-for-4.21-a

for you to fetch changes up to 55b078f031f556ea18963bd808e79a1dfaa4be44:

  Smack: Improve Documentation (2018-12-13 13:31:01 -0800)

----------------------------------------------------------------
José Bollo (1):
      Smack: Improve Documentation

Zoran Markovic (1):
      smack: fix access permissions for keyring

 Documentation/admin-guide/LSM/Smack.rst |  4 ++++
 security/smack/smack_lsm.c              | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

