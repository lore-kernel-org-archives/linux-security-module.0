Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F709C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Dec 2021 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhLaRZv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 Dec 2021 12:25:51 -0500
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:35050
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhLaRZv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 Dec 2021 12:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640971550; bh=AuOyBd6sE5f2x93HIKtxYbnETmd8fuEr2BsRaFsUoZc=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=X5LlbZcFRqWd6j3gn7mWAVdqW2BK5kjJyLyM/4OZZ+rmiFPw9a//J8tFqTpVvbGxEDGBprfZIFZmhBfKCRj6Gt8/7FsBxOoDaSwk1kohAn8RGGYLwdKWYV3NYn95q8c5SgTn93bgsPw7nilaIWR+YmNTqt2T2mcsd9Q+l9O/BkiWRK3bm2q6VlNKhusMEZZz/Jq6kmCsPwTUgW2lpE03FSNLHigMWU6w6ppn4Z0dOpEp35ZRrf5kDGBB6U/IHG7TArckzz2NKCTkx/KqchYuDRMqALUOrn4jNklJeaFdfsYoaDntSbUQI8h5r+vhTwYwO6OtIMqpP34cRs5KUYmUqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640971550; bh=JN0tlvKmMpQmGJ0LgGQciTCtZBEkQC+Rmw2e7DjcJd4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Wzxrku/UXR0afyBWnIa4IhBLEFeyO0IcFOUylJnQ+748C2ajonRTk8+24Tc1yTMTv2DUWcyfnUyk2Xc5PXVwtaGTJcdjpoDozzLVc0N/yBmSpv8nJwBOsfcfc7gaBjJQdZ/+JvbcFgqPPibgqDZDbDat1jR6jpkewZ+ZSnclliKNQjAwkSE8Th9rE52Zm1sZG4Fqd28JdqWsvz5WAF2pijAFyOt+MbnaznKcbtZsc/R3cFI78wjd616qGINKb9pqJQIj1qrjBnDSmqoHM4uwFh+rlxCL/b9K47xNVTxM9hLw2jzPR1mOPmr+QFIAbVX5gsRBTCDV9douFwzYK7zvJw==
X-YMail-OSG: Ues1wfgVM1lcShjcLtcSW6_Qs0ZEz6Cc8oN4jp8Fgo3LukYQbItffNSh_aXQMUB
 iLgNOLUiTjiVsPjxLnIuBAiKZQlRr3hfTOGijT_Rts1RCoXpI1GKoB2fFmxOqguz8xyGICIWf5wk
 Rev.HPyQWZUsmiQ30S4LAvdmoKFe.3pFLPOKrB3PmoFXyaExcEc9RQU_cgGtIo7n87UiGIighVNb
 QbAoEehaUqr9xdUJwhciIKfiVDzIQapR12Z6MTkw_OGd7OgQ.yXl4MTw5qpHoD8il0Q7OsybI9SD
 mcWKYHXD2PUzRJyxx4nQ9K0ydCx4.VX0VQRT0_b.Ab0OpHnEP7ovM2hiFZhwRadrOTOjSkVGKEF7
 nuSWCk1Rlrm8PASJz.gOXHPTXe_UwmajZKkAcZRCvsKrXCMYFjkZRcWTb1ZHZEW53vHvoSNoFenF
 hoCms.Vq4fy7HxlSO65abfTn2_mlAuXlSKGkQOVDhaQH8QkvX8dd8uUaKR8psS716bllRttpVh98
 mcU35HUAaMj35cm.5LYZaKHwXveVT0v1W1WvuBXQPDS8bx7laiN_k1WtPN2J6o9qkiBjWab9TQZx
 Lh6Nbmdhm_.7Gp3ML00KvVIcHbKsnsYTwkVJFU6asCFC5Adk8YvBsbe5YMzg0cLoEuYqP4YW.Zv7
 HF51VKea1DpCHRdoevelFuHTVRzUxcx77imGct6vu2RAcMUAbPIqnxx7NlBXLq7hS.wlpZ.cIgcn
 3IjzJ2x.x8OGRMNo6oDOvJFuXObBZZs2lfv0pEGjset3j10fCSeyi6Ujm.ywOZ1btwGwqLNS8cui
 VUCXVezRsT6zqekjJkajkzwn4qyVuaOPgwBu8myxFX8jgMPBq.53yhzcL01yZe6jlqr0kN6QwUUy
 ayG7llifFCps_Zy0.ELwFjJfC55EFOwRmRf4SrQzynyyM9nT8vFH4ZBDEwohqZ.qFDuQszQp9z_k
 eW3wQsbb8gVzHtT2paKFMTngWsp6.ERilJqs.BN4ScTUOrpZHOs8rX9FFFcNRbq6FJx6P4ughPmV
 Q.lFDPnAG91B7Ux1PllO5sVyzNPesgkh31liqV7yNqp7kcUlUDSs.70VbH9WmlKopAwavG_ho3PY
 NVC3mBp7jZw3BHrBMguNmz91vIz6J6wTc_4UJv0nU7HhGGHOBXsT6AHUc8KUDGbYw3XMtGa9ceO.
 J9JPOWyZvmyRpV.JN8CKiKeP9HsKYNSiiNxM6ycUR17itiy_CgrnOo9zauQmBtnLLG.wsVOKOIGt
 uVpEBFQgpGsEI6ilVknSa.6ZUb4UX0.OlBBjg_INPtnlwI5t7L.lnQN10a6TYlBl4dmZU7Shy6Ru
 lc.qcss8tLCAI896cxN27Dkwl691q.vuYpYwjzaHegQs30ziC8x9jzap7kEpI4dXdTfSCdpIMK_4
 ROUQkbT5GIk0VBzsxJEY8WDimuvMMq4ZJP9DOWuG0dMdp3igtooN.64U_axLDC9.ORFfLoUTDC2U
 VwDKjGWGHZxoD_wYakkospTp76OVC9hg27uqitJg6BKiyuNkPTVO2aNxemnluRcUZUhSXv.HC2ww
 8CaXvhZC679tisRQ4UR8Vov_PVkfzKi0iwDkVnJpMUZqhm4l87CGlrLXuYt5lf5QF7BuwcQvCkbr
 10WNq3AwIajD4XXASQyjtKYEdgvbHu7QzffTyl7gvqjJnej6T8dPLs3z497BHDRbW1Xp7iZZXrHg
 Yn0_rRkexcAALOSpfb2b1ht631XsPQ.hOcqKjcBGuSwcjLNlziwIcTDpzy49Em2sTuG4vwDXq06u
 f_0CiBAu8kEhB0O3brp90YUJWTkOGNQM0GFtc3dsFlYjdrDDdsBrYxkB77t5fGPGhVgZ68c3APnG
 FROLb8uhyXxzOKYplRj_3gUicbea_.hJC3o4NnBBGTaaATcj2_h5nyaUmKQlv0WOcRVpW7ZYm0SH
 W9Ll2foWmQG5Xs5_2XON0rLIoTUOZIDKGJ25jCSKcyF5B2gzyxD2SWUcD_xRLCinV77rC.h9vDwS
 anhdeWVB_vhhXL3.IYJ9rFhqhQ4tS3FJM4zQamX.Nwy.cKiwjyQts2cYoVJBs3bkL5PVd8OOCrSL
 tu3k8BRNScGmXouoVA6gR5YMbULbGkBpt2wTbVUa_CM3FKrYixzSpsZLlEjdqA7uDYgZURNOHnoX
 AGrJ0jwqSNQO.g5Wuvv9Rwr2Lfl6JCqYbooPpBrW7LwqfefQ9a5I74ICPcEf4dZYd7MbZwO2QWaH
 q.yX6baZS0xqaShlhdc_ZYFz2zanI3Yh_Cb4GIyZKMcjg1AyxnCiFhswKv8ripbdPD5b1LUH8BQ-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 Dec 2021 17:25:50 +0000
Received: by kubenode551.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5abaac250302ef4f8b81d869c21de2d8;
          Fri, 31 Dec 2021 17:25:47 +0000 (UTC)
Message-ID: <8cd68537-8ac4-625d-3416-3ce6eba938f1@schaufler-ca.com>
Date:   Fri, 31 Dec 2021 09:25:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: SMACK: how are smack blobs getting into cred->security and
 inode->i_security?
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <470651da-88da-8a9e-7ba1-c5f36066bf72@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <470651da-88da-8a9e-7ba1-c5f36066bf72@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19551 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/31/2021 5:08 AM, Denis Obrezkov wrote:
> Hello,
>
> I am trying to understand how smack works (looking at
> smack_inode_permission hook). I can see that that smack security
> information is taken from  cred->security and inode->i_security but how
> did they get in there?

The LSM infrastructure (security/security.c) allocates cred and inode
security blobs. This allows multiple security modules to use them.

>   Also, when does it happen? (for a task and for a
> file)

security_cred_alloc() and security_inode_alloc().

I am the Smack maintainer. Feel free to ask anything you'd
like here and to me directly.

