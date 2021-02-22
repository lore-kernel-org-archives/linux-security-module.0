Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A657C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD0D64E05
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 20:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhBVUcb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:32:31 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:46576
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhBVUc2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 15:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614025901; bh=o09Htl0F+JTJEVBg2UGQm/0a00VkTzMM3x/55BRQEAs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=cl0MFK8nC9Tv/iVDccUWfREUvIGSMSzbPPcgEDVtvPVjEhrlLO+oC2Z/nPtylfQhjdGWetMbvEcxxABT3mfVa7/VHWBXBHb45ghnWfXUlfZRtTPnfcM2GIKuyKZZBTIOadeNYEHeCaGf3Notp95K5RaDFAfM6fFNCjRHrZ2KWkn9zLeKKHrVZBsyOW6aWyh66Oo2F+9PHGEW7SguYmp7MGh5XCdHIiOjLDfjvENLPtY66uCCkmbsYRJySXoJUrYYlq11TkHRdhyLizGsKwDCY3ylWfYOW14S1+ff+aRQxbhLqRtWokvToTnRjYkoeL5d3NKLeAJfHbXZ1svz7O70gA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614025901; bh=nGwoexNpmOsxTOXp1ikozNI9WYtWalVkVRp68flLXT1=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=oe3Hvh/loSFkBNbjWl4bgrc3wOOqK6KBL+/5m/HnMeDomNh82Vcsgmy8FA+q/K+GWhccrnXvJxZq9tEh5SvXu3X+g+pjPW7eYEHwNzQEt3B4O0IMAMlMWQSmmX2eCvuIc/uuoT/h+HTE/lz5UZiNxYh0iVF6ZojS4SPZbdWg2BGkplDhhEzBYn4b9HSbD6NiXPirHRqHCapvTgWyiLMsPFAxUrFZgdj0OZlovmiuTa70zOlLNX3qRRXGb7xAkocewDWQvN3LugeIO/cFmHqkxvufRPF4og6yZkqdvUcz9xySR11GUi5flRdQDyy1O8SqL+RfiG73z7U5kPDBHwBAOw==
X-YMail-OSG: qHrvMcIVM1kavyDWxNzusODLaXzPEguWGMdYrUZKOCs3z4vFMpYIzRllh0jmhYa
 y6z7zs0Q_zVqsyC0jrYZNI30YzMrhMmL_yfF8C6v6pMHUjdFFMyiacU1wBhCNBs2Em_YuU1sikVG
 FtCbFs0YfAzDGV5oWoGWJK3Nl12uiggvLehRMxZpxcO06.7zosPF7S8PahvvPsWevYFiQxbPEBHS
 Jj1AzLdvf3MuApkfUOKngHk9rmswXD3L7q_gg9mbE1gEdTx7WlrGU5EqCxdhUicrPZVFifU0XnQF
 9Ob2AN5yD0MaDAhxA5LKX7aBMSHDhdq0n4oyos7kxT5QFG5aTowHJpy9StktdukkUqmspUzRrFWG
 pcD14ascvKJ0TCPRZrNJ02yYETpFz2gn2kl0raV1t7zaXWAbG0Q.xY4na67MCPsAGu1mwbHeFsYX
 6QHrRGr5oFKQwtIkeYx4LkCtOcVqJhc_QwgZyzxyt7wBXitoSbfX_3YvJU6KWh3oOwR4HeiJiWey
 Iq6avLAR0RTwqDxVOg1a5q.evGme.5HRs5ikoCnsSM8_40gbZghSgbOH1qjt8jdnwoq0.rjsNj0F
 HAp6_U2kcCaMezJYnynpr2bZwSVUUX6pT9tyfDISYFW5khbtspAh2YxZQmkMkwvixiPMd8626_58
 HP_Xdk61WEF44TzE_rBkKy60X.Hjc8nI68eINdD6YZjGoHjSO47QeUoLn0vt5CHe5NAf5QaSIdYo
 6HovFuxsD0QziYvN.u5IFb0l5EZOsdSYfJS9W9Jpo543_BLSek5lbBFZT53MmVQCXun_jntCKO_z
 8nlpknbduHo2M_81GJ_Rcb7qNVAa2QS68tKpo27tiOzQnPoru9_JKajJSV1njfAV2ibUzprG2NNm
 71qciu75qg6SvZ.USAkNa4eAULUz5fm4dmMsn8M5Vx7gcyaAEDRkU1kSijl4_FFUJtB5TG26T_fQ
 VeVmKpBUX10p14Mc6JD6ss0amrBbqVUksX1OdJ3j1_vrSENNZdv4nxw70HhvuzHOH2k65cLdrs7g
 kwxfhLMAxTNSW846AupZ16Tv9h5apgcTsfj8M2Hqq33AK4yOhgthpqyVn4kkTJwWEPlTVwh9NMBk
 O5nlobqA7K57UdYtUSLjVf63dY0lL9_Aqfa1SOXOtI4FVYSkk9HPWpIDiXO6kuap2RcMW4P1Z_yv
 q6k_HxyG371oqsVqhYqEdfVpn83F6JS7J_4OJHWpodqxrdLXfVK98crA7XryTYX0n4emj5AyZUC9
 fHQJfsUSa9bicSb4qoue9YV2QWBXfYkX_33ys1ur6ufspYMYpk2fCo7bKpWJKQceFOnmrxv0QwDU
 dI5NgCW7dN52bcM8wRtSiqdbCIpaZNUOAODcUQIApaGZU14o1oCwwljotDRJKOTlvPt4H6avv3tg
 XDQc74v0lChpZuQeYIAuX0g1x2mgPrHYF8TYrUnfqs27GT6399lzLCug83wAIV7fWw85LG.1Vi8l
 OHmhTzuLaJr9HfAqOBvZbPb6xqavYzINJ0LXtNhWDqbfK5Gjr.gKqsX2vMwZJ6TKJUW4.LmjrClh
 U7q0ZivfVtpUPpdghpvpwNCpZ7CKY5j52lTLEPXy5DyZQKsbFL.xCccY0Xb0qXsEHk7zDhaoBNRK
 .eyDLPBYYH8WyqXQSeBbFBA.BQMEdKRS3xchqpwxoRd7UEr6egc11LFs8hXOASGntFOfsOjwRLaG
 zFVjNw6F5BNjC7B2.D9Au0MyuZ7FizzVDEizPcjzIW62yr4USGkgG7JRYiG3ZjLMA_IgnPjUri.b
 JFzSH4B5T3K0dT7ZnSE3An.c_cSNmyDO2dY08nwy99RuQAqIVtWLsLTNZah7KOtKLxeET4cZj_9a
 uFSWBYDApjGfKJXnIhs6hr78bKY4XmnFe8eS3keGg1BRXO1OlKEkfvrS0ZPvOddcJN2wh9lJH9yt
 a2QSeN1.vJIdKJ.FNFsCrPQRO9mGgNQ9ILUUkyXQ7vP9VoBMJlfp22rvb1RKjDqPBTvS31i8daiL
 aU.R.zhGG2mNmD1qnMT5x9XH98GxdoIkxChKXfhDuDxg1nhnrFYaq2A7BweqzpXl7mYFFoxTcGPj
 XzrkpdEEluWv8AUl1HJz4ExHs5vwbwF7H2e5likDMuYzHr63NO5Z1_MtM2d8huqDlzLd4VIv5qVD
 bLUVAqFHINzvpjRMVBKfio7cLAK1o.x54RqRlZb5AG0fn_nqbgerOvASFJgXxJYRkck_aDG_N.XJ
 WrjMsQDLUBbOg03d5tmfPS5QbEfrqWjnwwO3l4oHBwbk0djYVXpjfwxMM9FhVCbSml8vpnDmFYmr
 wWE1d9th2ekgRVJ4x5V9tAzvY_GDFFiSUxJ3xVDpFE7eeN.8oRZxWadNyeGDtzE1RxVDvSePyGeA
 9yrcJ0J3eQKRDXRuezaJ7xkJs3U4RxWYqkpygkonLdallaz1z1CDwy52ZlaP0DhP5TN8F6uXxWZw
 LX8Rj5Dt8ci74ssOs2krjxdpmDLsuN1xQ9hQxKydnQCE3Myi0HAbO7ZFICo6LSx2SZ9sKGzCwApE
 xq8n7895dRcfEm.QyG2LoDC6cQswfW80NXC51ehsmyRgyEIreXqbw5GQ0u8e6BiUP.3oBDHkgdzz
 9tdq.Wb.rfxKoFLUBn3PkzZS1PoBvAJAzajK.wed.b0WTVRpWFIrSJNxme4W5YyoDVGTcfE_oabk
 EoR5Vlv4JD5ou_oxs2XYNjm5kEimBGYoTGJwfp1.fhNsBwd35Tsh1znI2gwJWjqdJ._fXMfBguNL
 tsYuobNGtt2E0C.TZdxioIyeTZUkQ.yLyV9ArJoJXpmkLf2dL5RZMFEpHel3r0HbmzXfKHLdJSKd
 Pg1kq.dDu1pGPUbUC6I_L1EV7WRWw3m0OR94OcjLEsMlMhqw1mjlI7gDYFNFG_vLR9OcF_EoYKJh
 Z323AlI9BMAIg0CpN.MyF_ZdXHVSw00ZeODE4tKNleOmwXnkN1A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Feb 2021 20:31:41 +0000
Received: by kubenode576.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 03e78e9b678a4731b78559797707a445;
          Mon, 22 Feb 2021 20:31:37 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
Date:   Mon, 22 Feb 2021 12:31:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/22/2021 10:31 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 22/02/2021 17:51, Casey Schaufler wrote:
>> On 2/22/2021 7:06 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>
>>> Add a new option CONFIG_LSM_AUTO to enable users to delegate default =
LSM
>>> stacking order to kernel developers.  This enable to keep a consisten=
t
>>> order of enabled LSM when changing the LSM selection, especially when=
 a
>>> new LSM is added to the kernel.
>> TL;DR - NAK
>>
>> Do you think that we might have considered this when stacking was
>> introduced?
> I didn't dig the detailed history of LSM stacking, but you are in Cc
> because I know that you know. I may have though that the main goal of
> the current LSM stacking implementation was to enable to stack existing=

> LSMs, which works well with this CONFIG_LSM list, but doesn't work as
> well for new LSMs.

It works just fine for new LSMs if you treat them as significant
features which may have significant impact on the behavior of the
system.

>> Did you even consider the implications before sending
>> the patch?
> Yes, and it doesn't change much the current behavior without user
> interaction. However, it gives the choice to users to choose how they
> want their configuration to evolve.

Automatic inclusions of new LSMs would be counter to existing practice.
It won't work for "major" LSMs.


>> This only makes any sense if you want to compile in
>> AppArmor and/or Smack but always use SELinux. The existing Kconfig
>> model handles that perfectly well.
> This patch series doesn't change this behavior if the user doesn't want=

> it to change.

Well, there's the question. If a distribution/system uses the new scheme
"users" are going to get new LSMs spontaniously. If they don't it's up to=

the "user". Unsophisticated users won't want this, and the others don't
need it.

>> Also, this will break when the
>> next phase of module stacking comes in, and all of a sudden
>> systems will automatically get AppArmor in addition to SELinux
>> or Smack.
> What is the next phase of module stacking? What would be the consequenc=
es?

The next phase ( coming real soon now :) ) allows AppArmor and SELinux/Sm=
ack
at the same time. More generically, the number of interfaces that can't b=
e
used by multiple LSMs are reduced.

> Systems will only get new LSMs if their configuration said so, either
> from Kconfig or from boot arguments. I think we should make easier to
> have a working, consistent and secure kernel configuration by default.
> If users want to have a non-default configuration, that's fine, fully
> supported, and they can do it.

That really only matters for distribution or product kernels.
Neither of those should use CONFIG_LSM_AUTO.


>> I know that the CONFIG_LSM/lsm=3D mechanism is clumsy. But we spent
>> about a year discussing, proposing and implementing alternatives,
>> and if there's a better mechanism, we couldn't find it. Of course
>> we considered "just use the kernel order".
> This is indeed the intent of this patch, but this configuration is opti=
onal.

Anyone who should rationally chose this option doesn't need it.


>> It doesn't work for generic kernels.
> Why?=20

Because you only ever get the first compiled in Major LSM, which
will always be SELinux. If you only ever get a particular LSM,
why compile in the others? OK, I'm ignoring boot options.

> Generic kernels can be configured with CONFIG_LSM or with
> CONFIG_LSM_AUTO.=20

Sure, if they use SELinux. But why would they use CONFIG_LSM_AUTO?
They loss of control over system behavior is unreasonable for a
distribution or a product kernel.

> I agree that generic distros may want to not enable
> major LSMs such as SELinux, AppArmor, Smack and Tomoyo by default but
> support them in their generic kernel anyway to let users pick and
> configure an LSM thanks to the boot arguments, and that's totally fine.=

> Moreover, distro maintainers will surely browse most of new options to
> identify if it is the best choice for their distro. The *default* choic=
e
> (for LSMs enabled at boot) is in the hand of users configuring their
> kernel, and they are in the best position to choose if they want to
> follow new kernel options and their consequences (e.g. distro kernel
> maintainers, whose job is to follow kernel development), or to have an
> easier way to maintain an up-to-date kernel (e.g. sysadmins or
> hobbyists, who may not have so much time dedicated to follow kernel
> developments).

Users who configure their kernels don't need CONFIG_LSM_AUTO.
Users who don't configure their kernels shouldn't have it.


>> I understand that adding a new LSM that you want
>> to be included by default is a tough problem. I also suggest
>> that silently adding an LSM to an existing configuration is likely
>> to violate the principle of least astonishment.
> Nothing is silently added to the user configuration with this patch. It=

> is an optional (default) configuration, which I think makes more sense
> for users not expert in every kernel toggles.

That is exactly wrong. Users who are not expert on kernel configuration
should not get LSMs added to their configuration without their knowledge.=


>>> CONFIG_LSM depends on !CONFIG_LSM_AUTO, which is backward compatible =
and
>>> gives the opportunity to users to select CONFIG_LSM_AUTO with a make
>>> oldconfig.
>>>
>>> CONFIG_LSM and CONFIG_LSM_AUTO depend on CONFIG_SECURITY, which makes=

>>> sense because an LSM depends on the security framework.
>>>
>>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>>> Cc: James Morris <jmorris@namei.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Serge E. Hallyn <serge@hallyn.com>
>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20210222150608.808146-2-mic@digikod.n=
et
>>> ---
>>>
>>> Changes since v2:
>>> * Revamp without virtual dependencies but a new option to automatical=
ly
>>>   enable all selected LSMs.
>>>
>>> Changes since v1:
>>> * Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an=

>>>   error when building without any LSMs.
>>> ---
>>>  security/Kconfig    | 19 +++++++++++++++++++
>>>  security/security.c | 26 +++++++++++++++++++++++++-
>>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/security/Kconfig b/security/Kconfig
>>> index 7561f6f99f1d..fae083e9867d 100644
>>> --- a/security/Kconfig
>>> +++ b/security/Kconfig
>>> @@ -243,6 +243,7 @@ source "security/integrity/Kconfig"
>>> =20
>>>  choice
>>>  	prompt "First legacy 'major LSM' to be initialized"
>>> +	depends on SECURITY
>>>  	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
>>>  	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
>>>  	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
>>> @@ -275,8 +276,26 @@ choice
>>> =20
>>>  endchoice
>>> =20
>>> +config LSM_AUTO
>>> +	bool "Automatically enable all selected LSMs at boot"
>>> +	depends on SECURITY
>>> +	default y
>>> +	help
>>> +	  This automatically configure the build-time selected LSMs to be
>>> +	  enabled at boot unless the "lsm=3D" parameter is provided.
>>> +
>>> +	  If this option is not selected, it will be required to configure =
and
>>> +	  maintained a static list of enabled LSMs that may become inconsis=
tent
>>> +	  with future user configuration.  Indeed, this list will not be
>>> +	  automatically upgraded when selecting a new (future) LSM, e.g. wi=
th
>>> +	  make oldconfig.
>>> +
>>> +	  If you are unsure how to answer this question, answer Y.
>>> +
>>> +# This lists should be synchronized with LSM_ORDER defined in securi=
ty/security.c .
>>>  config LSM
>>>  	string "Ordered list of enabled LSMs"
>>> +	depends on SECURITY && !LSM_AUTO
>>>  	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,to=
moyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
>>>  	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux=
,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
>>>  	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if D=
EFAULT_SECURITY_TOMOYO
>>> diff --git a/security/security.c b/security/security.c
>>> index 401663b5b70e..defa1d2c40a3 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -82,7 +82,31 @@ static struct lsm_blob_sizes blob_sizes __lsm_ro_a=
fter_init;
>>>  static __initdata const char *chosen_lsm_order;
>>>  static __initdata const char *chosen_major_lsm;
>>> =20
>>> -static __initconst const char * const builtin_lsm_order =3D CONFIG_L=
SM;
>>> +#ifdef CONFIG_LSM
>>> +#define LSM_ORDER	CONFIG_LSM
>>> +#else
>>> +
>>> +/*
>>> + * This lists should be synchronized with the default values of CONF=
IG_LSM
>>> + * defined in security/Kconfig .
>>> + */
>>> +#define LSM_ORDER_PRE	"lockdown,yama,loadpin,safesetid,integrity,"
>>> +
>>> +#if defined(CONFIG_DEFAULT_SECURITY_SMACK)
>>> +#define LSM_ORDER	LSM_ORDER_PRE "smack,selinux,tomoyo,apparmor,bpf"
>>> +#elif defined(CONFIG_DEFAULT_SECURITY_APPARMOR)
>>> +#define LSM_ORDER	LSM_ORDER_PRE "apparmor,selinux,smack,tomoyo,bpf"
>>> +#elif defined(CONFIG_DEFAULT_SECURITY_TOMOYO)
>>> +#define LSM_ORDER	LSM_ORDER_PRE "tomoyo,bpf"
>>> +#elif defined(CONFIG_DEFAULT_SECURITY_DAC)
>>> +#define LSM_ORDER	LSM_ORDER_PRE "bpf"
>>> +#else
>>> +#define LSM_ORDER	LSM_ORDER_PRE "selinux,smack,tomoyo,apparmor,bpf"
>>> +#endif
>>> +
>>> +#endif /* CONFIG_LSM */
>>> +
>>> +static __initconst const char * const builtin_lsm_order =3D LSM_ORDE=
R;
>>> =20
>>>  /* Ordered list of LSMs to initialize. */
>>>  static __initdata struct lsm_info **ordered_lsms;

