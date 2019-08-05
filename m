Return-Path: <SRS0=x/8A=WB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87163C433FF
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBDD20B1F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 17:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lLuwUJnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHERst (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:48:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19175 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHERst (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 13:48:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d486c0a0001>; Mon, 05 Aug 2019 10:48:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Aug 2019 10:48:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Aug 2019 10:48:48 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Aug
 2019 17:48:48 +0000
Subject: Re: [PATCH] security/tomoyo: convert put_page() to put_user_page*()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <john.hubbard@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-security-module@vger.kernel.org>
References: <20190805022626.13291-1-jhubbard@nvidia.com>
 <346e5a8e-57fe-b2ac-4069-50a8a83048b5@i-love.sakura.ne.jp>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <fa58ec66-dea7-8e00-cc31-426b997eafae@nvidia.com>
Date:   Mon, 5 Aug 2019 10:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <346e5a8e-57fe-b2ac-4069-50a8a83048b5@i-love.sakura.ne.jp>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565027338; bh=UH/wZ2TD5j5LKteS/k/OilrdTGLQ50Zk7Ly0LMxNvdg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lLuwUJnmr2qKk2WHpe+CKK0srXn51CQ1F5Qx+hpjTSdAt6YzgwauHlM/2+Cxgmzh7
         mX7Bat53fqDNUQD0eLKi52JARbCzHdSZBPesXwsKjmflWDIW+NHQDUY/wKDXAFoeJm
         5Xom9eVGEe7k8hVge2WwiSLkAVqg9qhtq3lNM9yjtrEmQiOcWrv707vdAXd0bqV9nP
         35ieiEGVYgMSBM/FGFuF5SCgTXu1D31Cr5hvJCWFkN+bMRKgtyWb5cJeHcE9Dx/8cV
         L9muICybx9Nqb9yVzWaUria/csDk9uC1Hr7oNV7Djw6ynXK/NGu5qz959fmLKMYycE
         Mj23x+rj0iFNQ==
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/5/19 3:01 AM, Tetsuo Handa wrote:
> On 2019/08/05 11:26, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> For pages that were retained via get_user_pages*(), release those pages
>> via the new put_user_page*() routines, instead of via put_page() or
>> release_pages().
>>
>> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
>> ("mm: introduce put_user_page*(), placeholder versions").
>>
>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: linux-security-module@vger.kernel.org
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Sending to Andrew Morton means you expect this patch to go via -mm tree, don't you?

Yes, exactly.

thanks,
-- 
John Hubbard
NVIDIA

> Andrew, please take this patch. Thank you.
> 

