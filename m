Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC71C07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981D2087E
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfARTlJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:41:09 -0500
Received: from namei.org ([65.99.196.166]:56864 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfARTlJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 14:41:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0IJemnG001048;
        Fri, 18 Jan 2019 19:40:49 GMT
Date:   Sat, 19 Jan 2019 06:40:48 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] LSM: Make some functions static
In-Reply-To: <1547617472-60140-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <alpine.LRH.2.21.1901190640280.581@namei.org>
References: <1547617472-60140-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 16 Jan 2019, Wei Yongjun wrote:

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
> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Casey, please review these fixes for your patchset.

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

-- 
James Morris
<jmorris@namei.org>

