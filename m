Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578EC001E0
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Jul 2023 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGSRN2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGSRNS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jul 2023 13:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0751733
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689786746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkcPX3Osb4OA2D5IidduaA2zXjGkNlWKrQ0mhSge49c=;
        b=Ks93h3vtqS+uYmBR9wdp94NuYQOIw10HTA1wrD0Vi8kOR603y9p9aYfS6285k6gvUUZJCJ
        IbExLWZmtckmvuAf3M+poNZUTwwaSjlfneAb8yT+DHQP7rGvbZqwpzHPWEazHUJMw6fgCL
        Lblm47gR2vFKNgHNueyaLbmH/7ORU7M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Q5BPe8PwPX2cR1BGtcfEDQ-1; Wed, 19 Jul 2023 13:12:24 -0400
X-MC-Unique: Q5BPe8PwPX2cR1BGtcfEDQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9932e8e76b9so418983166b.3
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 10:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786743; x=1692378743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkcPX3Osb4OA2D5IidduaA2zXjGkNlWKrQ0mhSge49c=;
        b=AxBjteOfxYctjzh0Z1FFQWct30+G6J7KdCmkXIEsQF6+UbOfItd0jz6UIDprJLGnkw
         yGbeLZO+h8H8bnv/w8eKPaJ2WYEqvfIpynPVlymuv7W1nJ7RcoxvTjWfbK/1mLFm+fxI
         hWPAEM5tUsAx43JCjzlzxxC+dmhmQsr2cHMyJWTLAaw7Q3LfjSAtgq02ajsPV2b33Pa1
         /f5PbL36PftVa2zL62fJDigZWBD2v7sgot0VpdA+ovp4a6t0E+cWot0+SzdznvI03nVh
         FWnm0d6xdC8whHv8FcSSGJ7QOXb3ozxoxwiSCFESjhk2GpcGJ6PrA8XHK0MPKXdsWY9L
         cr0w==
X-Gm-Message-State: ABy/qLbG+D5rcxvbpoohKvDYOXID1KwHmL/JSBc4bR3ayRFWs68SnQ/5
        FotxuXWOKvCd9XucdQibdtFk4i5Ns00WDfnQtJrvFn1Tq56V63jAIW/mg883/kIzLlgM5jXEoj8
        /8m8xPyvGUw+NUqLghBMVr+xrY5GNaNgeQ2wW
X-Received: by 2002:a17:906:d84:b0:994:54ff:10f6 with SMTP id m4-20020a1709060d8400b0099454ff10f6mr2451567eji.30.1689786743714;
        Wed, 19 Jul 2023 10:12:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGz54zGhPvYMbmpFt53PQK6LgNX37cQEB9yNTieid5ItMiwID6yFOylHPqQjVFsqfqQ8BKwkQ==
X-Received: by 2002:a17:906:d84:b0:994:54ff:10f6 with SMTP id m4-20020a1709060d8400b0099454ff10f6mr2451551eji.30.1689786743496;
        Wed, 19 Jul 2023 10:12:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id h24-20020a1709063c1800b00989828a42e8sm2589100ejg.154.2023.07.19.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:12:21 -0700 (PDT)
Message-ID: <095133d1-ad3a-8b5d-d000-10b0b377c7b3@redhat.com>
Date:   Wed, 19 Jul 2023 19:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 02/29] KVM: Tweak kvm_hva_range and hva_handler_t
 to allow reusing for gfn ranges
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-3-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/19/23 01:44, Sean Christopherson wrote:
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> ---
>   virt/kvm/kvm_main.c | 34 +++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 15 deletions(-)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

