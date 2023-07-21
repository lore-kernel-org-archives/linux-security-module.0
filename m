Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F494C001DC
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGUPJN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGUPIu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF530E2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689952075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AtcGzkETEnO18qgeRoihrAkrVd5qbbNpgaZO4bjwaRo=;
        b=OIiJIK9H6hYJnppIT6Fx/0GHwkQuuhI/vffYTVQcpBzzesLxatQQATn4+O26fyb3SqVDMe
        5g0O+wYwaQVJ66w7JaaiBrcg0cY0R/o4WHwzmltF512oybq1eP77yCv2upkvD13t04AyPH
        c8u2sypuXSVKg7ICjj4+H6K2LnJ8tK8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-snEBqkBTPBOwjiMN22_BOA-1; Fri, 21 Jul 2023 11:07:49 -0400
X-MC-Unique: snEBqkBTPBOwjiMN22_BOA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fdde274729so1810236e87.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 08:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952068; x=1690556868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtcGzkETEnO18qgeRoihrAkrVd5qbbNpgaZO4bjwaRo=;
        b=DjdoeUXUwVooA+u6oqRHrwXu1jsrPombdEdsZ5UYijPKH3UShTnDWOsRHdZF1ik9RR
         0BBqlip0fs92zzQqs6YGw3CHaU2e7gHtV5XKPCyQy4HCPQBlR6t3NA/u+0y1gupcBAnP
         z1R5feVbBX3BMhBqdpwzCqopg4WQezPFsppgDj8lehZAa1RDiOROCOulaH13CRqXcyI1
         S8FBwIBrzoXJfVxemOJu+tkfFRyOYUG0pjtZWAbcrPrSpUT/EDhr+YIk6lWQXlbwBAcd
         LvnHpa/OHcz1OllKfyMRxS1/MbARSmqbalgCVXFTWLjQXhTlvslWCIrW1zkeM2im8jG6
         rcDA==
X-Gm-Message-State: ABy/qLYZ5bJn0hYFpQEmMgGp86OiWpfoqPmutvgdZYjR0D1dmkWHFrAR
        3lYdm/PWssEzvx624M5h6Y+AmvlO0vtrMil+WTuwiLLmIuDFmyRmZgGaprTVaVhb3jGPiRLJlhW
        uKIKUQKMnQbIvWGpOFlwOAbTaAtEfB5uywfkw
X-Received: by 2002:ac2:4191:0:b0:4f8:5ab0:68c4 with SMTP id z17-20020ac24191000000b004f85ab068c4mr1303809lfh.59.1689952067656;
        Fri, 21 Jul 2023 08:07:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGo8Pi+B+7hRHqSy6ClZ4oP94DPqHOZMbTIQ3rRFkaZiIFeWC2//bW1iNqq7vZ0rxNpIdgKag==
X-Received: by 2002:ac2:4191:0:b0:4f8:5ab0:68c4 with SMTP id z17-20020ac24191000000b004f85ab068c4mr1303798lfh.59.1689952067306;
        Fri, 21 Jul 2023 08:07:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056402074100b0051df5eefa20sm2257329edy.76.2023.07.21.08.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:07:46 -0700 (PDT)
Message-ID: <123035a3-9d0d-70be-9894-f89a84c7e8fd@redhat.com>
Date:   Fri, 21 Jul 2023 17:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 15/29] KVM: Drop superfluous
 __KVM_VCPU_MULTIPLE_ADDRESS_SPACE macro
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
 <20230718234512.1690985-16-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230718234512.1690985-16-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/19/23 01:44, Sean Christopherson wrote:
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 -
>   include/linux/kvm_host.h        | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b87ff7b601fa..7a905e033932 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2105,7 +2105,6 @@ enum {
>   #define HF_SMM_MASK		(1 << 1)
>   #define HF_SMM_INSIDE_NMI_MASK	(1 << 2)
>   
> -# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
>   # define KVM_ADDRESS_SPACE_NUM 2
>   # define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
>   # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0d1e2ee8ae7a..5839ef44e145 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -693,7 +693,7 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
>   #define KVM_MEM_SLOTS_NUM SHRT_MAX
>   #define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
>   
> -#ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> +#if KVM_ADDRESS_SPACE_NUM == 1
>   static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>   {
>   	return 0;

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

