Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA9EB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 15:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGUPO3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGUPOQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 11:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A8272D
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689952377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuECWgmrt4c8ZTlDSWFvVOJXkvdaI59iER7noO41RWI=;
        b=EvkoIsl1Ald/n0VtWGIJbPb/A4z3GOpRj0Fhdz3yIaJA9+IuTR5LFPxCvPVCsM/PPQhaFn
        qzg5hwNlD9wRgSbxTD2TWcJDQZR8wW/OAEghdUsxebgITTS5FZ+r49v9XHkPvQUSvVRIbm
        nP7MgLrNUnZr075+tH0CO8K6Rm76QwU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618--D1dEvMdNouCSAkBt7Z3EA-1; Fri, 21 Jul 2023 11:12:55 -0400
X-MC-Unique: -D1dEvMdNouCSAkBt7Z3EA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb7d06a7e6so2073471e87.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952374; x=1690557174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuECWgmrt4c8ZTlDSWFvVOJXkvdaI59iER7noO41RWI=;
        b=QX+cWXeOVkqbQR9W4s8JrhzEN/IQPbmu7MvqfPTRQb79daPAHY5NAjVmloFf3SjxJJ
         FLzdUY8ExZKtJpsQzXK0F8T1ONg8NvfEYo5C8OAfrjBSWZ9hHn1T0SZm8PINwqn3Hh1g
         HlkaENM6v1i0pqWgB4rVNFY7ZkpDg1oMEPpjw3JKtIYHRKtsbywiZnATGeGb+DDRpV3t
         2bxpdGYWg8CC3/qpWYAHYwjwaLT+iY6yMW5bRMUmpUXKnRT0N1xTlnr/KPuRgTDUgByO
         cw3nF2WtvUNwDwiYQrzf0/h779GXsAfcO2iBiY9QHV/unA1Zc+TxID2NxqsrlXibM/Ue
         Hosw==
X-Gm-Message-State: ABy/qLY8NUnpapz3uXKBEIznoRsitUAI/lj/VqLgDwgAiSJWLnUHO/Dj
        bQOnhtJn/jC8FEXt4+1W19qc5A/H8zedozi5/rDTWMKNkgXRVT9waX4rY+jZVN4c6/VbuzHY8jt
        fSvB3jx3sPj0zLbv8jDI1DmhJTBv27/2iC7yu
X-Received: by 2002:a19:e05b:0:b0:4fb:caed:95c3 with SMTP id g27-20020a19e05b000000b004fbcaed95c3mr1377446lfj.53.1689952374305;
        Fri, 21 Jul 2023 08:12:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7b5XRxViP22WEsYjZVx9eEuQn7vFDvQWd5jPtrRlHnUDSnFTiFx5UF3BQ2XwQWfw7l/MGag==
X-Received: by 2002:a19:e05b:0:b0:4fb:caed:95c3 with SMTP id g27-20020a19e05b000000b004fbcaed95c3mr1377407lfj.53.1689952373968;
        Fri, 21 Jul 2023 08:12:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05640204c100b0051e0f21c43fsm2214094edw.31.2023.07.21.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:12:53 -0700 (PDT)
Message-ID: <6519e3f4-7cea-01a6-724e-a0bce10c3c19@redhat.com>
Date:   Fri, 21 Jul 2023 17:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 16/29] KVM: Allow arch code to track number of
 memslot address spaces per VM
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
 <20230718234512.1690985-17-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-17-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/19/23 01:44, Sean Christopherson wrote:
> @@ -4725,9 +4725,9 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   	case KVM_CAP_IRQ_ROUTING:
>   		return KVM_MAX_IRQ_ROUTES;
>   #endif
> -#if KVM_ADDRESS_SPACE_NUM > 1
> +#if KVM_MAX_NR_ADDRESS_SPACES > 1
>   	case KVM_CAP_MULTI_ADDRESS_SPACE:
> -		return KVM_ADDRESS_SPACE_NUM;
> +		return KVM_MAX_NR_ADDRESS_SPACES;
>   #endif

Since this is a VM ioctl, it should return 
kvm_arch_nr_memslot_as_ids(kvm) if kvm != NULL.

Paolo

