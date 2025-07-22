Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC0279DC6
	for <linux-security-module@vger.kernel.org>; Tue, 22 Jul 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199472; cv=none; b=CWNbRlBodp4ZO9fUy5KcypaVFVBP+IMDFXZwdJac5Pb9c0SIiPP+Mi3g5JWD68qhnjo9ci+d8oZeCSWvb/ksdw6N/rd6zZdvlmKYIz4YGJtIxBIsbC6VZ/Bo3EyONCYGQSqQzCk2tyS4w6EAY+SE9VtvXjGShIEbjI6t+JmZaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199472; c=relaxed/simple;
	bh=MqusCp5gjBKIVMloHsIZ6ErrDPcq+7/+0/XcqLkQXRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4/IaQTcFRh2ngGYiO9fcps9pY68agtdNW5G4SJKd4y5WyeASWopKnVD6iFuPnQjd1DjR6nPMDxTIUKge8PFNg/f848venfsBUGCdloIv8/dmT7ehX+b+gAOEJ16Wge63o/WDem7YoGW+yaRJFy1CgOQ/VY0XOCch2Eshw7B1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFTGAGmp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFTGAGmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753199469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SlkGDyZmqfarTxh5iJOxgcRyWvjlf8J8u4Rc9/G05cY=;
	b=cFTGAGmpvVQbIKYEaqHqYHiCR7bOqFDTDUbQb7Zfgg5bn7+ERPr6J5bpMJH3Xufp+WBIT4
	ljTw29SzvZOZoIoYcJE8EOjPHUVlv6e9NnHaM8QDunsd/9EKHubP83H329N9GjnWKm8Mit
	pEeSRSlVvay5a0gggpuVHvWkgYMl9Oo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Rn05FtUpNK2bUaJnKL7y6A-1; Tue, 22 Jul 2025 11:51:08 -0400
X-MC-Unique: Rn05FtUpNK2bUaJnKL7y6A-1
X-Mimecast-MFC-AGG-ID: Rn05FtUpNK2bUaJnKL7y6A_1753199467
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2226055f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jul 2025 08:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199467; x=1753804267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SlkGDyZmqfarTxh5iJOxgcRyWvjlf8J8u4Rc9/G05cY=;
        b=pqd8goiBnkVzsc+aeOUdevQ3WANGATs4XbB/SB9gtDWWY7dG2ERmaBv9bopzw7sNPP
         EByEadZpMOvdNDL+eQHQUmGDzDXq7NDs2pt22eTvDkIRkbehYJeobm8UT6STzElsY1KP
         IrUutAnnkfL+kJBZ+PB2FBXGBNC8MEfliiGB+6gUwY2d2PTL0xsTTmanBtmpynrYc3RK
         W10IhMKUM1b4RtGxyeZtVcIp3ZUz72/4aG4Ne1sFbRvUowyVVz84l5lWnMnD9rt+jG9G
         8/d8JV+nzzkHccRnmjCBfk4vAgdXFZO71eozeece5Mo5leqIP3Qtw0W6PPNRYoY74Un2
         2cng==
X-Forwarded-Encrypted: i=1; AJvYcCUGEvsGr73F17LfLU4FGYscLlHP1Mg0hroAbDePWK5rtK1oODc/8sIb3fffiEgtYNghJkvVfs8vfMGYN+0ThCsUJQz0XNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbSvrZCUSFImvhjfdeg5mgBvvJX2No+EusLMUpykJEUaDuLW3
	+Qn3b75p5RnuvixluQPmAUUqnZhC8sNzl3quQrrkVdd7+U8xm61rH/Ym0cMXwb+OfPh2s4678mW
	eeviguMjUEOv8yuAfgX0SUirwH9xFP9I17LqzZ883abfYA4lLhX39FkK2n+uhhp5I/jqQHvfVo8
	kNeg==
X-Gm-Gg: ASbGncu4Zdu7qaFSPkOmB5EbQVwxObN8R0x+QQvFAYK91MQ6fW/mWz/RPUmEvIaVJv4
	s8mDl6F9JUcvvbQM4nfjpYIbMajZ+34ryF/kX0ihCGhCy592YWCv0mgoJASFjFTOFCezr+F7ssD
	NMEKaL3P63tf0dxf5MOd0m9EgueijHyp/DdOmQEsQymJRxiFGAmQJGHT2ATJDuP1pg4AmM3EhlM
	Kjxarvxs5UqpCwTMmVuGjzNqQSKwkmgKIcMwB+jFr7xKMm+a2fiqWZXGSxSX1pmQit9RiTK2GPy
	Rb2Ie1BKNcyq16usk5WNFujdj/q0b3voExmoZC37ANiTetPL8pG5UVdq7fieM99SQNfOHQjpgfO
	q03qBkQUZrCvJmIXkGX4EICX0vpz/knu49ti5mWwJsqpCfV+RZ8bZESfbmDIcnY7Wv5w=
X-Received: by 2002:a05:6000:2310:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b613e6009bmr18304939f8f.11.1753199466906;
        Tue, 22 Jul 2025 08:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkDfCaoi3LHsLkKqFiAXihZtN/+Fsy2fLKOrcY5Mqg0ADhJH0qc+QAMJ0yQdyroq1ofLrPmw==
X-Received: by 2002:a05:6000:2310:b0:3b6:463:d85d with SMTP id ffacd0b85a97d-3b613e6009bmr18304895f8f.11.1753199466286;
        Tue, 22 Jul 2025 08:51:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48823sm13874304f8f.43.2025.07.22.08.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:51:05 -0700 (PDT)
Message-ID: <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
Date: Tue, 22 Jul 2025 17:51:02 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
 <aH-j8bOXMfOKdpHp@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aH-j8bOXMfOKdpHp@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KiWM6jju3oGv6RJMsYJosvWv-bD8CoCZi83QC7MbcqE_1753199467
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 16:45, Sean Christopherson wrote:
> On Tue, Jul 22, 2025, David Hildenbrand wrote:
>> Just to clarify: this is based on Fuad's stage 1 and should probably still be
>> tagged "RFC" until stage-1 is finally upstream.
>>
>> (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
>> still feasible looking at the never-ending review)
> 
> 6.17 is very doable.

I like your optimism :)

-- 
Cheers,

David / dhildenb

