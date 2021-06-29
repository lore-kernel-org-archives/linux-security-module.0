Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16F1C11F67
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jun 2021 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B761361D78
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jun 2021 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhF2XnG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jun 2021 19:43:06 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:45692
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235171AbhF2XnF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jun 2021 19:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625010037; bh=Mihjij8ca8eP5+a9IlMhvoDKDC4NO522L0EdK2dSkJM=; h=To:Cc:From:Subject:Date:References:From:Subject:Reply-To; b=GNUjXUp4aIEQEyK6wwURtF6ySxGl9yAjd1wUjfcls/GU8ylnFa/IbceSXnnLFlql0Vm0sn933trln4q9MqK2Hukv6hyMw3VK7VNW/JKCfPIJqWYfC265KuoqvD+ek6lKs5R9sJHAyIMtewiGUOXJMn3x1d55cgGuw1gRpzTPrhlnDVOaqPAD1BMC/UX7IReLswvdc4dyqMUAjQWPm27tyuhLloxqB+dC49/htjfwW6hi4tF09CF7E1ynnDajwia8YggxGpsvhv/40jNqt3nJdmDwWh7n7bDoKwlIwpi4jizpm7HUx75vc4JT7codp0lTGtHihDDfep42zS9x8Wtu7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625010037; bh=m8c2emsDO3Brdvi/zXaC6CmU8FkGbyb10kbuLicJeS1=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=aEM+sRYcl3tE1dYua5GhY+4rOrTcJV9RMeuhNT0526qKgZx8OZxxW6C1ZWMLhIIzEhiNuMHGsu/iiUx15Qy7oEYiEg6zgXvcd+IVWOip0pDdXVyEZjm3+3xHnKKpYJMJTBtHP4Yfbx+ZSkXChRgvyVZigLtRYcn1Jij9d8L1SF+ogSWrg3gzyZ/2GMg1aXPFtVcEWrKYZK+Xd9K2vzmNfCZxcB1Fqu3Rxi52NALRUunywGYs1ycdi8Cy4slhwKbb4TXP/ZpwGiGBkJ96qDNZZ+eTw/jpewjQiykMo3J94DHUmUHISDBYi7adykGl6Bivc6C1JJEYD15BYcbmRK8f7w==
X-YMail-OSG: JaTxXxwVM1mPkduuW8A9mxpAKBebh0rfmfoGxY55yC3NY2qxCM1JtDxrkM0SH3f
 a_7.5a2EwcIZj8sVwCou0w_27hGy84e6Lw5.k0ffIKzsmvjeE.c60N6VrSNlkZwLr3A3erKfTsqY
 Ov6dTjS_w5NhYPY._9PTNBOUHg_3I9THlcmCZ8Jm3k1AZq71GWq7gA7vKSAVPJ47envOMSOY1jMn
 LXoGZ0V7cSdbnLsrVfEzS.uS6YCGizivBS6CFF7BLJni9JwkSnyEYLJPk7EXcRGHP79V8TKYu4mn
 Y359ui_3F_FYFh.VWb3_UyyCHNuikoWM947eOzNKycaSslZodhO92QSaRGJtzAk6s4NgS_ihzV_O
 5rZFcrqwWF8859zkxbnYXm.u32BaTZudMaXZ2Q6BRt5x0cG6ZSkHpw.AO1YJSOyQ13JdzgU60EIo
 oTKP12B1T2DVsq3VvUfrftA0ETpEbH2IRwOF3A3tGAf3kFknTuZpDNs4XldLYxImQrzTwfIph8dI
 m4jfBdv9SqSSXKzXXxwYB6mswR0PtFwqZdVryfEGssv0MlsIMobCW4dBoNvqQLDY4MF5OjQPVoUl
 VfZ4z1oCp2JHVHcUNKMZDcCnBcTBJAevvfwIdktPQd2yufpmtOcLvASSY2UUFyJF6bwLgoxucawq
 oTEdvmrn3FWJZcKiN5ssrdyf71J9ybprAisU65_ICZvzxvE3I3knqVLWmXpjySvC_VDz3y2bT1rT
 H5SHXQTq99tbOf.Fw2ULHwJOy2jN6cyHzyMD_5cT69EWDhB4Itm6G_9oUa9SEe0tN1_Jf_sdQ37l
 ekDFTftjnn73q6i7jXi_PC6BMyihehopLcp72_LeEXLF2odeEbc7MmJniOz.rNBZWNqLfx3k6XjD
 i5AZHiW0Xk3Ev8bhJ2LBRgr84oNYLngxdyqdKDezQq2OECh1OXV7seGuK13s_i4P3VYgwn_im8d5
 aS2ZHsqi8ft.sZaLNHAirqF0RWvFq29IwYluyKIuVGcFDQDmcDGWHQX09LvUV3RbakwiQI_Cbg9p
 71ZlPPsXVEq2.VlYKtjOxDONB2mR1s2_6DJ2GqMPx2CCqYMpgiN51ky0BrqaMdH0MbmJ_WyXrA8z
 Dt46XYzY0IkFNsCkGpjKo1ngx2AbSI7u0uxSrHifewGSfzneMubbcvYj6boMmNhjwQWxFH_CeOGP
 vkg5whV1Uut30XoSCFceBeuvg8Z7Rl.r4bV7FgR8_0AJrYcXaVsvqMK5.L53jbqtD1ijDl4vd9EK
 VXyvErmD3RlOnmwpychH26nEcSVN8x0yPhXeAPNgPCts5L7uClIqCITaseGeEPj6NAR.99CMXcId
 FPIbQgF.tGWm0y_VzNYWLUWwpKrTIrbpK4OsifPPFrZys7SkxEadbhIys7PDJadKa2MwYDazkVAT
 JHqqwV2PeoWAL7mfaw8HTB3ztigj4FyVrzGkAtoMYuCPWs0mVQ_mk.dUF_oLkgSXaqkAni28D2Lt
 RSJrqdei5soQ3qUWqABiqEVg8BASzlT8t1p9KUDMvmyWwxLA_ETRE6qz2jIaneVhhZozLBmZ64De
 ouDIpsc3Ho.3iLdItqU1ieF7um.bXvYv.XPlbY.fBwt52UayUTumPpBXrTnRBpxUMEelAGqOY.gv
 lhwNbbNHZSmJrkd5yLVvD7cadQXmwBfCQRFYojrG5ymM3_nN7wQY6KRpGWFicn5WbMb7O5sT91w_
 aga.3GbFk4Nssz1gfcMrJ9TqWhBCeZhVBJjRPTScAeUILczhGCUlOyY1kvYLY2jxO5LiXGxU9P_1
 F_tz41GNG6XLaIAn5W7CPEpOLEUBUwS6zJkQt9CB5jNDNTJJmchVW72puX6JvIDYrXJYFTZWqmER
 ikz2i9O_av7SdpV2U82QtbAdewnt0uzEygjUSsJw6k5.vnPBs40zFmZ3IX7QC8VwFaAy4Dj7zPnf
 yGrGgKIKd4W_.GJ.FIM.9wKxRb8u0z8N0h1LtlI.kcu9pxezChd4HZxNKJ5X8FjXDSb4vcpMEpiu
 QT5vxsbucTzQB79ZM986V_a15N0tF7oRNUZtyXGelAKzymT_M8WSEExu7qGUTFMZT7rIOTm622jj
 .2_sKcjHSz_7wzQtH5DRY3ciNFSY3vqXfnUj9P5oI7Yk6GfG93kG.P763jU24kyx1yh4OHaj1MEo
 TJ.CpD0f1X3fJxKekXgfZm3QqxeV8J5G2SYXTVcMobIkNoRJBf90yfBntrOKc0uSv0zLrNwzjaPY
 p2nG5evJUzzc5oPBl4JNExJM2Gx8oLt.y9FX9pfkaYdCQ0y5bUIxU9VC5pSS7wtMdi7BY_DKM857
 AtAczHnkt5NoudOMgbS7.puKQo_TqIGCCnNuoc8RyUEAC8F65zN_MlezWZr0EcIvLNxjeTcV5GnO
 63bs_ql5WWrQOKlyw7lZBDdG0Zmalht.rceZc_VgFnXkwVte4iMgt2SIw4AuX3r_yyq6KU0TwITH
 nQkmGtSt.u3u4BVexXAbXxSrV2K0amMFV.qYxR_JX8RAnTbW7R27jbHcRJH1Lnd8D5H0At1n548j
 zUPztawEzf_53vIEbDaWV1FS4R2Xnq4H7GjoIck_uUSNf.D3o16HQNBH5G2QuRWhAaCs6VGqxMUe
 f6Xww8OwAI9bqeKTc2PsIO4M19V3moevTuKg5oWor.jtEcqCagHFmSsLTgVSdOkDdgcj2jURTjot
 gNx6BL6UazGM4TE_uKHkpq6DImHwXYDBfkP56a.8HNNGxDDczL.CKSElwBjIMmga6Xjyfv6_9Ccq
 dxAoXIfzDH8L9tpCu8HHWeqexqKTVNv1c.sQomHMzi1L67MYFvsqHzvgIw0wrQXCVrmwtZGtme2Q
 ra8oej.SBcoSWVkwv3xCbVRBEFbU0HzAomchl6xTvfLpJN5WG6fL8V788NphGLE9biCno9iySeUx
 cm9dV5VLd9Ic2aX4uFmG8osiVL7JDb9xjZJWZxi0izPdWkl.DWs1FZ0E4.HbanOm1sQPgS0BSwSO
 b1FRr9Mj3lQkOSyKjVMpmJV0fOB6l2EfQ8eQCw9AjK.GQoHQ6rN1UXyIe6AQ6ZGxGrE1rPTQtrYv
 UOBiB4xflNtVd.2R.fEZcLSsfd2l_sIAUaFhIatVhyhmlxgVlvM2e1pMPMK0f2UasQZozyJScNH2
 pvmer
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Jun 2021 23:40:37 +0000
Received: by kubenode570.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ecbbacafa30c1b718c277372371391eb;
          Tue, 29 Jun 2021 23:40:32 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.14
Message-ID: <ababec69-d997-c647-4ac2-2e79dfb3aa40@schaufler-ca.com>
Date:   Tue, 29 Jun 2021 16:40:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <ababec69-d997-c647-4ac2-2e79dfb3aa40.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.18588 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus,

Here is the Smack pull request for v5.14.

There is nothing more significant than an improvement to
a byte count check in smackfs. All changes have been in next
for weeks.=20

Thank you.

--
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627=
b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.14

for you to fetch changes up to fe6bde732be8c4711a878b11491d9a2749b03909:

  Smack: fix doc warning (2021-06-08 10:23:08 -0700)

----------------------------------------------------------------
Minor fixes for v5.14

----------------------------------------------------------------
ChenXiaoSong (1):
      Smack: fix doc warning

Jens Axboe (1):
      Revert "Smack: Handle io_uring kernel thread privileges"

Tetsuo Handa (1):
      smackfs: restrict bytes count in smk_set_cipso()

Xiong Zhenwu (1):
      security/smack/: fix misspellings using codespell tool

 security/smack/smack_access.c | 10 ++++++----
 security/smack/smackfs.c      |  4 +++-
 2 files changed, 9 insertions(+), 5 deletions(-)


