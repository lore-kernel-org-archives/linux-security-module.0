Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E5C433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Feb 2022 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiBARFs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:05:48 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:44256
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241390AbiBARFs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Feb 2022 12:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643735148; bh=3t2gw2LSNoW5tmwVSYafILowU2acZrbx4zjEAy2i5sU=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=MBbzaKqggdIjKrHBiLwrc64GsmYqCWUWgntm3/sh5JJtJ5l+gGOTOkl8FH5FA9K5rZ+0vxmnbzWmDRHzxX5Aak+ihi/9e7U6V+IRr31Y53T0Un1HUKRM3eRksuLgrAkMg/XvR2ZgKo2s8j0tsazC5dNeX/budLc6NI8gKpP9cke00Vv/GeeDiB7EITHrm3yaG45kTgLwG781g13X/mjXG8tnp2oq0GOshvkztXR/+MVK9JqFIC+AwTjfyd+ZdkCsXuF5RCjEPnVxbvhFKtmKshiyieRNeLsQMKR4A0j8Dh1K5S1q04e6z0EmcH0hFwQ73GSnUQazY32hWJSRi1s1DA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643735148; bh=5q/yx//AvnpqCpEY6tAmXyJisehihd36wuuwvDcQEGK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XnmzrdabnoLmyLTAnclwg2r+ikGOZ2bFDu4gTyQZ717ORAW0iGLOQfWJUXxo0w4lOK8gEZaPnGBXhz2dVTQ2UrfVflgSe35D9oQU/dnaaPrYaUJUvjxqAcZIbRUUP374y3wzdQFnGeJBuANbbUo00RqKFS/Km/tJLOO0ea3R3dqZ5cu8CrZL7BdQP3FPygCLgcvbMI+59OiFmtq0uuQvESx0ZNFjq5m7IUMRUDd7WlpCAgjwdaIjvZhzFME4Nga/iO3VRN6bRZN4bPgFX289905FIZVSdV5FVAyuYU5YDyo6y+NoPC5P4KOsSGnXK7AAoytG8HqCmjQrS3nC1nppWQ==
X-YMail-OSG: dG6ngSYVM1kOd84iwbLMaaW61tH8uzXu33EsKrni58DBQbUF6Gs62C5UK.vIZLy
 lAAb1nZzZHIRLL0ND7vic6d7s8JRlR6eteePhqGNFayio_cMlUBb4I4PIAP4VydNUui4xakqKLte
 TJJ2cu4VZT3cweIYejF0jskI1KkLbKOti89VqgrsnbkGxehrP1HW0RaMSgiGn9Za3M3Ns2opl7y9
 4bTezUfCE8DpsS1oE6Tptzig2jJQcJUQl4AK4c2v7zKBgaOcsuxbaUS0mFzPwdusntZCTBG4vgY_
 exEvGB42XqzHmYDfSMroyNkOpH4QS3fMsLEfNugKpFK46VYumAMQXvgXXzMUS6HROyKegArQ17ki
 qFPhbASlYYht0u0A1nHdeIPl_CsQfcy6GEHOngb3yXrP91Kq6IdLMdVkPvYTJg8kLFpi._vWZKjy
 suqfBcpOGEdCnpfIRVMAh_6WO.utl1AVXwReYhOIXIRCFMn8wq4USXLce_s6zJY_vNp1lfcSyadU
 R0eRtpKdWRA2uzCNP.P_tp5zG.bHrgAupvxexvwrDrPHfF.232xysj4wH6qGEi.WDdrDePS2q9yp
 aOpO5jBieOFx6uJB3PWG7WGtUghxiCop7kwcUP.QeHxrFgd9tB_xGYnZ.M5KB48VegMq1y_kC_D8
 gMDe9YEXn7wqie6qN3PwZMtFqwygOCw_l.sCG9PKJZguh9X6KjibF8kYmAssxq2Mec1Xp.c_tPDm
 30qN3Jygs57O252COL.wP87jQD6FImALbBBv3rLUz_knCIcC_1PMyjMFXKIVqw2sM_s2kCcO0xHr
 ybHtoJUSpUb4SZnwXj_zhWjzEKOLeVmk4hzO.KgEv4AVqqAo9XyQo1nUzs0YCMFErMxiHlwazrJ.
 P1.KmFh04hV8e92lbDTOA0vXVq8X35UD1N7JM0Aww.qiPNG3ZDybpROz1ZPRuvzjksRuz58oeBqI
 m2Ps3IluyMd103WBhameudGW4suVIILZi5fJvDBkAxkaGIaPyudC7ADUY4KnJl4o.sALyaiT1P1f
 lHivHvBdw3JszgzJybObq.htSUXJ9a.AGoP2TrYRSntR1rHvCXY2LfUNq75LEHvwuf9DQt62Q07v
 VHmDV7wH.BRy2LXdNlfYi5qa.2Rav79zoAk291exDkxI3QwKl4spQXMo3bnGnyNOEf0wqU1fjSty
 Xr.tOtsBpmLm8NfLki_dZOc3WIF5WqsCE_hUlRSxp.bVOED_.bkGvSDAW6MTzoqRgsjZ09qavRKW
 HahAYH4THnVQcXzT.J6E2Nj72pxwGgLRuE_lvfRh6DZkP2zdcnzWRI7pkPsE_81bd.QiyGukXWpg
 eoFns1NhkEMvYjHXl_Jx8uQkCo3k1EgiSI3byrh7ZhJllvBAxtl94obThIqSFz4rSbJqS9LXyZvH
 Kg609EgNO0cPIaphqY1BvDYPdNojNrA1qg7sLgpBehTM7hyA6gl40MKYA0yE8qEehc_2pulroNW4
 h3aY7sKf6fW_O0ssdr3.LA51y067RfJCKC80Yutm32qUwwqRlt4nrPeF6G3TcCkuD_SEfq15bHDF
 bpU_kdFOFtvGoj4pQWNtPOKEjwv2GGgG5FjYZmm7XSEN8exGqFyxPMM9vWLrWQ6McaD3_Ca0YtyR
 5rYdR3TKjswOQ9Ezp46GFEaRU9CY2UVw5H1YXamriVAf0U0YozrM.A0ZHnSoWECa61u5yK716FV.
 hNA0B0JgKr1fy4E_koAU0j_ANXvboxy6oUgaMpwSVlfhAPF25uXD9ojimeTsNRkMgmOESUi2RuGt
 Fy_e4Rsc3kkoWv8wk.ADzsZEBn3mdJn2Lqat3D4hEvJQdRidSbZOImAKaWIjTaZ1WkpJauLLw8Fq
 xHtoyGCUWXmGk_gJ5SMwLUUISA0rg.gZzeE5s3nYvRsb9hzUjVMmksFvLrqXGDWgp0mYKYvv5fdy
 Cyj2D1p1u92mwoi.GaWBbKgHmA20bE5BWlZhA6n4EmVsLrorLhqaNh90oxrV3xLDItRXrc3HAZhJ
 wzoHXVfdItYn9Woe99mwwkL8c6UKIXvFS0SL7fquUiMs5D.XiU7sN7KeFyXuLLmRS0QRpN1hpa.d
 lYAnI0tnZKsu0l8Z4zVS5TtZ64iW90aDMbdU_3u4hIPF1wlcqDsY7JfW5kUO_ume5GfGzhXp3gtg
 PQIbCWmqISqWmfY1Bs9DLTvFSSoHrmTRsrfsjxyhT.nf46STGrD1JRRqsFADOHEq2M_XWvUvAjtH
 OfMUmzA_ncKi.qWvpA4d0pTq7ZUHvsxgfj5EXnB8UKVCT7jpTUUnZOZEMYtSL6Ws-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 1 Feb 2022 17:05:48 +0000
Received: by kubenode538.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f2d5ece9301ad93a223f7180ff105b2b;
          Tue, 01 Feb 2022 17:05:43 +0000 (UTC)
Message-ID: <7164db8a-bf9e-b4e1-0b24-a1d03489f16a@schaufler-ca.com>
Date:   Tue, 1 Feb 2022 09:05:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Leftover info for sb_copy_data and sb_parse_opts_str in
 include/linux/lsm_hooks.h
Content-Language: en-US
To:     Igor Zhbanov <izh1979@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <b81ca774-d45d-6b85-fb74-ffa72223b35a@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b81ca774-d45d-6b85-fb74-ffa72223b35a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/1/2022 8:50 AM, Igor Zhbanov wrote:
> Hi!
>
> There are no more sb_copy_data and sb_parse_opts_str LSM hooks,
> but there is still documentation comments in include/linux/lsm_hooks.h.

You're right. A patch would be welcome.

