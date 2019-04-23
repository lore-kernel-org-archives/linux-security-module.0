Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAEC10F03
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97149217D9
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cvr3QFQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfDWTRs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:17:48 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39041 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWTRr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 15:17:47 -0400
Received: by mail-ua1-f66.google.com with SMTP id d5so5165460uan.6
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0R/r6+Dc1HS6D5GD+LDQaGbyZfhrZKOj7KqVz/9sduY=;
        b=Cvr3QFQ2YBZeOM6VP8GWbG4gVQuTC9seTDsAXY+zY3+Ia4xqkynjotA2UmquFlIKuC
         EDzL2OvkJTJEKfcYglm52pzlmdUvyolQPJpTy54k7dbJk2TusM9qmXtfPAJa/lN4S93d
         kfLFsFz+oaGMN9tjJDfwR54RvQU0d6O3q681o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R/r6+Dc1HS6D5GD+LDQaGbyZfhrZKOj7KqVz/9sduY=;
        b=V5/ipOpucr8nDCGg4T9pT7UVkEmbyfydMCDtDiOZPv4TikuJlqGL9jGdd7GfslUGst
         kpkA56Dm7SHXBxyQKPsjkfZ1hfFFpJxDWdTfQdpWkti1+Kb69se3IHxT2wt14fUFJjj+
         9JXT81xkTLMEKPOGfJpamV3wjGzhgQtqLE1Xxb6TtXV7JLzFbxXsO+zLrRmhU9HIjnLL
         g3xEEzWcEomd6C6bWYvIdG0bqQ+1ysjTdJaehiTuoFqHoWLLB7uEYM+TNnUebZXBSDdT
         07kBN5ExQ9Svn9fD0zuYnAyNslmwVBDQfpdWF6GQpvYKL09mT1iPxqR31eaJvpNrbkMd
         MhPw==
X-Gm-Message-State: APjAAAU2kbl0uQshr+KfJBirdstarKjjxpTTWk2DwvM4jElVOVf/e66X
        YuyvjB13zixPrIIYcTDEPzsGejLKkW0=
X-Google-Smtp-Source: APXvYqw9yl660lTzGiCVwo5ymsanvmE9qW+C9gLTtS4lU4aAsm0A79DFx7eTKGpV+G1sxXgmat6Y/g==
X-Received: by 2002:a9f:2a8d:: with SMTP id z13mr14211875uai.62.1556047066007;
        Tue, 23 Apr 2019 12:17:46 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id g19sm4302147vkf.33.2019.04.23.12.17.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:17:45 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id w13so8953819vsc.4
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:17:44 -0700 (PDT)
X-Received: by 2002:a05:6102:417:: with SMTP id d23mr5177794vsq.48.1556047064431;
 Tue, 23 Apr 2019 12:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-4-glider@google.com>
In-Reply-To: <20190418154208.131118-4-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:17:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKcBU43YGooE0NSk5BF9NhdHu6vuFOr8Zq6Fq-Dk4jNPA@mail.gmail.com>
Message-ID: <CAGXu5jKcBU43YGooE0NSk5BF9NhdHu6vuFOr8Zq6Fq-Dk4jNPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] RFC: net: apply __GFP_NOINIT to AF_UNIX sk_buff allocations
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 18, 2019 at 8:42 AM Alexander Potapenko <glider@google.com> wrote:
>
> Add sock_alloc_send_pskb_noinit(), which is similar to
> sock_alloc_send_pskb(), but allocates with __GFP_NOINIT.
> This helps reduce the slowdown on hackbench from 9% to 0.1%.

I would include a detailed justification about why this is safe to do.
I imagine (but haven't looked) that the skb is immediately written to
after allocation, so this is basically avoiding a "double init". Is
that correct?

-- 
Kees Cook
