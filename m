Return-Path: <SRS0=l2r+=TA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348EC43219
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3005921655
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Apr 2019 00:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VRQ8COnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfD3Aiy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:38:54 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:35751 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbfD3Aiy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 20:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556584733; bh=1FeC1S4++IQ7ryibon/JcTlgcRWbwGcpLQcAzzsZj6M=; h=To:Cc:From:Subject:Date:From:Subject; b=VRQ8COnBnypVQV5nYUbZmWxFE/zZre3+CWSMr1Rbf+7g/69y7nSVVMXaVnWgFAHfRhGKkVDGQj8FfnmfSofcbp+jzFeYfgaps9KM/CidrnCsXCjGd05uSWWNSGo+X/hj83z98gu8MVwija8CzjwtxySYkqfWOgnenW8ROPRCgIaNJICvx1088Dpy2Wn1XgxUDk4LIrzi4182QPsyU3HZn2R4k7iyGxvGKbuQMNDHtFI7RKLxuUfOHUH4FwLzS+4G9S5d8VXl9WrpxbACIn4ALDxa1P+v8UHGCfPmRLt7Q9gj4I8qje6++CIqg6psHBMiEJE24tO3WE2AHdbu7Sphng==
X-YMail-OSG: OEVLHtsVM1lwj8KeTahAeVgcMjBBMIsF9j_z7yjGJWaYdcWAupyh04d6FpZPsQr
 tBVaF6JlWzDMvMzdJDF_r3y9n7Eir4A0wIhoJALStRDi.B72ya_NQIEYKf2dJoVFKJzeK8FhbD6P
 d5AtRg13tWoeZEcalO5kCxrqDp8S7MOAzeDH_XU4KYB_uT7Sn9NBJZN0rz89CpESaZAjbLGjaOD4
 5qB2j0kHbs7YG3IAg5SyoMcrx5tjkzft38TDmD4uGWhy_c8EDwxboSJORnk4iBjqq_qrWJn2Al23
 5MauICkFynkKvdb9_zlffMvMydwqOWt8Jinh73ytbQRF38DCr0JNSTfz9Pa8tAEHKfAtMzbfAcCZ
 dorrafkdCaz4Vk_0fZa8Qzg8nbSPLtmssX4TKcAM19KQZLMxuls0nf6j95bguiCtcgQGqtQZbIu_
 uk4Fsnj.LXjCvlN2s1RxgEdAfKvy4eYEuo7llVWzeTnyAxPm86vTx7CSgg6Nx7Ubprybfx9fOrYy
 LPlLSqd87kUIxd8K6Dqgk03GKroWpWEp77nqux700o0Yu8qicYTTi18ruLJvWIO5bdKAgw2iM2ho
 t0FJ6CEYeNbWNBxMF8NoiHHkxbBJmgH683pHMNFYkcJWGBxFVLg2raJzhoxVM64CJ4BdAKkw0Xf_
 VRqX9KWM51DwxcwCWnH75yNiX39d6AnKdYmTaVC5ZO1HXSso8FqzSVg62xmvH05auIOemry6DTd_
 97Uj207fIAE0ZetEz7AVq1Ac8vPwpHXXZVDYt.XcbJaxK6ZPIxdbTGeMdmasNPoyNmLQuIv89iX9
 q8LSNi8zICm1yOLXKegMXO4WUvmsBm69CWEp4K3wZmDkipVGp23eJFr5U5ETFSjUsWP3UcCXCOsI
 lPgjA7hcTu6lf3FYeGT9gUNm8KunjTrxlXg5ijmtj63Z5w1wo9N873qEIbRFQS3MRG4YqDqugTS7
 yHugqY5jmqbKRxwqzgILmCQXvwAvZ.fU3pFwUvd9pEuRpGDXJqhMLB5YTMGjaLuzr5GIotWgOlwG
 yWdmRGBVMtNyxfd6_QeYolOolsVdO0w18S6LmbiXXtfPilUSTHgedEEfew_F8LB9SZMsWbPOkqwE
 tN18zf0TJv26zzwgjXEs5qzoayo28TlnL1CTCRavHvjfHijhpsB1ktRJtrqbj4vBdHnHf6VCBk2Q
 yJdyo5crDSs6TFhRqR0b2FF4c4P1H2RdFXcoF8MFvEPneyaWml3.94BOHamgOuJagG3s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 30 Apr 2019 00:38:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2ef11fb836ee2b43c029c6c851f1c03e;
          Tue, 30 Apr 2019 00:38:52 +0000 (UTC)
To:     James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PULL] Smack: one more change for 5.2
Message-ID: <a0fd7fe4-d86f-798e-df66-c4390bc38567@schaufler-ca.com>
Date:   Mon, 29 Apr 2019 17:38:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, would you pull this fix from Tetsuo? Thank you.

The following changes since commit f7450bc6e76860564f3842a41892f9b74313cc23:

   Smack: Fix IPv6 handling of 0 secmark (2019-04-03 14:28:38 -0700)

are available in the Git repository at:

   https://github.com/cschaufler/next-smack.git smack-for-5.2-b

for you to fetch changes up to b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:

   smack: Check address length before reading address family (2019-04-29 17:32:27 -0700)

----------------------------------------------------------------
Tetsuo Handa (1):
       smack: Check address length before reading address family

  security/smack/smack_lsm.c | 19 +++++++++++++++----
  1 file changed, 15 insertions(+), 4 deletions(-)

