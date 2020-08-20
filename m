Return-Path: <SRS0=ujXN=B6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C008C433E3
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D42207DA
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8tXDB6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHTVVt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgHTVVs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Aug 2020 17:21:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B13C061385
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2020 14:21:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so1673830pfh.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2020 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EsAjRN4EWGdA6npeygguQ2Nt+2Qs2ZtAg82JTA4fjFU=;
        b=K8tXDB6rNbGscQlHY1IKoadl3x/vhZyQ/BPRzUIJ9ekNpyEgrFUp8WnYNBdytMLT03
         xspi1TS1YHRjFLBTubnUoUCSmJYUJobp6DsgeFT/F5cu26hy9hImQkk6Jen/Ec5jLEk3
         nP64duWEgISYePfLB3r9Xmac7cfpySG0j2bUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsAjRN4EWGdA6npeygguQ2Nt+2Qs2ZtAg82JTA4fjFU=;
        b=HhyEu8drQ9aE0IfAyonEeU5pzsyIn9g9cilz8X8cheMC9CZm0d67V+VwHk5456oxlj
         85CrCXk3Bh/ZNpke8xjyPna3VgZzEbY/Q51mbPnLO/gOmY1LMw1F5pKK2z7DEibnl1yL
         nTYuacHwXlkqQK5pF8lzqgVL3cenufPQxh+tqbEZIc8ko7penuu2jbErrCzfXiyOjNTS
         27H7m+jhCUXTOgeglydPcnoxZnpI/SQkWP2r6m1VmwRRfQNjkuxWH08SVVgIGMSUoeH0
         dZOCOZD8n1M5SzH6HwrNATQJFpjRphs3CllDdilmIXC+48pXmUc0bzAeYIKVkC7ju0dq
         lWmA==
X-Gm-Message-State: AOAM531eBm5kHJLcmSDTFFy9I3iqhRy6ufL/gfYAZS98nKfqMheayN0u
        +VxbV+abDwAqIbQ6sxI0p4UBYgqtfdhCgg==
X-Google-Smtp-Source: ABdhPJwJ5uE9q3Uz8BjfaU+FBc50PS+4PET4V3mUpf4QuQZJT1QCIhsKZQ8JLt5HhxkLcLP/YQvrnQ==
X-Received: by 2002:a05:6a00:228f:: with SMTP id f15mr503972pfe.222.1597958506806;
        Thu, 20 Aug 2020 14:21:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm3680437pgt.54.2020.08.20.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:21:46 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:21:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Message-ID: <202008201420.D9F0CB3E@keescook>
References: <9ce6209f41b64734b2cac748783aa441@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce6209f41b64734b2cac748783aa441@huawei.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 20, 2020 at 02:18:21AM +0000, linmiaohe wrote:
> Kees Cook <keescook@chromium.org> wrote:
> >On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
> >> There is no need to check if this process has the right to modify the 
> >> specified process when they are same.
> >> 
> >> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >
> >NAK, please don't do this -- the ptrace and security hooks already do these kinds of self-introspection checks, and I'd like to keep a central place to perform these kinds of checks.
> >
> 
> Many thanks for your reply.
> We also avoid get_task_struct/ put_task_struct pair of atomic ops, rcu_lock, task_lock and so on this way.
> 
> >Is there a specific problem you've encountered that this fixes?
> >
> 
> I'am sorry but there's no specific problem. I do this mainly to skip the unnecessary ptrace and security hooks.

Cool. Let's keep this as-is so we continue to have centralized
instrumentation of these things in the LSM. :)

Thanks for your attention to performance!

-- 
Kees Cook
