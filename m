Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F6FEB64DD
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jul 2023 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGCOxR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Jul 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGCOxO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jul 2023 10:53:14 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CDE6F
        for <linux-security-module@vger.kernel.org>; Mon,  3 Jul 2023 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688395991; bh=gZJmRE6lmnVZB2NTyVJqz3e6K3JCO7UExrsJo560Xvg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=n5LEf+qkXl/Hs4C0gyXItBO5B0iXkZyRJ0y0xoGaCCat7yPd87zWzUMbPorks2wLZTHGfV/C5WuRqXqY+FwkJ9YmVZQ2DS+MHPI0l6pJorFI+dt0AJm01PnLvClM3dnzMWGJ+YXKT/obE6b4uLft+O135I2WVBSrAaVD7KyCYddOqidxV/7j/7U/PR1xGErph7sJf2k9ZAQy20U0GsrO7d1b9JkFZg2MMFGsS+/9M5gKXGzDSkcUYVUjhe9aAmNQdqWmj+RrXn8/Mon0Ueb6iQgMiDWZHOp7xVVaBxplLCzEQYUZ3HFCS+hfyA50/w3ey/x3IuA34IAoDAG+lAJHig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688395991; bh=Kaq7KRP4s+3nFHTLQCkqaNR3Ti6HXWpwdmWunyamg0r=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jS3Xuof9wZE1aawwlezL/Le+boB3oIyvE9YEac4psAamedfIbe+VGFu8kI5UIWz5CGyKfnDQ8goMj+nI69klb14+qgYScc22LZC1tuGTItdhsqvRV3DU9xYzZlLuI2ahx3jUBp2N0LX1iwcLc9cRnpMvYQJU6ArO4iQDxmyFH8a/4eNVCSmvojuu3lHacoKz644e2LK828QUcsg9UTPNpLlvepBUv2TnCJ3KBlAVUUHFlYtLLswgXVjafXiVBgEv3qYdjybMBpkbeGHjHPOMfWSP7fm7zHBloW/bY7PHSMAcEvuIrhgczeswqUfFnXB9Y1mEhcGy9jFpXLQ67QFQyg==
X-YMail-OSG: JNciwDkVM1nJakS9t9qgv8b4d8Zqy6.nRka.Tcwg_TBSCn4u3cEO0ELUUFsiXRY
 7LbcxNoQSWNUrqhLYHz4__o6y6IAA9SOBOj2YrKKBzzzP1xgx4U89xiild5LxzUUU0LDjKRC_KUR
 5roiUqogl2m9l1erapwNpSNnm8VeAE06Lwz35FD_E6uNeLLwJxSHDCH5ZuprWL6amcAuUPA7OlPl
 tHyl9xhpvi7uRXa_klV976e6iVzMLg8gL9Y9paDCSOqdB.n3sQuhkqFrSTEodi_aMN_igaIyWcl6
 ux1nhvq9DQlevvAvYQTikjAmlugcgmvDWlW2kV0Z684m_GEey2gAzyGhwdn0Vatu1UPOWChSSzyp
 3VBHycO4FzBxyQqmOr.uMH0_8xp8eClH0YYGDm2oD8g2fDuuVbtVYQxW19QCM89JRimoakgX_9Yh
 UlOSSu9wD.KqcL5OW9ctdaQFAvTG7RrGN8FAtw.fGWXAIA94CsfjA1Aig_ukHSw4EaR5GlTxqNrh
 cMAYBzllRKrrfEr2OzBPcKQCytJTffd.8Uu751fhSax2JO8xiVsoElC3tXFvM5QfvIE3O_hPjmH.
 3DQlv.Y0Cpq.UTbyC6S54UL0gZsBuK5QD71VtMfdDQbLUTqJaHsq9gFpm67uaJfFtR0a36PQuX0Z
 .jqTgIliaEMVy2ly.P37egorhPuQNfL3P4Zn6xpn58O0CMrFTnjp56DabEK293vtW4yUhsK9gpji
 Szvm3ZYkUszW.78YvgSov2jwFnvKbXOBhAr_VhkOwj0jP1BALD9Q6GIT8uToZBfnOVJbw3Fi6sGb
 9QBi_SOOPBHaCM8e6hIBp9_7vqqvo5mLol2SWy6cbRnFShb3cuqgsGCt7pFgurPyR2uy5L8sTq.g
 6h70zd3teTNVss08CKBE8WX84uNdHLPrDbCR3lSBEfA77pKqAsgA73K7T3A2aA6.cIlCONeELZQJ
 9y6jgOhQhrfKt4qumnNk1ckE67u9BAnL4al39IKiR64Y3iJeTOHejEZKr3ksjJf_S7E26YtFvUf5
 fBx6yMUvvBIbyIRxa9p8MVTFT69SmJkoMIB3D5bJqFv9dzF1sREC5TzQgiFCBy8OK4ARi9TL4q9q
 xmnCd4ltC4.zv42JUJYigcWlphQGUxfqmWvfQacmEWcq5Ln_GRYPya34E3Rhh2AOvGf13DFC0Thx
 LV14Ir4EBofLYl9.usWuJL1o1MPotOaCrmSyNidZ9zcH2HvtSsiNNLVwQvhAy1o6IbJPJSjrj6yt
 i8r3aW_5QgFLI4ZB166zzR3otwuwtE8APNN4SBtVtZ.hhDe.vS7pMa9TeJBh7L3dyJ1alB8mNuSf
 ukShRPLWJcuRkLPqk2KGPWOuT8unP4HbbjDSHHRzkApy1HFM_61mTWC31kG_53sZ2DkzabtCGXLY
 lvcXHJeb7TG6oliPN7Y..lov9ADB_dGQ1W2DJfsbu7Rb3cGwgYSbl3FSKwUdX.mpWRQGPW8Umulh
 NxCK6nG_hAo4lZkUxlZA82OYDi7u_DOP4uf2vwxpo_qwffSTeL.WKQyDaVRdFMRJcelLf9pJBghd
 8FokRM_9x5IVxJRaLh_MkYTXpR1enSaHEVrkxMGK6aBe9J2wodD6q5ETK3yTogePlZ8iOZEJcu9.
 hRoZCtNcP0Oc_6UZK.OWcMsiW8T_bTROv5KFuaxcCIhzvp0i7DzNnVM8gw6P_pq9rA32XJdMgP0i
 EkUeOnjkw3_U8Zmb0ket2fYsFnCinWRdng2KYAE64SB7E5519dlaWLu.DOrb2VM.r_42oPi5UhNU
 7fAzb1vEEECHmJUYhCA7Oq07S3UdDBn_RqBBugf.r1ZobkfaIS1dTdO5DEgbAXknLJyCn46BLDMR
 iLd2uehjS1iH0pB1H2qDZALp6v5ikSgvXZZ6MfVtdNG1eiVgQTMnZrdtXYOOJGw4r4Wu7bzZm4xG
 gGyQUkzmuacwBSysWzrRTQ2qE_pzYaNIA2kC7FFBIXIkC2D81bj8Au6tgzLMNjGuGqmPV.Q9E7lT
 PkRvl.luXKBaSU0ia72bNQtpLmJn6IDmNCowWIXgrmYCeGd.9Hg086Tjy9YNnndCxdC.o3csWt89
 ApT2A9fj3_ZepEKMMZlMyIvsKP1DKJsrGE7LxmJSbHAHv.HPLT25dEORnfn6VIeA_ZFVeQiRZMNF
 8EN2zbzyNQe80CxH5Bj.Nw1_eR9rukFeEWktT2UU6QMsflW92NAYO1nTaF1tddm3ITs_PYlFqPy9
 iRRmc9v.L.XxklPoaOFwQYc2cq2GDXG3fKbzbAn2mrzAUO5jLIZxz9FPQDpDfXY4oXZ1yB2oLAK9
 ifMo9
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 45e96ca1-22ad-46d8-86a2-169ee597fdbb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Jul 2023 14:53:11 +0000
Received: by hermes--production-bf1-5d96b4b9f-2p2gp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef4ab3618aa9d4848912c71509c51da4;
          Mon, 03 Jul 2023 14:53:07 +0000 (UTC)
Message-ID: <8ca4ccc3-0e54-ad50-7b9f-fd04708548f0@schaufler-ca.com>
Date:   Mon, 3 Jul 2023 07:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [LSM Stacking] new files fail to inherit SELinux security context
 of the current directory
Content-Language: en-US
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     john.johansen@canonical.com, linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <c0ee001b-caf4-22ec-d1c5-d3d8d790760c@wewakecorp.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c0ee001b-caf4-22ec-d1c5-d3d8d790760c@wewakecorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/2/2023 7:06 PM, Leesoo Ahn wrote:
> Test env
> - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> - boot param: lsm=apparmor,selinux
> - AppArmor (Host) + SELinux (Container Fedora 36)
>
> Hello! I'm currently working on a project related to LSM Stacking, and
> a few days ago, I encountered a significant issue of SELinux in the
> container environment.
>
> When creating new files in the container using 'mkdir' and 'touch',
> the new files fail to inherit the security context of the current
> directory. This problem occurs by the following reason that
> 'security_inode_init_security' hook is called, which sequentially
> calls 'apparmor_inode_init_security' and 'selinux_inode_init_security'
> in order. 'apparmor_inode_init_security' always returns -EOPNOTSUPP,
> hence 'selinux_inode_init_security' is never called.
>
> Does 'return 0' in 'apparmor_inode_init_security' to call stacking
> hooks sequentially have no side-effects? if so, the solution would be
> easy though.

The correct fix is to security_inode_init_security(), not
apparmor_inode_init_security(). The upstream Linus kernel
does not have a hook in apparmor, so this problem wasn't
detected there. I'll be sure to get this into v39. 

>
> Best regards,
> Leesoo
