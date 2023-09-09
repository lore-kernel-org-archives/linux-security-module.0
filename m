Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E0EEB57A
	for <linux-security-module@archiver.kernel.org>; Sat,  9 Sep 2023 00:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjIIAPz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Sep 2023 20:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjIIAPz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Sep 2023 20:15:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A081FE9
        for <linux-security-module@vger.kernel.org>; Fri,  8 Sep 2023 17:15:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so21399527b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Sep 2023 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694218549; x=1694823349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaKhly8Aj9nDlRectFKYGw3FxO6EGE4C2aH6vsrGIcs=;
        b=KKQYboSqcTfMiYuHqb6JaslyaUwLzygQtr54knTg8NFmKZzW9Nk9F02RAnx7QH76ia
         RSnP7F+UCzWFEgW1vS7n2nD/rmqu97xxXhcj5PwkUBzHhxGFYXhOM0um0yr9FX8DpsCH
         21bYQnWQAdXtwyqFTHsM9D2GXmjWt7d51G5geMz2N4THsLnsSmGJFJh325W3DOtzhQG+
         mKmymS6dV9lG4v1aHafJwZMd4+rREJjtGYyKpGi9L+IMoZ3vprp5C3XlcQHUBn1z2+j9
         MaVh85U/qkraojXJqCxJBnLJIvLcUlXYYdEsb1ph6ov4zAOxrXGLaXGELdxBclajwmko
         Lk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694218549; x=1694823349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaKhly8Aj9nDlRectFKYGw3FxO6EGE4C2aH6vsrGIcs=;
        b=mRBkgCXGc5LzDz0w8QK++1gWDWSwkyTLyfZuBfOD2p6I6AeS0/AchNa7NXarMiMn+z
         9Vto83vuGUuOXO2kDDM11FfsFLJcyDcprYZfZ18VR7RoB1pvlnFJBmVWJcSarXhZqatj
         5K7ewBYVZDHMlJCtFslV3RYo5Ss1kkNBAgD7HXvyJ7rWtI5a1ahxo8mSHJyYsvGyQumV
         xaTl9mtU/M8SNqXXpIQaSUGIuPwGYKslGYUsgUUeLnqrK0D+E5Jjo+ssNwvV+ftxI2vR
         zI+a6IX4EfvT/yagZ7tlA3Bnzl60RqC0b9xignSxyggA9rXhp1Y8/Dn/LGNg2RnXDTnF
         mr9w==
X-Gm-Message-State: AOJu0YzotHOF8WbtjmXLRoMVVSSk7X0rs6KWcVPpJF64X0+5xxQsNU7c
        5FG2ckVXJq6tYuIvxLt6mpfLl/PL+jI=
X-Google-Smtp-Source: AGHT+IF1C60bg2DJN40Ko3jIsOcOxP0NOjMSP0DFTt+pfC3PQMs+2qr1EtNSX5EQJ2FP9+vXkLa3AHa75+U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9848:0:b0:59b:5a5b:3a91 with SMTP id
 p69-20020a819848000000b0059b5a5b3a91mr89060ywg.2.1694218549752; Fri, 08 Sep
 2023 17:15:49 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:15:33 -0700
In-Reply-To: <20230908074222.28723-2-vbabka@suse.cz>
Mime-Version: 1.0
References: <20230908074222.28723-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <169421599820.98577.9267896589643015779.b4-ty@google.com>
Subject: Re: [PATCH gmem FIXUP v2] mm, compaction: make testing
 mapping_unmovable() safe
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, isaku.yamahata@gmail.com, jarkko@kernel.org,
        jmorris@namei.org, kirill.shutemov@linux.intel.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com, willy@infradead.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 08 Sep 2023 09:42:23 +0200, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable. To enforce
> that expecation, make mapping_set_unmovable() also set AS_UNEVICTABLE.
> 
> [...]

Applied to kvm-x86 guest_memfd, thanks!

[1/1] mm, compaction: make testing mapping_unmovable() safe
      https://github.com/kvm-x86/linux/commit/4876a35647b9

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
