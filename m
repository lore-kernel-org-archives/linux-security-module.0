Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1FC433B4
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Apr 2021 22:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ECF61407
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Apr 2021 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhDTWlh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:41:37 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:25481 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233964AbhDTWlh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Apr 2021 18:41:37 -0400
X-Greylist: delayed 1372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 18:41:37 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id D3E813FE8D
        for <linux-security-module@vger.kernel.org>; Tue, 20 Apr 2021 17:17:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yyg0lQhneMGeEYyg0lnDNr; Tue, 20 Apr 2021 17:17:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=syuEG2Mjtsbf1cHjhB2o/aMUMbsmdd4MrM1Ol05rDEk=; b=xF3mqnBUbfG1Ao4fRbpN4F8qMb
        Y5NdkyaKW7Pp7vZ8GZ7wFpbb3J88sogig1A6GZGsjER6rSs3R4tcFAySTWbc0TyDTJFUb4LNzqTMp
        joNwvE/+b1jl7X/PTwHI88eAMwyjxYc7WNHvhdgqGJdcoFtWlnYASRtBsSzrtLSnBBJtWlX+WPILe
        PuwOGjLqU+cGC7/QmgfLLUdJTflejDIH0cGTm6AwW0bPQ1j3M2KZi61ubaSnzywqrWjvlV3RcaQ0n
        FVu++BB4tcPz+4XV61iK73oxNaLFgkE/f3FLYaV3W1f9hAjVNKHxwUsfjuN/kFX8ZpxugbHvtd3Un
        e4idK5iw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:50536 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYyfx-001kDG-Bl; Tue, 20 Apr 2021 17:16:57 -0500
Subject: Re: [PATCH 010/141] ima: Fix fall-through warnings for Clang
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
 <77650781-7088-21b7-aa8e-8e5fbf81920e@embeddedor.com>
 <079454b4147b6ca054129490cd256c948ea08cc1.camel@linux.ibm.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e809477b-acd8-8ac9-41ce-0433672171f4@embeddedor.com>
Date:   Tue, 20 Apr 2021 17:17:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <079454b4147b6ca054129490cd256c948ea08cc1.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYyfx-001kDG-Bl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:50536
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 4/20/21 16:32, Mimi Zohar wrote:

> Applied to 
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
> next-integrity

Thanks, Mimi.

--
Gustavo
