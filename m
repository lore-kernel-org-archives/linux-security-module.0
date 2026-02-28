Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F22877D8;
	Sat, 28 Feb 2026 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772256872; cv=none; b=c9eOHCCTjgpMqVp/nI0JtttP1ezspmC7BuJ/9m0yHPyXLPneB8w3R4tj6RccQXao+pbyy5WXRXqgCbJk94hPPnTPkxl+PV9+LuoGIp4vc8Lx0nzutoPERpR6jqnIEo1zrZcHGZuJ63DLsMeQGU8qDF3aBQbvhJ9nsxzH2gBnlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772256872; c=relaxed/simple;
	bh=sTo7ttKxW4qkAJ7gPSFGQddJdAolYP33nHR3bLxdvBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEcgx7vSXoUAKE/B2TIlsb7vxzqQxkcb6e1mBLewkBcjdDxwXc3B1FjFP0FyWLwXyfv8NR5qehFqrZAmTVBQBBkGmQozKZUcIOjEshSY5c1neh2JprhawTPl0g1oGYHsPnMKiS9sQiWezbspjo6H6jXog9pPWv7sbsyarug39kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X44QETJD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X44QETJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772256871; x=1803792871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sTo7ttKxW4qkAJ7gPSFGQddJdAolYP33nHR3bLxdvBI=;
  b=X44QETJDXZayc2zl75amAAnD0Mb8yFmJ+ce4RgJMmjXRCwgs7bG9vc52
   5LuCXi9T15PtP6p9yBRxZqB/bwCrD8Gog34oMi4420S+HJWfrimtAHV7i
   RnQXWP53/P4/ZUIEyCe56YPlM4qBA94eWXEsFQQ6znb6errWcBPlZq5Xj
   ZPCwLzo09Qj68kXpFlVJPDQ96qWaViY6NOxngFWRWYY/yVZ4MnPNU0jxa
   QByPKMpG3HoDlQRY2yLPVW/Y38ycyWaUNus/WS7tRc4EksCJzAapl6cxf
   JFkuaN/t8/KBhrTozSwTNUuUVWnhGERF2wvvJs9p6ynosquMxjnUznupJ
   Q==;
X-CSE-ConnectionGUID: F+GkVeHZSzKUmt7UJgqGfg==
X-CSE-MsgGUID: QrjEYhqMTiqM4k7qFy4WIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83675005"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="83675005"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 21:34:30 -0800
X-CSE-ConnectionGUID: S5AEptvYTtqF/GCtLPcCFA==
X-CSE-MsgGUID: 9+Qbd53OQ5iLoWIw3O4tNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="214881695"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2026 21:34:25 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwCy5-00000000BKB-3zAQ;
	Sat, 28 Feb 2026 05:34:21 +0000
Date: Sat, 28 Feb 2026 13:33:38 +0800
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
Message-ID: <202602281307.9DVHYnXF-lkp@intel.com>
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
config: csky-randconfig-r071-20260228 (https://download.01.org/0day-ci/archive/20260228/202602281307.9DVHYnXF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281307.9DVHYnXF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281307.9DVHYnXF-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/hornet/hornet_lsm.c: In function 'hornet_check_program':
>> security/hornet/hornet_lsm.c:183:15: error: implicit declaration of function 'verify_pkcs7_signature'; did you mean 'bpf_verify_pkcs7_signature'? [-Wimplicit-function-declaration]
     183 |         err = verify_pkcs7_signature(prog->insnsi, prog->len * sizeof(struct bpf_insn),
         |               ^~~~~~~~~~~~~~~~~~~~~~
         |               bpf_verify_pkcs7_signature
>> security/hornet/hornet_lsm.c:197:13: error: implicit declaration of function 'validate_pkcs7_trust' [-Wimplicit-function-declaration]
     197 |         if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
         |             ^~~~~~~~~~~~~~~~~~~~


vim +183 security/hornet/hornet_lsm.c

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
