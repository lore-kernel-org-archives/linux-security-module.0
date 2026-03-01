Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B62FFDD5;
	Sun,  1 Mar 2026 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330613; cv=none; b=HOJ91CxxplekZ7G70ZirQKBWnjLq8HnKCMkeBWWTsmn3KuLU3yzljh2OkoLqd6ZvaOwZZ2Mhx/ZszlKwZ90eQRU+UP8HD9P6/kowsvbW5VICMD9xAhIFDYmLUtno1KaiL6lnGlzZv3+pnR3EhEfTBU5fe1+U/MXSCVBv9YLvn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330613; c=relaxed/simple;
	bh=KZzP/JecF27xHHiJFhTWIUfU3XREE4PimgnFsthN5/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNyKQOv6JLITYukvGLri9OydTFEd+LNlkJVmOfERG0h63Fp9dYUBumaZDMIWEvZGAMGu7O6MaiQTMG7T8MK/j14aKC4PZPcgwyj89XrsQSl261VE6p8zWICqQ2UYVIqtKRlDspXZoe4ugmdPSkdbIXi5LnVgigpCiFHrXeM6U/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxjXn8St; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxjXn8St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772330611; x=1803866611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZzP/JecF27xHHiJFhTWIUfU3XREE4PimgnFsthN5/A=;
  b=RxjXn8StrLonnm/3sngiG5MPJlLdX2lJFO2M8ldJkjvSiuMVGpUq2MSl
   eh0VbHisBIa25X8qUxhUwIpK3QG6+v+ekHLrfXCae2Zi3MhiP/9KyNmAB
   JyHlGP3osH1ycR54Wb9Hq3e27gOzgFrR2NEXWUn4dQ8T2zdmQVdyUlCmK
   /dHgB3YPPFvNv2gzdVprv/WrjbsdwrUYzvUqWPqknNo6CpvHWG83DE53S
   BUHSNzmeej2FCmnJnAoQrx3ODT4ruaEbH4gnarLRoFWw8OCha4v5G8bil
   hSXvLqwaZMvEsBugJcTLvhrsoPZ2MPSFSe/9ugFzD/q8iqpnHZaJOSmVE
   w==;
X-CSE-ConnectionGUID: 2myQ6w4NRAOi2xSmH9U79g==
X-CSE-MsgGUID: IlC7v/yNQ7us+e3Bjb7bBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84012019"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="84012019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 18:03:30 -0800
X-CSE-ConnectionGUID: 2F9CqOx2TE6GYuD7zyqyCQ==
X-CSE-MsgGUID: MU1ccFKrRu6sm8nt7mKVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="220438890"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2026 18:03:26 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwW9S-000000000rZ-2a4w;
	Sun, 01 Mar 2026 02:03:22 +0000
Date: Sun, 1 Mar 2026 10:02:29 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 07/10] security: Hornet LSM
Message-ID: <202603010957.7JUXdjTd-lkp@intel.com>
References: <20260227233930.2418522-8-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227233930.2418522-8-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc1 next-20260227]
[cannot apply to herbert-cryptodev-2.6/master herbert-crypto-2.6/master shuah-kselftest/next shuah-kselftest/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/certs-break-out-pkcs7-check-into-its-own-function/20260228-074528
base:   linus/master
patch link:    https://lore.kernel.org/r/20260227233930.2418522-8-bboscaccy%40linux.microsoft.com
patch subject: [PATCH v2 07/10] security: Hornet LSM
config: um-randconfig-r133-20260228 (https://download.01.org/0day-ci/archive/20260301/202603010957.7JUXdjTd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603010957.7JUXdjTd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603010957.7JUXdjTd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/hornet/hornet_lsm.c:10:
   In file included from include/linux/lsm_hooks.h:29:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:32:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> security/hornet/hornet_lsm.c:183:8: error: call to undeclared function 'verify_pkcs7_signature'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     183 |         err = verify_pkcs7_signature(prog->insnsi, prog->len * sizeof(struct bpf_insn),
         |               ^
   security/hornet/hornet_lsm.c:183:8: note: did you mean 'bpf_verify_pkcs7_signature'?
   include/linux/bpf.h:3624:5: note: 'bpf_verify_pkcs7_signature' declared here
    3624 | int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
         |     ^
>> security/hornet/hornet_lsm.c:197:6: error: call to undeclared function 'validate_pkcs7_trust'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     197 |         if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
         |             ^
   1 warning and 2 errors generated.


vim +/verify_pkcs7_signature +183 security/hornet/hornet_lsm.c

   153	
   154	static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
   155					struct bpf_token *token, bool is_kernel)
   156	{
   157		struct hornet_maps maps = {0};
   158		bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
   159		struct pkcs7_message *msg;
   160		struct hornet_parse_context *ctx;
   161		void *sig;
   162		int err;
   163		const void *authattrs;
   164		size_t authattrs_len;
   165	
   166		if (!attr->signature)
   167			return LSM_INT_VERDICT_UNSIGNED;
   168	
   169		ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
   170		if (!ctx)
   171			return -ENOMEM;
   172	
   173		maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
   174		sig = kzalloc(attr->signature_size, GFP_KERNEL);
   175		if (!sig) {
   176			err = -ENOMEM;
   177			goto out;
   178		}
   179		err = copy_from_bpfptr(sig, usig, attr->signature_size);
   180		if (err != 0)
   181			goto cleanup_sig;
   182	
 > 183		err = verify_pkcs7_signature(prog->insnsi, prog->len * sizeof(struct bpf_insn),
   184					     sig, attr->signature_size, VERIFY_USE_SECONDARY_KEYRING,
   185					     VERIFYING_BPF_SIGNATURE, NULL, NULL);
   186		if (err < 0) {
   187			err = LSM_INT_VERDICT_BADSIG;
   188			goto cleanup_sig;
   189		}
   190	
   191		msg = pkcs7_parse_message(sig, attr->signature_size);
   192		if (IS_ERR(msg)) {
   193			err = LSM_INT_VERDICT_BADSIG;
   194			goto cleanup_sig;
   195		}
   196	
 > 197		if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
   198			err = LSM_INT_VERDICT_PARTIALSIG;
   199			goto cleanup_msg;
   200		}
   201		if (pkcs7_get_authattr(msg, OID_hornet_data,
   202				       &authattrs, &authattrs_len) == -ENODATA) {
   203			err = LSM_INT_VERDICT_PARTIALSIG;
   204			goto cleanup_msg;
   205		}
   206	
   207		err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
   208		if (err < 0 || authattrs == NULL) {
   209			err = LSM_INT_VERDICT_PARTIALSIG;
   210			goto cleanup_msg;
   211		}
   212		err = hornet_verify_hashes(&maps, ctx, prog);
   213	
   214	cleanup_msg:
   215		pkcs7_free_message(msg);
   216	cleanup_sig:
   217		kfree(sig);
   218	out:
   219		kfree(ctx);
   220		return err;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
