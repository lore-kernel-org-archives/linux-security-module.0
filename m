Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E702512EE
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922858; cv=none; b=XPL1YAJ84rOyWlkXIg9B5luPu+eA3WLhSyCo3EsueSDWMAWulIoMkAX49WUxmxGX5B1VmjtaN/D99g2GJeu7PtrQs3wHtDUdHB8hH5NZO3PnR7Z4ZLqVXzPGRAiyAGCDw4m9yAH3bxAENzBbgh+apQ8UXU8bstQoI5AgNZ2n1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922858; c=relaxed/simple;
	bh=bruREYZz13FVqwhmiTuhvJnq89yjM0qtV4JcUUKirMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sXR2uCP+8CkQ01XmKwIUO7nOGuMG1CQQCJ5hK4JH7CMepjtFsUFDJeabCipDLhPql7yV1hUpbRZhLM9jDiRX9TpIMi6r9MAfXiSh1DE0PMXsdyoJ2NB+wf0WWze9gV5zHKIkFFmHeJKX7YukDk4rjG7aaresTMawGaGXGTPhY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIbEH2Ox; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIbEH2Ox"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76c2ef87618so8729355b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754922857; x=1755527657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=DIbEH2OxjBvZkBS8teorCGp39U2CsmDZuMeaPxaLBtckmwePYI1C99M65EyxVI7trh
         HMj94pK8tSAk3aLUDeLtAL6D0cSxG/BAIn/jY23E+Z+FueDmK4DbobALuGZ7GOUSpFAV
         pFuN9hANNqRVIBG3ZvvVCSw2QTKDTvKP8zGpnXzSyTfcMqchaQovLADWbt6PftZYq+8u
         MDnxb7e9+ghOdjDXxhD0wKp0209GGbj42znut7BAb3XeN1mYs9dLBE8YTT0TeccuZFNV
         78Z3olcG5TguJmbCuK46mBMg9bII8+GyNCNGPCcxWsmK1r2rbJoaYCZLg7gIdLsEdA9X
         HxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922857; x=1755527657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=bNcyauZohJB6J2Gi4uXoTEpdyM0oU5nnP5J6Yaedjsc1bA243As/+waA1u26YXyUB7
         dHKZEEssIqzLPmULAXwb3/F1ss6aWEw21bWKT+iRjHMoZUSnFvcQIfHEx1WmJZX47Y9I
         6XkxZUTnjdFmXUp5Uk3LIIIrVpC5zrDCBxLjYTTb9nExiQaK/4owNz5rWi8K1sifBXnM
         TZX/MfEKTQI6LVPMVvYQia/093djWomAZSlXSmWFbu+4nn08dePeGpxHhHoCVN9ASjDe
         1H4AQcFblwf/hv5o8a+DZtl+ih9B5ftTQK0j//JNeltt0xkmTtzEJ7ZnnJUTL7eWoUmV
         9d4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk9QcoYBoASKq+sjFJc//gXBuhCD/A1MR7vdnsk1RLbW53FUCqxoY9c6BF1Cpn4ZwfxBGMahn2nvbyGVajHX/tQBm1sJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCbYAhS4dK2mcSDZXcuGCC64qWwtTL3s43dyl7G5SLP4fEpEq
	iLv43CTJDbGEljZTB7+vjy3NMH8C7LCwDa+Go+xpQh8FE7ipWTXBf2ZxHggEv4v8KX3HfKEPULx
	lVADH3g==
X-Google-Smtp-Source: AGHT+IHDzFt+0zXjA0CUz3si8YkwDTRVPFUsiiRh4VZN4Dkprgq2wlq3CPL9ofZgO6/62HnwUQZt6ujhFVk=
X-Received: from pgos21.prod.google.com ([2002:a63:af55:0:b0:b31:d198:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8b:b0:240:6dc:9164
 with SMTP id adf61e73a8af0-2405502ffeamr23223057637.15.1754922855887; Mon, 11
 Aug 2025 07:34:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 07:34:14 -0700
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811090605.16057-2-shivankg@amd.com>
Message-ID: <aJn_ZvD2AfZBX4Ox@google.com>
Subject: Re: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
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
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1].

Is this still actually an RFC?  If so, why?  If not, drop tag on the next version
(if one is needed/sent).
