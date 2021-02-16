Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC06C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Feb 2021 22:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D368F64E6B
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Feb 2021 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBPWHj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:07:39 -0500
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:42311
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230417AbhBPWHj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Feb 2021 17:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613513213; bh=mb3T0IloLeWSZfHGM59VvTZ2INcok7KeJezcMTtUqQY=; h=To:Cc:From:Subject:Date:References:From:Subject:Reply-To; b=uENi5N9YaCO2q323TY7dN/JHAb0NQmfPSMUQL1qbP59xRDGSJfq7rBPvOV5C1EJHrJ+TgZYtb5R31lQ4bOGNu1KoXawz7R46XSwDp1EXpnkrylQouS+xAZ6bD5wh+K0YYDjpTt7iCTTrGzAqzqCLDUJjawV1rPwlmzBoIE3Wf3XbEr03Wuo912t8qKLm99B17tiKFs1snf8xNSp7ioViw0LD+PLW3NNShp4I1Yh40cyTGU1QEAG0GFzRRdkdiwvf/xndP41BUhBQinPXsyW2wwdzIXmBLjndp8G0KfpmZxTGSgLD5PlZR+q73roKrHVd11XmEgyU4YEO1DJfJoWpxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613513213; bh=1Qfs86HXUq+B8CxB/9PJX02fZLQYRQmJtPrHvBk/4Zu=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=sXEzPTFR4tRX95XQgB5eQeNS60xcq787zmK6R2VU5NEBtE5xsTVEeNR7ZVopEoBkbuAEyrRQ/TjQB28EwvX6zelpcJG68QlJuOJGKkMzgg6sZ7NaiRCjP4sJgygW6US/XY8yNapgM88rio5LTfAdf1WPnL61UyYyPqx+rTE68vOeqv6P8pe3SoE4mCIBCSz6NgVSghQibdMucTGghKu9yoklFXR0SxaCnPOOVQo0JGy4WidPw07wfGmp5XXcIRN9lurSQL+iQDkeQE9CFozbWImlWn9RWgj0BSyja/VQVsr9YZqUZ4fbEBYXGVW0dl/EKcWv1bD9TtMIqmAUhgTtJg==
X-YMail-OSG: COJHCbwVM1n3zlHjZhDU8t3C.zxreQN6RxqlPl5__XHsF4WTkevQ0TJpcke617U
 HtipPmb5qSJRZJgme.sg.cVwKxlej7Nwz0Nl8L5puHX5QDbNw7w.Dzz2bcNWLRw1vqlW1NIImRTW
 RlKFDnOXH04otPDNeVP5Y8fnpU8av4jFwJy5BhWe3xV0oZmLP7GOx8PWmXgym_E8urtNrDqEt8Yk
 gn541bNUk_zBJm2SVHaVDPpwdfI8VXdhAwbNI7PIEc76OaZhJCbslBQ6iRb2sRl7acKWCdwBauEG
 kfKIM92ko55aOaj9V2Ab0nySHItzcaSo5jQOLB6pUHjzwjqHVNNtPoH4IRo5me1rLnsfYsPenT1W
 yV1He0tTiAymft8pOj1.QhoD2urdpptO0jGc4an_lj1YUDGtOFTKwisOjs4bqMej2nGiPedYJNSL
 SLmQw6MWu5ZzdLFCWuZfCbVPEQEsVRu7S18X4vmnnacUBRvQUs4ffwQzpOmtFy0pEpGbPxzf4EVe
 0trvLoiMfsYU5vvLVDP3Q.gi5oqOi6DZtbeHgTrIFHMXqGDa6dPH8F2OcB3pBEIGq_kYBamJtHZY
 yCHQuAgpnZ8M3YFQKF28VueNcex04j18CfL2e_zYwQ3jSNaO.sk8OQYDL4va1tNTbRnn6aVe_6yu
 C6MTEkTnF62pL0SLGxembrnatVfeiMo68YD6vz8tvpxF4oQ5MmafKuC31Bgks8ldwhR3sY2tYyBL
 41v56lwjMqivBt2JqjnqKk2WxKaCBPsmMbV0xoHpnGzG3PeIMPVAnS39aMfycwMjrTDnOzWsKk_0
 IWxrbQYbL.IJaoOKFk_k_X54zuMJqrCi34viuf.eNl.YQvyAN_kYle3xQqsefp6faPWAWNrM7bBg
 xhKkEbaQSGRiJsVxNkjsusfEFSCAmRorv1u_g.DAnYko0kOSkN1hgqXo1FnQGWVwtqlAcdqu4Mn.
 mwFK3mpBQH0lfHDlXhbRy4zYovIiqd6bnVT3ssXtRbUVX4eL0M0tQc8GCLvSfZ_aroMyNindMRLe
 IU6H9gM97eP_hOv1iovuTtJcpPjxY5Ejmj8NNf9sPLTuRqDjk41.THynp9jAVQ2pCbbELUiGIekO
 V8xs2oHn48eF1HObezvwtfThIv22ljpI57K7FyOMv2G_Mnvn7G0ex06fqVjfYnErrZyOqj8VUMTl
 1ZUavb2ZhpMC_sbB6QX56smQ0r0TwRAKlLqKn_uU8VgpFRzi_26ic_LnZ3mp3KcHvDkbvO8RW9N8
 cyP.S8XaLgzU05FekMkPvWHEAqeXFqVOb8bQ8zI_1zwF_Biqt_ePhS_4z37m9t3T0aAaprOOvQ4g
 cGkfaTxAPEbgA9I7OxbQdxupqIhF9WODWOw3Pah_lnAISk_8SldR4EBqwUDIZT_cB4mYTJ40U9cH
 UGAioqrqXf0QXHZzF.Cp1oqxrkG_AoxcFY4C2suy2tgG.3rl5k7JQtXFMhkYa7ogI8XmqAvoU4Z7
 PWONjNIeCYKSQv8Imh0lSq4Vb6jbnH0Rd5htQsTEF7WlxD.GnDY2EYRDQIMQqVQTeIpHQ.FPfaZa
 qwA9.jhDSZZemFtv0SKTqOiRhavC9I4ytQGg0pEHWT6JWp4iYrwtjCZ7wUmlsWy1pYB_nbwN8YG3
 UHnTvSlrP33RJKPNEg8..LLl.DnnIyVl5TxDb3WhytemoDBRHGgKSRY08YWfUVZrqpLdGr_gld0b
 ykrCOnzl9GeJPnLiDvg_WX.rhx4ooA2k0Bs733aY0d1jRyoBr982vP._LAw2WWXCNy9KedHO4yFL
 Vdv4K1BsMRVYE.EIiCamwf5nkLYYfpgROdCoiVcBQ_fG5jyXooIvxr3hTaqEATuQAw781Fx7lX.t
 MFnnCPARJZ_.zreaq2LYSt2zpOKUlnLwAE5QIZqprD6wgeeHEks6vN_9dTRpILm6ob3PSVWFM.m3
 atPb2j2z0R6xwF5Z5rfBkJBnos3O9jc27YxqtkMUmEjjoLpZlD_GIMkLp1XX_H5lGcWMwbATgfah
 mAUpZgIIxo2IsgAun_GCrnIncjLgHeXJGnPjgLtUN1Ft0.ZHnxDwWeAyinK0rwhinik4BTDT0_VX
 WPIDUbbJELM3lc6zdhbXx3JFf42NqMxfqS9t64bdRWIH10_NaoVaDL7EmNIy.tMR3dHsW_WnqKVJ
 ytC493nYuRfPyAeEQIDc9w0eyznVcnvHWqSG6VggJlNHmX.jTrADMwk81gq6WN45L9Rxear5yD4x
 QEvj3NEiGNI1ai1qDTF8LJUygnL330kMjlXlU5DWt6.sXp.Mx.Mjtk1Ehp4yXfY1ATbjC5o5vJdq
 x.u81_Ae4Xuv3plKnpRJh8zOTjtfnDfETvkqUWkaQYqFmSLQbkhtAnMcsOD.WNRFJ902VH_vBw3m
 5zVZxeuoDGvR4ZoNfoR_.VE_uJIYJP9hpyvTCI6j1_UzSHnExx1CyyZRo_hIQLjSKEx4aL889sdT
 PbF51PPaassfWe0Q2b04744LdC7Qrtub8NOHlfPgIeqn47mwAZgKV7Zn4.yuQvrhm3mlmt4UZxoC
 wCUf7cIN47TVvGnGWEGTA_5L5o9vrK6k1vIHa34HrkqR0SHwUinz7KWt.XbWdP0taQbC9W60aDXI
 xb0XeCG5y35u0B8xqUnP7KjizPXGjHR8ocbWR4fHmkTd1i9H9TBA18xBDAdHGCSdPyI9qDBiQIvI
 uBQt4CLzQn0MPPcr.HSM3XFXgxnxImJQI2toK8BVD_yjPDSCHVg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Feb 2021 22:06:53 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 49fd909a87fc98d2c5e6fda4e03a24d0;
          Tue, 16 Feb 2021 22:06:51 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.12
Message-ID: <7fc1be79-b611-24e9-f2fb-282dd061d755@schaufler-ca.com>
Date:   Tue, 16 Feb 2021 14:06:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <7fc1be79-b611-24e9-f2fb-282dd061d755.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

Here is a Smack change for the 5.12 release. It introduces bound checking=

for the smackfs administrative interfaces where they were missing.

--

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9=
ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-v5.12

for you to fetch changes up to 7ef4c19d245f3dc233fd4be5acea436edd1d83d8:

  smackfs: restrict bytes count in smackfs write functions (2021-02-02 17=
:14:02 -0800)

----------------------------------------------------------------
Smack updates for v5.12.
Bounds checking for writes to smackfs interfaces.

----------------------------------------------------------------
Sabyrzhan Tasbolatov (1):
      smackfs: restrict bytes count in smackfs write functions

 security/smack/smackfs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)


