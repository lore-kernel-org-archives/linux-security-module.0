Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698DC678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 20:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCBUWm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUWl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 15:22:41 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB151FA4
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677788559; bh=66tieii8lSd6/RBoHcQnmGt36Vt67WpLF1PQhKQWQBg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lQitXfqHgASxlEpeuKrWCS+/LLG+fcvUGsyGsIkCZsbpPQ53z655HXDLCqTjGeLmlX0NAAVBGyVINJE6T728uv/SsEgvjLih+JKUM2OPwV5pS2RnGzgdJEwlA80/E0JWvs/Chi1+6Zg9hlzDe5f3s9okanwwqR7h7aJZ9owF5lwTMDPf4pxAL1W9wNi+zwGUgB2oGhfnjcz0dGxHPakI+Exf8zyEjp+7IVHW2M/NwBTloFQqcUJAK9cuwLH2NSjtuTNoH9DFr+XT398+aGL6WYtDhVffc2K7TBPNZJTmLnKUSFazoQ99r7fejb6SpLTYNcCwHOWD3tQxl0k29le9xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677788559; bh=+8D8tMWFv5/xQilnK2mLW4JkmjnQSPpCZK/2uZWNewk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZLsty0Kqc8jyaveRF1AdHJ9mvVwLKJSNs5XWOj4w/TilXR1iq2nK3lcrwG2a/FUZyhDtwJm/P4wW9SHJUzF4eqHoadQhqjsnog+mZij8XMVviMJDpeTcTLs1Dgm2wQxuCnB8oIoIM4S6UcJe0hal54avlazvtV0bJk2Vii6skqw10fGZumF0VNw+wnFyNgLerAGFpEysTwaxt+6E54xPFuufJX7UkOwpvdW4yd/a4l/hQAXgo7MOQ7GS8guO9UQvrkQITvoD9y77zcQT/J4CYCLbtyaK5AGSCxw0+NaTehPSjVvIk1oqOv5GdAtjXExHMaL9BaJ1xHN9bBiULqB29g==
X-YMail-OSG: rnERCxQVM1mNxMfNRE5MoZCLv.yHvakb.dNyCBqGCnVWBatPFTGPD65mSLjz8Pn
 QPrhISf1cm2.ATF_YmNChMQTvqfAZnnGUed3jMl0kUUP8u19o92RW9yNkusoy.cczp_17N3adkHP
 jvHMeBquo4QU8YSVuQPF1s9H6OJXcAJkHTH2BGCEoA38KtXP87ZSDx0QjPrtRwEKBnzUrTK6NEFj
 82atKv1alM6Up3alxDMK.TgloeTH9g7iIU1P3rB5yRZP0yDltpdwEFG622cnasw07xe68DzpQBKG
 xJhVJQXSaifH7BLzNaNgVuBASPX7RjgR2WX8Bk2Cgnlssm6RgIq_b8HQDgUj.7CaCaigR6OcHzZw
 T7LNM66WXvuf6i9UN24qbFpwMzQfWGX2VYY0QfYXU2uAadxUtxH7POC6SuikdeIvV453jdlovOeG
 ikeG.wqOsZBFQB2Pa6kH89dicvwF_nXRkl9rSLVqMU7zU0Q2zAMD0BSl0P3PtpAXpAJQ.BplqWKk
 dkCA01hKwcXp7NP7f2PSqhzEJbDIc7EBsnASZpiiFIId5a1Z_eyx6KWdCNHd8MW10o_Z8WopUJ0r
 3DE3vDXxjIG5QBgwNvOOeS85NjOvfYzvPDRQDeLHVBZDxPDJ1QLq4DwmFeueTajPlox.z.N8KhwQ
 bTXVJuhASdqAN4p6LVHKBqKQsrb5aT3qjKTqNSV.TER8gniB1xrPpfNvdTMu8Y43RSwlGbLZ9itx
 7s6Nw8ipSMuWpYTNAt.MyziM.LRaB37h6OZYjm6t42dH.PgYQoiPubr7OziAJpkpKEWveJO9rc.K
 x6YQiSoMML0rBRoRANLrpK7MO5qyACafYOF0ejUSnXszM2xqwXhr0q8NIo9dLsKSS5KkOeF24FVI
 ZXPg4TzMTvNGRlJRZjOE4hJmXEcxc4nRmwSqkltwnqYlatzQrqIUfFB.754ghRgQnuyUjuhxdwL0
 ScVKcG7HvdJ.B43VsdAvgfZp5BHXkOi_mVJeiFssK4ELKiybH8Qcga82OdPQ7obim5Rt5Dceoc2P
 MutFhVTWyP.Y2Pobmi9.guGrUCuoJ_UrqVCgqGHCyeP5VMmS7q5yxjFJDM9cqGnBTILgYvpACe60
 Ub3S9EbgOgFyh_j4ckG3Jt.AOxcarhl0mr0t9B9_XeE1hbtg9nWQu38B5RAPFerjtGdad4WRn_zY
 54KlzE8acvNrntj._3FQ1oPeDG_vLWXVBqQqcVy.IbiAUt0x4tcZ9ai1oZicKR3u2lkv9GZugsbG
 yOS3z35mSLP5ntkvHev0rc1_5iMFicNTRgjfwJPlvBPI8nANDWR0VFDFEjr.tc4GKz3uQj_6obno
 pE62dPD1l9I0Y7nTQu470BBlErKlYFXr_UL9KvFJf1tQS1qVSk2toDxCqzoTnJpLEIoZdL5MCW81
 GmZ.H7wkBOShssJC1BDg6DZjCnZxGk3leQDo3blNNS1qDxZ1.oY4agx61kWfAHF7faMdBcfhODat
 6rCtJOz7Pwa3CqjsJanMdd9Z2pk7liITJYMANQwFByCWxyVmbraf5WHe1yFF4Jz_nsnUIFym9Ibo
 KTNIRZukT2aBL7kW4xxC_79hzKPAwgCdtMBiGTx8LMslVrN4qbhT.AOpZhU_OQVM0N30HvLmpHey
 1TxU0UiE4EuL5YfvSkPwFlTu5eHa32x2CHtkJoHTfgUDTdCIwYpRMT47QLcPPcG9DvR2g2n_FXaj
 NzA13aPlAk8YKcnEVgJWgdAW.uH53xTSkKCtnucCoXUwc1QdJtyoPFjy1p9CT5RPdtX8xyaRhQ5e
 _.yEHoXp6kTLD8xDMDBpMC9wdldYf0_V891vz4xlpvRU15go0OTacFgJbVt0cU4bVHqrTFBJmbjZ
 2OahO9PZDnM_OY.M94ZSHbuJoRVPxwLMFl2BO7PJA8Qj8BObpaL10JboclpHPREwv9AX0P.qpXaN
 ZiuJcJUwXQ8748z4fOx8Sikx6N6f4EwBcNKFQ35V.QIJ7la6nhsnmSZ3ELJHOZpw_ievEOpgBuqj
 FC5RQjilTBKm557nL1OAdK7_CWGG93kVOCQtLpwvoX_nFQ3uu0x4b5fvOqQUpvRYaV8wvkF.ajwO
 4lfLkRIXLgxPIgWF2kLi0x7oBx14cuioQljw.O0q2qsSxr1egcuxAqUQ7InVKlA3evj1kBtoKRG3
 wJIjVsFI68frs7dkhIeMJvmAbrY6CcK7kV6b0YTu441LEjw7jVJmJM1Cf10G.W6b29IFS54wdaeS
 aQdMZsIF9oU5tfLbMR.8Ak8xXX.KPqrraPaYri5rVGa4vGymACU0ds4AG0Vz2aT5fw7ca7BPogc0
 pxKf.qfhS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Mar 2023 20:22:39 +0000
Received: by hermes--production-bf1-777648578f-286lr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f8602952775940ab7540712f55cf367c;
          Thu, 02 Mar 2023 20:22:34 +0000 (UTC)
Message-ID: <e8cf7da9-77e4-e836-9107-db219a266158@schaufler-ca.com>
Date:   Thu, 2 Mar 2023 12:22:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     enlightened@chromium.org, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, casey@schaufler-ca.com
References: <20230302185257.850681-1-enlightened@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230302185257.850681-1-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/2/2023 10:52 AM, enlightened@chromium.org wrote:
> From: Shervin Oloumi <enlightened@chromium.org>
>
> Hi Mickaël,
>
> I'm looking into adding a simple process attribute getter to Landlock so
> we can determine the sand-boxing state of each process based on
> /proc/[PID]/attr/current. As ChromeOS is expanding Landlock support,
> this would help us paint a clear picture of Landlock coverage in the
> fleet. I prepared a patch as a starting point, and would love to get
> your feedback.
>
> One area I am not very sure of is the case where more than one LSM is in
> use. In such cases each LSM could have its own process attribute
> getters and setters. What I learned is that when this is the case, the
> kernel only calls the hook function for the LSM that is loaded first in
> the CONFIG_LSM option. For example if landlock comes first
> (CONFIG_LSM=landlock,...), then the kernel only calls the hook function
> for Landlock, when the userspace interacts with process attribute files.
> This is not a blocker for us, as we only currently care about reading
> the Landlock related attributes, and my understanding is that this is
> working as intended, but wanted to get your input.

Emphasis: DO NOT USE /proc/.../attr/current! Seriously!

I made a huge mistake reusing current in Smack. If you want to
provide a Landlock attribute in /proc create a new one. Long term
we're trying to move to a syscall interface (patches in review).
But for the time being (and backports) a new name in attr is easy
enough to do and will avoid many headaches. Better yet, a subdirectory
in attr - /proc/.../attr/landlock - will avoid all sorts of issues.


>
> Shervin Oloumi (1):
>   lsm: adds process attribute getter for Landlock
>
>  fs/proc/base.c         | 11 +++++++++++
>  security/landlock/fs.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
>
> base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
