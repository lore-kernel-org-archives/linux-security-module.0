Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F71264A60
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923285; cv=none; b=am6Sz/F13fa5jRi02fnRQBcnL1JvSRFxj9ntKFDrCgAd1/zimPeWyARyZ8vn18w2dBSfcU/ENQBBBjZgcndPt1yKj80zYcvFyk01uXk0w1pidn3tbKt0JO7g8eP4DGsPSZ4L93mL8F/Vi3BRpz1wnUgiWt9WkCSRXM58rOy4vmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923285; c=relaxed/simple;
	bh=kbpPvhNZz6SqWU9uqkbeGc4vIVmkx079K+FGeZ8lOws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8cP+eYwSN0deh8l9aM0CAD4hXiIOEVYIXqUDToT+7V3nI5HGOBJOah0V1kkpvdrTLy+x0lDE/jp4iFuyuTrxieMp75jNGIo+fD3yAXu51W/XEJb48f5GEUsoMldWwST63S601Q1qCxCk96tLNC58WnJ0/ZJoSnYxTa9o3ESRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9dsvyMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9dsvyMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4gbggx2RPFlVO4t++KHmOzrhjwslbE7WXGI1AzTGhb4=;
	b=D9dsvyMoIb+EgxMYpQJOmz2oQ89Y/g7j7RMFVEJQesphL3IVSKVaQ0JB57E0dE7O/d5UHl
	bJDhKXs05zFu5jtp6C/MH61BgNnp+cO3ccz3+Bi6Ls9UZuAInrHCUw2x/rvsRQcOdW6aMZ
	D+YdWgYqnNy8tu0qVySfYvXTKtrI6CA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-oXj2AyVfNp2fgUCRB9HjpA-1; Mon, 11 Aug 2025 10:41:21 -0400
X-MC-Unique: oXj2AyVfNp2fgUCRB9HjpA-1
X-Mimecast-MFC-AGG-ID: oXj2AyVfNp2fgUCRB9HjpA_1754923281
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b604541741so2321166f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923280; x=1755528080;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gbggx2RPFlVO4t++KHmOzrhjwslbE7WXGI1AzTGhb4=;
        b=Zim/HqyOrCLhdJGQXUMrkB4SDWR8JHnu/2reoBYbmGiYBH8Cdr0r0BH4rHTodMX/th
         g7BAe0gvpCjc0oEW0ecc56y9MeT8AjZ8fAPHNfku9w40Qraki042c1ezaKA9Hb/ywU0s
         4dlm8AicfyDve2Hyerqc00zI9MF/70HDUJ9V9DcrhI+amf8oGYNrb/OjV4NHpeeoF0Ak
         mAr3LKK4zgYfU2OvFadXZO1iGkvHPoElXWxI7P+jARe7g0woRyeJ+6mvSqZcsSw4UXpb
         tJ10H+K7yuVO3oms0xaCp3Kr7nFsonnK29kf4Qe6wPYwOfApk2ERHi2ju0JzjeaING9c
         Xu8g==
X-Forwarded-Encrypted: i=1; AJvYcCWWYtyY06BF7dP2jwAd5rw/NLruVK6QONAMLMQBlTIMTjKToYnU56y08k2/cUTHYliHV1b6R6+y1HMHAr9WK9eYzslHQis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHdJHFdOGyDizRK3WEb1ZV8fgnJmpS08askFA85yKvuIfnlIX
	H2y0bIki2DOxDkglgLr0DMnfXcaP3S3u/hBkKuB46FDVpSCRuC0aY5AQYVq8AKYWFop78a9wEzq
	ItDH6HeUIHvA6Up3IiIkBRnQrvxI3pNL7KbKo+1+NvpNITyIz/IZ6wROW1eZLCk2LRz7HxBehJw
	tcDA==
X-Gm-Gg: ASbGncsWCyWFTz0bwtHa+jBxlrAvp0r+BMND2/tVyy25Zbi8/a+a3FtANCtCIv3w4g1
	jOwkV3O46LhKwCko0Kvf0VYgd184Pba/6A0wEw/U8ZYWh+xeKqawjnU9bMdr25bAdn6uQZpQQ6R
	Pi1FEgi2/lyGKQeyvcX+7hokG+fMPteBdX5H0GkQv/lR4CvGv4AkZU6lH8w2Ui3lwG+ENx1iohZ
	jXCzKiNmcR4NjubrR5MmOJNi0NqHWWfFmFPHzdOMlgTZSXHxoTWLtdraCHFr+5RpCeiRhjR66tg
	+Jz0FqKxt6eVro46PFW6vYSGTsWUakZkgNwz/OVr6lhJcSU7Hjw5hXXK6cTL/LfC1Pu8RQmPy6C
	c08pY5dYn01jgSo85h/F8IYr8AbsJHkVZnjEtlS9qlr7YVxFQNt20oSCeA7X/8/B1JLA=
X-Received: by 2002:a05:6000:2408:b0:3b8:d1d9:70ba with SMTP id ffacd0b85a97d-3b900b7517dmr9713517f8f.32.1754923280181;
        Mon, 11 Aug 2025 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmqOKGQy8og6iuYjR3rW+/P+X+6GleHhPef0aGzUOgh7s7rRGq5mXZf9HiFNB9XK8mxgicg==
X-Received: by 2002:a05:6000:2408:b0:3b8:d1d9:70ba with SMTP id ffacd0b85a97d-3b900b7517dmr9713436f8f.32.1754923279410;
        Mon, 11 Aug 2025 07:41:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm41145907f8f.64.2025.08.11.07.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:41:18 -0700 (PDT)
Message-ID: <42956218-bda4-4089-8f43-f7352ee73b4f@redhat.com>
Date: Mon, 11 Aug 2025 16:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM
 guest-memfd
To: Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>
Cc: vbabka@suse.cz, willy@infradead.org, akpm@linux-foundation.org,
 shuah@kernel.org, pbonzini@redhat.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250811090605.16057-2-shivankg@amd.com>
 <aJn_ZvD2AfZBX4Ox@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJn_ZvD2AfZBX4Ox@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mdNMldkQ0Vs2SJsAKBTcPYXVImG0hBL0MoeU_FUOPLk_1754923281
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 16:34, Sean Christopherson wrote:
> On Mon, Aug 11, 2025, Shivank Garg wrote:
>> This series introduces NUMA-aware memory placement support for KVM guests
>> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
>> that enabled host-mapping for guest_memfd memory [1].
> 
> Is this still actually an RFC?  If so, why?  If not, drop tag on the next version
> (if one is needed/sent).

There was the complaint that !RFC meant that it would be based on a 
consumable upstream branch.

I think once this series is rebase on top of kvm-next, we can finally 
drop the tag.

-- 
Cheers,

David / dhildenb

