Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED73C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jun 2022 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiF0RDz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiF0RDy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jun 2022 13:03:54 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7B14D25
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jun 2022 10:03:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p69so10193257iod.10
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jun 2022 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E++Zo91YUYL49yU+TLX4vsiJviRDwZYo3TtlF2dL+yc=;
        b=TH4qcvBC1WfFEVD0R2JEuUcpb16hZQ61gitb2lAXhJHnsDqjmg6llAHTDZe6jj0mxj
         T/wEf4Z9pMJPuHomU36S1GhPxojnvtssDMENzgI6XhnASUHDJxfv8WJPh5LFQYXCf9Mq
         rx2SK6QAf9KONBavHi4wNImeJvU8tMpT7dAzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E++Zo91YUYL49yU+TLX4vsiJviRDwZYo3TtlF2dL+yc=;
        b=38Nyl9sPPxch3zoF4x0h8Wz2Vt/mXP652VE++q+1S6JRB+kceJpYK8Qw4Z7YCgGqhH
         kPa+nOPf6gJJQrDORrsemOl+DrG792XA3BrpYzSZSrFVfLx7uSVMJddUWrDvIQ5J7bG7
         7uwZlmeIAjWwK0c8liPcfEbdTs59bOymND+eUSQUM7/JYwdBgr8CVmcIje+mX62YpUKl
         H3Fh1VvEm66AKdXddwuy5jzNwqR3gehX5OX1xbRF1Vt1nrMkjtX5BAv23fM5k+5w0HJC
         BP+AKfWy3L0AuLWEumeysWzax9MexV3H+AI7EeHWu+kdPb/lWmXG3bO+zeQbubSP648v
         sukA==
X-Gm-Message-State: AJIora8QoRU4NG1Dx2RiTBlqYSKQC78/AgCphIcC5hTV3zxH/HsCr0MH
        wSP36Gz9fl77wReWaniiLAQr5A==
X-Google-Smtp-Source: AGRyM1v+GraNnGmLT3MJ5XC6BajyKtuce8TmvgiRH13sBZEVJK3xUNAN7bWSx+L2B2EU5t4WqU2UeQ==
X-Received: by 2002:a05:6638:f16:b0:339:e45e:2cb4 with SMTP id h22-20020a0566380f1600b00339e45e2cb4mr8526928jas.151.1656349433131;
        Mon, 27 Jun 2022 10:03:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q3-20020a02a983000000b0033be74df72csm3881238jam.3.2022.06.27.10.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:03:52 -0700 (PDT)
Subject: Re: [PATCH] kselftests: Enable the echo command to print newlines in
 Makefile
To:     Gautam <gautammenghani201@gmail.com>, shuah@kernel.org,
        brauner@kernel.org, keescook@chromium.org
Cc:     kafai@fb.com, songliubraving@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220625135455.167939-1-gautammenghani201@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c6c6966-0164-12b5-f73f-1ecf157e196f@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 11:03:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220625135455.167939-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/25/22 7:54 AM, Gautam wrote:
> In the install section of the main Makefile of kselftests, the echo
> command is used with -n flag, which disables the printing of new line
> due to which the output contains "\n" chars as follows:
> 
>    Emit Tests for alsa\nSkipping non-existent dir: arm64
>    Emit Tests for breakpoints\nEmit Tests for capabilities\n
> 
> This patch fixes the above bug by using the -e flag.
> 
> Signed-off-by: Gautam <gautammenghani201@gmail.com>
> ---
>   tools/testing/selftests/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index de11992dc577..52e31437f1a3 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -253,7 +253,7 @@ ifdef INSTALL_PATH
>   	for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
>   		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> -		echo -n "Emit Tests for $$TARGET\n"; \
> +		echo -ne "Emit Tests for $$TARGET\n"; \
>   		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>   			-C $$TARGET emit_tests >> $(TEST_LIST); \
>   	done;
> 

Thank you. Will be applied to kselftest next for Linux 5.20-rc1

thanks,
-- Shuah
