Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5208EC433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 20:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1529064EDA
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhBJUxl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJUxj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Feb 2021 15:53:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB21C06174A
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 12:52:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx20so1886439pjb.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 12:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BhLsHpnejZb9qlOYSW2Kja4BMZ8FQIuFfGfNk/H8iJs=;
        b=BKuuy7OzoJUop1sR9YXDRNHU7KNdvSAY8JnCprJ4HqHiVcDLscvzFP2yaBR+iQ2NGz
         4WYMbeWZdkpdGvpwi23u2RSf9IuynDjwdAjLWZOWyxyz01XvNn/JrV9drS5a1RtCSGd9
         XhkRtJ64zH42UfEFVW7IK0XuSo0hW2+tE/bcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhLsHpnejZb9qlOYSW2Kja4BMZ8FQIuFfGfNk/H8iJs=;
        b=Boz6qa3X+qJHh+g1bYX+w0G+zcVVf8uzWdxVKWyQ3A2OK6k5AuHOEQ1KyjTGpRL6I8
         gXwzYR7wV0HvMtQVgQd2manAovaSQSJAJ46DI15bCm/gFbK2WPrQtFi5MV26D4VVKpa9
         X2pvzMwkL8ZIF2paFj1Hi9JCjCgZ6DAYX1tWriYcby/bFEU7udn2qZZ3kNCAYLCMM79l
         mhWYRYVi0+hEqLQ4M1SKXAJ91MK3OnwPuttW14bfJSDf4ll27J7LE0mDoRGeeqMWttmj
         DIBewfwDYqwRZZc2Hat/+t5S7d9x1POh5dj0Mte5rCwBEBZZJL9qSzFol1t99wYACaSj
         x7Qg==
X-Gm-Message-State: AOAM532vRUHjTw79LXt7kzDYqN/HH59Ip7P4CiRQb/DgX7gbtS+VdxTg
        L3GNnHyFVJahvkxgn1uc8iCNbA==
X-Google-Smtp-Source: ABdhPJyvnQnwOQXyNXOujg+dYnsireF9XR87NKVgnzVshrTpr6Uy6+KvBaws8jN12Q3XkuhO6LT2TQ==
X-Received: by 2002:a17:902:694c:b029:e2:daa3:ca4a with SMTP id k12-20020a170902694cb02900e2daa3ca4amr4750113plt.80.1612990378679;
        Wed, 10 Feb 2021 12:52:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8sm3059930pju.29.2021.02.10.12.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:52:58 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:52:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] integrity: Make function integrity_add_key() static
Message-ID: <202102101252.12F104E44@keescook>
References: <20210210080131.1209889-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210080131.1209889-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 10, 2021 at 08:01:31AM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> security/integrity/digsig.c:146:12: warning:
>  symbol 'integrity_add_key' was not declared. Should it be static?
> 
> This function is not used outside of digsig.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
