Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60513C433ED
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Apr 2021 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2625A613EE
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Apr 2021 20:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhDTUw4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:52:56 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.66]:35875 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233675AbhDTUwz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Apr 2021 16:52:55 -0400
X-Greylist: delayed 1439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:52:55 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 451B3449E
        for <linux-security-module@vger.kernel.org>; Tue, 20 Apr 2021 15:28:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ywyule2Lr1cHeYwyullpD9; Tue, 20 Apr 2021 15:28:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iAn70tR/fd1yZfaAabH+Y/BPcV703Uz3rtYuuggVBZs=; b=jF3UcFo7Dhq7RqiPQ4Jq1xsO1n
        kPff+Yzqk0rWnJqLut/DI+R7kd3gUPa0814W+JmABs4vHrHMCxukQMcL/BOGxRxeYLvETjcTan7Na
        kco1MwcKAjiSAU4ZC0LkTUqabv4jzTHOhmGmiOaZpLQFGFvnNT6ci2xm1M6biPvBzVJ4rg+eUtdc3
        DtFVRKkCUBQVLV20muE9JYfw2Pho/pDcmtnc/9Zw8XwYLZt6YUdMZJg79HjjprR06SoLmYs3Y/suh
        RjDL90g5SR4tcg/31JjU5P0Qt4cuOtK/kkL7hIP/RnsA6ZCQqnsjBcNVdiqqQ/Az8oWeKDjZ2zuIj
        4GRQLrqw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49074 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwyq-0039sF-PK; Tue, 20 Apr 2021 15:28:20 -0500
Subject: Re: [PATCH 010/141] ima: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <77650781-7088-21b7-aa8e-8e5fbf81920e@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:28:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
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
X-Exim-ID: 1lYwyq-0039sF-PK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49074
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 215
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:25, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of just
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  security/integrity/ima/ima_main.c   | 1 +
>  security/integrity/ima/ima_policy.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2d1af8899cab..600b97677085 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -743,6 +743,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>  			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b5adeaa47fc..ea634fc3b82f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -566,6 +566,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>  						   Audit_equal,
>  						   rule->lsm[i].rule);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -802,6 +803,7 @@ void __init ima_init_policy(void)
>  		add_rules(default_measurement_rules,
>  			  ARRAY_SIZE(default_measurement_rules),
>  			  IMA_DEFAULT_POLICY);
> +		break;
>  	default:
>  		break;
>  	}
> 
