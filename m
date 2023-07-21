Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC355EB64DC
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 17:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGURSc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGURSb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 13:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B26171A
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689959863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQftevPX0XUeLPrBO0NAWxPIrge3Hp6/1+H4UC+Ikhg=;
        b=jOullois1qXlg5Og+Hk4Cxtese+TCHcC8rw2CeBbTUYPjQg7FTnFa6SP0p+5V8JrHXT/da
        mdFJ8HQdnvBlcY9viQASyeBegU5sASkpq5ANhGB4LihO0dE487hh3CGC6sPdmnpAAuSMU7
        inuj12KMvP2UdGF5aE1s2CTQsTtq9hk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-robXo4jTNtiWJ5l6YT9lVg-1; Fri, 21 Jul 2023 13:17:42 -0400
X-MC-Unique: robXo4jTNtiWJ5l6YT9lVg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso1345608a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 10:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959861; x=1690564661;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQftevPX0XUeLPrBO0NAWxPIrge3Hp6/1+H4UC+Ikhg=;
        b=Orbuep8FHMEzoZx4/UujDnyEJ8DC2U8u5UOiSnwg0zCJ0so3owHkHd99WeJWsOtKgS
         ZLWaKKtS9HNDwoUHIMrhcxL2M62fateYUG+EhFoYg6lk7O7fpvhnq+d62FNYrLayVBzf
         79bqNLjbuSTip0/WzKQ6menKhTRkkscYUUDhhCd4gV9A03OlPN9bxUFppxmY8N3hwUty
         8cElZirhSmObvFvpooqGByisoALmZrajkniRP/KTe9V/eXEyY1g4Le97DlBEONfluDSW
         CY95eUcfDVbO2E+pVHcjqXC6zlP1AFyZsFpWXynmg8h8E8QaZDafcnfrgFKUPOm/aNYZ
         Nm7g==
X-Gm-Message-State: ABy/qLaL8PWyvDrjsAAN/1gAAOvLiBtuEjks35TRcnBEbW2330vaEjSv
        XgFOd4f5D9T2GB11quc2GWOm+5U0YUGhmYYukCQpglhOjoJxgvcoCXyA1M4L2hyK0A59KFFB2Ia
        vBbvgOjSTEh8UZc0SkP0AnUkdhnc/mK9g1Gzm
X-Received: by 2002:aa7:c753:0:b0:51e:1a51:d414 with SMTP id c19-20020aa7c753000000b0051e1a51d414mr1878167eds.32.1689959861038;
        Fri, 21 Jul 2023 10:17:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFyyf9U2FFYwtGg7Nfx7TqscSvBa0fBBUyOLoWSpgQImoylEzXmYhbWs/84TcbA6dVob4NtSg==
X-Received: by 2002:aa7:c753:0:b0:51e:1a51:d414 with SMTP id c19-20020aa7c753000000b0051e1a51d414mr1878159eds.32.1689959860744;
        Fri, 21 Jul 2023 10:17:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id l9-20020aa7c309000000b0051d87e72159sm2346640edq.13.2023.07.21.10.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 10:17:40 -0700 (PDT)
Message-ID: <8ad7a846-64e9-a3f1-4bf1-731a994d62cb@redhat.com>
Date:   Fri, 21 Jul 2023 19:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
 <20230718234512.1690985-13-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
In-Reply-To: <20230718234512.1690985-13-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/19/23 01:44, Sean Christopherson wrote:
> +	inode = alloc_anon_inode(mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> +
> +	err = security_inode_init_security_anon(inode, &qname, NULL);
> +	if (err)
> +		goto err_inode;
> +

I don't understand the need to have a separate filesystem.  If it is to 
fully setup the inode before it's given a struct file, why not just 
export anon_inode_make_secure_inode instead of 
security_inode_init_security_anon?

Paolo

