Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D04C48BCF
	for <linux-security-module@archiver.kernel.org>; Sun, 13 Jun 2021 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223E361153
	for <linux-security-module@archiver.kernel.org>; Sun, 13 Jun 2021 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFMR1I (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 13 Jun 2021 13:27:08 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43483
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231915AbhFMR1H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 13 Jun 2021 13:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623605106; bh=DLuPs7ftfr4ZowcqzSHhvL6aPTCxobhVLAv5UcbHEsc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dMVFdG/2AZ0i421D91SfJPAXD2inwouX6csJXSWVMmq1PtF4rB4v/fLysPp6zCbNmXD4bQ/Au4lHhlNcio4CVGVWJAOGe0LcHM76iGEmdVw+1q87pbcSJsgkDmO5MujZi7mrddeCmapS9vvaKj5HGqStjn0Au7kOSVoZ1/t7WMdAF4riH2fcFYIXP7BSnXiOY1S+OCD9kjGeaHxAbPkg6lFSS8XBFa2ecJSVUVo36TD329BZGxWI6nh5K6f+KAkcBbDWlwBBQHz3qYcfrudP9YgflI06l0SU1+awzkKj9noCr8WASGr9vEQyW0eEKl8jROJFCmR+0N6bXyVKpwKx6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623605106; bh=3GjYIAqUAsJ6b4mFFNXPtdNdfNMd0ODCWgBiIKS0uEc=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=db5oNXAFCrXyGjsx8WeO54FgGWJKItdan3HrPMm020tyZRA0HNo6sbqAVo5lEqONG3RkzyHivET2P6eYO96vbzGTJ6DnrDLo8/Ny7qgML1sbw7cP0dQSpeTgZT87ve4tOCyFgs8wffPBLVcX4ckosjErdMre3h//xkO/K8QEfZExUmYWE/893KACmFsbR2JVPYBqNGH83/2lVhuYDVa5CNJBMNYah6IAf9GKJpGhVLIJYelcC6wA05ZgueN2OvcFu57sLUnBjWy5uMzTHc2Gz6EwgIwT9kVs8ylLf3uX6aVI56GTVzJf8qyBkdHxODOBRYzgM06YlveC5Ym33jHjrQ==
X-YMail-OSG: umy4OcsVM1n19Gipb48XkXGJfzCQR5sEoBjS.5bcu9CVMLKWCw2iG8ZGZxqWaF4
 eE6Nn__xe3ua.GB6xd55CK_K19XlaVaBjnweJhQPvrLWskt6JFdlvBR8SvBInlJBwcZEOzfNcwOf
 OvIAgvHwj0jWW6AdfRmN_GNTLfFBPV5vwUcHuObmYOG2Lg4Umm7fF5VyGXGxaBICUNSSFu.qX2eu
 yAmL6HRl8Y9lsZNaMQR7duhck2YAXT21pIdZZ7HE8MBfrWoIhBWIubi1ljivyk3XIhGwCi259EJu
 iJnZZ2jX9LKT3jfSs57eS4jAmw8iDao.yy4OH8WPoHs0Y3i5.Qf_ZQK8kFEImyfAQbrYZ6MJ0nkY
 oTWpr0XBL.Etyp6BI7TSXrlVkkYGiqI9S97KwSusAC5fEAKiR5s0Zjyhfa2IKcFKtTzhZtWspnOK
 oWTfFBXEaPFWh6SVPpuyK5g0Qr7Ec722Duy2GvvTFn0jqppFm5dxY5hEs0Lop5nTVmHz4iof2uNg
 ATWiYBBqO11VC.UOyx4posYRPLBlTDP0PdrlTKTL1bj16F2E8c7LpEug5H.Kdz9DpjKeKc.BHhvv
 tOPfLOWM4xuUEq8jKUecHFmqTIi0ifrQ4BFXVAZHijxI1FI9yYNyNpm.laSV.3kFmlts6XzNqoaN
 ynOOAxAiKc93BRki5DqONFMcmI4lUrK4zn1a3lU2CSOSDzBuXBMi1cMwXZoLOceuCEEFWmvnPNMq
 KCAoffouH2QUV3ZH31_61w0u6oE0blJiqcqok3znh5mRwsy5N_7Pz8oTYbpM1XRrI7DMT8Fz_LNi
 7x_uJkxPQTizV.5I5ROhSx4Ky3lToIC2luDnu8vxQK4iZOI5uW1Vyy23s04rpLhWAPQaOXKoltNI
 4Da.4.ITl7oWuTagA7XxPrZyKOyYRTDD9T4Dl0RcYUlWldZeUCZIbQeUbueLL2zlYB17LCchZJ7Z
 _5Vhf0YJPWhBt1IQ3kL00AsYmYR7pFD7Z47pKQdnTv7lq9H49g6Hy2_rcP7U1aF7u10I1sjKF54f
 .jiZmGRHttB7aUM8ger164tcjjit1IR3pfPYke3htsrEB9s26NXm2xz8BtrmbpzH6CILzGz49csY
 jDHdtaABG6aEmTYctZj2XtzHegQ4SWMXW.4ArnC7WIScZiXv629I2R6ol.ivYUPQUVJSaOehWJnO
 8AZwR89q.tSdCh9eueC4QDL7DDBVz8b6H9Bq0TU9KKtT8aknF1nbRpErnBCdjVRofLfLfEUqHNjG
 wH0Lz_4oisn3hgskBHTG.LrN.4RXiAJUGMd0r5bIAxzyo95FjthTwvBxSwoB0AIh2Q0y_TfMcg0g
 pow3abGk16Y4tw_3naLL1UGqkwOFbOEyiDLxAtfti6g6gnzX4fv8ZVacjoLLeEvF7FymnwoSZTf0
 s6llQoxYezO0bhQFQv7_UyN4yWKG..zc9NRXpsy6YMAWQxvLkyXyhYexxrO7PDP0o3VmmGrne.4Q
 ryErwcGvl7HL3XE5VaAvpFDQaIyMVO7t7SrtnNfxTVCVYJ8UgU69TfNMopmKzMdIHgP7ifcvlQ4I
 1nQey7nJlRD3YgnpSpqTapIrUkaUiKObZfomM_KciOHh5etdPF6O.Jl2z6mi4lfcI9w1SopL3Qfu
 t8TImf4FRava6_QSeIga2Nvk1hpSlZOdo4akMQBvnuggpL6V3LshKq.VKyobIxenQwTgueLFwoGT
 rRg0EVt49QjvM6ZXoldlEqxQU0eFeQTNbrtoJ.oume.Jx_dzD3XNVdUVGlgPnNwsFGk298ru2JyM
 zfGRjkli8PUShigx58bBM5tjFSEXeL07RIuKvrnrcK_gqbs74J.ruGO0T1AfndZ7w8H6MeHZuteE
 5SXXfmCPcDXekwyZYB6lxB1Kx5e5VwsoNeUOBGfGitRmAAZBAw_zWYfHkNqkYEc_I7ryyCb4zpX9
 ratM8iPqLjE4hMtuUnMytjVpnGC8ddruJS_dTG3AEgz4LKqYrjro_mvpEl23ON.TKhDhyiRDlH3x
 orBMmc1QvviDXkFYl6FK2puEmVynfaR.PaoiXuOWrGV_nwbvsmnTEyED6JFn90oVn1gcPMPgKQDR
 CbeWZt7PMghrSU3D_MQWTzIZZ9dFJhSTN.6G8V8rFFCmovzRfpY3E.l244G4BUzmfc8dwaqEUdDX
 .QfOTinLhfJP80.oPY4huw0DwxWLciX2a_.EiBAL_.oRaBEW8vfm3u.7NzcGm_w467s0hmiX1vgI
 kIq2CqkgiMH2kcd7p_x_3uT1F83W8iba6HC04IyNxmNg4_IY6F6xrxdTbd4eBCnqiKQhPF_u7JBQ
 fSBkglak.m_zTECL5Wntv7lX5ruAvg6z2QfsveshHRucYlIN_HSJ3836VniBLgByTrb0lOzdIUuJ
 fiel0l9i1BFlSm9XnqmIgzzSNSftMvFSYQJJ4iHfbi7drFZ8QoGkg70FVGZ3gmIMaTlR4kkR6Q4t
 4BgiKhdqgZ0c2bYFJRnXEtr8GzwZ_Fc0OzhuQZU0TdDz_4All2Ue6NoEQAujASa.JzScD55qZrc8
 KS9ZSOp3LyviOFKh_O8v_WqA8uy4r1vbSqPTNCzIfIClEerr0F2AWoHWrf6yYvjeCD7nXS2KZb9W
 J59xaT1bc1rWlsuVC2uv8z5r8ZoRxW_WezsLNEOL8LQnzoC5x5nXvJUPuBgeztaIXjbX7s1G_PTB
 JXJ679D.G.w0cPhNRl76aSTSxEj3gFjjQXb.3dvLK5GG0vPtpIANNwDPWh1pGZB50_ZStUUS2uvA
 jmD_Ir_GRI6bI8YfQ_c07kYPTwP2ImRJmVurlsjyEVKEFACTisfecR0RwP8_fR91.CO3S5NEYG7r
 kRul2X1NSloq0Okg_2e5nuYFzkg291If_njwycTTJKrBOudvJcYyb8CNZX62E3AvCP3tQNKtamWy
 opm6X4IIfIJeF4yPSvN6U28LbHMThpQQJsHzI.SHb
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sun, 13 Jun 2021 17:25:06 +0000
Received: by kubenode528.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a03e59b121b5e90ed39505ff4a18b473;
          Sun, 13 Jun 2021 17:25:02 +0000 (UTC)
Subject: Re: [PATCH] security: add LSM hook at the memfd_create point
To:     Li Qiang <liq3ea@163.com>, akpm@linux-foundation.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        paul@paul-moore.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, liq3ea@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210613064359.389683-1-liq3ea@163.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0661e74b-9b2d-6752-8251-79988e3b735a@schaufler-ca.com>
Date:   Sun, 13 Jun 2021 10:25:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210613064359.389683-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/12/2021 11:43 PM, Li Qiang wrote:
> memfd_create is often used in the fileless attack.
> Let's create a LSM hook so that we can detect and prevent
> anonymous file creation.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

We don't add LSM hooks on speculation. Resubmit when you have
an LSM that needs the hook.

> ---
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/lsm_hooks.h     |  5 +++++
>  include/linux/security.h      | 15 +++++++++++++++
>  mm/memfd.c                    |  6 ++++++
>  security/security.c           |  7 +++++++
>  5 files changed, 37 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 04c01794de83..955556d0d084 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -403,3 +403,7 @@ LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
>  LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
>  LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
>  #endif /* CONFIG_PERF_EVENTS */
> +
> +#ifdef CONFIG_MEMFD_CREATE
> +LSM_HOOK(int, 0, memfd_create, const char *name, unsigned int flags)
> +#endif /* CONFIG_MEMFD_CREATE */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 5c4c5c0602cb..e9c31dbb2783 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1557,6 +1557,11 @@
>   * 	Read perf_event security info if allowed.
>   * @perf_event_write:
>   * 	Write perf_event security info if allowed.
> + *
> + * Security hooks for anonymous file
> + *
> + * @memfd_create:
> + *	Check whether anonymous file creation is allowed
>   */
>  union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 06f7c50ce77f..44b43a7569b5 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2037,4 +2037,19 @@ static inline int security_perf_event_write(struct perf_event *event)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_PERF_EVENTS */
>  
> +#ifdef CONFIG_MEMFD_CREATE
> +#ifdef CONFIG_SECURITY
> +
> +extern int security_memfd_create(const char *name, unsigned int flags);
> +
> +#else
> +
> +static inline int security_memfd_create(const char *name, unsigned int flags)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_SECURITY */
> +#endif /* CONFIG_MEMFD_CREATE */
> +
>  #endif /* ! __LINUX_SECURITY_H */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 2647c898990c..dbd309e455d2 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -18,6 +18,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/memfd.h>
> +#include <linux/security.h>
>  #include <uapi/linux/memfd.h>
>  
>  /*
> @@ -290,6 +291,11 @@ SYSCALL_DEFINE2(memfd_create,
>  		goto err_name;
>  	}
>  
> +	if (security_memfd_create(name, flags)) {
> +		error = -EPERM;
> +		goto err_name;
> +	}
> +
>  	fd = get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
>  	if (fd < 0) {
>  		error = fd;
> diff --git a/security/security.c b/security/security.c
> index b38155b2de83..5723408c5d0b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2624,3 +2624,10 @@ int security_perf_event_write(struct perf_event *event)
>  	return call_int_hook(perf_event_write, 0, event);
>  }
>  #endif /* CONFIG_PERF_EVENTS */
> +
> +#ifdef CONFIG_MEMFD_CREATE
> +int security_memfd_create(const char *name, unsigned int flags)
> +{
> +	return call_int_hook(memfd_create, 0, name, flags);
> +}
> +#endif /* CONFIG_MEMFD_CREATE */
