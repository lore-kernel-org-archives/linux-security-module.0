Return-Path: <SRS0=0oss=4I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CFC11D25
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DFD208CD
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Feb 2020 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JCMzGAFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTXtM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:49:12 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:38280
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729298AbgBTXtM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Feb 2020 18:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582242549; bh=CRcoGR+7TT2iWC+J4y7IrLPQAmbJ1ZJvyReRX9V1uYw=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=JCMzGAFOYYe1Lq3eebmV1M4EINpFGAZjto7p39n7XG7bBgsSZSBJN1vSRdELFb+HQrWPapPl13ceAX/j4j/BYA6W6k06/q/FZGhMAX+63OQJdI3WLpNJ00EMuVQ+QffYkdCyIB3bNcvr16CAauGdpceRzMa4W/tOAh7M5QxLQv5eYoYiKIB1Y3RtfWpR1C+TfUxMl8WSTKOoxiS+PsRh6HirgzSLF7Lo9KCg4swBGYuOlyMm3rm3BGufsnyYCiSXi2+zZSR/Sh7p1/Ejgx91QIcHUbGzWnB5rxXl0hfnDLHfqB9WxPHGPNq23rUS4Esy7ISyv6r//r70oQir9vTNpQ==
X-YMail-OSG: iT12gWQVM1l4F5KkvgVVzansU8aL3TPmCaVZ3yawTYOfGcCBRKPYjZXB65u9pbJ
 VmeeawF41FzswC3ic8J_YGSQx5vPQRu9UXlDbkZCSwbFbQtDCoVZ77zxfeX6U4Fw0jCerYF2xJMB
 KMq7ec5UvE86f.9Si01eUam4vP.g1Jj9wWW0ACzU.1HoUf9hRBXxan6m0HcPpw1sV.Qp3G3l9cK_
 hF_diDgyOc7FEreBaOvX65bGvU6yWujq2vFnrjsh_kGCCGg0sYPDsoVob2ziMyOuoG9Qgna.rMwS
 oDa_V9vKL.FwpvP.UBDW04b7vSGUr23rBrg.4uOCqlAy1yp4XpMiM.ed_o2MUlqE8veEmfJY3.Ut
 vFX4454D56j2r2NKx7Vnw9MQQgLemlY918TqZzALyGr8HD78ON.1Q4aR4KLn6Tu7wmrcAnKxdFHv
 DLg1dO3xMJYaKa.b4Ww..ym2cghTmJHPMcyI0Bp7e9XD5W9COTJTIaY_ZOJUaEYxyhKpkSYou_cN
 FkL4pEECux2N5.JWQl.ysaVq2mWPMyB60B1RYm3nE1Pg5RRMcxTZbTJsk_Tb1q8PB3CxIJ.eVjee
 2vfgfBBl.PKL6mDhEWxR6GauoySEg16NmOp7tWNOjiFTraefEW5GOzr07V9cN98tyx6juoTZG8Bs
 ghTNw1FeMGxe6yyj45TeTj96Ivy6r2yKcZZDWH4szDWr7H._691hnydX49ffL_rbJWyMKcJyY1AM
 sFfFubxR7rCEEm9AXHvdXPc6Tu4FxJf6BptZCQTZ7OO1lxN5B1fcnZ8F7zc0NQFa2yqf0loU.GDR
 Y1GKYMaXdDU5CfGkAbM_Gbt4pr6.b9BuO35x09e4.LwBaYSaHjbcGna5ePcdQFSHWPKnVthgf6bE
 WZ2ReoA8X2ccH4vK7DTuyQPT1XKhcR2PilCsuIs4V852C2e__XNQPTYABMAoyXFwpuvMaM65EjAP
 nm_qOJ1dN6dqPMtIB8fYwCuL1Qp5XucgPfv6woy3SKtUD5fYqUyfxWrDzYbcM_syYjnjop2ykXnp
 L8VLFYPq7U5HwoC_OkCKZTsA4cn9YRA6ax.Cm4A2xwlsGDC6sMvztdSPia12H6aKR0U2FIwVy2On
 ZA.IqlgLkREB5HhuwkDvBeV.WMMk09XvhIP7XvmErofDb8WU69MmwbyqULIM_M_VNxgqqlZ.oouZ
 uCC0exAJzDXC6EMLl85HcvFR7.bMijDkYkW6Vkv33CCnF_DGF4IHsUQyJF3p9Wnv.FhEc1AhFoUe
 wwPuePCDosqiwN1gkYhJcGf49..vmJ3lR0o_5d34j0uM6I8Q4fV1LZBqY5H5jNnRxAA20WzfbdM3
 L5XOsY7lFRZHEvhvDoJY2ziuhfCOXFQ6ixNkA.2OQ.X4JmNxqnXKkFNiDnuuZA39CgxevgpDMgLy
 UkyRlldlnY4Smzk7iVev8YqJ.5BLeKeKJDR4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2020 23:49:09 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ce0b481e3b364af6d6326aa7d95a5f82;
          Thu, 20 Feb 2020 23:49:05 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
Date:   Thu, 20 Feb 2020 15:49:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220175250.10795-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/20/2020 9:52 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>

Sorry about the heavy list pruning - the original set
blows thunderbird up.

>
> The BPF LSM programs are implemented as fexit trampolines to avoid the
> overhead of retpolines. These programs cannot be attached to security_*=

> wrappers as there are quite a few security_* functions that do more tha=
n
> just calling the LSM callbacks.
>
> This was discussed on the lists in:
>
>   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.o=
rg/T/#m068becce588a0cdf01913f368a97aea4c62d8266
>
> Adding a NOP callback after all the static LSM callbacks are called has=

> the following benefits:
>
> - The BPF programs run at the right stage of the security_* wrappers.
> - They run after all the static LSM hooks allowed the operation,
>   therefore cannot allow an action that was already denied.

I still say that the special call-out to BPF is unnecessary.
I remain unconvinced by the arguments. You aren't doing anything
so special that the general mechanism won't work.

>
> There are some hooks which do not call call_int_hooks or
> call_void_hooks. It's not possible to call the bpf_lsm_* functions
> without checking if there is BPF LSM program attached to these hooks.
> This is added further in a subsequent patch. For now, these hooks are
> marked as NO_BPF (i.e. attachment of BPF programs is not possible).
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_lsm.h | 34 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 16 ++++++++++++++++
>  security/security.c     |  3 +++
>  3 files changed, 53 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..f867f72f6aa9
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright 2019 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_LSM_H
> +#define _LINUX_BPF_LSM_H
> +
> +#include <linux/bpf.h>
> +
> +#ifdef CONFIG_BPF_LSM
> +
> +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> +
> +#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...) bpf_lsm_##FUNC(__VA_ARGS__)
> +#define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) ({				\
> +	do {								\
> +		if (RC =3D=3D 0)						\
> +			RC =3D bpf_lsm_##FUNC(__VA_ARGS__);		\
> +	} while (0);							\
> +	RC;								\
> +})
> +
> +#else /* !CONFIG_BPF_LSM */
> +
> +#define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) (RC)
> +#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index affb6941622e..abc847c9b9a1 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,22 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook  that allows attachment of BPF programs, declare=
 a NOP
> + * function where a BPF program can be attached as an fexit trampoline=
=2E
> + */
> +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> +#define LSM_HOOK_int(NAME, ...) noinline int bpf_lsm_##NAME(__VA_ARGS_=
_)  \
> +{									  \
> +	return 0;							  \
> +}
> +
> +#define LSM_HOOK_void(NAME, ...) \
> +	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
> +
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> =20
>  const struct bpf_prog_ops lsm_prog_ops =3D {
>  };
> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..aa111392a700 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/bpf_lsm.h>
> =20
>  #define MAX_LSM_EVM_XATTR	2
> =20
> @@ -684,6 +685,7 @@ static void __init lsm_early_task(struct task_struc=
t *task)
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>  			P->hook.FUNC(__VA_ARGS__);		\
> +		RUN_BPF_LSM_VOID_PROGS(FUNC, __VA_ARGS__);	\

>  	} while (0)
> =20
>  #define call_int_hook(FUNC, IRC, ...) ({			\
> @@ -696,6 +698,7 @@ static void __init lsm_early_task(struct task_struc=
t *task)
>  			if (RC !=3D 0)				\
>  				break;				\
>  		}						\
> +		RC =3D RUN_BPF_LSM_INT_PROGS(RC, FUNC, __VA_ARGS__); \
>  	} while (0);						\
>  	RC;							\
>  })

