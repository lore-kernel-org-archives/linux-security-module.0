Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C326F46F;
	Sat, 28 Mar 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666555; cv=none; b=U20gwdkiFYks7RtAGcd54wWzYCeOec12MtJxajrX7GM754XfcQY+mhWeNAcNZrgfDNNaNgJmRCBX5TjwFzZrSYHgQtX8fL6wUytug6Tl0bWuTp7T1Lui7Vy7udhV94HSCoT7uLQLAsdChJh7lT6g+7Yp4lcQ5K3SdnUZhuHCzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666555; c=relaxed/simple;
	bh=+nZ4u3MBcRwp9OGWXaCUo2FPTKLyPZrQVTAvSmX15Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpKtGCQ+thKUBjtezz5uWL+Phn13pIvk35lcpZUKWer6f6uiJ/Dt8Un5CKKQp+5LSK0V96Oq351W/UhdeOvb/UsOOO3fUKrp4pZdBhCnb9RwMv+wrovaTOD128NSYeCBaJHtbvkMrHBiWULUYjv6/dY84c/ZMNjEM2zOys+ixwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aknoCzpB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aknoCzpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774666553; x=1806202553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+nZ4u3MBcRwp9OGWXaCUo2FPTKLyPZrQVTAvSmX15Bk=;
  b=aknoCzpBFPiWDl2zhYIRTrNx/Viwi1izg4yymvSELiYZiZhNSPZ6NjqS
   T23LURY1gE0trdSMruvKRHrQZ/Ti9Q86vSqImFVQ0OCWI9LGiwIsLjuhU
   25yGqXYrHQcKwxXRQ6g62rpyjL9XGNmrYpoF75MQDxYtKxgAjQMD46n80
   dYHgsfkWJI6Q5B7lxe2ugD/ZB9TFklfuJbmaWva4pv0G3+3h2/8omGYwi
   j1u6cX1cBHur1UfXxzexXjXS++yfO1p2YFyJwGMpmZKwqWA7l97QcaWTd
   WReT9Bx348IxEcv1jMHCtqaY1eu5Q2yKu1+DGa4tSWW9MxQD6pQgcoQ6d
   w==;
X-CSE-ConnectionGUID: o0uctF+YQuywrHHaHwpYCg==
X-CSE-MsgGUID: X4M4L7QvRrqnHdC3y1/2Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75857023"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="75857023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 19:55:52 -0700
X-CSE-ConnectionGUID: /bKuae7qTwSAoSUlotz+1g==
X-CSE-MsgGUID: peMT7tAZRFGoECNlx4ANoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="224685528"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Mar 2026 19:55:46 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Jpv-00000000B0v-1g9H;
	Sat, 28 Mar 2026 02:55:43 +0000
Date: Sat, 28 Mar 2026 10:55:32 +0800
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
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 6/9] security: Hornet LSM
Message-ID: <202603281030.AIoqyOy3-lkp@intel.com>
References: <20260326060655.2550595-7-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326060655.2550595-7-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master shuah-kselftest/next shuah-kselftest/fixes linus/master v7.0-rc5 next-20260327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/crypto-pkcs7-add-flag-for-validated-trust-on-a-signed-info-block/20260327-145024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20260326060655.2550595-7-bboscaccy%40linux.microsoft.com
patch subject: [PATCH v3 6/9] security: Hornet LSM
config: x86_64-randconfig-102-20260328 (https://download.01.org/0day-ci/archive/20260328/202603281030.AIoqyOy3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281030.AIoqyOy3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281030.AIoqyOy3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/hornet/hornet_lsm.c:194:6: error: call to undeclared function 'verify_pkcs7_message_sig'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     194 |         if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(struct bpf_insn), msg,
         |             ^
   1 error generated.


vim +/verify_pkcs7_message_sig +194 security/hornet/hornet_lsm.c

   155	
   156	static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
   157					struct bpf_token *token, bool is_kernel,
   158					enum lsm_integrity_verdict *verdict)
   159	{
   160		struct hornet_maps maps = {0};
   161		bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
   162		struct pkcs7_message *msg;
   163		struct hornet_parse_context *ctx;
   164		void *sig;
   165		int err;
   166		const void *authattrs;
   167		size_t authattrs_len;
   168	
   169		if (!attr->signature) {
   170			*verdict = LSM_INT_VERDICT_UNSIGNED;
   171			return 0;
   172		}
   173	
   174		ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
   175		if (!ctx)
   176			return -ENOMEM;
   177	
   178		maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
   179		sig = kzalloc(attr->signature_size, GFP_KERNEL);
   180		if (!sig) {
   181			err = -ENOMEM;
   182			goto out;
   183		}
   184		err = copy_from_bpfptr(sig, usig, attr->signature_size);
   185		if (err != 0)
   186			goto cleanup_sig;
   187	
   188		msg = pkcs7_parse_message(sig, attr->signature_size);
   189		if (IS_ERR(msg)) {
   190			err = LSM_INT_VERDICT_BADSIG;
   191			goto cleanup_sig;
   192		}
   193	
 > 194		if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(struct bpf_insn), msg,
   195					     VERIFY_USE_SECONDARY_KEYRING,
   196					     VERIFYING_BPF_SIGNATURE,
   197					     NULL, NULL)) {
   198			err = LSM_INT_VERDICT_UNKNOWNKEY;
   199			goto cleanup_msg;
   200		}
   201	
   202		if (pkcs7_get_authattr(msg, OID_hornet_data,
   203				       &authattrs, &authattrs_len) == -ENODATA) {
   204			err = LSM_INT_VERDICT_PARTIALSIG;
   205			goto cleanup_msg;
   206		}
   207	
   208		err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
   209		if (err < 0 || authattrs == NULL) {
   210			err = LSM_INT_VERDICT_BADSIG;
   211			goto cleanup_msg;
   212		}
   213	
   214		err = hornet_verify_hashes(&maps, ctx, prog);
   215	
   216	cleanup_msg:
   217		pkcs7_free_message(msg);
   218	cleanup_sig:
   219		kfree(sig);
   220	out:
   221		kfree(ctx);
   222		return err;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
