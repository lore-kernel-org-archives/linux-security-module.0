Return-Path: <SRS0=n1M3=DT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BAC433E7
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Oct 2020 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C804C2087D
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Oct 2020 18:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mSQtq3KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404102AbgJLSNE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:13:04 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38253
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404017AbgJLSND (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Oct 2020 14:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602526383; bh=8eCM6LJOT79n5bc3w/IODElEbZRQS2hX2XQQTIO4KUg=; h=To:Cc:From:Subject:Date:References:From:Subject; b=mSQtq3KD6hSl1oKnofc8Dh5HKSuTVX9IkLYp1dDVjyLviaNM04hIWksZqlkDrRhVBc1HCVdwXx6qq2D8sEAMYZz5Fq130fwovrU+jXy99X6eBKITgIg8XN/fbQ2rxQkSPo/PUqHBe5KBDfGPwqcxcVVewyeOMBBxDaFp0RaSfcpWjnXhkMRJzHSpnPDjDNaonMmHhIUiBLT9jCHvZyeevDlMWYRoOjCezuVR6t3Vnj1gZku1ZW1NoimEbhfvtZflMbRwD4Nlw5LTrj1CUDaBe2rGu2a9fy3tBKreX1lTwFnZp8LH4136yLB2KS6aQaH2y7xd3u0kEiQQymempuihNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602526383; bh=S4CNXjO0spr+ubMrBBm4yOz2sU+DLHlfPng3wUcO6IV=; h=To:From:Subject:Date; b=TivhR5OjQ73+59gDAffRWdltkhjs7K8Xfjx3w/6UCqKvXOIv/ZJLae8EzXkUhuREC5i4STuAp3ULZiDz4hqrduwzPKVrYKlgRxzPog5W8wpm3CoyLYYvg5Eoth64FlkvoFx+q5XiM4OT3i1wKDeZjkMNnxJgBJOirjTTlzi7RDjWdqxNjdlPbVAQC16BmUejJyztQRX9vXRqh2/183tl3sLSCTFsDvzHz5Xaiw6YHO+YsadShF/X17uMT634Lp0XjNiWTJ01tvbFXd5O8DH8P4gF44lfowJT9M1CuAlSIFAdK4bgMOSrpqM7w8ir4RFWmimxGBjNhyqvi6fYzOoz9A==
X-YMail-OSG: QVF40qQVM1l1Fohy4ZIJkIuNCxxWVedEjcQXGWOF741phpL1LuBHvjgVV8ktIw8
 DHeFCImvzaYEYZrnizJpAQeljwsfya1ewy5Ht8gwk7HDLYPu8eKKGHzXdKptJae435qgSFe.ncOI
 Lq6FL53puMEP3.sUG4UEyCnubZzFbUWSXA_wELTLzlEBi4jVENhmPgTum.KW0VK3v_zglAt_qYev
 rSowmLwBrsFodxLLNQcdFFYKVIKrp7lb3UWhsZpK_3e79I54v0RFxwTxnpdL.7v4lTll6MPjHa0Q
 9ixGnbmqxNTWegG2GIvI.K_4ga7tp87V3pU6Aigp7ND6Ch0vrISFowhghLyJaRAOzxxYV4f7beZT
 D7Y378qku_WQ3I4Dc70Yrl0VGJy.SyA21bZaKJIWW4pIuzeKrEB1hStQ.VxpVLjwCKYlwYVYOqJN
 3jt357OJGzXgNML.xVfLS1hBT9kD3aVIkd_nGE347u_RGawGLz5jlLFctAy7v6k7FKpP.cWxIpzr
 8OnOl13PTyB.6SjMNT3ZybTh5bFQ8kEu01sD_F5FywRygtyrnWqdajh37pMrqZAQCqg3Mp502vzN
 TXCIBByHd2cIQYxVcCIWhAAcNcvtMHnrWqBv3NzfbIji2J0L65S2ngKWvRcgubdvGgSgeikVIlnC
 s7202tAnDsbUDg.vUb7iTMLAno0l9mg3HorEjYci5TRMq3Pm_QQTjhYuLitW3brZR3Rjshdgia0i
 YQsWro3UxOE6gNPA49NMNdhgNpMw7_VPPl3IkM0zXWIxnYT7wbvA9WoanvSCVlfQb6bN5YyamoFa
 ESW57HjjoGeWUjHYWNSJ4BBVsjNQIYOEzJsberS8ZxEylYNVXY.LY2YFzJJ15zJUoG9kT5v3z8K6
 3grIOjCB1tX.K1MPD0a_Tvpt_g_kWoRCS9PAmGDn0_YwSJxpmd4GiU3PwLBnMzkCD9nDlLeuMMrl
 QetiRhTISnBSUq_KTdWo5LOMjO3Bbs58GdF20_Kttyy87_AAofODlvC3XCbrFyCTbfx1IGry6khY
 cptHN0O7S_3qLADGeC64GIYc_VnkSePpHD2U75ZSjI6JU7kO3qVJeD_2LRFpW_abxy6hOkhbBRyB
 EFPdC_jejq6NhGqsFoktQzQuziqrFT6YuYRVkon8hOmd6ls2r64V1yfxwP9bkPn1iNhRZR33.wRs
 EM886PhQ8oM4V3V7BUWrMOZquJA2xSb8enj9ukvRSYeWj5yqNikYHSspR05QDCgMiaIxG0rZxWhm
 1MIkkrWK47b7pooNNIjJqcCFvi_sVakaWZ0hSBeXjQnzZ.lwCC3784z2w8B64UZcMJBiUdWI.Dir
 uD7IeOgboKlP2yYBjRESLKJMMdrIPAHgv2sgItZwJG3g4pT3hoPUjwYrFsThAj.AoO8uD.aRF60E
 UA2dcUBFrEyv2709rHSdmVFA_io0XxPMa2ANJiKqT68hB4oHfR9YWXBMRBLm9LS.Rdr14egngqNu
 o_5G5sPgU87mEQ0QeZ9gKZZOwfRTDz381maQDXnrXIIj8TUw7Bjb95qzagmOYbiGmAkHFeRoQVHh
 sf_BQp8rYAPuGcmMOxtgCirtgyCVjBXdz4McO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 18:13:03 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b3e8df5906594d7e7f20b6689795e967;
          Mon, 12 Oct 2020 18:13:02 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.10
Message-ID: <efb97951-c946-8511-a6c3-b8aa340ebf8f@schaufler-ca.com>
Date:   Mon, 12 Oct 2020 11:13:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <efb97951-c946-8511-a6c3-b8aa340ebf8f.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16795 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

Here are two minor fixes and one performance enhancement to Smack
for the v5.10 release. The netlabel cache changes have been in linux-next=

for several weeks. The performance improvement is significant and the
new code is more like its counterpart in SELinux.


--
The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bc=
cd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.10

for you to fetch changes up to edd615371b668404d06699c04f5f90c4f438814a:

  Smack: Remove unnecessary variable initialization (2020-10-05 14:20:51 =
-0700)

----------------------------------------------------------------
Smack LSM changes for Linux 5.10

Two kernel test robot suggested clean-ups.
Teach Smack to use the IPv4 netlabel cache.
This results in a 12-14% improvement on TCP benchmarks.

----------------------------------------------------------------
Casey Schaufler (5):
      Smack: Consolidate uses of secmark into a function
      Smack: Set socket labels only once
      Smack: Use the netlabel cache
      Smack: Fix build when NETWORK_SECMARK is not set
      Smack: Remove unnecessary variable initialization

 security/smack/smack.h        |  19 +---
 security/smack/smack_access.c |  55 ++++++---
 security/smack/smack_lsm.c    | 252 +++++++++++++++++++++++++-----------=
------
 security/smack/smackfs.c      |  23 ++--
 4 files changed, 200 insertions(+), 149 deletions(-)


