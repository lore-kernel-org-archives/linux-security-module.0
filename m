Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98904C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 19:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiKBTF7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBTF6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 15:05:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2F2D4
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 12:05:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so17496805plb.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Nov 2022 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txFQrEfMZQpea1F930rJNp2m9RjQBLyraMMcBHn2Ql0=;
        b=E0ecJRjqxI5dV8knkHcpeKQ0FIV6Twn0eWEGzUYVfbClw877LXaWvO2cRRH1yMOiZ0
         Pwwilo8PKU7g7oZWOiMqwlVL60PaSwQmDXOrZi/ALqclxxZPuAPUhFOPbv2QWVFIs+I+
         prJUg3F4tcEAh2sYiIkvc9TWQMs4hHGu1sCgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txFQrEfMZQpea1F930rJNp2m9RjQBLyraMMcBHn2Ql0=;
        b=XqoVwcwZlgSxkf+UZ+oogogcGrx9+TUFzfijZyYgIWV6ImxbpPh2QgC9e8y3b6XwSK
         S9OZQIlioEc7LDWNDp3mmqo7xAUm1sqqO2hbMGJxGp5U+kmyiy+TdeCRTkjAqQwEc975
         sV+kGLV53G8eUTZHzT+GL3JZmBxfWw2HKjCvBx7CXpcOfS+doUbz8aOAXGfunvIHg8jB
         ErioHjZYETdTkrK2msXC2fSWGPsUKQ9X82EFWyk9n1O7vrXrAYjoRoAnEpmxArdq79Qq
         iWtsKzL6ZSc8UONdAFA/zqm/kEncYnII+vFYPsDYGETFXY5VKHDp2QeXQTuLqLNM8tVQ
         i8rg==
X-Gm-Message-State: ACrzQf0a+iaxYDYznbefh+DvJD3orpC8HmM41E7li+3Mpf7OK8t4+leE
        TpwMUo93Gh89OO+V0J5zIXwNiA==
X-Google-Smtp-Source: AMsMyM6iisC+0P+mRwLQkyVBhLFvD3ap6j2I41TCgqI1umm46PNeyw9QAZiIqsd4RZWN5tV+9mEhIg==
X-Received: by 2002:a17:902:7c12:b0:186:8111:ade2 with SMTP id x18-20020a1709027c1200b001868111ade2mr26102381pll.111.1667415957197;
        Wed, 02 Nov 2022 12:05:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144-20020a621796000000b00545f5046372sm8741341pfx.208.2022.11.02.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:05:56 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:05:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 05/10] CaitSith: Add LSM interface management file.
Message-ID: <202211021155.ADD6E05A@keescook>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-5-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102171025.126961-5-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 03, 2022 at 02:10:20AM +0900, Tetsuo Handa wrote:
> This file is used for registering CaitSith module into the
> security_hook_heads list. Further patches will not be interesting for
> reviewers, for further patches are providing similar functions provided
> by TOMOYO (but too different to share the code).
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> [...]
> +#define cs_debug_trace(pos)						\
> +	do {								\
> +		static bool done;					\
> +		if (!done) {						\
> +			pr_info("CAITSITH: Debug trace: " pos " of 2\n"); \
> +			done = true;					\
> +		}							\
> +	} while (0)

This can be replaced by pr_info_once().

> [...]
> +#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_SECURITY_WRITABLE_HOOKS)
> +#include <linux/uaccess.h> /* copy_to_kernel_nofault() */
> +#define NEED_TO_CHECK_HOOKS_ARE_WRITABLE
> +
> +#if defined(CONFIG_X86)
> +#define MAX_RO_PAGES 1024
> +static struct page *ro_pages[MAX_RO_PAGES] __initdata;
> +static unsigned int ro_pages_len __initdata;
> +
> +static bool __init lsm_test_page_ro(void *addr)
> +{
> +	unsigned int i;
> +	int unused;
> +	struct page *page;
> +
> +	page = (struct page *) lookup_address((unsigned long) addr, &unused);
> +	if (!page)
> +		return false;
> +	if (test_bit(_PAGE_BIT_RW, &(page->flags)))
> +		return true;
> +	for (i = 0; i < ro_pages_len; i++)
> +		if (page == ro_pages[i])
> +			return true;
> +	if (ro_pages_len == MAX_RO_PAGES)
> +		return false;
> +	ro_pages[ro_pages_len++] = page;
> +	return true;
> +}
> +
> +static bool __init check_ro_pages(struct security_hook_heads *hooks)
> +{
> +	int i;
> +	struct hlist_head *list = &hooks->capable;
> +
> +	if (!copy_to_kernel_nofault(list, list, sizeof(void *)))
> +		return true;
> +	for (i = 0; i < ARRAY_SIZE(caitsith_hooks); i++) {
> +		struct hlist_head *head = caitsith_hooks[i].head;
> +		struct security_hook_list *shp;
> +
> +		if (!lsm_test_page_ro(&head->first))
> +			return false;
> +		hlist_for_each_entry(shp, head, list)
> +			if (!lsm_test_page_ro(&shp->list.next) ||
> +			    !lsm_test_page_ro(&shp->list.pprev))
> +				return false;
> +	}
> +	return true;
> +}
> +#else
> +static bool __init check_ro_pages(struct security_hook_heads *hooks)
> +{
> +	struct hlist_head *list = &hooks->capable;
> +
> +	return !copy_to_kernel_nofault(list, list, sizeof(void *));
> +}
> +#endif
> +#endif
> +
> +/**
> + * cs_init - Initialize this module.
> + *
> + * Returns 0 on success, negative value otherwise.
> + */
> +static int __init cs_init(void)
> +{
> +	int idx;
> +#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE)
> +	if (!check_ro_pages(&security_hook_heads)) {
> +		pr_info("Can't update security_hook_heads due to write protected. Retry with rodata=0 kernel command line option added.\n");
> +		return -EINVAL;
> +	}
> +#endif
> +	for (idx = 0; idx < CS_MAX_TASK_SECURITY_HASH; idx++)
> +		INIT_LIST_HEAD(&cs_task_security_list[idx]);
> +	cs_init_module();
> +#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE) && defined(CONFIG_X86)
> +	for (idx = 0; idx < ro_pages_len; idx++)
> +		set_bit(_PAGE_BIT_RW, &(ro_pages[idx]->flags));
> +#endif
> +	swap_hook(&caitsith_hooks[0], &original_task_free);
> +	swap_hook(&caitsith_hooks[1], &original_cred_prepare);
> +	swap_hook(&caitsith_hooks[2], &original_task_alloc);
> +	for (idx = 3; idx < ARRAY_SIZE(caitsith_hooks); idx++)
> +		add_hook(&caitsith_hooks[idx]);
> +#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE) && defined(CONFIG_X86)
> +	for (idx = 0; idx < ro_pages_len; idx++)
> +		clear_bit(_PAGE_BIT_RW, &(ro_pages[idx]->flags));
> +#endif
> +	return 0;
> +}

I'm sorry, but absolutely not. One of the most basic elements of the
LSM infrastructure is that it is read-only. Even __lsm_ro_after_init is
a grand-fathered behavior that is supposed to be removed once all the
old SELinux disable-at-runtime users are gone.

I don't see any _justification_ for why any of this is needed. Yes,
it is technically possible to make an LSM loadable, but there needs to
be a convincing rationale for _why_.

-Kees

-- 
Kees Cook
