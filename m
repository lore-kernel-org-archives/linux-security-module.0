Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B6BEB64DD
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jul 2023 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGXVf3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXVf3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jul 2023 17:35:29 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD4E74
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jul 2023 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690234527; bh=UZtbYJYRzRBS0ZFd2r+9Fr8O31e9UG7oJqwbKlGuJOc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sh35K9DNTjVnczODqWlBvOvi48ajgKt7h95LdqMOIuM9MCP0aM95bedQ/dREbGu0wwWIYe6vU2PopTPjmW/5GyuL0q/Fxjnf5d/0WkCPqtB+ppAghACPYWERzeXvrluvES+JvBtTIKw/7n2yok2V2zpEoHFDOubOIUt65YOHljTRjqJugbrZ9dsOjG9K88B0MXPX+eoBygpobLQYFioyxUC65TWu4h9QoJgEt5fBMzb7OHLfujClQ+t/z8r5jiISYTtzcBXpxFqwvrqq3IfNiZEjkLr8wniUi5jC36mJL5d76qwkIOZQYI/s9x+VXPBMkLfRd5lMVknFZPUo7drM9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690234527; bh=Rgy4ppRcd1tAf2rit5x5YLAzx5eXihXzgcIyXCi6oP5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=c8QAs11vujHXVVAb3sgMubzpgJrmDi26Qo4acb0c1AucPGyUGrcHbkKqJZutN8hVwClG8aYadXYZLikWnePt2lZaW+35ABIBxvQPcFbss32oNO3Ai22+SW7Ov9Qwg8eBdhT9bauHS4aA5AMjTx9eJKhx48ucviPHiIWd7vB5hoXyYfZsV2wzpXGbmwLrzTt1EThLR89zBfa45dLphLJT876OvCusDCixiging7Uq85DRR40nu0daBRfRFuEynrhFeUz0hOVhnfpxhcds4owjjPcK0RbSDbZBV8JZYHKbcYSokJtHJQiteLFCH95w7j6Juk3LhyzyIFfAm0jZUb+63Q==
X-YMail-OSG: T5mZmmEVM1nMfGzxC5PLWnBD9njoge9_3T4V67NXBGeayANrevzfTpWZCkNV4p4
 EWLoi3OzUH4jTkK62pantDBhE_5voTdcKj60atk18S2uKc8Yt_VmxpLUPvMA_RPcV6WSGgjgWQPv
 pnLx31H4lTJxByofacYZ.KFiiL3l0vbpPwKg6S.tqMV1vf8SxonSoXrPO.9MEenysuqeg0aLwNZo
 m5sFuALCofDTAnd4WdRqU.yeD6sHwfFiqAPP3oPrqDrL9FAR3gIdIIuI3mO3yh7htnUFoUysI6NT
 78Qz8nrD2V4U0hAkoQ.VzacXIVc_He3r.Kh88q_GHad2K0CvC06bTSaXhpmiLI7i.BRG0_lLdo3i
 H8QOzW96sf2fW1897jsp_C.aTzXBHhUm09lAOKb2883o0JWPm_nZRGhi1BkNkw9fjeYA6rxFLIFl
 SFCRnFEr8YL.lYBIaM4_VPUr2ilvmi9YBcpwmkEko9CIT6VwXe5xJ5VyHza8m76S56qfPoxpOnMG
 D_NPjU_nFP6xvbPbsuo1G_wkKU.f5f.jS1spzkUDSM4HcvEVv9J8.CsrGgln.N21NY1OCw.pWtUR
 pz5YCQxGay0i2YxeQfjEqTLxxOCuTVZjNHyeqc7RuVuN1RdUkVQVSS1Am._bLx1D7cXaLf7_4.uk
 S5fhcltRwl9kVRMIWAyMQVx.xL96l5vfpnAC7MGbkhlkWBM0erxi7uBBlDl275CD.Bc8Xjbq1Ciy
 wtnUk3xzYRHtw6sbfbQuYaXrhp05e_SEf70YHLcvXlAbv1Ew6UgPRAtDXOioEhiiqrh.kPDymESN
 BsjLlNRhGevCq9dK2Ju7thiliK_Xoj6hPnALfhBOpuK7Ap_LVTHz.GPyCOafwNdURiwMtvfkBfCr
 b3hCVk30AZQieNcSKya3ILspUWokdckSJf4Enry825T2X7RETIUtpthEletGE3HQPFhmAn.vCJdY
 g2atIB3eTt79cF5NhPw3Pdp0hbbHrOpBkFWMIbXpEO3nDEUQeLBnm1Osj9aG7MBqESJwlqwU0t0d
 wU_3NfI._iW8seIMje2d67OrkgabxJM.G1VAbjE9dlu7E_CMF.Vdv3.Ad1xMehKoWUxfVaQC9PGA
 9jBgWvmc8Mb7KW5yPbec9r9Cx9...PfxXMMnL4J4YvqVmG.qi7Nc.PsB.qHwfqesiLCjAJNgv2xQ
 QutIBBQJ2kw3kOni_LOd3aDMWfQzamVnUzVklZ8cj_.EAY8iya7YYSiyZZ4ez8utvag_K5hI6dl6
 Ot0hSqZQuygSZXAksa5SnEJgC3hc_kHWH8_gO.2UAVdMv3U3roaipsc56z9UDzP_9SPRTXyhA4ce
 ZXxEgB.1jdEltZvJ_d2Ni63DbkfTbwWJ.nDUXbqtJFv_1NxCUO2oki_EsvnifOcqQX8z7mdCews3
 ylQt0Vo6fIAIowYfT0viTIo1M_PP79yXnE2xcuZhrwYWQpoq5sNOxg6z8uLAgJH5LJbDU_QSnx6P
 5NlexHl0WWlVb.7cMWHrydTf2R0TtaKRjc0IqQ0seYY0ObipdYJMpFB.Ft_V_lZ6E8dFA0zXUPWu
 6YZ9R45pXqPfw.0XA38och26Al8kSHln1W1_dXRBdK4SzkznEAJUnpV9ifQAi3xw_1hD47oFLLAX
 aJn8mvWwDjAKY230af.bM7lBtmO2oZdrzNBrR0GXcwMxDw0PeMbTBf1L0kDRE3.uGC3N.H6Mkwo0
 WcwTAU4si8duqckbjj.DnoTcS_1MytFfoH_qprytaUvBzZOJrNBdWocacZCoPZ8VL2UteXrflgQa
 T6zkoGpagdoFZrr3RkFA2L_nr6hL.jYXjeiuU2IzUOxmgEI2RmIJJDnjY.ImLR1WUY4O307hf4s5
 msm42DxhpAFIpu9UNiLDS8uVUAu2xkMFDj1bQWgV167T1A1MQT4ArJ0UQijcrUw6dWGyYPDnJrS3
 7usleRklq0gu88cSW1mjEi4sLv728EWU50NWMtcphQEaG5mY9h5hEQ6QJkFGJStDITu2R6PGdv7u
 vxrTz8pDPTOlrqSJOHcH58c_GZg7WL7lPap2TlWx5Fa4FIdk9_EtQyswaGuNtr5foSLYnBFjwrTY
 vOKUibmH7Dbw6.35Y.x3diDALM_zWDhZsHgLhL2Vke4yMYnKv..lFdgKAzgupj6zLHDvq6mupdgO
 Oa7t6_geLizRFYib4erf64esvYEQxWmX4htPg6SOfGDljzJHiaRrRt.XzshmNF8CnojZYtvTLT5e
 tM54LzSYfpImfq53Qh.lR3ZIajKIhZAdk8_L5ICP3ersZqoZnqU.OmamSrmu3MCjL7kuatMg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 691d7691-ad3f-49f6-a414-1f4d0402369c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jul 2023 21:35:27 +0000
Received: by hermes--production-ne1-549c7f6c44-rbj5v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60c1c970a628010248391c35620cac50;
          Mon, 24 Jul 2023 21:35:23 +0000 (UTC)
Message-ID: <7ef141bc-8a02-4ef0-c970-8de3e0146139@schaufler-ca.com>
Date:   Mon, 24 Jul 2023 14:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [LSM Stacking] SELinux policy inside container affects aprocesson
 Host
Content-Language: en-US
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com>
 <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com>
 <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
 <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com>
 <6bd218f2-af8a-52c7-cc27-6fd6c27d4446@wewakecorp.com>
 <f21a05f9-249d-e362-6ae4-32499d190a21@schaufler-ca.com>
 <a05afacc-4c93-89ec-b7ab-0d26cc874eff@wewakecorp.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a05afacc-4c93-89ec-b7ab-0d26cc874eff@wewakecorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/23/2023 7:29 PM, Leesoo Ahn wrote:
> 2023-07-18 오전 12:51에 Casey Schaufler 이(가) 쓴 글:
>> On 7/17/2023 8:24 AM, Leesoo Ahn wrote:
>>  > 23. 7. 7. 23:20에 Paul Moore 이(가) 쓴 글:
>>  >> On Fri, Jul 7, 2023 at 4:29 AM Leesoo Ahn <lsahn@wewakecorp.com>
>> wrote:
>>  >>  > 2023-07-06 오후 10:43에 Paul Moore 이(가) 쓴 글:
> [...]>  >> If you are interested in stacking SELinux and AppArmor, I
> believe the
>>  >> only practical solution is to run SELinux on the host system
>> (initial
>>  >> namespace) and run AppArmor in the containers. Even in a world where
>>  >> SELinux is fully namespaced, it would likely still be necessary
>> to run
>>  >> some type of SELinux policy on the host (initial namespace) in order
>>  >> to support SELinux policies in the containers.
>>  >
>>  > Thank you for the reply. It really helped me to know the current
>>  > status of them and what to do now.
>>  >
>>  > Just a little information for who is interested in the stacking that
>>  > we decided to branch the LSM hooks by which lsm the current
>> process is
>>  > in instead of entirely calling them in order.
>>
>> Could you describe your approach more fully?
>
> As far as I know, the current stacking feature is implemented calling
> the entire hooks in order of 'lsm=' boot parameter. But our desire
> must be calling a proper hook at a time by a task's current LSM, for
> instance Apparmor 'or' SELinux instead of 'and'.

SELinux and Smack rely on the fact that they manage security attributes
on all subjects and all objects. On a system where some objects are not
labeled because they are being managed by AppArmor instead, you are
going to have a security state that is muddled. How would you have a
host system that uses SELinux handle files in a container that is using
only AppArmor?

If the host processes never look at the files in the container you could
have a system that works the way you'd like. But how could you ensure that?


>
> And so we have been considering adding two new hooks which work as the
> same as the origin hooks but additionally branch to a proper hook
> function with the information of current LSM by calling lsm_task_ilsm().
>
> The following changes are a part of our approach,
>
> ------ code part ------
> #define call_int_hook_by_ilsm(FUNC, ILSM, IRC, ...) ({                 \
>        int RC = IRC;                                           \
>        do {                                                    \
>                struct security_hook_list *P;                   \
>                int id; \
>                                                                \
>                id = (ILSM == LSMBLOB_INVALID) \
>                        ? lsm_slotlist[0]->id \
>                        : lsm_slotlist[ILSM]->id; \
>                hlist_for_each_entry(P, &security_hook_heads.FUNC,
> list) { \
>                        if (P->lsmid->slot != LSMBLOB_NOT_NEEDED && id
> != P->lsmid->id) \
>                                continue; \
>                        RC = P->hook.FUNC(__VA_ARGS__);         \
>                        if (RC != 0)                            \
>                                break;                          \
>                }                                               \
>        } while (0);                                            \
>        RC;                                                     \
> })
>
> [...]
>
> int ilsm = lsm_task_ilsm(current);
> ret = call_int_hook_by_ilsm(mmap_addr, ilsm, 0, addr);
> ------------
>
> We are still worrying about the part of calling lsm_task_ilsm() with
> 'current', it seems dangerous in some unknown cases.
>
> What do you think about this approach, Casey?

I will put aside the question of whether having processes with
divergent security policies is reasonable for the moment. I know many
people believe that it isn't, and I think that there's real danger in
it.

I'm not a fan of making the call_ macros any fancier than they are.
I would rather see a local copy of the hook lists for processes that
use a different set than the base system.

>
> Best regards,
> Leesoo
