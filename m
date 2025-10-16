Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0913B5A9
	for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624253; cv=none; b=Hr1w1rmZok886vqgm5QdS530uAMt0AfdkkyRdSNgpe3gfUYEsM/2AOYvkoplpCwoVVTZ1/yMC1McuIXlPIsRUM86n9AI0bvufJyXCss3qUpMQCSUp8Snuy/dZpDuQp7aXOjA4qFYacj5VI0kdV4wgSIglx8YOlpHntwFunsmiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624253; c=relaxed/simple;
	bh=MjX01ygQ/3tk/sGwgwk/36ebQMdAkveFRCJrUinD/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhiJ5ns/YGC4Wt9FZ0HJzn4DlN9IXLL7BB05pA1bwjVOisKXFrnVLJLvFigM/usXukWsqeJeB9CbvmGPyiejklTkF7u4YgrCxRyjh9WJMvyuOqrRhuuEyp/0ogJ9lYbidFq3PS030+FCS7VOdJ6mqExESO3rZFvD+JwQB+Bh+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dwCRqlcK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dwCRqlcK"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c1f3f4373so5551696d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760624251; x=1761229051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=dwCRqlcKPsDQVOHquk4yaz5Cv4fPtBLRWee5G2rzxUKcdtZMxVfMRjn0mDOxVrewwz
         KhG5boJn1F0EHcgdAzDtOfdzxeKOTi86FsXlAOWzMrmH+qmHPIjPHnnbJKnBial5NN2b
         4s7Z9es5jhpxKD0kAxJ8BkzNr5E/4oEnPzEGRDR69OAByvk0p7UU3lTzxrx7vGBSf9Z3
         oFPf1jGc9s4O18ef3Jiycd7b1+QVMzmqQadgc3U4egLfYhQRJcWQGXsUfbZhQjhFupIc
         gADI612o9/2HT+1Ux5P4OzN0RB9D9sj32O8DTRenmNW2We4+C8H08EuCwSxwVtoUYDcS
         l0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624251; x=1761229051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=vZoenLWXp2Ik5arUu7nGEY6iYHcaeBfdRFEZ6A5Syed5g3XduoMTERzUdNUSmO9UZK
         Th//AxCt7KC+TOhqDVkJuQxXyHEoBKXu41jGZP4iOODU7OZGtt2lAuNQcOrSAddGByRX
         Bvjjv78HPG8DS5HDB/MWcpwgQ/ZJ3yeTk9kw9nCxYE2zKT9G0w1+Y7qRSG5brfOZ3B5o
         I+ae6FedjAEx7slaNmEWZXAlq/A10DTv4aOAGdP7RzUppNSpaha6uGb4jwpEzwYHE+5/
         e1KuxHWQMrv+hOxd9joPDOFy5N6cr7YvwzvusHQCiQvFW8AvhSyQTpBGDo4G2Bt2+R7A
         H2uA==
X-Forwarded-Encrypted: i=1; AJvYcCWo0DERbc8UPmxr6LefdYJ5wCEY2MO8enc7gZH7Der6Y204kEnUDkn4zYothEMsOJ8oY636s45bOoPn44VtfDkeMoubId0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKgnZdP3NMhG2u6fZafosNDjwh7zdFezl6hWhpm7oym5sk98j
	VmLxX3PRzx4qHp6d5x2aDDyhM6X/bmO/0FcVKh6dgHCHfyg/1pT5HTR4kVTSVD6RO80=
X-Gm-Gg: ASbGncsPn/TMyWkalMy32Zy330OEoX9EezaAzfUjmQRmZpaidht6ejBmAw6z8Aon4z1
	+2XZ3+BXAkKZo4699Wpa+Foool6sYeKrQsZFfDH6JeKf92Y3kKKOUxanlgeEBe0O+ieZiYiBlZd
	egzzojAm89vTNzy1LpQYZGHVcMDveLkErwkvrqp0SSqpuaeZivESQGVpjFuROFJuGXjYWxfsLzH
	9U/kEgLX/yu8GfCk1Vze0ctDOF9ETj7VERDB/fkSfJ9KsxGxaOGnng0c+b3603negmAACBOoVFo
	JlMk+Kxf2NpRO1M7xgCq/gpa3KGeqfrlefE7x918ryuv0rCXtbIVv1YtOSuG+0eH+RR9KNvFLnL
	NaPDL+JiaDqWWpx82dHifSJYflpLqZKg4HZKob4YmLNrtOKHZgzJs9SsHD4mzSqBJxtoSUxxg5c
	GxBL9UTo9uoQ0QkVb/F4CIcLiGNgKuWRwmgmZhBBS/TxvNRVcGRON/Csp680P2ssyGTFBtSw==
X-Google-Smtp-Source: AGHT+IEMapVQRI0ck2KCGxvEYuBB3a+08a/2JspNz86EbcND1SGuRInp+B2xwxF3NumJMeFQLVJPkQ==
X-Received: by 2002:ac8:5883:0:b0:4e8:99b0:b35e with SMTP id d75a77b69052e-4e89d263140mr4179321cf.30.1760624250594;
        Thu, 16 Oct 2025 07:17:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8955b07e9sm13309541cf.27.2025.10.16.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:17:29 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:17:25 -0400
From: Gregory Price <gourry@gourry.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com,
	jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
	linux-btrfs@vger.kernel.org, aik@amd.com, papaluri@amd.com,
	kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
	clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
	shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
	shuah@kernel.org, roypat@amazon.co.uk, matthew.brost@intel.com,
	linux-coco@lists.linux.dev, zbestahu@gmail.com,
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org,
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org,
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com,
	tabba@google.com, ziy@nvidia.com, rientjes@google.com,
	yuzhao@google.com, xiang@kernel.org, nikunj@amd.com,
	serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com,
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
	josef@toxicpanda.com, Liam.Howlett@oracle.com,
	ackerleytng@google.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	dan.j.williams@intel.com, surenb@google.com, vbabka@suse.cz,
	paul@paul-moore.com, joshua.hahnjy@gmail.com, apopple@nvidia.com,
	brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
	cgzones@googlemail.com, pvorel@suse.cz,
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, pankaj.gupta@amd.com,
	linux-security-module@vger.kernel.org, lihongbo22@huawei.com,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	akpm@linux-foundation.org, vannapurve@google.com,
	suzuki.poulose@arm.com, rppt@kernel.org, jgg@nvidia.com
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
Message-ID: <aPD-dbl5KWNSHu5R@gourry-fedora-PF4VCD3F>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
 <aNbrO7A7fSjb4W84@google.com>
 <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
 <aPAkxp67-R9aQ8oN@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPAkxp67-R9aQ8oN@google.com>

On Wed, Oct 15, 2025 at 03:48:38PM -0700, Sean Christopherson wrote:
> On Wed, Oct 15, 2025, Gregory Price wrote:
> > why is __kvm_gmem_get_policy using
> > 	mpol_shared_policy_lookup()
> > instead of
> > 	get_vma_policy()
> 
> With the disclaimer that I haven't followed the gory details of this series super
> closely, my understanding is...
> 
> Because the VMA is a means to an end, and we want the policy to persist even if
> the VMA goes away.
> 

Ah, you know, now that i've taken a close look, I can see that you've
essentially modeled this after ipc/shm.c | mm/shmem.c pattern.

What's had me scratching my chin is that shm/shmem already has a
mempolicy pattern which ends up using folio_alloc_mpol() where the
relationship is

tmpfs: sb_info->mpol = default set by user
  create_file: inode inherits copy of sb_info->mpol
    fault:    mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
             folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id())

So this inode mempolicy in guest_memfd is really acting more as a the
filesystem-default mempolicy, which you want to survive even if userland
never maps the memory/unmaps the memory.

So the relationship is more like

guest_memfd -> creates fd/inode <- copies task mempolicy (if set)
  vm:  allocates memory via filemap_get_folio_mpol()
  userland mmap(fd):
  	creates new inode<->vma mapping
	vma->mpol = kvm_gmem_get_policy()
	calls to set/get_policy/mbind go through kvm_gmem 

This makes sense, sorry for the noise.  Have been tearing apart
mempolicy lately and I'm disliking the general odor coming off
it as a whole.  I had been poking at adding mempolicy support to
filemap and you got there first.  Overall I think there are still
other problems with mempolicy, but this all looks fine as-is.

~Gregory
