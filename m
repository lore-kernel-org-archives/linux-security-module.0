Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FA1F3B97
	for <linux-security-module@vger.kernel.org>; Thu, 31 Jul 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977466; cv=none; b=c87C4KaGXksb5/iXKOr3j6O727fB9akTS6Uw/MqZEtlZUF4nAmXaUrQJ/4bZWxzIGhV43NYnMoVp7Jk0bCmfACcFwYO/dQtvYcTDLg/DPMkIf9JMiCK7VjHAlzQcBcfMydpFzXsZoXbKFbV5Xv3iJEkyFFaTxK9Oa8gvv+rN9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977466; c=relaxed/simple;
	bh=zXqYwYUo5V5xtf38XeLw47tBDZGEMXc9yoHG17JPGAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IIW3VKygfylp6TJGXX13mzjJykKk5cBY8lZbf64t9xrZE46ph6a2skZxTGhmVZysHKx8b7yyStAMYWC0Cldh3QJlZ/wb/N09vweLx2rYtvDCWCfFFMclNl1fIxbY5wluzNVmk7Ru9RE8hdU/BmXYc1o3AIR0RdHnf1LyU6BpLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQCpaCeu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQCpaCeu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a588da60dfso350489f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jul 2025 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977462; x=1754582262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwEehyIvfFZxsxz6xG2f5ye6bcAONjKwPvSd6npT8hI=;
        b=uQCpaCeu488YzeJaqdtnpSe9JwJPNqEpBRpSw7umCywMzJkQaArjkMboySJ+37y7eX
         3l74AeaBFzWbTS8Q3oiaVX6FqmIypchnDkF5Tza5s+9z+BKDqvBDfSLAkTKDswMi2EHh
         rVOnMimM1pTDg20/rFX/WPG+s+cUQJ2vi8hksg7plziau4Ln+DkmVqtC1thMLLlXM/5d
         LQel6Op+cTuent21fKW7sWRUzh8Szmy40ynmhaBlseV9aJvcpbgx+Re+eYmpFc7lt/D2
         AyHDLvb+V1NE+SmqriJFPWVtEZ8c5gHGvGWBz/V9CJVCSCLsD+RlLGxUMqFV7Jp/+T1M
         YEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977462; x=1754582262;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwEehyIvfFZxsxz6xG2f5ye6bcAONjKwPvSd6npT8hI=;
        b=jR3srBKaw1p+2ypumBBCARAKIEuAikJnyaCNPYnJqiJkinTcph2FTzPCywUjTaHL+4
         7S55MOzoLEpq8JKj7vNDhc5tCDGk1mVsZuSKUt+n7mEAxeoRAu90TzX/EUpvKqvMISNk
         n2+03nx0dhYpNzCiAa5qo2HtZ9dM3oecREjm5Uu+KSHI/saKQWW7n1KJ1nLY0pAdJxhe
         uQQBszYCcf8YA/ZXP3HrSFZLrZNBZ6qErAAoDKWXWheqVLzIBIgA4H934JncjsQyKL3N
         3XMnkohs+1UTGwHGV7OkOgBuaV9LJ2ZadVkmy5rZasfRrWwxFeLchKExvKM4WbHxx3tc
         X1eA==
X-Forwarded-Encrypted: i=1; AJvYcCWSw8eEtjhk2aF6nsGt3dhwfC8xwzfATEBWZ8ph11AyiaTX7Q6VwgRk+AZ/5kkqBn2yGwf5TXdkNdYOwYZT9r3G6IKPphA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu22D6lE3AZ0PipbFEZiyk6Z7GLbTZsX/UsqRdAvb3WP0a/87
	xfGWAjEYi3jJyQH0B99QwDcLvAzPZ2slglpwKZUyRduEpotxFAJkvtcP3CuMF/p/GeU=
X-Gm-Gg: ASbGncsGZw+c+CzNiSMOdIJougiwLyfmwu5kx8S/Pk1czi3vG3gbPRotpSQfweIj+ml
	IWVKm2ZpHmSEQEg+V2i5mgXNH5Ay0IQPWj2Yt1OTL97OOY9oqSCH4D5fqryx5Hhz+bXsMH2s+O/
	T9/Oyx4C1x4Cs7BsHZMgDJH4RbPMhzZJukQCvAXLS1DcFJkqNLREbka0szWpx6B7SDh4km7WtKt
	HCljllyf2z9Z9wAnrT5Jjslq0wiSSJT5F+4pQr75CGRSlaIx7zlryLb8KsEcWiD9ZapsWbDYG8N
	v1OrtCzkaN7uAZ46kxiA0Xypyx1Kjo7zOqNb2AHXLwb+evhB479coL4CAmnJeK+hR3QbS2tXSzh
	Jj/tYTpm7oxmY4Usktjjzpt8e560=
X-Google-Smtp-Source: AGHT+IEJypDs3Srfs5Ta2SryXW3PqrPZ2bjD8Bn1TfOmElhJKEUhoyptNdeCt1IpSC2bX7kUHiSQGg==
X-Received: by 2002:a05:6000:2f85:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b79501dd3fmr7085161f8f.59.1753977461645;
        Thu, 31 Jul 2025 08:57:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdf4sm32052495e9.11.2025.07.31.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:57:41 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:57:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	bboscaccy@linux.microsoft.com, paul@paul-moore.com,
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v2 08/13] bpf: Implement signature verification for BPF
 programs
Message-ID: <0b060832-4f55-486a-8994-f52d84c39e38@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721211958.1881379-9-kpsingh@kernel.org>

Hi KP,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Update-the-bpf_prog_calc_tag-to-use-SHA256/20250722-052316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250721211958.1881379-9-kpsingh%40kernel.org
patch subject: [PATCH v2 08/13] bpf: Implement signature verification for BPF programs
config: m68k-randconfig-r073-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231202.8rYZJ8D1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507231202.8rYZJ8D1-lkp@intel.com/

smatch warnings:
kernel/bpf/syscall.c:2797 bpf_prog_verify_signature() warn: 'sig' is an error pointer or valid

vim +/sig +2797 kernel/bpf/syscall.c

c83b0ba795b625 KP Singh           2025-07-21  2782  static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
c83b0ba795b625 KP Singh           2025-07-21  2783  					      union bpf_attr *attr,
c83b0ba795b625 KP Singh           2025-07-21  2784  					      bool is_kernel)
c83b0ba795b625 KP Singh           2025-07-21  2785  {
c83b0ba795b625 KP Singh           2025-07-21  2786  	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
c83b0ba795b625 KP Singh           2025-07-21  2787  	struct bpf_dynptr_kern sig_ptr, insns_ptr;
c83b0ba795b625 KP Singh           2025-07-21  2788  	struct bpf_key *key = NULL;
c83b0ba795b625 KP Singh           2025-07-21  2789  	void *sig;
c83b0ba795b625 KP Singh           2025-07-21  2790  	int err = 0;
c83b0ba795b625 KP Singh           2025-07-21  2791  
c83b0ba795b625 KP Singh           2025-07-21  2792  	key = bpf_lookup_user_key(attr->keyring_id, 0);
c83b0ba795b625 KP Singh           2025-07-21  2793  	if (!key)
c83b0ba795b625 KP Singh           2025-07-21  2794  		return -ENOKEY;
c83b0ba795b625 KP Singh           2025-07-21  2795  
c83b0ba795b625 KP Singh           2025-07-21  2796  	sig = kvmemdup_bpfptr(usig, attr->signature_size);
c83b0ba795b625 KP Singh           2025-07-21 @2797  	if (!sig) {

This should be an if (!IS_ERR(sig)) { check.

c83b0ba795b625 KP Singh           2025-07-21  2798  		bpf_key_put(key);
c83b0ba795b625 KP Singh           2025-07-21  2799  		return -ENOMEM;
c83b0ba795b625 KP Singh           2025-07-21  2800  	}
c83b0ba795b625 KP Singh           2025-07-21  2801  
c83b0ba795b625 KP Singh           2025-07-21  2802  	bpf_dynptr_init(&sig_ptr, sig, BPF_DYNPTR_TYPE_LOCAL, 0,
c83b0ba795b625 KP Singh           2025-07-21  2803  			attr->signature_size);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

