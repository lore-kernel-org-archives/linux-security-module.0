Return-Path: <SRS0=mR5W=EB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DCC4363A
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2319E24650
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Oct 2020 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Zfsez78r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785715AbgJZQUo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:20:44 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:41528
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775580AbgJZQUn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Oct 2020 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603729241; bh=JXz4y1SmwDW62HLmbboK5HMHkwIdbZK66iokQuERO68=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=Zfsez78rMRtzUkjmH/3jHVOf2J6LUL5OhnfwNVZjLjGxT+8AGyRfXsNyvsLehvpdxyRU5xmsMW4zt/VNrxEXrRMYBy9pkwbLnadsk3yVYE/WVVl9kw+wLS3f9de+ft4k8QM49RRvdHaBJZkxhESBZ7x7/X/H+uO1EmYwAnpvGLEuvVSXo74uGCCQJ+PM5hTVhnR0g3gnR5/LnTqq8ZjaLoZhMTRVaYPbKVp8CvijTsenLHofvZ6V5DH/6KmCBwh8frjDqSJMXL+ZcUinHPMIh5sZKz+n41AAyh7T9rkMxYfFttjqRkvSnJQIZmcYqC0gUsKgOqpFuBXjDje5TGRRLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603729241; bh=8nVBPpFtNgL7TZSiT7uqtycEEMoSXXwzH8vuL46Ebpq=; h=To:From:Subject:Date; b=bjbyO4Vvggu7B586L91KTFNy01a6SgbJC6htamR4N/ALoHqFRqEvEDGm4XbMqA0er4RpNxyve9gEDZ/sqiPSHmUlow/Msp+H5gKNnYBZAsM+hW/H7p/rtpr7hMd/oOAOS8uyinLYq29Bpl0/SSNx2AO0LbXY3WlPHqW+AkskgxhFSQXV4IXQ19pVhajZ/c3Ws6HZvWj1xFene6+Bgjua+NaFoqirxH227I7lY9HksePjCZ1V8UB/f+wi4xz3SRexQOFZgzlJvPLfj7NIlw15favuGYSRr4IWVBc/r+qZAW0mleD/RzjmVpK7hd3HdCxFFVjo+t8IkVit03FTNT4iqA==
X-YMail-OSG: 60uzVJoVM1mN7OxrAeku5tfzNDsW5qIPIlVd8Ymjjnt33_nkp_UJJg3mEfVXeel
 ReR2RP29pHvaDKljZHig7xPXBmUl8GAangYTOUKKShXlUlawrpBMOw5qqZkzOwuuycIltySQD.np
 BPbxSVB.3ZvESFRFD58okkm3OElH.bAjJ9bIorpq6zGXFpsQkNZeuW7EULcagGMdA39ndMQ3v5Gd
 sJbPal2Mk4fg.87AxezzE55LSyRK6d5h79IHAbf0Co9Tb14WRscoK4G6Z1Mx3yzmk3cWEE9qJtDn
 Ym8x4vlXuawHL4ZKJ.338J_p9iopxklT1oUqp.06Amm_IhGfuQW6lvPJWkGSFV_7NbAOZSDjxb5m
 cnmakABaSCnGqk6t7d.MFdo331fuUZLaBBUv1KEqVDlHaoAMcL7RDmh0c1Tg57FRPmvShlx6_qdc
 cnhCM3OHBafCTDROI8d5AMas7Epuq6x9YqyEQOgRZ1nrDOgEGx2MKEWT8fwR4YwFdtuscXMyIuOY
 ZhykLcrppg0yJDWCsV3rmuF_lMcZjQUxirroHFZqMvDJyAiPItsHFuHrcB8eIphZF92MH9oqJUwF
 60n2TiVyS.JIcZM3Pt74t3Q2rZ85Zktqy2DCTt5Jiwp4S9r7Bon5mpS30DJ99Y066.GO1bfPhs0p
 VLuIm0JY58Q..vOL5mdoVd9AgiSnKypg6NU7ZHI1f2boQB8aIOPJEZZhI6i7OO181C2dtgMizdFR
 cvXE8oWP3sjp5uFkM4n.MYQLRd2JKS3CMB3x5ljGznreWpgDuw_38l.kO5I0KGyWqyYzpSvEzuRG
 ayCa6RpAxbWihfyymujRJuZ064zA9p1A72HWMHJj_wu3rzQM_fLxGddyxVtFmFyGprTLBkS1cPSy
 RkKcVj4hKV3pAdGtwHyJSItN3S5tHeJD3OpRBfoXhGg9OHTcvzCJ3Zgh6BB.ZQYO5E3S5E9IjEGs
 TZwu7n0_CpLdz.OY5EU0vhPNlgpYAbgAJwS6ccDf7rSYh_QiGFp6zWOWu.A4QUnaUIwVmBS2x4b_
 Q6ghHBdxitPWGaXIrwWx27AG98LYlpVg.V_QFOp_embZYDMuwVWs0NCYVkmxIj0wbkT.Bj31sLku
 vvn7qof1.Cn3bfnGhGP5Nh79ushAyYGlK32x.30xgu2QcS3mqr.FPNmM5wXXXDw1EQtCy12tVdPB
 zmjq6.KCSDiN4_V16Q8mxW8BmzVu1nmnHNeqTFz.xS7VcqF7KHdLkjBhNIQcWG0zaTNJQW8BAuu6
 IkgTmH_29LL1X07OGWsnx4YAYUM5aXt03zFVNBjblxhZMh35LRdXnsylmO9I730R3N5E41iqE2iM
 zZ9aiD.9f5xiNLbTgQCv52nARtRf4qlG7vCaq.0oeeT4rmhApS099ZxzB1MVDJaCpc3ukZ9vm58y
 LTiofpqo3SmASL1UyvyUmu0LGDzx8g8KyRXOtZJSuhAuzojNvrVN_wg3W5qCfsHvC0.7VJp8tfh0
 cB59XY7v_ntgciLzG4bKf.irvudFbxt.J.XUlcYxrjrEFM6eCYpfgtg_RLvFV8mi9q1oCXG3jf1s
 MjHY6nqACTXyp3nC8Fr9QFSgKCf7tdq3l8iUyCjP8f8DFgvbODFo2UiA7SGWsM.YabPojYX9djPO
 DN_KKQByj1bPEnb1QZX06HahkNjMhPE9bahtcL9TpA5kMmphpD4XRj8rXqa6BMHtn3ifll.1hEE5
 S6YdbA2e2GggNmQJ2iqXXG0EUx.qCLEcfr7DehyV67qGLaxumzChvqQHzw8fvsTVbQgD24HxYClI
 C0Lu07b9dfwAgWXfIEJX5i4iF6vPwrfB8TaBna6rNXudXw7qISQL4P2BasSg.iV3tu5SaqJOgHLo
 1TMJuAXZAN.dzFx48Vqjh2xkUVdJ65bMp.tjdzfpBnoib5Deq79qaKCSVNhYF6b5stHM_98VCdhI
 _19_lgijtEwkpVSzamxDJCa9F_Lxf06aYsTJ3bLvgGPdAeq00dH6agLpTygDUZAe1xloxHkz4RJA
 .YTXIG56m6Dyd7moqiEl5eVerESIDhj1tvoqxsnuawiJE4TXOkHS3__qqSM.82TB_h.siPJ25ADM
 fKuHi.A7.7O0gUD7visAT4te6gBhrPEfIMze7rSJZsqoXVM90KjDpy4Y5B.TDSh4XSevRXkXxeVV
 yiaawf5JzlaqIi1gdCQBwi2KP.SLqmQFvPCF0NY0h_CXeWKJ4Rs2tGZc6Nx_Opvy0rJ.svTgssrX
 Zgqrw9ZHMO1yf0oOsuvdi3ybzJoUVKIn8d2dg8wEX62OERUo8GcVCfXXMMjsqRVr_Y1YKgKE.y1b
 TzYVPZc.TjMkWtxKSCwjj_o3tlmwdpiqWuVBPWZEthhGhOnOgTtvGKJ_rlN8Zs8oSmjpCHhf1pDp
 .MIC5bvxsmQM8muPfGMLhkRwD27qvQ.HfuGhsDO_lNzF7iUjaaxLfO0e_gTTbzLKaloMw65ditUT
 J1AAMKroMVOf4eacynfHYqsJ5NN3_5ZZ462_CTWyrcnReVJvF6.pBavoA6sHqj8O_29zpcJ1bGtz
 QvJdyWGEXmtECHCMqPDBE_im.neJapnYSdwwEGgXAb2kuFI3zQ9BBg7IyfOBk7VrTZTUOuiJKyop
 8dAvWQ.n2AtTcK.QDwRXDWP.3B1W6ijHIZY2eVBGVPuKma0urKxacKnSSB6TlhD4ieMF1d.kkM2m
 yWfJ2DVhs7b4hUW8qTGqmYVKDFCG5oKxpPIcpvvyxju1fTL0t5HJKrIL3P83JKPHzEesA0qdEAJj
 I1IZCbCywMyRwpwpvzolG1d50tRJQHM4NJbNEFa.O0EnXLmOCvoUVwKbvPEM4vBzrbHnpWRK18_C
 _qHNsMxqLJA46znnRhKP.I8CLxTKsa0x0Xqobqt4oJgRa3eVyYotXlR8gvBdtNbW_bDmfv6iwOzU
 lvB6ge_5KwaoZ5FeaTMvoHIYYl3RUL8tU9MMCEkuHW_aF7p5Qkitj4pp.Ht_NcgmmbRlm7PO7k.b
 Zw2olnCLkGpsWMIqrnYejJp5RF_GbY7RPLWPolN3Sw5nUyCLH5mD8paluvl5gRs5an0qu1_eSi4W
 k.A_WQZEsezD3CAoGjaG1mSXKpYZZSsx9nOIxllY1cuP3hcZNDEy6S_z6rkDQpb.qUiwtMKa1B5K
 5Ai.nf408h3z1qkdrjyfQ4JGh736JX0ceufis4lepVDcCQtWps77nOuoTLyJNabPwlET2EJq1eAN
 QYDQmfGjjAmpoosHeQ0CEWNmTant4oM.cDDHoXVlEBlOARqI9UWssAjXY5jzVyycCG_jDvCuyLk9
 aS_prbPjPyqIMkoN3QrN8eYHKJu_AGxaqMJ..xZpisqCLfHLl483DXY5_DMoM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Oct 2020 16:20:41 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 946c72bd1e01ade9952e8b88774b787c;
          Mon, 26 Oct 2020 16:20:39 +0000 (UTC)
To:     Aleksandr Nogikh <a.nogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, akinobu.mita@gmail.com
Cc:     andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        glider@google.com, keescook@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201026125227.54520-1-a.nogikh@gmail.com>
 <20201026125227.54520-2-a.nogikh@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v2 1/2] security: add fault injection capability
Message-ID: <c768f42a-1370-5b38-4f89-357744fd9d5a@schaufler-ca.com>
Date:   Mon, 26 Oct 2020 09:20:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201026125227.54520-2-a.nogikh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16868 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/26/2020 5:52 AM, Aleksandr Nogikh wrote:
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Add a fault injection capability to call_int_hook macro. This will
> facilitate testing of fault tolerance of the code that invokes
> security hooks as well as the fault tolerance of the LSM
> implementations themselves.
>
> Add a KConfig option (CONFIG_FAIL_LSM_HOOKS) that controls whether the
> capability is enabled. In order to enable configuration from the user
> space, add the standard debugfs entries for fault injection (if
> CONFIG_FAULT_INJECTION_DEBUG_FS is enabled).
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
> v2:
> - Renamed should_fail_lsm_hook() to should_fail_lsm_hook().
> ---
>  lib/Kconfig.debug   |  6 +++++
>  security/security.c | 53 ++++++++++++++++++++++++++++++++++++++++++---=

>  2 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 537cf3c2937d..80d289591e29 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1803,6 +1803,12 @@ config FAIL_MAKE_REQUEST
>  	help
>  	  Provide fault-injection capability for disk IO.
> =20
> +config FAIL_LSM_HOOKS
> +	bool "Fault-injection capability for LSM hooks"
> +	depends on FAULT_INJECTION
> +	help
> +	  Provide fault-injection capability for LSM hooks.
> +
>  config FAIL_IO_TIMEOUT
>  	bool "Fault-injection capability for faking disk interrupts"
>  	depends on FAULT_INJECTION && BLOCK
> diff --git a/security/security.c b/security/security.c
> index 69ff6e2e2cd4..1105ad0f6891 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/fault-inject.h>
>  #include <net/flow.h>
> =20
>  #define MAX_LSM_EVM_XATTR	2
> @@ -669,6 +670,51 @@ static void __init lsm_early_task(struct task_stru=
ct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
> =20
> +
> +#ifdef CONFIG_FAIL_LSM_HOOKS
> +
> +static struct {
> +	struct fault_attr attr;
> +	int retval;
> +} fail_lsm_hooks =3D {
> +	.attr =3D FAULT_ATTR_INITIALIZER,
> +	.retval =3D -EACCES
> +};
> +
> +static int __init setup_fail_lsm_hooks(char *str)
> +{
> +	return setup_fault_attr(&fail_lsm_hooks.attr, str);
> +}
> +__setup("fail_lsm_hooks=3D", setup_fail_lsm_hooks);
> +
> +static int lsm_hooks_inject_fail(void)
> +{
> +	return should_fail(&fail_lsm_hooks.attr, 1) ? fail_lsm_hooks.retval :=
 0;
> +}
> +
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +
> +static int __init fail_lsm_hooks_debugfs(void)
> +{
> +	umode_t mode =3D S_IFREG | 0600;
> +	struct dentry *dir;
> +
> +	dir =3D fault_create_debugfs_attr("fail_lsm_hooks", NULL,
> +					&fail_lsm_hooks.attr);
> +	debugfs_create_u32("retval", mode, dir, &fail_lsm_hooks.retval);
> +	return 0;
> +}
> +
> +late_initcall(fail_lsm_hooks_debugfs);
> +
> +#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
> +
> +#else
> +
> +static inline int lsm_hooks_inject_fail(void) { return 0; }
> +
> +#endif /* CONFIG_FAIL_LSM_HOOKS */
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs=
=2Eh and
>   * can be accessed with:
> @@ -707,16 +753,17 @@ static void __init lsm_early_task(struct task_str=
uct *task)
>  	} while (0)
> =20
>  #define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC =3D IRC;						\
> -	do {							\
> +	int RC =3D lsm_hooks_inject_fail();			\
> +	if (RC =3D=3D 0) {								\

Injecting the failure here will prevent the loaded LSM hooks from
being called.

>  		struct security_hook_list *P;			\
> +		RC =3D IRC;								\
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>  			RC =3D P->hook.FUNC(__VA_ARGS__);		\
>  			if (RC !=3D 0)				\
>  				break;				\
>  		}						\
> -	} while (0);						\
> +	}							\

Injecting the failure here would allow the loaded LSM hooks to
be called. It shouldn't make a difference, but hooks with side-effects
are always possible. I don't have an issue either way.

>  	RC;							\
>  })
> =20

