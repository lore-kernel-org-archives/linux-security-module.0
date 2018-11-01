Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5352FC0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8C2064C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 22:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8C2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeKBHJP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:09:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39803 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeKBHJP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Nov 2018 03:09:15 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA1M4DqZ033663;
        Fri, 2 Nov 2018 07:04:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Fri, 02 Nov 2018 07:04:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA1M48FR033651
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 2 Nov 2018 07:04:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: fix small typo
To:     Yangtao Li <tiny.windzz@gmail.com>, jmorris@namei.org
Cc:     takedakn@nttdata.co.jp, serge@hallyn.com,
        linux-security-module@vger.kernel.org
References: <20181101155508.23383-1-tiny.windzz@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4712c089-3fbf-2753-dc42-4db5f8ef771a@i-love.sakura.ne.jp>
Date:   Fri, 2 Nov 2018 07:04:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101155508.23383-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2018/11/02 0:55, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

> ---
>  security/tomoyo/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
> index d3d9d9f1edb0..badffc8271c8 100644
> --- a/security/tomoyo/util.c
> +++ b/security/tomoyo/util.c
> @@ -106,7 +106,7 @@ void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
>   * @string: String representation for permissions in foo/bar/buz format.
>   * @keyword: Keyword to find from @string/
>   *
> - * Returns ture if @keyword was found in @string, false otherwise.
> + * Returns true if @keyword was found in @string, false otherwise.
>   *
>   * This function assumes that strncmp(w1, w2, strlen(w1)) != 0 if w1 != w2.
>   */
> 
