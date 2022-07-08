Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58A3C43334
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jul 2022 20:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiGHUjY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHUjX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jul 2022 16:39:23 -0400
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E531EEE7
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jul 2022 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657312761; bh=4gGJV8VG67WEelspCfXY3F1RTxutsINvkK9IucbP2eA=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=Yw8YLnxGyv6xwCCCHQewf55VBxBUq0rZ9Vp3iMLh24UDjwN2TB9BRpKlQXsgimyCX0QpGccTPBb4JdLkibZgjxLhhESJdlkSAZzbNLePBcoeaQ/xciize+gxVrwtZXBE5MbcUmFnMYrIWLV51PzQNf83MzwisJvB6D3BpnqDFXDSIuEPOePp72c2MGjokmmAy3lXQAXSZE+UL2T5Xu7cj2weJudFSRQlBV37ZqT0Jop0kDEzIeDXQtFDv/S9vNcaIRlhY38KMfnCtmSYj2ZWhN5bteJ/OlNmeKV0R1JoI9gNczW/e4iXKxat69WQ7IGYFmjqP5u2jVYzWW97NCF6Cg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657312761; bh=4QmTKoPD59O8gAjfGQ1iY1HpA/20vnN/iKL1oaSC0sy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Fwo5hi+zX+3us0FlY6yVxjjFrIDIuTtgXow+359w8B7MxtuSbtyfebNX79bbMCJM04Q5Ek//ecpACqhX1WQMkZKkuZFbecop7/H93Yn1qAdQR9dkwGFCp5HIApDJAvdPSQTQSMwxYesvZK5JgA7T9GgGjUT6VYOxPG2eYvkVAhBtYmY9dTSSpSI2XTRpS6uwf4SGHnvB9yaaviHOsPTsDp1Hr08RWRrqA6l+9ab90O0M4uhc8z7oL8ecDiNXS3IV3HUTC2HyQ1B9xKgZgGfk2bXBiuxy5l3LmQx0WebcBfD4CgjTOI/FNa21/cAFJqBTrSshMFTSpGrD936oatlMAw==
X-YMail-OSG: IMD4OboVM1mF1AYBflLK1N1VLfWLNwBoD2dBgLD7YlaYZ.otPx10HaDvzfrr4tu
 PVU2cDxjDzOASkdHCx3vAs26W5Jo1ahGLe24cvBys9LEnnbxA5uYX4Cijku97FK4WZ_fT3r7Lof0
 pQ3nuDBC7twcJXQTMwzr6TQye3etynS5ycZ3cZCUwdAQ7GRkYyfBZFIo0D_k0N9WgZ95kHslbXB6
 6AX1Wy0AWrP8I1PsTM4B6NzrawZhIIZNEJtvL2kjDY6VkgbswVbyCxVy8Dss8KZBGXdLUT6dwSHh
 ln7jdHG7M_ziH0dXkd_rIrFqTLtBnoii8.buXqVhZBj_BckutqMVf5tJQzFKxpHUvGY5fHoUtiCN
 5gKqJOi0oMnA3Plj1KKBCByrK4v2_Xjkda.HQsfIHm7GbhDtt5moT8vfxVuE7xYkEm1_60JPhDaq
 dd2CwQH2xfi4cHnNWQXkeehj09w1VXKaHlnv9VANZpnjyELzfDLCBQZPm7g2NjAbJN.vWTEiJSR1
 ySdNuQu8y6WRQEyB3vUhOAeUmEw3YAQJlYwh0xxlYayeUGEmmz3tQSkRzDCCyMpea6sss5Qeer24
 l3h7XcshO73xW.eEBZ3_7_mx3aZqRyfztK93mGCTtNN9sW1O0sJWe8HNMgM3el8PmjkDvHzpfmr4
 37fIPjBdsTbQd8J1LnoQWgcP1tKa0iJBsqrFn21u1VeS0RQ6bJDme4NyVyp3SMB2ABSYfaaoEgIa
 EqeYcJsLTLSgwv_5SdkLDzBXV71IjnmAwdmrip_eKr98NxJf6yy_w9VKyFaY_2khqQnOjnA.kt9H
 F0mj2_FwYecXgHIB0ZRxVTJX3hY0Wz1g1GTHzJL7_k9sXRel1J6e.OcRVweqZWtvmwRmLEbpDu4U
 fImwol_oXLGRRlvnftPxn._y2sC4kfiAAXUGDGwMpGmvKu3k9zP63mF85wof7Y5EO3ymcfwptWG2
 IjM9In1.inBSQll9dNf5xVReuL_re6IGYqwpFPW5eiInUsoG2T7ttNMPEDSPYbgELxxCu7ZAtBfm
 sE2bc5wleOAF5yv2dRX8.h718kBDiA_FTY.MAIixQb0hcWEmeK1Qsa6xfCziYJZavuB5mTOGBg7y
 tfvKQDEkd2a3ME4xPtN7L1gWQVDIcKs3TSX3Y7_zX0o6OqYuECS08LKeT55qpScUBkBYpsSxuiFx
 9WFyGI_AfDa6edAbPpTqs8zA8zwk1_waBTVvUY1vSZArk75g4oCHKYNLUelGjkZTljxvY_Ub5pF4
 0qrGFz6c95dJsV.kRlUdNIdSaIo0AaQrL2JVYDs_PLkjQi6OMjFZwqMqLs4LPnx_bNVB1.Es2anM
 PW6lmy7b4kBkzS7FQgXV.gu_Yky3.ghKQNhQIHjwHp55ABjbQFEMcOAxRjapmiYSK8YsPDkYLl9b
 bhtYoGeso1BYq2KGROo10l7xHvLHh74r7deJVeRYPF84bqXz2XM8jA4SaYWQGAAc16mwlGMOXCPo
 RimV.
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Jul 2022 20:39:21 +0000
Received: by hermes--production-gq1-56bb98dbc7-hx587 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41667ba164a413cb3c12fd9ba0b14d55;
          Fri, 08 Jul 2022 20:39:17 +0000 (UTC)
Message-ID: <481cd63e-1988-72f3-5d4b-1ccc363db21f@schaufler-ca.com>
Date:   Fri, 8 Jul 2022 13:39:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
References: <165731248606.335227.15503387932450699761.stgit@olly>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <165731248606.335227.15503387932450699761.stgit@olly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/8/2022 1:34 PM, Paul Moore wrote:
> After many years of shepherding the LSM layer, and Linux kernel
> access control in general, James has decided to take a small step
> away from his technical role and has asked me to assume the
> day-to-day maintenance tasks for the LSM.  This patch makes the
> necessary updates to the MAINTAINERS file.
>
> Thanks for all you patience and stewardship over the years James,
> I promise to do my best not to screw it all up :)
>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..5c7c5d04b99d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17909,12 +17909,13 @@ S:	Supported
>  F:	Documentation/admin-guide/security-bugs.rst
>  
>  SECURITY SUBSYSTEM
> +M:	Paul Moore <paul@paul-moore.com>
>  M:	James Morris <jmorris@namei.org>
>  M:	"Serge E. Hallyn" <serge@hallyn.com>
>  L:	linux-security-module@vger.kernel.org (suggested Cc:)
>  S:	Supported
>  W:	http://kernsec.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	security/
>  X:	security/selinux/
>  
>
