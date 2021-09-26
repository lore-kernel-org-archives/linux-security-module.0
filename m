Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05606C433FE
	for <linux-security-module@archiver.kernel.org>; Sun, 26 Sep 2021 20:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22A461038
	for <linux-security-module@archiver.kernel.org>; Sun, 26 Sep 2021 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhIZUvP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 26 Sep 2021 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhIZUvO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 26 Sep 2021 16:51:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC34C061570
        for <linux-security-module@vger.kernel.org>; Sun, 26 Sep 2021 13:49:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 203so13869231pfy.13
        for <linux-security-module@vger.kernel.org>; Sun, 26 Sep 2021 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1Xi2zI3xz++jAU4KL461gSjO8O02r5P5HLSbGNQJnPI=;
        b=YNUKZmOzFiHeJ2mJa7gvVYN7uN2TvfskQSN1D5sRVykhEQSaJ9ruR/0/YcZL/v6m+1
         ej1FfHbYG0ay7WCE+E3fA04decWx+gxNMJh/2AfKb1EJT5DQhro8je6KQpQGeHKkDbsI
         2Vo6bqf1guqWezlCcy2Pu6ROHYsiuxXT4kAlFIb+PM88X+oLVX6srxEMUnpVmYtptPL8
         WAOiHaRdS1eZovd/jq4qVEL92/LIrjngBpm8KGcaYFTn8I1F9IQaKEEHQjkczzN5zKka
         GwufIKM8VX78GbMlNVMgRK/KoB016OeVF3XuaLuGYvlJ152+ArnP4IkuG15uKtU0UehI
         POCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1Xi2zI3xz++jAU4KL461gSjO8O02r5P5HLSbGNQJnPI=;
        b=zHK9zsYOrBe/xLalgUMQB5Psfuw0BRHePC+rwxBMMP0UJntMA07nuhTyUPEihepFoJ
         pZXzbO+x4NCIiXw+KvRucT0Xx+HJkPpvSDcAtetL5aRipYWSW/A8YUfzpCd+/utE4nrK
         YhGZ+dBNO/IZlj8IxaLFo27eefz7DHrTIe94ieljk/SzwqqTGIi+qcTqGuOfHECIAEV4
         reKywtPsQZtFJsAbHKChv7djxuOFAn7kQbb4ls5QRwGqJf/Pr66U//VoyyfBZV0qCh3I
         jyy82L8Qb18eUoXiTUWq9UJrb0YS3HqOF6gN+xA421mDxDQ3FtQp5LEzvRJZVnMiog7F
         j+9g==
X-Gm-Message-State: AOAM531Vkm7mAh07VQlA6n7MtXRlZ1lrHeO3CTzc1f5h0CMwa+cZ6QJp
        wFQKVGVoJh72QS2rTIsAF9yu5z3EnQuaaA==
X-Google-Smtp-Source: ABdhPJzndYH2uLj5kPrP3Kat7T50/IOEb8DNH7IWYo8ePwhsiil1vOxBGyaBm89cXY3NegHO0nVNfg==
X-Received: by 2002:a63:4457:: with SMTP id t23mr583580pgk.354.1632689377421;
        Sun, 26 Sep 2021 13:49:37 -0700 (PDT)
Received: from [2620:15c:17:3:4d45:c2:971a:f134] ([2620:15c:17:3:4d45:c2:971a:f134])
        by smtp.gmail.com with ESMTPSA id q13sm6606060pfk.128.2021.09.26.13.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 13:49:36 -0700 (PDT)
Date:   Sun, 26 Sep 2021 13:49:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Stephen Kitt <steve@sk2.org>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm: Remove HARDENED_USERCOPY_FALLBACK
In-Reply-To: <20210921061149.1091163-1-steve@sk2.org>
Message-ID: <d2dc495-98c8-9a5c-823f-bb1cd55a8d4@google.com>
References: <20210921061149.1091163-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 21 Sep 2021, Stephen Kitt wrote:

> This has served its purpose and is no longer used. All usercopy
> violations appear to have been handled by now, any remaining
> instances (or new bugs) will cause copies to be rejected.
> 
> This isn't a direct revert of commit 2d891fbc3bb6 ("usercopy: Allow
> strict enforcement of whitelists"); since usercopy_fallback is
> effectively 0, the fallback handling is removed too.
> 
> This also removes the usercopy_fallback module parameter on
> slab_common.
> 
> Link: https://github.com/KSPP/linux/issues/153
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Suggested-by: Kees Cook <keescook@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
