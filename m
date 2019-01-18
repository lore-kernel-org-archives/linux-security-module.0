Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7EC07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D089D2087E
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JCc47VyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfARTpB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:45:01 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:39285
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728989AbfARTpB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 14:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547840700; bh=nUHL6Jqtpo730h8gnJTKIn+Sb9ESm1RZnQ+mOkQdO4U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=JCc47VyQgFOmOnD3mOF/eLhs4rrpTs3evSUk9mk5O01yesCPFGMNmLSr3LFyL7vjDwb73X2mw1sTtHW5Djg8IxGdd1GH8yCJAeBLyj0ipmIO3pLb2grT5bu5SyCQ1eCJLC5JlWqy9luk07qkjPok919aAnfwLc1711iAoMvErKJxoyJliKm3JH+iGs80PoVaOOpH1JIWVnZRIQdw3PhajBs6AN0PVEb0eSwIcMNPoYiXSBkIeV/0aSGMl2i3YxrT1a+iHvhgTIHJKCtDYYh7/4DdIiGV5P6x+w6j5U57psq7vlZJ+CONN/21hk/GpN1Lg1+lEgo903gp4b0XUSKSpQ==
X-YMail-OSG: 5pOCTi4VM1ns8LEzdpgiC20yNa_LuewBsWoxNLrKPJrYIJNwGg0EgxLVi4M36mD
 .ExsThQV9O7xuWYb_.za_v4t2i7mhK5zaSfQap4EQj7k.oGI49yUHPV_oSec38lOyHBQ9Cw7yUJF
 c8KgppAAjwyaXBJ4c0_pSxxRAV7Qx43tCSJ4CoYwcYAWCL7GhnwyFDjvkMw3O1a.gU9VkkxQQsFQ
 mYmP3IvB3G7AsJSSiVmwlYWf_IxbBMhjHwuYv0kaBXKQ5L660RFnTikdz7dvPFmbv5TZifo5fPmq
 wW1Dup4gL4lnJZQ1wadk90JBmG7DPJbjF8VpMByWQZBM2o_FLKmeuRK8Tny7w20HwDLnNMaXFIfN
 n4X7Sz53CAsuwEptoCh5ECcrVE52p_JE6yPKY52To4JNXeh4nCbEU3T8o4JJ9Wbp2ZTYI6xxntOi
 PLglAVmWoak1Kcvyerwyt9ONXpKGfE6927m8lh1ANUq1CqMSS7jJv9m8y1oq2ycAZqHo0gkRSY2K
 coJ1Yhr54NsQRAIN1tvYTLAM0EqKVgtRkHK9m7MZWoy11ZqPCiio6euyxjX84QnfrvQ0R812OFez
 Npe879sm3hbE5wYjQn1d6RAf2u54PZs2S5l4U9Gy4LoGiLwIXHY1m3d_PTlBiPZL5JSVPhCC8EPl
 sQzMCCzelLv7qoWzb08Wctxu6Iz1iOneV8o2k6lU_KFZXp0GUEDzctvlGT57jEKLTfq9QWnlSGfQ
 vJdvBGuA1S_I0Lcmry8IPl43hFukcRRvR92xlQcnARBv7DLL5KgXL6dvT08GQ2hxqKa9a0sSYDza
 V1a4wzkZbPvJ1cYY.z7CaFgBTeRehVMpx07Lob4_Sj0NJgoBuXRmYxWNZc.CWvlPf8TGeXoIgmlM
 G5w4LinJ3HoS6PNn6ehGWn09C_N3VuKcaXzwCDNA.5dHBDa.XHetdM_EZobH3kWolDdcUDWJ3Mq9
 9D_53Q83nKbc2izMnI5vhPdGkHuHOOYa1wI7ykLMh1w7zJBz9oKJdphrDc0.V0nDUbEGoDjuAU2Q
 5ETUTtTHeIpkGqLgF_94f1SVgpMXlUXi_T9MK_A1k9GID5eDFCrzZm6_qyY3hvRQs_hMf8XxqBOR
 X9GodUKB3wDZYKzxMTpvr7dPjFPprg_L1bSQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Jan 2019 19:45:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 62c92109436d696f2df9cb64412cdcf4;
          Fri, 18 Jan 2019 19:44:58 +0000 (UTC)
Subject: Re: [PATCH -next] LSM: Make some functions static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1547617472-60140-1-git-send-email-weiyongjun1@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9cc301d1-44f9-313c-5ca7-4950073c9a8b@schaufler-ca.com>
Date:   Fri, 18 Jan 2019 11:44:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547617472-60140-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/15/2019 9:44 PM, Wei Yongjun wrote:
> Fixes the following sparse warnings:
>
> security/security.c:533:5: warning:
>  symbol 'lsm_task_alloc' was not declared. Should it be static?
> security/security.c:554:5: warning:
>  symbol 'lsm_ipc_alloc' was not declared. Should it be static?
> security/security.c:575:5: warning:
>  symbol 'lsm_msg_msg_alloc' was not declared. Should it be static?
>
> Fixes: f4ad8f2c4076 ("LSM: Infrastructure management of the task security")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 9a98c52..750d3f3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -530,7 +530,7 @@ int lsm_inode_alloc(struct inode *inode)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_task_alloc(struct task_struct *task)
> +static int lsm_task_alloc(struct task_struct *task)
>  {
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
> @@ -551,7 +551,7 @@ int lsm_task_alloc(struct task_struct *task)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_ipc_alloc(struct kern_ipc_perm *kip)
> +static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>  {
>  	if (blob_sizes.lbs_ipc == 0) {
>  		kip->security = NULL;
> @@ -572,7 +572,7 @@ int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_msg_msg_alloc(struct msg_msg *mp)
> +static int lsm_msg_msg_alloc(struct msg_msg *mp)
>  {
>  	if (blob_sizes.lbs_msg_msg == 0) {
>  		mp->security = NULL;
>
>
>
>
