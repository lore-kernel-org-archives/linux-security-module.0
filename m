Return-Path: <SRS0=6iY4=B5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED8C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1248D2067C
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEkhe+wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHSWSt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:18:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgHSWSr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 18:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bjqS+7/ag+GlZL7MDHoI6q1qHsiFIMlTVT+GfWM93es=;
        b=iEkhe+wQtLRb/ctEAHYaFmhOoi7xgGA2Ck+CCdQFZ7QVGs1ViZQe/JfMzPghElZMDP8e+t
        Jb0opi4HUJvCGrcuh+m4DVLr1bxoCLw1lKexAFZ+wRr9L/dyCxX1o+pOFoYctS03Qtp/zW
        ZGzHKg6JDp3irdbJ0UEAQAEJTqhY9fY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-DtJWny1lNd26hNuDX1g3qg-1; Wed, 19 Aug 2020 18:18:44 -0400
X-MC-Unique: DtJWny1lNd26hNuDX1g3qg-1
Received: by mail-ed1-f72.google.com with SMTP id c16so106562edt.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 15:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bjqS+7/ag+GlZL7MDHoI6q1qHsiFIMlTVT+GfWM93es=;
        b=LkEZXV16WNEX4KdeKUCGfEXGm2qZCdSRQ6TsW41Spy2oMtw0Mv1UnkuRnHXVe9Ha50
         kj1QmRpkOazGoUftOX2Nd1V3hqXAlXl4v2XL4wavo0f6HxpEnOp9N6JWVYoJWaFp52LB
         14Jy1aVD0aQiua8VuYk0bYRRBdiA51sxJBr/rd+CMDeBGDJ/t0YnvCCmQE7mgl6oHn3X
         +oQ3VUSJxYbd5mQ5Zz+0e/O0LPf+TX/UcugdPbGQFq6g7oHuWu4sUKjF1fGzfbe+6ipD
         5Xk3Vy4CpYTN9mJ7HzekTOZYgyvhvZVYETXE2km/jF78whL22XmVVPfPdSs2lmIy3K4Z
         nL3Q==
X-Gm-Message-State: AOAM530bprC7r/2XaSbhtyxsvFTtLvEizqJip3+FwzVBe3EyJNCajszG
        1aGdRCTumkED2zKYV+4dddx5r+XsWYJiGFmNKOy7MoMj0sfK/67F6GjFoiNAiUuKk2BtUX8Vpff
        2n51hLztFiTxnZoiW1p2GtEmwzjdSdrbG1698F3FYDMykPSeIrY/Z
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr131679eds.363.1597875523804;
        Wed, 19 Aug 2020 15:18:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnZye/Q8HkQ4liS+Kqt3asNqB7AE105skhLVQlf7vnO2U3mWIqSDEIdoJ51ctolKi0kmHjHkkCYh4rXfBMZLk=
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr131670eds.363.1597875523651;
 Wed, 19 Aug 2020 15:18:43 -0700 (PDT)
MIME-Version: 1.0
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 20 Aug 2020 00:18:33 +0200
Message-ID: <CAE4VaGD8sKqUgOxr0im+OJgwrLxbbXDaKTSqpyAGRx=rr9isUg@mail.gmail.com>
Subject: init_on_alloc/init_on_free boot options
To:     Alexander Potapenko <glider@google.com>
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jhladky@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Alex,

Could you please help me to clarify the purpose of init_on_alloc=1
when init_on_free is enabled?

If I get it right, init_on_free=1 alone guarantees that the memory
returned by the page allocator and SL[AU]B is initialized with zeroes.
What is the purpose of init_on_alloc=1 in that case? We are zeroing
memory twice, or am I missing something?

Thanks a lot!
Jirka

