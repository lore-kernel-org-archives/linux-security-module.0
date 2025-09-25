Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3212ECE9F
	for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841978; cv=none; b=R8KM5jf6fcUQnxgf2AWfpUaCEBYFwXcdUbWzH2/f4rGcajqSa/mMVVM4Y9NF5PhShsTlu/acZSz2X6wL79nXFyQrP/UKLPYuil09BTPppG4NY5sXyg4ZT+e10pS4xZgwJwWPL+FsklVRaPAxAM3N2f31idYZHotZ91pufXUGut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841978; c=relaxed/simple;
	bh=s9eeTE4+TFjXly65mL70gO5Nj1aP2Sg3pnQCFQVgq5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPkTQ4TwCTjDbPzNLACRLlvNYmlimm4hkyByTMGJXwe4HHbEGS4+0fXK+qSR1wtw2j6bD5ajOZ4yGkyIqxfW1LEeESImrrPwsGTnz9Us1Bqw6AajvpgpXqEjpHjDC0BXpJWnJXNtD57VB0Lngdb/ybGHP/iFwO79TEfi9xIq7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVbDYwXa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVbDYwXa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2699ebc0319so15981625ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841976; x=1759446776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=sVbDYwXasc2mcrj61avHgC1rB4YS0wPRRtbb4hZag5XVUbPrS7XQbZSXAOeH9jVejv
         Lt9oPzSl/U1GW2nDxx0Umcn/39IAfO2vqIjTuyLV/iNKTF3pjM306hf8KFdMUYd7uK5F
         UmGtT8DDR027cKAPDEEkorjVd2HIwGcJf9hCl/irDGiSLK5wDccG7kUlDD5gEgr2CPZG
         IwAzCrxniJa9Z38PYAkkm2LMqGtuV+jSvkBm4t7N9ryIAvVWkvD5bLByKskb1WvHeuDA
         ikqy2CYzoPapkeA4WyWnowQjrjZ4YOOaRktX3nOFshQHQi6FA9M5SvxyUH7k4HTpUiEJ
         Gz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841976; x=1759446776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=m3wm147zNS+chYlRV9CkPsA//snxJNDEfbiggwZ7BTwuQjJ4mM+5jqLjzKQ58lZCGr
         sYmnuskz4OfdTMeoX4TWHx5pjvt1tow2qnX5PA7sZCbxMmSVR8akWBstXIKYbGGYr9dy
         z5zp2RToDekw4e+erRSBGxWiWS7OSqnvl5PpNFj+vBe7KMWPpqWF4mn2M1w/rXJjf0B6
         LnfOVzr7bqBRHG9D1+AbDmnrNDa4dbBHGyzvrnK+83D6QI7X3iEIBeBMrx83U5fixxmd
         lRwSxBoV0+gDFh8OE4axrZf4kYMayulMYRhVGf1Q6Yozgge5XK6cYvmvlQLyTkZh/IRV
         Avcw==
X-Forwarded-Encrypted: i=1; AJvYcCUxgbQvX/ZiOpFND0LwlN5IllHHhRjoMSDAwPfMHYEO80ZvoTOpeiIoXN5C8dO1G1OQiwvkaiF4qvUbh5Zi9Dlbcv/UdlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKEry2w0U3uOaEgfNBPJ2H9Om4VIswn0YpzhttSihE+IlZpyb
	iWBW1i1l0TK8Z9H8iN8ajf1zo0k/sZTA3ptHlEeHJGWNoBHIhdZUF1mp3wk3QP0JVqC+vbPmdoq
	H57mqAw==
X-Google-Smtp-Source: AGHT+IFE8gFtFdnHNmX2p6THQrFO41fYST4gwotcfBj6rGswgxHnE9CG8NuKci3w5GnRskLMvJFI/+Q8X0o=
X-Received: from pjbjz6.prod.google.com ([2002:a17:90b:14c6:b0:330:9af8:3e1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:262:79a:93fb
 with SMTP id d9443c01a7336-27ed4a7ecbdmr51468535ad.32.1758841975402; Thu, 25
 Sep 2025 16:12:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:12:53 -0700
In-Reply-To: <20250925230420.GC2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com> <20250925230420.GC2617119@nvidia.com>
Message-ID: <aNXMdSZkqDtsGRLm@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shivank Garg <shivankg@amd.com>, willy@infradead.org, akpm@linux-foundation.org, 
	david@redhat.com, pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:35:19PM -0700, Sean Christopherson wrote:
> > >  LDLIBS += -ldl
> > > +LDLIBS += -lnuma
> > 
> > Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> > any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> > trivial, but I'm a little wary of foisting that requirement on all KVM developers
> > and build bots.
> 
> Wouldn't it be great if the kselftest build system used something like
> meson and could work around these little issues without breaking the
> whole build ? :(
> 
> Does anyone else think this?
> 
> Every time I try to build kselftsts I just ignore all the errors the
> fly by because the one bit I wanted did build properly anyhow.

I'm indifferent, as I literally never build all of kselftests, I just build KVM
selftests.  But I'm probably in the minority for the kernel overall.
