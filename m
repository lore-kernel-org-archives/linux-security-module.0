Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32258210198
	for <linux-security-module@vger.kernel.org>; Wed, 25 Jun 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838976; cv=none; b=Z2IR2T99kGbrIwuQj4PFdvadlwP/eFTZ5PMDat/larjUASM8WlLgum28nGqbqxo26E5HYrXOxahs9x1bmxyPvYSI0ldP5RaJFbiJXTV34WZ/ded7uSBy1UbRZkd/rRflRvMfTNF0pmdt3kBckhX2DOagGMjIDkG2QPmRslq8a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838976; c=relaxed/simple;
	bh=k4QqOnY5n4kSSvGI2Ff6V9C6tGWaisl+ovQgrEI6VwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K484oov6MlwblNCqpatLm4O/0WdEMvUXB06DItnShf0YXH/D0uFhOVAOof6XmWZD/0T7k7zXc2VzjWl6jsMarM19CbZy3OjdMcT6GY5/mafCHucAcrBD65tJxMD8mgbSGD1zEQCl3XGYtKtLEtEJUll+05jNUnLwDqT4pmkyIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBRekYJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBRekYJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750838974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xwSZ1HcItWh2kHExNL9FlSdGICB/8peAJVb69puN99w=;
	b=dBRekYJ/hXkiT1JUjVvPBm/uXxJ1/K5RUrNMeYt66IT8X9e7dF9VaDwZe09cwp9Vt4jeM2
	hQdUxpT/kB6ftafrIFModpiHtX8kRiZ74fcT2twDIOkVoD3xHM3WiunjljSJ+jt2g88pV/
	kGHMR8b4oIJf1lPhNBAXsCXh5fiNyrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-2JxsMZ4GOp2zUE_JC_9a1A-1; Wed, 25 Jun 2025 04:09:32 -0400
X-MC-Unique: 2JxsMZ4GOp2zUE_JC_9a1A-1
X-Mimecast-MFC-AGG-ID: 2JxsMZ4GOp2zUE_JC_9a1A_1750838971
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450db029f2aso5255925e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Jun 2025 01:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838971; x=1751443771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwSZ1HcItWh2kHExNL9FlSdGICB/8peAJVb69puN99w=;
        b=YJ9L/+mMDfycRUrP0ZNcjLmyaKr0TGzoLnbkpBKiyemSMp0GHtelfl+W7Ruw6sAN9S
         DwW/dzEleUKTTceOI/gMw1sirQPqZ6ns2/R7tvu5XzcuHtqvCw5VKExqw2Fd34Sj0LAs
         0DLtVzZUM26X5XlLrSEfuDrPREbr8VgHoo3y2ZVP8esv8khG+IfnSffE7tVLcHODlBnP
         Y56OqqtA3PlFZ4OWrroaUnie8I14P4EIcAB5a9BWNeRyXtYaLjE62rb7JldgqdOGVt6s
         pT9CoapJkthTeM8xPyhNRGDpK4L78sjnaCbKFMVQK6qYVHs0RrdSQwdv43NApHP4B3Xx
         bNDg==
X-Forwarded-Encrypted: i=1; AJvYcCU5+yosb34T17TE1Fu/x6eo45kztlZzNuovA5csCd5Pidj3o7Jrpu+Zy9bst1TO2oj/NHwNwtrCXcMH1u5cBh9uw/Yz52g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtmDg9zd90gFtb3sqsWK8Nujt6Cq/zk9QoYFqWxjS13DSzHtI
	HJnPUh+BFcZgROkNgPSYQYVXvZBdUPGAwH0lb2c8Ptq6nMW46NLYJiMRz3i3MObKGcmK9PZKg6d
	xGfjwQGGdsnFi2NmUEbTvaUnlCmG0anB3cQxS+k547EhO/EIOO+/LP2b/884A0aQliFUzUf8bgB
	U0AQ==
X-Gm-Gg: ASbGncuJjE56kngfHgJ+4DWpy9VTdqdZSxKChDHnMN6CKEgDGpoj2BNmDVWEq5bxA8S
	mDvd93veGmoa3Yf+R5V4h/1p42xbU8Xxq2pVOyS6v69jZM+k2JymYCdtSc7D0Rj0NPG3ObxAVoR
	uAzHMg4g8VkVKKk+giYGFllWIZ7dBjJ2kpz8PpaNDPLJIRJ5VfsD7jlS+/OEomncIrK6THGZkrS
	p9f74BpDG/vcxqbuVeGVDMPpVPFfmJ6mbvFWY28xcVlRtg6eDWPx8hnPoQbPbhSpdvX02xaN7gi
	pQRl0CYPiYO7iePcBQs47v9WNK57eU+AV8sskFsviMDDLPlqI7Hgc9wyPIuMvw3188MDWzgEwcP
	Ccd3nAKBfA7Soy+QL2H0wRx6u3Vbyvi+ueOejS7Ne6HmL
X-Received: by 2002:a05:600c:4e8c:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-45381ab9f6fmr18354535e9.2.1750838971189;
        Wed, 25 Jun 2025 01:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIv5ddtA1ECIgR9ITGbTAu2z1vHYvlf0bb1zfIjRcvGmv0s8+jH0MYCmP85CO8z/Ek1v8nag==
X-Received: by 2002:a05:600c:4e8c:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-45381ab9f6fmr18354005e9.2.1750838970712;
        Wed, 25 Jun 2025 01:09:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382366f88sm11928625e9.30.2025.06.25.01.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:09:30 -0700 (PDT)
Message-ID: <cb15403f-27ba-4410-b702-8148abfb0247@redhat.com>
Date: Wed, 25 Jun 2025 10:09:28 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>,
 Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 paul@paul-moore.com, viro@zeniv.linux.org.uk, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, cgzones@googlemail.com,
 ira.weiny@intel.com, roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org> <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org> <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
 <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
 <e5d11288-ef0c-4a82-b117-6d12d2357964@suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e5d11288-ef0c-4a82-b117-6d12d2357964@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZllY2xWxIlJZbC0hLQTawFXlryREFOVpOrFcjcXHot4_1750838971
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:02, Vlastimil Babka wrote:
> On 6/23/25 16:28, Peter Zijlstra wrote:
>> On Mon, Jun 23, 2025 at 04:21:15PM +0200, Vlastimil Babka wrote:
>>> On 6/23/25 16:01, Christoph Hellwig wrote:
>>>> On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
>>>>> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
>>>>>> I'm more than happy to switch a bunch of our exports so that we only
>>>>>> allow them for specific modules. But for that we also need
>>>>>> EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
>>>>>
>>>>> Huh?  Any export for a specific in-tree module (or set thereof) is
>>>>> by definition internals and an _GPL export if perfectly fine and
>>>>> expected.
>>>
>>> Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
>>> modules, so external module with GPL and matching name can import.
>>>
>>> But if we're targetting in-tree stuff like kvm, we don't need to provide a
>>> non-GPL variant I think?
>>
>> So the purpose was to limit specific symbols to known in-tree module
>> users (hence GPL only).
>>
>> Eg. KVM; x86 exports a fair amount of low level stuff just because KVM.
>> Nobody else should be touching those symbols.
>>
>> If you have a pile of symbols for !GPL / out-of-tree consumers, it
>> doesn't really make sense to limit the export to a named set of modules,
>> does it?
>>
>> So yes, nothing limits things to in-tree modules per-se. The
>> infrastructure only really cares about module names (and implicitly
>> trusts the OS to not overwrite existing kernel modules etc.). So you
>> could add an out-of-tree module name to the list (or have an out-of-free
>> module have a name that matches a glob; "kvm-vmware" would match "kvm-*"
>> for example).
>>
>> But that is very much beyond the intention of things.
> 
> So AFAIK we have a way to recognize out of tree modules when loading, as
> there's a taint just for that. Then the same mechanism could perhaps just
> refuse loading them if they use any _FOR_MODULES() export, regardless of
> name? Then the _GPL_ part would become implicit and redundant and we could
> drop it as Christoph suggested?

If that is possible, that sounds indeed nice.

-- 
Cheers,

David / dhildenb

