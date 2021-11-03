Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D6C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A0360F39
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 16:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhKCQDp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:03:45 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:39679
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232495AbhKCQDo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 12:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635955267; bh=ez72d6VR8oS1WYl73ilfBW46j/lX6BB50JuEfp8ISU4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SVFrf81iRQ20qvf5cqSQYU8pCRFBRonhFzV4oOhsfCuXzQFyDN78UhQeSQxMIjNT6jqc8ky/bQsyto+scKjVbO3vqJ+DEoURyfEHG7bBNH6pvg4GlJTpbW6xk1yBt/uFK6NSglajbry2lAF5vKGKUTynd3rpHs+cZqaKnBcL0KSAbSuccPvjH/nsQsqjeULaQYA4dEuNJSQzsQbpi+YoawJECn2C4hAkCjcfoRmY8FPL75mzUmpMJFGogHoW8AfLEoywAgjZfJflP/mLsb7fpazjSQe1X89CtilFnpi1/mDN73fsHLngcFYeCzvay4Tr5StdiNkcGVrhPnZSBroo4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635955267; bh=XTIxGnpjm14zteDjpGCuWjtglidRjI9RrUDPf4PATt6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=e/DwjbaANsxzTM8/sJpzQdXB5pcKeSDIYtJ+1xjHpqvQP8W9PLc7GuD7pqjd7js4JtksyYGSg5FWIOpH8hARyp6xJfG4niotI+98toSgaoU7jR5J4GdsS1+lkYr1AghrUMCxT2ZryZID8pqKBD+6ecwtR/bk26jgIWKhrll6Qw5dBAvtPJJVHGnENMoO0PoLDl/nC60vZFjo75uFS6AeoZbyhXCeubNgI8SNIn2rIpp3R84dhuXCy9zQq33gLjXE2UtfNfmz2B71O7JyOlz8OjSpKcpdEdmFIrn3JferfNzNLochjGs0QbL4XhTG5Fu+YsKgh9mjsVv9L/qiODcYug==
X-YMail-OSG: WAkYTMEVM1lgqzEpzgDMsHalwVg5QolGjdrLFdHsu_G.0vNyt5TklZWw6AvGZ05
 MgwhRLON73s3FTohvvpQRoFk7OVtDhlBzZty6Nv5vE7GnnNn2C1UiHBhvXhi.9cv7_l4UoLGL6qe
 cnEqRP.AFiOnFZGtLDLn6wPuuP4bk4tjk45duBL9P1IboAwBX7pvDAu.xejEKeej.ScJJ8lpXxyX
 VcrOR4ZFWXww8sGxkoNUnF.MsA2s_Zr2DwYOQ6erYTIFUhqDK70yrm9eWlB0md1bGcUoKizJieJh
 v9BwzE.2ZDdhsSHet7nFweAMKAznUk.EKoXvUEejpnauWDDvsRaGN8kr0gtIYtFQ6eYKg4S79Bu_
 wAdbgkHGOzSDo8YhjPY0bS1CUm6EIqNXVWIaOtg0lTjRzWdtRo4xQA3XlbpGjxOpKj9AbqUc67X3
 k3erh.sUZ2lUA.BrOQ.VTtoV6jY_QEtkpi6I06MdYXyZ_GkkrsXMBe_MXeL2G1CDIhuRr4I3s0yU
 HAClcO2p82FSucRV3qQ8QWNs8EbnJgtcH3XhafqHaHh2zG3s5Gjjziv.E0SDajdGYxLEP.ZO0pwo
 5AKZFBqYXtg9MZLkG71pmmQAPJItUHUSqdUqHuqcO4CgssqfcwDIfTRsMP16fasfOaxnclfGKtZi
 E2JfH.6uW72DhYWSFkZNxJSUngPMf51zUXAowscKLiqBd7J8Md57XZcoHau33hsGY0NLUJIoBYje
 IcQiB_0M4XivK_w362SlSkleC6QZ1PGdi8WYjVOBGirW_DfrTK58qoIY8m2jWHVs2Xp898pGljEo
 RhPY2t0XrMJSJetxFhH4.PSJIeqp1bXKOsUURMDVh6DNAyFrqHdiQs1EvMvxtTlHRSBQg7gtp6Ai
 B8YnDqwTtPfjVoHI.DCMHqtg8wLRmL4JbWXwgQVa6a9Ct2wU_ajxGzm4B.4i.3nvagW59k5wto5M
 GBsEORTV_dgZl9iBeAMK6Mvya2qZ2v_hagow_ansCrGur8HGVWnLQYDTcfzNHZYPAV5YBuMg2kls
 .sRiklkak8zPSNsUXaqDFY4eRF5XqmU1AWKlXrPOzgFsYvCB1Ak0eKh98cxPPtVwPClQDD1VSfuu
 mDaLYWnRYtQeeFj5uvOx8elqofObO1vs7I0YRMCUrYUZABwiNJEQvqAVfoMrnIc1yizmTA2LYcNJ
 K75aLbKn.WYG1bGBj6iBANtSKSBKldYL1jxed8hACL0YaDFICSsIQ0lFMYwh6cZXlMXZRXm3vnxd
 cSW5NMWAagNIMr65Z0b0_V0KE32FC9tTIcct9EEyE7pWUbwgIsivog_pEfbs7VmdtTCeWSKhrnVO
 o2l0BjCQLEAmjIFQggtGo4R4dCCwXt6S9DWM9OmQnTrwcHOQ_JgQBwOui32HMCSqrZWwnuiR8aeN
 ApWCZ9pHeXuLEa4QwDqX1YRXtyKvZHXOBwMylIBRpLzL.0MG2ESeHlQSyAn1LQHEZBOzM69ci8Jo
 kTfZVP7ACabyRSn5t1OONRLj1FZYcJYPqrgphxJyFnXRXHBrw0lwGVymdM_TPoRIZkTD9LvxkX9Y
 AI.od7bR7n9pYjKZL0Ow3sEdQEGzXX6LgrgXEYB6NeuMUGdk591lfM1BLXsL1Wkd9E80rGAvjJO3
 SL3Ed2IBhxEnkwEX7KTu1DzYUB51_FYKKuWawn3USIanJN21EVS._t0mWooSfRltSaTZgWr3EHwY
 d7DGMqi2gUS4lPlfjGlF5yWHI4BDgSVrwfLiMlgIJye1uKLB._aXZfO30QoEBX_B7W4o0aZlQfTk
 DuywDHyknNufhvnNkcHGNfK4lxEZJA41VUEdfhuTpVaNnY8UTT2zYCP9iR5ciL7uy9GPdg1E2js.
 cVUWhaef1ocKWPslBteBL8kZQhsJ0dKvSnTZJqsaOTykYh2QBwP8l0W_kwdIZYycff0CzZNA5qzl
 GTPhLyQEHTIScE6kKwScDhFzzRCSwYZmZNYIMWMphLD1hOocLOUqCrgQLjZ7fDb4_1UldoXSQdug
 1u6IJr5x175y6AcdRmLHfOZASXnEMBd7x2q1ope7_si94dj4RzIaN18cwnga73BhL80vi.XWGxPa
 u_ToTJvi0GsEoX0xHOBttuunSvA4S3y0Mg5JzV2cWAef5NYWIH1o87ePN_kyvPUDPH29rIhsSpmt
 TYOxmfKdMMo.Sjxxw1d0g9hVn2vpwcsoqGXHXg0QkH33XM6ocr.nZRwZUR4EdbkN_G5lIKHQfGbS
 pgqOEh9snzZmk16Ccrn56AqxJbMHvM_ZFx.dPzT_XSxiPX1gYQZ6dSa2deKOk1K89PK9YT7Y-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Nov 2021 16:01:07 +0000
Received: by kubenode505.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 804923039b303be64eac486475e577ab;
          Wed, 03 Nov 2021 16:01:02 +0000 (UTC)
Message-ID: <79835dce-7e15-38e2-5341-2fb246a445e7@schaufler-ca.com>
Date:   Wed, 3 Nov 2021 09:01:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] smack: clean up smack_enabled to be more readable
Content-Language: en-US
To:     Austin Kim <austindh.kim@gmail.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211103073131.GA15173@raspberrypi>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211103073131.GA15173@raspberrypi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/3/2021 12:31 AM, Austin Kim wrote:
> The smack_enabled is only set to 0, 1. So changing type of smack_enabled
> as bool may make relevant routine be more readable.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

A couple of changes below.

> ---
>   security/smack/smack.h           | 2 +-
>   security/smack/smack_lsm.c       | 4 ++--
>   security/smack/smack_netfilter.c | 2 +-
>   security/smack/smackfs.c         | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 99c3422596ab..dc1726f5953f 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
>   /*
>    * Shared data.
>    */
> -extern int smack_enabled __initdata;
> +extern bool smack_enabled __initdata;
>   extern int smack_cipso_direct;
>   extern int smack_cipso_mapped;
>   extern struct smack_known *smack_net_ambient;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index efd35b07c7f8..ba3b46bd2ceb 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -56,7 +56,7 @@ static DEFINE_MUTEX(smack_ipv6_lock);
>   static LIST_HEAD(smk_ipv6_port_list);
>   #endif
>   struct kmem_cache *smack_rule_cache;
> -int smack_enabled __initdata;
> +bool smack_enabled __initdata;
>   
>   #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>   static struct {
> @@ -4953,7 +4953,7 @@ static __init int smack_init(void)
>   	 * Register with LSM
>   	 */
>   	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> -	smack_enabled = 1;
> +	smack_enabled = true;
>   
>   	pr_info("Smack:  Initializing.\n");
>   #ifdef CONFIG_SECURITY_SMACK_NETFILTER
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index b945c1d3a743..82092d9387a3 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -70,7 +70,7 @@ static struct pernet_operations smack_net_ops = {
>   
>   static int __init smack_nf_ip_init(void)
>   {
> -	if (smack_enabled == 0)
> +	if (smack_enabled == false)

If you want to use a bool you should use it fully.
  +	if (!smack_enabled)

>   		return 0;
>   
>   	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 658eab05599e..7649ad8cc335 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2993,7 +2993,7 @@ static int __init init_smk_fs(void)
>   	int err;
>   	int rc;
>   
> -	if (smack_enabled == 0)
> +	if (smack_enabled == false)

Same here.

>   		return 0;
>   
>   	err = smk_init_sysfs();
