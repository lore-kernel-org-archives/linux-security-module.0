Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502FC433EF
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Nov 2021 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BFC60EBB
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Nov 2021 22:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhKAWtg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:49:36 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:41008
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232354AbhKAWtf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Nov 2021 18:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635806821; bh=6/TIVJ5a3v7Q7E577iTkgkCrU+qS8OuqzrmRI9eBVjU=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=sgkaYR081wE70/cqYOblQHPuHCCy+jc8JgOFdgq4Yz6310ifbA1QMpAEdvQP71CA3GxGtPHZLjUXyhYrS/gcJOpsP5XVVpzFTvHSTaFJ9RvMNHJEgon9+45FfaPLQ99CGAI6SEIPGv7EywNxnvWIqVFAUOlSS3FafOi7HKSoeNKxJ13BU41G1myecmlIq8LHIE83np3XmQYHUiU3vHHui5wPYeIdWe7NRtNWrs1YHDTFF/hMCpmQVSzNRsBanGBqT835z971VoA6KBtCuvkxy25RMqLneHAjRYJhBX77sls59H3AsmR6bAGoi5E8bzMw+WC2T3Z3mAGrhpSSGOBjdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635806821; bh=Ncji8YX7jndnxKPYluSdvbdA+VkWEdMz3Ej4GxdehsK=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=XJhb376W5QPCoolDGf3KS9NkktOtIY7lPLYHyZ26iJdxQkNASPHWcdVhr9be6Rkul23/GaPW6WeSSmidf63FzFabklo0hTXQj1Kmg15J3TV0Q7XVT8eCM8s53D0TH5rvbT3BdObxWDzP5Dr4hivJ1flk4jJvw70L1fWUzW3Esg8cqzeByBdFr/HKvHsi/6vWWsJvy/T7Qc2hgyUkPPG8Zyop+5YLpClTJFJXCd35dIJ8LI1NtVubvaYwkIhGwYK+TscbAuVNINbNTOFvZT1cGzfYOfFLrA5pWXEO69auP9MqTUrV4y/ZksGKyEGp5pCaWeduwblpgyzSJQfanKYEyA==
X-YMail-OSG: jR1.ILkVM1l6jM18pcUGgCLtU3hCb57J_IQQs_jqPZ2XmUko.vuVw_YRPxfiJzr
 .6Cx7EdD1DSJyU09SdPQfmzvx6s9ZlPZnRkca7lE8V4uDaaKir5k9Wt7S6TfDD.nWr7YAFHaSKNq
 D2qe8ni5cCpL6t6JZHw66lWwaS3H1_4WMPO7SfgyKAbqa6LUBzMuc63AjDo60yu91tCak1cDnZL7
 pWerDk1wPnIteu7M94qX0LK3JJ_c2_4fNL50yPKb1WlrAccddftxLvwIcsYgwuF8WfuFivjDOoVt
 c64BEk3CvPBf4ilCCV3n38eAqFO6rGdKXXn68AoY5idiEBvZXRBivYAtzSzmVoGAjyrIKXR651ZF
 s8LKE3vJ4HeeQt0X.Utoyuwhod3czzfVphlGxC3aLcA8iU_ufebxX0szllCpyJDT6RGMxQoLm8J4
 PomeqG57Pb3z6Ker3VVlJt_rnwWyjoBpie2_Xl7P8ilZVC2s8xCzYLsiILDRx1yNeIQINwB5PVPT
 zPJAh_L49dQ6nlrnpOLxfwGRlKqWTLuKcbLIK5Zwv6S.asSm.Mtqop4Nxwoz.rJTIomWrusds7aJ
 HXSbEq2HqkMGJQeXOkwaDKc7GKzbkZBBi1NWyINvBVU8nnTjYDgoDzYVuztVRhigWjUEkIYHYV2m
 ihiPC25KtRgXMJpYTtz9CHXc7ZOA6Cp121.y3.NpJra_t5IghL_3bmvek7KUvb2TvZ0ZPUB.7SE2
 5j9tzvz6nSa_t6gjFaxLpJmbBMHyX22jNCNMVgHZouqfMdsFQFCzLQZBsMH0PFlmNMIuf7GGTqx5
 gqiJWbX0YSsnhYm7NS02GOdD_5YR4iBUkkQxIbChlY32z5N3EuDxqNnEU7Abw5IFgp4DiLloVLzv
 Gr6tyvoygcC1_vr05B_7MSrIigtkZTZ740NBzxjLJKV3FamEHd5Nfqd_BgwC5QPZR.mUJ1rjkNcB
 V4Qc3SY7b4rkZr4ny9u4ntg6TQ5GgsKDEJwv9r6vYh82rfydC9G6xKcfJ3DTFevJpNwNYuQATF0C
 Hm_Iw9swTGoi6A_9NwVrgt92DXazHdYToug5Up_DDE0v8DmxZkHV8PNGlOgdq2YwBnfdqACBAi8K
 MNCHbP1iObKTYKwQ1gU607nuuNZ7tPdrLeZMt8iZGQdiaZKdl2rw9AlhEKptv7zBbMV6Xk9kmwOz
 F1qNEha6EK1olBmcWYJjlbtX9fXNomXkY7j5ltLB.bb1NI9AICLS7M2bxwE5P1PeGNM7widiUR.U
 tu2DOOxJKq2nDHBCTynHac1H1lknpIh69fG8yc2PhTzTrFQ0svHYfxn13HAoAA2kCnGjZwjlUPhR
 Z.p6BkX_91y5L9LiPAu9krFwftb92F_KSGYaJuMTsiszrKXVI61oSCpy_ZCK7sQBfKZBqmZL33kd
 frJ.k0fpXpA1fQ_vW5tQVZ8V5cI6c3zi9OUG5VDPTizoyJKZUpN1FO_iDDTa197UU57x7.CpQIJI
 KgrKYyIRgJt39gKlRDZ9DzDBCyHtQJ01Wpk0ZisaGAGqgHa5Cu7z4m2yaQMBsCcQZ6ahqHpqL1L9
 0ZjW9kHVh_fC.Vnc29A4t77CB.PpsfRKXQHhNgqtzB2ataNVCQLUaUKoFBs5A2Nq2dyl0uoqJVzg
 lBAkw.eCzHaiF1lWpseei.6im2Cp_WZOi2unZ4gzdm52mokT.Lg7uQyiDFM3WcdHgFUXkLdHFWfj
 Mods9A9M_ajIMJ2bUNMf_Bj.0.V5MQsG_APrCf7ZMM.SHGCTJCuyKu5n2w.IxHxUDMPs5y4bXwOk
 h3IohlsoARVWGowdXAw34g6qbao9bgxaNJv8i3udJE428wtaPPod6VNIqhJg1vVpe0EogrloZCYD
 TsQVooCEMgkecYKsi3dt5_VduXvXHiSt7Lzf9DBY1MyiyB.SHMX.iDePJdtMDPcFRkliUTiBhb.u
 BpMIA9mgOUHg5WGBBvDi6hue08qZom1lUBLomuja0asdw_zmqWQQBjS8NFJIwyOglMNePOUjn0WD
 _81oT1j4fDtnWud7acxyLTsF20vIjtp9jWmTyPR7wwVGeBBwGTWHh1RrKWwi81DCNbAyi86bU_5D
 3RGjfbtWcKp84VAX7YVASmwDFMlFCUM1fKJcV9oa9ykViOdF_rsj4p_7.suoWCD4LlTFXtmeKjKO
 nQd8KYf5bbHOMaKry7JECGvkgPpHdeMDkbrwqTikaHjQYUAz6Rbm1tIvnxsLMIR5O.GcZ4J.P7pF
 99wecMN3tIIEjFfTJSRxFYmpCpmNHkj2JaMvUxtZX9uuIpViRIzd2Wjcor5do9TeZyX6TLtkEm4U
 z384JPSfwywyZ_w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Nov 2021 22:47:01 +0000
Received: by kubenode549.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cf8550e7fff37b14786e6ebe5d791649;
          Mon, 01 Nov 2021 22:46:56 +0000 (UTC)
Message-ID: <b3e4f10f-b065-68fc-957d-92c65a5c7193@schaufler-ca.com>
Date:   Mon, 1 Nov 2021 15:46:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.16
To:     torvalds@linux-foundation.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Florian Westphal <fw@strlen.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        casey@schaufler-ca.com
References: <f34e40a9-e4ba-ce9f-fdf8-1faaf73c69d2.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <f34e40a9-e4ba-ce9f-fdf8-1faaf73c69d2.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus,

Here is the Smack pull request for v5.16.

There is a change for overlayfs support that corrects
the initial attributes on created files. There is
code clean-up for netlabel processing. There are several
fixes in smackfs for a variety of reasons. Errors reported
by W=1 have been addressed. All told, nothing challenging.

I am attempting a revised email setup. Hopefully this will
address the issues I've had with previous pull requests.
Sorry for the multiple copies I've sent. I am trying to
work this out.


--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.16

for you to fetch changes up to 0934ad42bb2c5df90a1b9de690f93de735b622fe:

  smackfs: use netlbl_cfg_cipsov4_del() for deleting cipso_v4_doi (2021-10-22 08:46:53 -0700)

----------------------------------------------------------------
Smack changes for 5.16

Multiple corrections to smackfs.
W=1 fixes
Fix for overlayfs.

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: fix W=1 build warnings

Florian Westphal (1):
      smack: remove duplicated hook function

Pawan Gupta (1):
      smackfs: Fix use-after-free in netlbl_catmap_walk()

Sebastian Andrzej Siewior (1):
      smack: Guard smack_ipv6_lock definition within a SMACK_IPV6_PORT_LABELING block

Tetsuo Handa (2):
      smackfs: use __GFP_NOFAIL for smk_cipso_doi()
      smackfs: use netlbl_cfg_cipsov4_del() for deleting cipso_v4_doi

Vishal Goel (1):
      Smack:- Use overlay inode label in smack_inode_copy_up()

 security/smack/smack_lsm.c       | 41 ++++++++++++++++++++++++----------------
 security/smack/smack_netfilter.c | 26 +++----------------------
 security/smack/smackfs.c         | 11 ++++++-----
 3 files changed, 34 insertions(+), 44 deletions(-)

