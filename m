Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CDFA3740
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Oct 2022 03:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJaDwp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 30 Oct 2022 23:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJaDwo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 30 Oct 2022 23:52:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F82614E
        for <linux-security-module@vger.kernel.org>; Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso14762894pjg.5
        for <linux-security-module@vger.kernel.org>; Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I21cCJCWzwa8h49wcXGzeXQhOZvvflCzQcd6UuE2zWU=;
        b=KL2LH3b4va5k6gTuWpyglwWk9uIF/pxPF8vz5wfF9STqAI4VNHhFwJbnm7iv1gD+wQ
         DLtFxxalLnDbYfw7+9J6SOiCGvlfIIZRgsJ1cxb8iMH77oElt2+eLpXxIeJOTFzuqjI8
         hS8E6st+Bf0kXUaz0uAJmS/WtsnS009LRV/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I21cCJCWzwa8h49wcXGzeXQhOZvvflCzQcd6UuE2zWU=;
        b=qUfzGskqCYwWk5YtSrLES4e+ANv0W+vaGwaBCxQgJVK/8jSws1v7CEI5xKgIg0ZVDm
         z3JOO5ZUQcNLGSedpmehwIWvBO+31kkmjWC/8rUyKC9wujoB+eOnu34oZcgeg/e+9WR7
         gPWdQbsO7AE4C3DjbqpbZj0Dwuz+K15Tbl+qVOy3Kj4QdvUXklxx0oXPnvKywAlL49eb
         zIpQQ0Tuz++TH5vt4CQLABYAcmZZ5t/katGZrHJqk/msqXre7SDlOndYUYKZ+UqO3r+k
         2LAmEa0QUhiJ2eF3yBVYI5kDENzHdO4dN7fnYk0B6cDthScdCvu3B5NK/6WTcnkYq7Yv
         VPOA==
X-Gm-Message-State: ACrzQf0EaWyIGQiR1UaLWLAc2WwQjqF3gc50m4jIzIWXUCSGUGGdj05B
        4Ql8fyAw1T7kI2F19qjZ6Rm4Ow==
X-Google-Smtp-Source: AMsMyM54jFk2mBz/o1yRYVtXbsqLJ9pdocTsGFyRkYXG7q/qQDt4mJ1zt+SM1g7PD6l1nI+/2Xm7Hg==
X-Received: by 2002:a17:903:40cb:b0:187:1d3:461a with SMTP id t11-20020a17090340cb00b0018701d3461amr11960773pld.155.1667188362334;
        Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f624:9e85:ec7a:fa29])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090a294100b0020d67a726easm3120676pjf.10.2022.10.30.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 20:52:41 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:52:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: apparmor: global buffers spin lock may get contended
Message-ID: <Y19GhTg8Q/3ym/VD@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On (22/10/28 02:34), John Johansen wrote:
> From d026988196fdbda7234fb87bc3e4aea22edcbaf9 Mon Sep 17 00:00:00 2001
> From: John Johansen <john.johansen@canonical.com>
> Date: Tue, 25 Oct 2022 01:18:41 -0700
> Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock
>  contention
> 
> On a heavily loaded machine there can be lock contention on the
> global buffers lock. Add a percpu list to cache buffers on when
> lock contention is encountered.
> 
> When allocating buffers attempt to use cached buffers first,
> before taking the global buffers lock. When freeing buffers
> try to put them back to the global list but if contention is
> encountered, put the buffer on the percpu list.
> 
> The length of time a buffer is held on the percpu list is dynamically
> adjusted based on lock contention.  The amount of hold time is rapidly
> increased and slow ramped down.
> 
> Signed-off-by: John Johansen <john.johansen@canonical.com>

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
