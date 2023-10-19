Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F0FCDB465
	for <linux-security-module@archiver.kernel.org>; Thu, 19 Oct 2023 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjJSIIz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjJSIIw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Oct 2023 04:08:52 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE612F
        for <linux-security-module@vger.kernel.org>; Thu, 19 Oct 2023 01:08:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SB0QB6SMfz9ykHY
        for <linux-security-module@vger.kernel.org>; Thu, 19 Oct 2023 15:55:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3EJIC5DBlhxmBAg--.60267S2;
        Thu, 19 Oct 2023 09:08:39 +0100 (CET)
Message-ID: <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Date:   Thu, 19 Oct 2023 10:08:31 +0200
In-Reply-To: <20231018215032.348429-2-paul@paul-moore.com>
References: <20231018215032.348429-2-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwC3EJIC5DBlhxmBAg--.60267S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4DJr45tw1xuw1rWr4rKrg_yoW8WF48p3
        Z8uFW2qFWUAF47C3yFvF43Xw17CFWDJr17G3yUur4Uta1rAa4kKr4v9F4akr15XFWkArWr
        GF1qq34jg3srZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5E4YwAAsy
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> When IMA becomes a proper LSM we will reintroduce an appropriate
> LSM ID, but drop it from the userspace API for now in an effort
> to put an end to debates around the naming of the LSM ID macro.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

This makes sense according to the new goal of making 'ima' and 'evm' as
standalone LSMs.

Otherwise, if we took existing LSMs, we should have defined
LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).

If we proceed with the new direction, I will add the new LSM IDs as
soon as IMA and EVM become LSMs.

Roberto

> ---
>  include/uapi/linux/lsm.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index eeda59a77c02..f0386880a78e 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -54,14 +54,13 @@ struct lsm_ctx {
>  #define LSM_ID_SELINUX		101
>  #define LSM_ID_SMACK		102
>  #define LSM_ID_TOMOYO		103
> -#define LSM_ID_IMA		104
> -#define LSM_ID_APPARMOR		105
> -#define LSM_ID_YAMA		106
> -#define LSM_ID_LOADPIN		107
> -#define LSM_ID_SAFESETID	108
> -#define LSM_ID_LOCKDOWN		109
> -#define LSM_ID_BPF		110
> -#define LSM_ID_LANDLOCK		111
> +#define LSM_ID_APPARMOR		104
> +#define LSM_ID_YAMA		105
> +#define LSM_ID_LOADPIN		106
> +#define LSM_ID_SAFESETID	107
> +#define LSM_ID_LOCKDOWN		108
> +#define LSM_ID_BPF		109
> +#define LSM_ID_LANDLOCK		110
>  
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes

