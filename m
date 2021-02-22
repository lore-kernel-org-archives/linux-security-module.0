Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23050C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D972F64F04
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 16:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBVQw6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:52:58 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:33469
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhBVQwz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 11:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614012728; bh=GHEJp+l5Sm051cmDlRcixOhX3PsUeZfZCgvBk2MPgcU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=uPlthhmvJJbr4+hIJgNj5pErVIH7Na/hJ+NGu/Sv7RiNq1Qq92vn9+1egCd/ED8N28M1iVXArfq3nttpyLgAQ+abCG78CLa9Fnu1vOddai7w0mGBhGIrRHYo8/k3ETuRNYYUf7QdQzf2Yw3Eo6sTVjAhstrVJLPMrsAGG3umBh/K8fj3FMyvq9SqvDgiEzkMY57OgnJBaBBeIauVv6/b8p2nZNoMAtiuBZ0M1d117xD2eExW6NOS35e4D0XMQUfeEB1JWtMOCemmTuUySdLLBawZteP6i3H/7ZEohEMD2HXnJ++c7uf3ADn8QKBdxY6uW8+ipf4RNiUYsG5O59eRdQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614012728; bh=dSdbTimGn20V1VAtwlMI45proqUMFLSwsyAC09fL01X=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=hsEhNYabCmrqOjJRA+dlsittD2RM4xG33RW7WVa52KxmcbvHF4o82/QH/9NXX88l0PXBMSI6Cql/oCCzFPkVHhlvoJ8uE/1z4Pc1Fn94G+ZnXYzWpXQreHa33hW2w/i+NFPE72yDpaGR53TfO6J1KkdJxJO3h5MxSevi3riPVZGO8FrUkwk375ajLa4oG5F/+aw4lFkYd52k3QXCRj8/iNf/kSVj17BZmxhHsqeMQA1mKCQDBbK07psStWuNDjXcyyCu3/UeiP1xneGmCxpGrYY0Uz3erue/cNv21+W1U/PQL76MpKZo3tyIyv6A3PMUwymSinyVUsdZGN5OOGlBeg==
X-YMail-OSG: 1roy8AsVM1nQu1RbPNX2ZibfRqLd65iJ9A.xTHq5AeKA1Kz0ocFNNYOHIR6WfwG
 lwEhShGZWOVs5ZBXWJyfMqpeC9iTEGtbrSnScZ4Gd1nN.JpJzVXactH_VAlbOOITkXUjVrWI4.7_
 zx5EN78HlpQ286N9tVcCzGeGz7Tfd0XOM7FsgzS9hIaVDdOhfpKVVE05hk5H7GmyPoQ6j9pk_Gbn
 MgvdjkM1K_y5szyJi7NL0wj_sZpSErdD7O1P3iUB8JFdBY7hMJjWR0DXhSL0VEbOpraNv8uMEbfG
 nCNVPITXnaQyUXrQnM069MVhMta_xl2f.eTFMbb_DlyFfhmmzcnxOm_Nye7HRGWALq2JT6IStLgC
 Zr_trqyCTc0qb2apXeuktaOUDbLYcD7LCs1jpbKZ7RBSfc_0ujyZCZOxSs0Xf_bTeZ0LlCH_GdmK
 2f7J47jbCXvubDYUENq0QhtSvoQ9XhveZCig6j8Tm_kjhrGlf5IPmaX8ZG9U0ZCAeWZj.vvEfud3
 oIRZSCbbCI_bjl4KUr6006.tFtulgTLim4EC8IPS_Rqb1XWYicUZMDfSUizsKHgKY0AXrg6BK_Ej
 4Rn0Soau3ya_Qv0Ah84aXX08U0aAwM6Pwsspel4qj4v4FX8Zvp8AxNBMWwW5g.O0borJv6HS.4R8
 R0aSWhMw0tJEaGx5vQeoQY2F3k1fYiY6rxrPaH8HT0IOlxaEu.TNZ0csQuPaCbVeWCTfDtyFXvS8
 19eQX66oO9VVEYuc6As.cbQHh1KHWBKMOX_N2Ao2RmGK9r5K.6zfFK7Nu7ti3ZM7CNYfyEXsZqaO
 5NQ0zJjcL.TWMLEN9S_Bg8__LDFgQX2CqhUkGujn71.49IfSySTSanguS2rYP4o1t5eijA_SU_Ol
 0znzX9K9Tc_GZpNPQ_GtdmemDcTADKdAR0cTRBNs5yu62YVJHwzSRIifzDM_wqT5lbdeSIjx1ANN
 iipMasmas4uF7ZmTq1lHrOKXAO_M7mU6oke_qxqg6Co9Lwft.txFEcDuogwSp5o13dGgDlhKfD3j
 Eyb.QpxIBArfYPvHQr1nZX8mtw2p6SmaTWHvVMBw6a2JexrQv_MBskaMyYuqLocXqek1tv9yC_5q
 OUMAdeEiraCSoZifl8RqetGIy3iuyAtTbfQmFKOhGnNSeAjcy9ctjtwUBRx3h2FuIk6lBD8GKRqT
 HZaEhCnGvGGU9GXo6E.UizKW7vr6JyZ7QbPEWPPKhxF_UPcPefiSukewi2tUfoOYeMzfUV7VVyOa
 A5B8xyr5OKnHuVfQbzTrbVHj0x1WvenZdRDJkBnM_jMYXhjFMwUy3JVtSCLpxsMCUPztq4GMiU1x
 RT59NHtKPmh377H4qvpzV_OoceEApnk6.get2pbVPcxmJsCmb6JkPGKkcNHmSI1NbaJQ8jjlutQu
 9juoqS.Qm1A_nLkfKdxTppA68pDGZpv_PhVWLId0jozqnkjMpD1U.IZajdLJi.AZpX3fBipcQNnt
 SwliKcswSAPLeYCJHyLWcWHo913QnYx5cqWbyo.GJeqOZm_WnGZsG2jcNDF_5CZxA4pN2BA9.07C
 _4D.LZbViObXeRbeYk1NCRJbVQi46dDjmMtNOyIyDOM22Rz7sDVFCB4Vb3QMy4WwyooxvA.cOjFn
 0RDlKe.jsm3Y7bzDOsHLIuUy3EmFS8KDMrrMeBcSBlv14Ptci7vWc98ymwPIcGAwjRu975CTpqwl
 2Rwi4YRrebBOHqli4rMWM7XIJoZXgNpKJfUJNpk9.YB9odYijmBSjK6la5jHb9QRtTSbu73cvobY
 z_cV6qnKbLGiPUuIloTIlbrZgD7vL14lCnGna24Z73Nd0iEG3KV58TeZbqN_HM8sujH0bngpR_aO
 k_jtKt0GUvdt_x3OsFxAJNOczy6MkZI9TQJh_wxsrU7WlqRMmyhzs8fy_5rkTaNkVgSrFQYc19Zf
 1sfl7yAYnfGV_T6WSAGz2Q9P.FHMXdOhgDE5X32ok1octo0PdFS718C_m6kY.ieC7S9vznRi_QWv
 gUVTSxiFHYqYEVlTtvQ1uGwwNqTYu7Y3wj5d5QC63.3cXpTzPqI76ooq4mVFpQO9vkC3_yrH0puN
 ARIkX9qek_Py5oNSstNlALB.Ag2dIDLUSNgcSmxF94QInheUT6xZ62ymp0f2rvmBEwM2vlgL0dY1
 6JaSFG2jKBv.fjOjjOd4qDuOKQxYnmXrfryx2ARp5nckNv7N4MK3aoE6odpuykrXf.ZVsR.JvGmq
 T9hoYlikUQ4e2_rrHtoNwBu0wKkkr7kv.G816PsGtIPdq0Q3XKrvINpm8SYd6RjUI9rw7_A_wGZm
 fBwPACPmnokTkBbWfXpss63Ch2NYTG_TSUOKy7cU5RqKJ_Ck9.UG8rVQ.hcjZ7fJ8OuHKdtvDCgf
 _vFspw_06ql5MhLT69zgdpcuwTJXX59bfAgBQQYd73v6yolfu08ZyeM_sS0g96F6TP.zUFRiRXg2
 kiJY2wuoy1TpK4rWZgl1enM6BKzM58SkzD0NKOUrvN_9GWV2oAJuZXa24JbKk7uN37A3tW5_1apY
 cggcfVzyWyiTBSgwj_1W28hgVj3cviqeFRWeT.tqbqy8tugAieGuUj17NjwXQvvLEWcAGOFWwwlT
 .7oIjssyTnIpMevC6BGtLNu_ijulH5ODmOa3zlENXJ82GSVlaYk3igcPAF32QZo35f0DIcbqy7bK
 j0zaM9S.qYVduQqpybD610P9UsTldKAAomIBRY5Cm_151aAJXi1i8Vh6SuWmfkcMvky4rfgPvr6a
 TW2F_uX.yoN63_a40MIDIy27Z2CwMjpSghMqchttxRQVzXSv4_uV02vHTCIlMt0qV2tCjVNc_enl
 vH5dI.alFr2id_0nanfvnOPVo1miHtaoA0h0mTlfzEdJx4ysOIJ6bQ5AML2N6VSQ2qSDLD..pM3T
 OU0m8gLR3geEbF28Sq017yg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Feb 2021 16:52:08 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d2c841c384566721a026918cf0385760;
          Mon, 22 Feb 2021 16:52:03 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
Date:   Mon, 22 Feb 2021 08:51:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222150608.808146-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/22/2021 7:06 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Add a new option CONFIG_LSM_AUTO to enable users to delegate default LS=
M
> stacking order to kernel developers.  This enable to keep a consistent
> order of enabled LSM when changing the LSM selection, especially when a=

> new LSM is added to the kernel.

TL;DR - NAK

Do you think that we might have considered this when stacking was
introduced? Did you even consider the implications before sending
the patch? This only makes any sense if you want to compile in
AppArmor and/or Smack but always use SELinux. The existing Kconfig
model handles that perfectly well. Also, this will break when the
next phase of module stacking comes in, and all of a sudden
systems will automatically get AppArmor in addition to SELinux
or Smack.

I know that the CONFIG_LSM/lsm=3D mechanism is clumsy. But we spent
about a year discussing, proposing and implementing alternatives,
and if there's a better mechanism, we couldn't find it. Of course
we considered "just use the kernel order". It doesn't work for
generic kernels. I understand that adding a new LSM that you want
to be included by default is a tough problem. I also suggest
that silently adding an LSM to an existing configuration is likely
to violate the principle of least astonishment.

>
> CONFIG_LSM depends on !CONFIG_LSM_AUTO, which is backward compatible an=
d
> gives the opportunity to users to select CONFIG_LSM_AUTO with a make
> oldconfig.
>
> CONFIG_LSM and CONFIG_LSM_AUTO depend on CONFIG_SECURITY, which makes
> sense because an LSM depends on the security framework.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210222150608.808146-2-mic@digikod.net=

> ---
>
> Changes since v2:
> * Revamp without virtual dependencies but a new option to automatically=

>   enable all selected LSMs.
>
> Changes since v1:
> * Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
>   error when building without any LSMs.
> ---
>  security/Kconfig    | 19 +++++++++++++++++++
>  security/security.c | 26 +++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..fae083e9867d 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -243,6 +243,7 @@ source "security/integrity/Kconfig"
> =20
>  choice
>  	prompt "First legacy 'major LSM' to be initialized"
> +	depends on SECURITY
>  	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
>  	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
>  	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> @@ -275,8 +276,26 @@ choice
> =20
>  endchoice
> =20
> +config LSM_AUTO
> +	bool "Automatically enable all selected LSMs at boot"
> +	depends on SECURITY
> +	default y
> +	help
> +	  This automatically configure the build-time selected LSMs to be
> +	  enabled at boot unless the "lsm=3D" parameter is provided.
> +
> +	  If this option is not selected, it will be required to configure an=
d
> +	  maintained a static list of enabled LSMs that may become inconsiste=
nt
> +	  with future user configuration.  Indeed, this list will not be
> +	  automatically upgraded when selecting a new (future) LSM, e.g. with=

> +	  make oldconfig.
> +
> +	  If you are unsure how to answer this question, answer Y.
> +
> +# This lists should be synchronized with LSM_ORDER defined in security=
/security.c .
>  config LSM
>  	string "Ordered list of enabled LSMs"
> +	depends on SECURITY && !LSM_AUTO
>  	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomo=
yo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
>  	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,s=
mack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
>  	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEF=
AULT_SECURITY_TOMOYO
> diff --git a/security/security.c b/security/security.c
> index 401663b5b70e..defa1d2c40a3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -82,7 +82,31 @@ static struct lsm_blob_sizes blob_sizes __lsm_ro_aft=
er_init;
>  static __initdata const char *chosen_lsm_order;
>  static __initdata const char *chosen_major_lsm;
> =20
> -static __initconst const char * const builtin_lsm_order =3D CONFIG_LSM=
;
> +#ifdef CONFIG_LSM
> +#define LSM_ORDER	CONFIG_LSM
> +#else
> +
> +/*
> + * This lists should be synchronized with the default values of CONFIG=
_LSM
> + * defined in security/Kconfig .
> + */
> +#define LSM_ORDER_PRE	"lockdown,yama,loadpin,safesetid,integrity,"
> +
> +#if defined(CONFIG_DEFAULT_SECURITY_SMACK)
> +#define LSM_ORDER	LSM_ORDER_PRE "smack,selinux,tomoyo,apparmor,bpf"
> +#elif defined(CONFIG_DEFAULT_SECURITY_APPARMOR)
> +#define LSM_ORDER	LSM_ORDER_PRE "apparmor,selinux,smack,tomoyo,bpf"
> +#elif defined(CONFIG_DEFAULT_SECURITY_TOMOYO)
> +#define LSM_ORDER	LSM_ORDER_PRE "tomoyo,bpf"
> +#elif defined(CONFIG_DEFAULT_SECURITY_DAC)
> +#define LSM_ORDER	LSM_ORDER_PRE "bpf"
> +#else
> +#define LSM_ORDER	LSM_ORDER_PRE "selinux,smack,tomoyo,apparmor,bpf"
> +#endif
> +
> +#endif /* CONFIG_LSM */
> +
> +static __initconst const char * const builtin_lsm_order =3D LSM_ORDER;=

> =20
>  /* Ordered list of LSMs to initialize. */
>  static __initdata struct lsm_info **ordered_lsms;

