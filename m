Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8353C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 19:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC72961186
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhIUTCo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhIUTCn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Sep 2021 15:02:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14965C061575
        for <linux-security-module@vger.kernel.org>; Tue, 21 Sep 2021 12:01:15 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t1so57154pgv.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 Sep 2021 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uUvwtgDvS9z+MmLCsIbndyuppV43gHnzlz5qvL6KeNg=;
        b=c9uP+rap/UfN7fREE6h8u3lsZij8/9nesp5oAq6rWx9xNnYvzMF9PP463fCmsUqDar
         kEwNNzzupFjl3iVssQImb8bF3h2/B/8MlMGNIDKsuMe9bchBPSyFkLc+uuhUiy9QTIMI
         6UVxssDsqkegyngHCgoDjyvtGGXIsR18yy7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUvwtgDvS9z+MmLCsIbndyuppV43gHnzlz5qvL6KeNg=;
        b=3QT+Z7RhVBYY5q1qqu0Bisf5TAB1TZINe+DlhOzcWDtfvLidQCIw8Q71YQtVDv3BeL
         cPzRgZkvDdVlh5QYRwxcXNhBgDbfEXvr7iaclQgOvOMRQySRCy2DOek5NMb31m+FLQPw
         h4OPJ60toa2FJpRCnbVpzzb7gTg3fCoystWcmi7AQJKyOmqgT1EtA+vtwVbmXLT6mvJS
         tHI/IS9H8vEe/H1RGa02qzYJx9sDAebXiorBiF+VGqcU1e29xuAWbI0i0kGCX2maWKK2
         Mh2+wvtRzQvHfRyl5+UnoxjClFD1Q0Vr3x0yq1Uw5T48MwSRe5TSDGzftWxCEmeVX3kW
         +ybg==
X-Gm-Message-State: AOAM531auoIl4RBCpDM5lcQfsMHSsH5BiuA8U1DJ92ghSGjIQpj5GMO1
        eBO+8WQgz0s748fypQpdl7jcyA==
X-Google-Smtp-Source: ABdhPJyhkEtFnUnBg+9qtMK4KmQYa6j/evLKD74iespv+jzZ07EoQOA7rlY7bUrm0t6g+7REwX8YJw==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr3869655pgs.45.1632250874538;
        Tue, 21 Sep 2021 12:01:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6sm3451285pjr.36.2021.09.21.12.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:01:13 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:01:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: Remove HARDENED_USERCOPY_FALLBACK
Message-ID: <202109211200.14E421C@keescook>
References: <20210921061149.1091163-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921061149.1091163-1-steve@sk2.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 21, 2021 at 08:11:49AM +0200, Stephen Kitt wrote:
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

Thanks for doing this!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
