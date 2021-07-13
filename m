Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D6C07E95
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jul 2021 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995D761166
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jul 2021 13:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhGMNWr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhGMNWr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jul 2021 09:22:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00BC0613DD
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jul 2021 06:19:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 21so19593409pfp.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jul 2021 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sYaLI5hREs6S0GCn5kt31M6b+bWhHLGZQ73MTTA23MY=;
        b=E60K6rOVubJWxCl5FlN6nDmOD5MG0l6g8MRW71VqK/ZgOuHK4IIFJUJs2rkCsCqq5X
         JTXOWjW9k0MiBAVxgm3NhAXgVJGVqELXGp+RLSOkUORU3bwV7d3UV4YyvjLYYUTfQtKX
         wR6a2Ksg+z+gj5loBep8jhT2BEjD7HR82E//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sYaLI5hREs6S0GCn5kt31M6b+bWhHLGZQ73MTTA23MY=;
        b=ODdqSA3T6WD/63Lrr5wrpA5LjFxZW2E+uDm3XdUH3ZDvRtMCYvQf2G43MDFFVpvTRV
         W3QfNsrpY70TE4saCgZNnpPWwaGk2vcQXtzqffLMpWvPNNZxZ9UxwfeLEu0iZZ/k3IVo
         pE3EwL73LDOApWdwWYjcgOEDoe/Oprb5c4K8+FiJA7Zphk9a2FgWzf+kmcVLifgWMSuK
         WxwX6Tfc4m0h6Lm9DYq1ADefTRpP6SxrB+EJ077QdwhUj5YoJBx9fvtZRFeAsKPG3F7N
         UU1Gyj9ephseDH2ZnNwbCi28xcrf/bqoe2y1xvd9rfJMO8BGXRtPhFOCLUtAOoilkkdb
         0Cng==
X-Gm-Message-State: AOAM5302o4dFkZeDNx4VKmWN+JQss0VBskNN6LosaIvlgN6Q3ggcEZgT
        wWR1u3TRcxkVxOU+xTUNk4tw3A==
X-Google-Smtp-Source: ABdhPJz/Hrby3BnB86LdkmOz8m+7CJUogDKjNLjMHs2y7/3yHj8hq2Nfoie3OSv1kUQRR8RBUGrQ9Q==
X-Received: by 2002:aa7:82cb:0:b029:2e6:f397:d248 with SMTP id f11-20020aa782cb0000b02902e6f397d248mr4759999pfn.52.1626182397180;
        Tue, 13 Jul 2021 06:19:57 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:e304:7803:b108:f108])
        by smtp.gmail.com with ESMTPSA id d129sm19492414pfd.218.2021.07.13.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 06:19:56 -0700 (PDT)
Date:   Tue, 13 Jul 2021 22:19:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Johansen <john.johansen@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: apparmor: global buffers spin lock may get contended
Message-ID: <YO2S+C7Cw7AS7bsg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

We've notices that apparmor has switched from using per-CPU buffer pool
and per-CPU spin_lock to a global spin_lock in df323337e507a0009d3db1ea.

This seems to be causing some contention on our build machines (with
quite a bit of cores). Because that global spin lock is a part of the
stat() sys call (and perhaps some other)

E.g.

-    9.29%     0.00%  clang++          [kernel.vmlinux]                        
   - 9.28% entry_SYSCALL_64_after_hwframe                                      
      - 8.98% do_syscall_64                                                    
         - 7.43% __do_sys_newlstat                                            
            - 7.43% vfs_statx                                                  
               - 7.18% security_inode_getattr                                  
                  - 7.15% apparmor_inode_getattr                              
                     - aa_path_perm                                            
                        - 3.53% aa_get_buffer                                  
                           - 3.47% _raw_spin_lock                              
                                3.44% native_queued_spin_lock_slowpath        
                        - 3.49% aa_put_buffer.part.0                          
                           - 3.45% _raw_spin_lock                              
                                3.43% native_queued_spin_lock_slowpath   

Can we fix this contention?
