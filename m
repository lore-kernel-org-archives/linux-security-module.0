Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55378C05027
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Feb 2023 22:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBHWPe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBHWPd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Feb 2023 17:15:33 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DEC4228
        for <linux-security-module@vger.kernel.org>; Wed,  8 Feb 2023 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675894532; bh=no1SbdACzJ20/OWtBBCxAooClyEUF0085PQFSdHD+c8=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=DglJoBshU2m3+y/CQ1x4hjlkLWFBulZP9FCBMQRZ2aJcpO2z5QFZkqf0UC+h5Qy1l9hOwkzO+X/ZazgS04gU5PU+EHw4BHuNmuX5KYmZkzJeE8o9YxEdqEoXAD6TKTO//svEin82nbQSKddHxanLK/p13qHDMBQfrSCk6GdZ90rC5bS53aIpCMK+Zj69zZl0RX4sSVLbEKaoqNnB64XZS+S0rpm559WsTu3QixZikrJEqeK0phjr0TbbLwX/i1hhzVCPlpqk4dMvy+uur5NXrpG0xqVhcULOcPjr/2D6E4TRZW5QlGHwV4BOnV/uXjpVao6dUtCzEe9X4Qw91mB6DQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675894532; bh=Y7IcbDfJc0E5qH7BdRb2kc0uS1JsFZFxUutWK1UPAhm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QeNpJoQS9ZEx7YmOzGF7avkPYR74F9DH2AggdoIvUpzIRm3roCmcxEHRkTaEQNEnVVVr2xxTT6GOPodfuGAc0yuwiwu/9c5FoMnzn0hrADv9/WKWzAr01UH0ZkBYN8WBEcQWUYB9yeskvALWYOkUu4UkwZ2IpsCv5tMWhb5diad6ly/mM4fUhLSyt3VE82UTytxvZxREE241ADp5HucOZI9rSYB9l8+JEU1rMayymG14PW48pS+l5Dpp1Tb55DyZ2wC6MQZ85FTPfKtqz6YYVNXX+GZ8Ogruf3D9gnj+t5oKZbTEFtxlkFdoG4VCH5Gc22CsIh85mOdkGoAVhblUZw==
X-YMail-OSG: k1H_oYQVM1kV71R.NdPmRjuS0Vo4t9XLkn.MOtcGlFarBu6RQ4Y4O2NN2AnDbIw
 3O.DgyUwZyzIuyjzjYL58kQ8wMYdg17cyOWqENw337VMgrRDfgi5bt9hf7920FN6MptAbOeW47pQ
 p95gcSwlUVuHaG4TBXPvXusywyggqpd5drJly7zv0aDAOAVIlpDWGLW3XCav_mgUvRjor3fR.crB
 LPIwEdFAtb6822m1von_yDinfZf7Hn2jjPQBXik9CH6AfiUYf1WHplOlAfKu6.dofub6bj9MSvO4
 xqRI2Bm4KJfGyNNsN7DqOtlPAz5QFrCFNJHZPpev4z9As5cLreif._FP55TE20za8NkcJoPlWqL7
 Ywv98bZ.fvDhXWeeMnBQXP.p0D4DIoMEDTZwo0MqjrtdD5I9Hv_wQCsnPRD4_h8jVJa8WpId9fft
 9cmsTegHpoDO93kjyK2xYd05A4LCx2WvfMml.kRsXG1gzW9KXNqIdgNkR43YKY_bA.Mh8ka4oTZ6
 bHlwKCgbFOUDqMUOIvWnalvHyYFzrT4L3l2hJrQSajtUnyRhxSAFZU5PgYtg6LVBFoRDNBvfwTuv
 BGRx29BxEweSb6B7Q2HJy2CEuONeFj4rfsVIzaHqWE_TVR8qNmrg3p4DfrF.KrR07hhOeLVMlTCl
 tozGsrX8QWiSUHgT4_coST8WRkbKEoesQXghlrbl.fxug8p1JC1OIqK2pffFslwrLLry4L89Y32y
 fklllS78vcVWrqVcBnDU9MbcsknYZy3BxN9wX6_2oX24nTVOOxwO161hAzkW0vgzSqGMAIvwNTLS
 tIulWynw5W2miPINKiNXlNnIhsLAZOfHnfMSsLdfZwEHi4RNn1B5.WrJ4vnlXlWum0jMH.LvasBJ
 825khSH1g4bawK7MvA4YII6mqLXktd7F6bdlGFXeYRkGcUQh6ft2PvPJS5VOLCjSJVuYKY6bhBVs
 nB5RQb2upKMo58gm7CS8m6.Q2ouIM5Iqpi3GK3fNccswUiOfC3JWgArU9eAGAFLMDy7Td3QkETY7
 A.CIMiwkPitF1.dXqB6kf7VJ4.ItDCWc_rvcS81vr6DJaBo8v.LjsZZoFgQAzvGUPu850o4FiBOp
 NMng1vvxE2g.6OhBQGfGqD3KBii8bOGlojckm0doKJs326bIaJvTRl2QYpqNZTherCwelGQFHIsP
 Zb0ZbxbXhOwJPfWr6K9tZfHtc5qfx4DtKBFOPcjvx984XsGuk4LlvAg1splx_VczX80cGJVnY_cR
 jec.8inP2F_kv9ffjlfO9Z1r_IIMlrF_n.OT0tuBDDXHeAgM0W_nFAsFCXaXyplrqkDPd0CGrBm0
 lat84JkZaBXapJWof8BZqiKu0GPLPdeUummFh82ao.aLSuh7fV.zsTiAyEq_tabXoDSRDznaMXIK
 ODZmmsW5QMdtjts_GEgGLdgKsDxWODhlM6cyDzB80k2pezgzKV.8Cy5faE5aRmNJSJALL5scNkK1
 _NCGGurgRQenSdxXMfEjGih4X9RPpuogB2nB9LPi_uXs82mBE0x4UpmH6mx17zztZ_McYrF1moV4
 sOEB7DD0DQ2bzHGEbR5A2SxOacOcsBJbfAVF4nlsPjfRmfNAABapvOypTZFS6e6r_hn_VjRgIQhj
 gH.WiTK.N3_BCc8iRU8qb8agtRsapNHZWXHHb78XH.Jbdr4LV5Y5lGNjVN2SaTTuhd4xxkxmagSk
 KGg6O4k64W4nH.m_PJ4w4i9rjU_RR2CTs2slgMjNNHSYVHBq_i1X6kGRRcmDB43CU7qmcEgNTQ40
 tkwzMB0MqT7I7FWKVJQSE6syWzpOAG_vALcZgWoxR9vsv_U96RX7pG609oSPIsOxo.l8O3vZ.IrE
 xKD_UCztsm6RXWou9WXFuVoZOZD.8Sy2ZbD5_X63BJs019C.AOKXC20s9OUYNj0rhOy8PaKQOq5q
 CXmxmQwkClGaP8JYN2558onHCFVdX5zAD.hLKFboSddgxaZRRLE6xugRO08Y_LnxPErjlailYyY_
 jSAK.lcML9FLF1YZxNDqDz3w_W5MN03ALd5ofM4Q6axekg8TdNqpR94D_gkYsFnBPRoqREIlIJ8E
 98XrtzRLoni1HX8xJ5WXjy5pdamcYqYMfgBmOi1DYS1bXRe_XFgngmLN9yEKDOtWa7SbYP2u9326
 oU7_Gm56uxlTeCCajK8P0m1tti0Lxy5nYgWYy0UAvrKOCLEh9AmbFlZa2stjpzuAJKorG.8yLHzE
 e._J6qHsMXMVxApzKCQIe18QpVw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 8 Feb 2023 22:15:32 +0000
Received: by hermes--production-gq1-655ddccc9-6nnrh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 33f8bed32976b0d5c4fc1b9d7d6ee4e0;
          Wed, 08 Feb 2023 22:15:27 +0000 (UTC)
Message-ID: <ca0a230c-7e4f-e8c7-1f7f-53c3b4017e2d@schaufler-ca.com>
Date:   Wed, 8 Feb 2023 14:15:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/14] Activate the configuration and build of the TSEM
 LSM.
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-15-greg@enjellic.com>
Content-Language: en-US
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230204050954.11583-15-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21161 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/3/2023 9:09 PM, Dr. Greg wrote:
> Complete the implementation by integrating the LSM into the
> configuration and kernel build infrastructure.
>
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  security/Kconfig       | 11 ++++++-----
>  security/Makefile      |  1 +
>  security/tsem/Kconfig  | 22 ++++++++++++++++++++++
>  security/tsem/Makefile |  2 ++
>  4 files changed, 31 insertions(+), 5 deletions(-)
>  create mode 100644 security/tsem/Kconfig
>  create mode 100644 security/tsem/Makefile
>
> diff --git a/security/Kconfig b/security/Kconfig
> index e6db09a779b7..98c538ad6790 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -207,6 +207,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/tsem/Kconfig"
>  
>  source "security/integrity/Kconfig"
>  
> @@ -246,11 +247,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf,tsem" 

Better check with the BPF team to see if they're OK with TSEM
following BPF in loading order.

> if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf,tsem" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf,tsem" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf,tsem" if DEFAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf,tsem"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..11d93885c806 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+= bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
> +obj-$(CONFIG_SECURITY_TSEM)		+= tsem/
>  
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> diff --git a/security/tsem/Kconfig b/security/tsem/Kconfig
> new file mode 100644
> index 000000000000..f9199686844a
> --- /dev/null
> +++ b/security/tsem/Kconfig
> @@ -0,0 +1,22 @@
> +config SECURITY_TSEM
> +	bool "Trusted Security Event Modeling"
> +	depends on SECURITY
> +	depends on NET && INET
> +	select SECURITY_NETWORK
> +	select SECURITYFS
> +	select CRYPTO
> +	select CRYPTO_SHA256
> +	select CRYPTO_HASH_INFO
> +	select TCG_TPM if HAS_IOMEM && !UML
> +	select TCG_TIS if TCG_TPM && X86
> +	select TCG_CRB if TCG_TPM && ACPI
> +	default n
> +	help
> +	  This option selects support for Trusted Security Event
> +	  Modeling (TSEM).  TSEM implements the ability to model
> +	  the security state of either the system at large or in a
> +	  restricted namespace on the basis of the LSM security
> +	  events and attributes that occur in the scope of the model.
> +	  The model may be implemented either in the kernel proper
> +	  or exported to an external Trusted Modeling Agent (TMA).
> +	  If you are unsure how to answer this question, answer N.
> diff --git a/security/tsem/Makefile b/security/tsem/Makefile
> new file mode 100644
> index 000000000000..d43cf2ae2142
> --- /dev/null
> +++ b/security/tsem/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_SECURITY_TSEM) := tsem.o model.o namespace.o map.o event.o fs.o \
> +	export.o trust.o
