Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11F2EE986
	for <linux-security-module@vger.kernel.org>; Wed, 18 Jun 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259534; cv=none; b=pxaX2zjlcQ5wDcOtJmFyRQKqggNTCdcOQRpG5AtSbQkGRs9SPlMYAtrzeAYYvbpqtDUzvuoDVb5OUR9KF7yCj2I8VJTEyBgmUZX7c7OKWhpAeenb7Aiq7umCNx/K4FPvvFj48yLa4HsR1ryhy/o/zPpsNgeoANbeplwy5n+jsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259534; c=relaxed/simple;
	bh=S9CRGFxZrsWQiCny4A4jtEs+ZyqisFVOoxUZS4pQsAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+ViPgRKOoDKIxvAR23NKns4ounVV6ixc8STYX7CkRAD9+Iyvfznh2FpwHlm/Nqe18DGZ1dn13CHzAKfhHDKEXorXaxI83eQ/kmbDZMSuEqlS2d9c73XEftz671JM7BGqmzhaGGalDI+ctyx9UPa6COX7nH8FN1GX3ya11apAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hXnkgei+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hXnkgei+"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6face367320so68568656d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Jun 2025 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750259531; x=1750864331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w7ovcA+eQ/2b8rTRZRntXptSXxd0DShnhC4amsa/B0=;
        b=hXnkgei+GvAnXgvPWlRXZmB61e4NSw3VNV7hgtaLxE37zsDxFdKtJ/JVtovewvFlxP
         BRigJGwouWNb/jP/l5rLf6wklgPEEtMX9ykrmBG8tArz+bONfw1mrWhNYGLV9tdhK17h
         QMdRvlVoIAy+mnhBaSseAQhT7y4WICxcEY4Zt3drIDPdh/Grd/Fk8tFRPEL0UcHcRWug
         QO7j1LyEhOfWZICyHdg3sqcsZVzOzj4lzY+RT6eA4BKvPh7Sus3QQPCOsjOue5nmHGje
         e5mGy9ggdOQg0cQlN+wwwAtOaTW197HmFDXjOCmWVNrbLCdYKO8gXYtCHMZ+0K7jLewd
         ZDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259531; x=1750864331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w7ovcA+eQ/2b8rTRZRntXptSXxd0DShnhC4amsa/B0=;
        b=ib7JwOkP1YYhkMFTkCtIFU9USHFoH8XVyExOkSc2Iab9qk/msEr81604kxJFIyT7D5
         DvdssW9uB6G32uX45Qx+cl5zGoAfWyzn/rJqHsxSHXs3KId//cb3ngtV/a3zAvmKw3H/
         wnmc59VMHNAtY6+2JOPxmOXZMpHnTMp/IDjCh5LyiookzGN+3js/N1qL3YAXXWtU6FpF
         /St5KGJd38PLUZHtGQOrT3VyaK0uBxXbKhpnQuqPASFYSjRrNZya+ct7joLvuHZIPOkl
         8Guq8a1WPMJUhcxQCgz/U0I7Q+e2KRBJT7M3Rf/a6ZOCwAppIWOoSCtaU4QrNb8HyYny
         aGig==
X-Forwarded-Encrypted: i=1; AJvYcCU80DmiTGAYrYzzk94rRrHaAhl0/sQbrbOXB7CB7fXZnUUvIn387B90FUi7YJ5I7Q7ewIX3HM3Zp6JaKC92zpGA/rZ6Lj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFSMaPvXuHzrY3/+ADpmJixiqM1dO+7rD9BHkHVu1d65KCAHEl
	tzMQKt2T38FbIy0qGpi8UWd5Hac/xtpeyQY3q/78DjcGH9mWZLtEZ506QpzkVW7HaNg=
X-Gm-Gg: ASbGncs+QI8+JSx/Xe3JFJKrElcPiMgjhzXLBOVd85Ns5MPgaf5qrNeW2bT5JfmXX0m
	S9K5z4gHSOhBBSbLfW2cacQ05gVxW3ibBSkCQt45snvowJKNtOg4f6lVKVXDDgSi2tYzsQKaReQ
	QQEfj/2XXIHoMqIC8OL2qyMOCOpSn6n0neTQDmSCt64VLxx8bCYF5h/Uc0eftS2abrHF4Q3dTiW
	nJNU66dQqpUyvPoiCnI3mPHhxi0oAjYIA5PZiYkZTXVFtafDHpspc+mCF7Usx0LZzcW8D9YeWfN
	RbJ7MhjFNGz671ls3hVUaEwspnhxFZh7/YlunPL4+qLsYdL3vxne6Q7fWvh35oaEooC3
X-Google-Smtp-Source: AGHT+IHofhP9BiiWq9pfl7Z5RgEudETJ5GYEen3cpQ0dOiuu8S3eCNtXQb4YOLf1G9jX/1/pyfy2rg==
X-Received: by 2002:a05:6214:570d:b0:6e8:fbb7:6760 with SMTP id 6a1803df08f44-6fb47725d95mr260081446d6.1.1750259530934;
        Wed, 18 Jun 2025 08:12:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:cf64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb4cca79bcsm45456016d6.6.2025.06.18.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:12:10 -0700 (PDT)
Date: Wed, 18 Jun 2025 10:12:06 -0500
From: Gregory Price <gourry@gourry.net>
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
	willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
	pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
	tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
	jack@suse.cz, rppt@kernel.org, hch@infradead.org,
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
	roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
	papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
	quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v8 4/7] mm/mempolicy: Export memory policy symbols
Message-ID: <aFLXRtCDfoNzQym6@gourry-fedora-PF4VCD3F>
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-5-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618112935.7629-5-shivankg@amd.com>

On Wed, Jun 18, 2025 at 11:29:32AM +0000, Shivank Garg wrote:
> KVM guest_memfd wants to implement support for NUMA policies just like
> shmem already does using the shared policy infrastructure. As
> guest_memfd currently resides in KVM module code, we have to export the
> relevant symbols.
> 
> In the future, guest_memfd might be moved to core-mm, at which point the
> symbols no longer would have to be exported. When/if that happens is
> still unclear.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/mempolicy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3b1dfd08338b..d98243cdf090 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -354,6 +354,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>  
>  	return &default_policy;
>  }
> +EXPORT_SYMBOL_GPL(get_task_policy);
>  
>  static const struct mempolicy_operations {
>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
> @@ -487,6 +488,7 @@ void __mpol_put(struct mempolicy *pol)
>  		return;
>  	kmem_cache_free(policy_cache, pol);
>  }
> +EXPORT_SYMBOL_GPL(__mpol_put);
>  

I'm concerned that get_task_policy doesn't actually increment the policy
refcount - and mpol_cond_put only decrements the refcount for shared
policies (vma policies) - while __mpol_put decrements it unconditionally.

If you look at how get_task_policy is used internally to mempolicy,
you'll find that it either completes the operation in the context of the
task lock (allocation time) or it calls mpol_get afterwards.

Exporting this as-is creates a triping hazard, if only because get/put
naming implies reference counting.

~Gregory
