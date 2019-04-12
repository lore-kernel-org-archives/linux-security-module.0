Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52423C282CE
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2067E20850
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eumZZKoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDLOQ2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:16:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32944 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLOQ2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 10:16:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so11422860qtb.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2019 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNfbrBu7Kf9YbRjnRfGu2WkpXEstm8Do5o3zkCQBOsE=;
        b=eumZZKoBJ/J7a6yZvp+R0ymoOPiMq5XT5S4PwM65P3vrvD20o2zsyrfkkdun5UN7CV
         LPt1ENh3ifW1ZRYnNxRAzmjz4jVP5AAVB79gk9pf74nUEnDKWfg6Bw6Z5qy3xnyHiePU
         LSy7GQXYQttk7Otx7n2V3j9wz1zxN8wQm2Vpr8G6Y1+stOD9mKxvFpRHrV/u8nZbGn9z
         eKPp2H8AxXU8HOUJLLETcz7XjkSZ7dZ47ODe58Mbi1EQMYm5VIfW09Az8ND7F6BsqmGu
         GgMagBo5MQnUhJQcy3g6TBDlKVl6x+aoFhHeWzvhVdcpqKgNqcesBqRG8AQm7vzdTKnv
         kieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNfbrBu7Kf9YbRjnRfGu2WkpXEstm8Do5o3zkCQBOsE=;
        b=DDYB/aeB3/auLcX0TppXn9eZAwMkvtY/SKC2LpLsz8WSaNw4RCYN8gLAkFlP+t97HI
         /KWHvMnQKK0/1bGYs5MxjYoxu68yDdNA4eqSttuRsHqn4vD7WD3CPz1Vl0was12R77IY
         AFIGZyPWbuuh1PM+P7VjxtBYJ6bA6LE3Ktg46C7IU8Nx9uAr06W/bYgW84VV+xtEvqo7
         /1FDnzMJyaR8D3LUJyZkuiIB6xX32DFI14sCUDYGBvYgvmwCAaSarvR9fSNwhcXCojSp
         uBlJFj60bUV7v/u9pmXoJR2kVQADHxZbsd7P88ho2oOBBRPkQNtzK1BZ/3r6xKJ4GbkV
         8PXA==
X-Gm-Message-State: APjAAAWFvKcpxSFMQnLwy5k1uFTZMpRq7OQoI1f/E6lcEBRKA3bO6PHw
        1BvBl9z0mmv4ZdbZHzANIdNMig==
X-Google-Smtp-Source: APXvYqyXKlNJWDYZCf5oo200N8SzRVdIL+ocZ9fNq4nkloba4fzT/Zza6kqRyNv2tAtHBLnzjFOUJQ==
X-Received: by 2002:a0c:c165:: with SMTP id i34mr47138291qvh.6.1555078586767;
        Fri, 12 Apr 2019 07:16:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s2sm10321417qkg.67.2019.04.12.07.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:16:26 -0700 (PDT)
Message-ID: <1555078584.26196.50.camel@lca.pw>
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org
Cc:     linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        ndesaulniers@google.com, kcc@google.com, dvyukov@google.com,
        keescook@chromium.org, sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Date:   Fri, 12 Apr 2019 10:16:24 -0400
In-Reply-To: <20190412124501.132678-1-glider@google.com>
References: <20190412124501.132678-1-glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2019-04-12 at 14:45 +0200, Alexander Potapenko wrote:
> This config option adds the possibility to initialize newly allocated
> pages and heap objects with zeroes. This is needed to prevent possible
> information leaks and make the control-flow bugs that depend on
> uninitialized values more deterministic.
> 
> Initialization is done at allocation time at the places where checks for
> __GFP_ZERO are performed. We don't initialize slab caches with
> constructors or SLAB_TYPESAFE_BY_RCU to preserve their semantics.
> 
> For kernel testing purposes filling allocations with a nonzero pattern
> would be more suitable, but may require platform-specific code. To have
> a simple baseline we've decided to start with zero-initialization.
> 
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.

Sounds like this has already existed in some degree, i.e.,

CONFIG_PAGE_POISONING_ZERO
