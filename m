Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E551C64EC4
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Mar 2023 16:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCCQjS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Mar 2023 11:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCCQjR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Mar 2023 11:39:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7E18A8E
        for <linux-security-module@vger.kernel.org>; Fri,  3 Mar 2023 08:39:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az36so1994537wmb.1
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677861555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31I07e7lhfZ86RBOVPxLGMJkymKTXstteSUgSLtkVn4=;
        b=WvAaJGvELrbE5hc3JnT/95UEkrlBlS4qbrbSnLndepoPAe0TpucumoexZbtX9omAxK
         uOWAuvGI6+0wcvr9EvoXTRuutPnKhBAuu+DwMU1RS5I6juMl6RWduAbxGcFk0Ky19/P7
         78lMFsPgBpgrxjU5R6fAXapkPgB2xS89ZBI3mjlUouL2vSjymOIpOdY2AIvX5Cps2fOi
         EHBsv9A7y+htBWwGVce+P/pyPSZdYIFevDt0ySx6jZIY0SEPxXv2+JKrfImp07WkODpg
         rqGMEEq44s33qGVVgTbWUap9B8f+0pdI9r8Mt1SdQvArF+/8TSuu8rjDbOZdbOQMlMCO
         07xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677861555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31I07e7lhfZ86RBOVPxLGMJkymKTXstteSUgSLtkVn4=;
        b=eqkcJ8NDiyFX/P1LBVAXA0JU55PouTwla36mayosZngCu2doBQr6WO6ZpLcdjIGLzx
         AU8evBA7msVFpYAyD3vJceV0/NUqHrflORrJQYgud8zgCZgF7/a8Pw+jcs1Q4+oVkOaS
         Rt5anIK/hwko5gbcyWdmjmSujdpud+M9F0FwTH2T59sy1ok90XAXWO9rfbf65LiMPMJd
         KwyJP5oH3kNrBRSnuOtFU5offfmW4yRuOc1dVPV0T553G5jCR1ZwtQI3G9a42Lugu86z
         3rYoC3C+4PM5tjXUPhh9aGCXCzlL6uLDgJCOOiBheR1viCtHy62DuIghhMo/1bTXgsmu
         I3cw==
X-Gm-Message-State: AO0yUKXRHBAU6ZCMorw8b6qKE1YVJblpmZvyZgY7SxyTpx8is3PAKtHH
        khk+bzjNH0tauoPjdvbKvh0=
X-Google-Smtp-Source: AK7set+P9od8tW798HctJwCQ7LSF91Ata4ghAqKUqfjVHUBJvQ8kifaBb+ZRU8pijX+Ae8eNVURVJA==
X-Received: by 2002:a05:600c:4f88:b0:3e2:66b:e90e with SMTP id n8-20020a05600c4f8800b003e2066be90emr2406921wmq.10.1677861554885;
        Fri, 03 Mar 2023 08:39:14 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003e1f6e18c95sm7008619wmo.21.2023.03.03.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:39:14 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:39:13 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     enlightened@chromium.org
Cc:     mic@digikod.net, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jeffxu@chromium.org, allenwebb@chromium.org
Subject: Re: [PATCH 1/1] lsm: adds process attribute getter for Landlock
Message-ID: <20230303.c98f1b8fa91e@gnoack.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
 <20230302185257.850681-2-enlightened@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302185257.850681-2-enlightened@chromium.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Shervin!

On Thu, Mar 02, 2023 at 10:52:57AM -0800, enlightened@chromium.org wrote:
> +	if (landlocked(task))
> +		val = "landlocked:1";
> +	else
> +		val = "landlocked:0";

Landlock policies can be stacked on top of each other, similar to
seccomp-bpf.

If a parent process has already enforced a (potentially trivial)
Landlock policy, then you can't tell apart based on this boolean
whether any additional policies are stacked on top. So what does
Chromium do with that information, if the flag is true for all the
involved processes that it manages?

Does this meet the needs of your intended use case?  Should your API
expose more information about the stacked policies, so that it becomes
possible to tell it apart?

Thanks,
–Günther
