Return-Path: <SRS0=N7Ha=T7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6C6C04AB6
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 14:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5126AD5
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 14:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GnGxjK5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaOoV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 May 2019 10:44:21 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45623 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaOoU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 10:44:20 -0400
Received: by mail-pg1-f180.google.com with SMTP id w34so4151380pga.12
        for <linux-security-module@vger.kernel.org>; Fri, 31 May 2019 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RHQnLjVCuzDq+CHZRvfpRZb5hKNSCy3a2JeU2KJM6Fg=;
        b=GnGxjK5/JnD6DgvQAMsuBHSEk5MAcm6dRUlszPuN0RiGCbl8cpi/e0k67tEdBCTjXG
         B2plt6FDeG3nEhKDdjaH4YwCkZfVMi2ssOoSz1/br7M9oyiBu/vHOMMSWnh3C49RDdNk
         Hx4qv5rFEqiDBOVpo/q6gcjNco/xflvfRzZ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHQnLjVCuzDq+CHZRvfpRZb5hKNSCy3a2JeU2KJM6Fg=;
        b=PeSAR9oBXK3L5WhV5Kf+rimNK+67TYgs5BMZWvzZ4Lpz3fwXeVq6V/mTpUgfInKKaL
         vRHuPcZEwA3cC6livqHnepac5iVOxYPUaZB1qDD0MDPJFnhMoiE9Kn9BgGn4HomhQWHR
         Z+BkErgCnI6RLIG2trrATjmQqiJPlEcN7ypWGXTX3ujEWViI+uqqS7FngBOXrDGJcuVj
         OPN1cUUA4AyeNi3dNtz0EYEZ0TbtHzJWvAZpcb6nwRvx52y0Wk4CLJibtQfe4erGghIu
         QlUmdRWwdkWXiJGlgwUiDgIeFjaEJNTa6OiyuMloUS5sr1lp6ylGq2WOj1UwbWX43y6g
         N/oA==
X-Gm-Message-State: APjAAAUuBAwTIO2J9V3N3OREzCwMm1E32cbjIs0J3Xb4LjDNvKq1SqGC
        Z6yEXXsyeRsVNP1GQv+lfWGqew==
X-Google-Smtp-Source: APXvYqzIRqdfdxaq/26x0YLlSNSrYfyqBhnbawPfi+9f2Ik6dZkOl6eY+rdzVTfWtukHyzOkP33o/w==
X-Received: by 2002:aa7:9a1d:: with SMTP id w29mr10358364pfj.81.1559313859909;
        Fri, 31 May 2019 07:44:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13sm5847079pjq.20.2019.05.31.07.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 07:44:18 -0700 (PDT)
Date:   Fri, 31 May 2019 07:44:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Ke Wu <mikewu@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: security/loadpin: Allow to exclude specific file types
Message-ID: <201905310740.522B3A7C1@keescook>
References: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 11:46:29AM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity on linux-next has found a potential issue
> with the following commit:
> 
> commit 1633a4f04cc171fc638deb5c95af96032d3c591b
> Author: Ke Wu <mikewu@google.com>
> Date:   Thu May 30 12:22:08 2019 -0700
> 
>     security/loadpin: Allow to exclude specific file types
> 
> 
> 209                for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
> 210                        if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> 211                                pr_info("excluding: %s\n",
> 212                                        kernel_read_file_str[j]);
> 
> CID 81977 (#1 of 1): Out-of-bounds write
> overrun-local: Overrunning array ignore_read_file_id of 8 4-byte
> elements at element index 8 (byte offset 35) using index j (which
> evaluates to 8).
> 
> 213                                ignore_read_file_id[j] = 1;
> 
> According to Coverity ignore_read_file_id is an array of 8 integers.
> However, ARRAY_SIZE(kernel_read_file_str) is 9, so we have an out of
> bounds write on ignore_read_file[j] when j is 8.

What am I missing? This doesn't fail the build:

+       BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
+                    ARRAY_SIZE(ignore_read_file_id));

They have the same number of elements.

-- 
Kees Cook
