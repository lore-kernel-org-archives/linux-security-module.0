Return-Path: <SRS0=ZVpt=SR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1612C10F0E
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Apr 2019 16:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E85A2087C
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Apr 2019 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SY7ehdng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfDOQ16 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:27:58 -0400
Received: from sonic315-21.consmr.mail.bf2.yahoo.com ([74.6.134.195]:36495
        "EHLO sonic315-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbfDOQ16 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Apr 2019 12:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555345676; bh=PIABHoEoN6ukXo3EC5uDaJILCId1EmCVEQitppa16jA=; h=To:Cc:From:Subject:Date:From:Subject; b=SY7ehdng8cURbHR5MqhfpfJHUQCWMl8GMsMPt2c+0+QSGFuDu4KaRA2BzRmHdHHIpXfzfkrjpCVrSZVbK1MgkG1vuSZVRwjKzn9nxb9wD3/5r/mU9g4jk2hu0AI2VLuk1seJTY1t/5VRz5KSfG5Jc1BODQZgvtyHt9vicHkTt090RI1N43RlBabpAeO3yjU4RNAagbz0db1eUuk2pveEu4oSCaCwuSCAE+xQBmHTdUA+PG+fQ7xIwrfKcRBm05KZP0w5YLv00as5bde0vPF7KodFqnUD3ilECQOlIOHfaXarEEQE5EqWPIFAB58PZD0S3jMQSwMbkt7BLeOHlnXK8A==
X-YMail-OSG: Gu.5QMsVM1lSYFXMX5LUFcDP7vInQPVAMHYklNyTiXAKqqQGWv8fWL8_mxb44dU
 oidQy2.Y8h3XOQNRTTU7imjrxWqANC4qyxsaPiI8sA_BCTu1H0Ql1u4pRW127VKMtikf8BLaRdK.
 jrAeuaxMN4useuNf62ROZ5yfxqEcaBoNG3yA7w2SuZamZi3Ff1vuXrXA4hr60odGKhUwr.kjaoQW
 ajXzXr3hVU.liFHF96tcyIHCes8PuYerz71D10FxvjTUVwjtodgeTR5Vr0GsAB5WIXHd8CnLgzum
 jVkz5jZfTiN_TL8V4PRCGnLsfxg4kb3C4ZmQdgNx.Q3sWFQwccXJ4X6a0jHr04NRGERBOSZ0Qy9n
 KgqXILZ6rfWmdwCwSzpRjdjGI.N0NjBwQUWCjYHzJxAWwBlSxG0TO65G2OFgWTXguqvird2BkVZO
 78YUFN71.iMBDM4oRMBfAnL8Tu_IOp7nrqpPHSp5hxeLcG0WJz1fZpWMOi721NmOpSC20cZFbotr
 gXJUlmOQqgVi_.4mOAabux2HYdlUGjq_AruRJO_si94aLgJ.2YVEA11PmtKLBeqIzGE9BxlVvMs1
 .nWEBUM45GrmvsIZpcUlmYxk6y6_Ocv0ilF4Xuw3DpVNWHTVfMm3RTO4rn2jZktFegCc.3jNhiun
 B2EUPWFAgDd.LKWCqtm1oKxq_sBaZ1RRI.qOecSuK2KbZJKqDF7pDephyY.MpxLw2KOI_ewH7ytM
 66yTGlOfogIrNPHFCR3U8FlM4FKrClAFU7bh3gePbxTictmgpjlLF7bG65VXAdZ8BXN9IT9nBQ9D
 GcxUZCpixlhAWYvQtH5tMmQZakxdPkIhkTAEeh5zzqlStYVaLINZciwU3OhSj0SvGdHd4e.W8iZi
 kq2kSztR_lVxyUvQ3BMcaq2TKhaq21dpjR4saoZCe0Z3oRGfeNuxWFFa52SLcdmJakefLeHlrp7D
 qPCoQ_9izhTDXqL_xXHQKXxbAyScW.pE1545RiGqKuKlQHMfVfzWve6HsIMj2k_jonO1w1Wfa1sS
 GFersXHQIC3C1_CT8sbHp8RELwmHrk.FCCNRKnuAy4ZbeCXhv_Mk6FH_bdbPQ0r9_YTMw3LnUH7v
 Qk4Z8vyMdn9ErL3qo817osUC10kkIUtKoLFsdguM7JqabJcO4Mc_TSgU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 15 Apr 2019 16:27:56 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d72d375c9350633e68756d5ff494b4bc;
          Mon, 15 Apr 2019 16:27:52 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: Changes for 5.2
Message-ID: <9a7f3da5-a80c-0fa6-c66d-70a1ef61af6f@schaufler-ca.com>
Date:   Mon, 15 Apr 2019 09:27:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, please take these updates for 5.2. There's one bug fix for
IPv6 handling and two memory use improvements.

The following changes since commit 9d7b7bfbafba5e6cad609f1188243a7f0cd0d293:

   Merge tag 'v5.1-rc2' into next-general (2019-03-26 16:28:01 -0700)

are available in the Git repository at:

   https://github.com/cschaufler/next-smack smack-for-5.2

for you to fetch changes up to f7450bc6e76860564f3842a41892f9b74313cc23:

   Smack: Fix IPv6 handling of 0 secmark (2019-04-03 14:28:38 -0700)

----------------------------------------------------------------
Casey Schaufler (2):
       Smack: Create smack_rule cache to optimize memory usage
       Smack: Fix IPv6 handling of 0 secmark

Vishal Goel (1):
       smack: removal of global rule list

  security/smack/smack.h     |  1 +
  security/smack/smack_lsm.c | 13 +++++++++--
  security/smack/smackfs.c   | 55 ++++++++++++++--------------------------------
  3 files changed, 28 insertions(+), 41 deletions(-)

