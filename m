Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93F21770B
	for <linux-security-module@vger.kernel.org>; Thu, 29 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748504396; cv=none; b=hyzryxKIGUq8rifce5IDuhsk+rmoYwq+pNWqwQU20MvCbCmSF3E2fja7DR6+cA10S8AJwu+PdUxU/BPVxBypf/039M4P66sxfO9e25jPVhgJ0fglsjJscdHl7NdKcpEDB+nplbw0GWyJCndgiLwIfWjJ8FQuhMxMfbqZOi/M14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748504396; c=relaxed/simple;
	bh=O0dJtGowE7gW27PoxJSALuxp+LKuKC26CPdErKCWpdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Avq+0LSSgcEoGvwx7IJIdD/pUDPZn2ucNwXcWQ5uv6aGxgyod7NctnksKBQccrQ0rQhQl9PWS2bJsEMlKrRw2Mk0jNILRzbqSgw8MkhxBCcd2As7Db1KcXPa5yQuP/SeK4Kp2+Aua201IwvFYv/O1FOVJdZFfaKGyWt7x6ZayQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EC3QbiCb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EC3QbiCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748504391; x=1780040391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0dJtGowE7gW27PoxJSALuxp+LKuKC26CPdErKCWpdk=;
  b=EC3QbiCbGHTyNiMRH34/lBa+BQ2CiQ2qI+OWqNLtShtWBYq++XCcd13x
   13G+uAJUkrCTSNNedX4Blt8JY9XDQYVk9cbmtpw7hnHnJjY3tk9TlLBtj
   bLWtXtD+RCtP6GtQ6WsWrgEal2yyiMzmnP7VNa1blD8un9S6TZKEhKaxk
   QQIh+4oEBcRrBaDF8EUXU3DC3cEcQ9QHkW3JsMCnKN9RZ2IDK1R7k5iEU
   WYK/RmpWJK8CEOl6rMaUGekG+yOlz/jFX2gp8nRUw8XcFbhgEPCPLkrrK
   1ho8OoN0NQb6E+u85+X6n0tHXyxZUKONKFaZJM6xdt8Ka/4lOtB3J9UcX
   w==;
X-CSE-ConnectionGUID: BgNqXEZATnCHq/nS1NlKbA==
X-CSE-MsgGUID: A/5BLA28SpKmaoWS+r/fDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54350236"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="54350236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:39:50 -0700
X-CSE-ConnectionGUID: UvhzwCjmQxK10OKYCy2EVg==
X-CSE-MsgGUID: milfsRW9RzWrvYt+qh6aXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143952706"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 May 2025 00:39:43 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKXrZ-000WRo-1I;
	Thu, 29 May 2025 07:39:41 +0000
Date: Thu, 29 May 2025 15:39:19 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>, jarkko@kernel.org,
	zeffron@riotgames.com, xiyou.wangcong@gmail.com,
	kysrinivasan@gmail.com, code@tyhicks.com,
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] bpf: Add bpf_check_signature
Message-ID: <202505291545.Or5jFXUA-lkp@intel.com>
References: <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master v6.15]
[cannot apply to bpf-next/master linus/master next-20250528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/bpf-Add-bpf_check_signature/20250529-055248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250528215037.2081066-2-bboscaccy%40linux.microsoft.com
patch subject: [PATCH 1/3] bpf: Add bpf_check_signature
config: arc-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505291545.Or5jFXUA-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291545.Or5jFXUA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291545.Or5jFXUA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_check_signature':
>> kernel/bpf/syscall.c:2797:23: error: implicit declaration of function 'verify_pkcs7_signature'; did you mean 'verify_signature'? [-Werror=implicit-function-declaration]
    2797 |                 err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
         |                       ^~~~~~~~~~~~~~~~~~~~~~
         |                       verify_signature
   cc1: some warnings being treated as errors


vim +2797 kernel/bpf/syscall.c

  2766	
  2767	static int bpf_check_signature(struct bpf_prog *prog, union bpf_attr *attr, bpfptr_t uattr,
  2768				       __u32 uattr_size)
  2769	{
  2770		u64 hash[4];
  2771		u64 buffer[8];
  2772		int err;
  2773		char *signature;
  2774		int *used_maps;
  2775		int n;
  2776		int map_fd;
  2777		struct bpf_map *map;
  2778	
  2779		if (!attr->signature)
  2780			return 0;
  2781	
  2782		signature = kmalloc(attr->signature_size, GFP_KERNEL);
  2783		if (!signature) {
  2784			err = -ENOMEM;
  2785			goto out;
  2786		}
  2787	
  2788		if (copy_from_bpfptr(signature,
  2789				     make_bpfptr(attr->signature, uattr.is_kernel),
  2790				     attr->signature_size) != 0) {
  2791			err = -EINVAL;
  2792			goto free_sig;
  2793		}
  2794	
  2795		if (!attr->signature_maps_size) {
  2796			sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&hash);
> 2797			err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
  2798					     VERIFY_USE_SECONDARY_KEYRING,
  2799					     VERIFYING_EBPF_SIGNATURE,
  2800					     NULL, NULL);
  2801		} else {
  2802			used_maps = kmalloc_array(attr->signature_maps_size,
  2803						  sizeof(*used_maps), GFP_KERNEL);
  2804			if (!used_maps) {
  2805				err = -ENOMEM;
  2806				goto free_sig;
  2807			}
  2808			n = attr->signature_maps_size;
  2809			n--;
  2810	
  2811			err = copy_from_bpfptr_offset(&map_fd, make_bpfptr(attr->fd_array, uattr.is_kernel),
  2812						      used_maps[n] * sizeof(map_fd),
  2813						      sizeof(map_fd));
  2814			if (err < 0)
  2815				goto free_maps;
  2816	
  2817			/* calculate the terminal hash */
  2818			CLASS(fd, f)(map_fd);
  2819			map = __bpf_map_get(f);
  2820			if (IS_ERR(map)) {
  2821				err = PTR_ERR(map);
  2822				goto free_maps;
  2823			}
  2824			if (__map_get_hash(map, (u8 *)hash)) {
  2825				err = -EINVAL;
  2826				goto free_maps;
  2827			}
  2828	
  2829			n--;
  2830			/* calculate a link in the hash chain */
  2831			while (n >= 0) {
  2832				memcpy(buffer, hash, sizeof(hash));
  2833				err = copy_from_bpfptr_offset(&map_fd,
  2834							      make_bpfptr(attr->fd_array, uattr.is_kernel),
  2835							      used_maps[n] * sizeof(map_fd),
  2836							      sizeof(map_fd));
  2837				if (err < 0)
  2838					goto free_maps;
  2839	
  2840				CLASS(fd, f)(map_fd);
  2841				map = __bpf_map_get(f);
  2842				if (!map) {
  2843					err = -EINVAL;
  2844					goto free_maps;
  2845				}
  2846				if (__map_get_hash(map, (u8 *)buffer+4)) {
  2847					err = -EINVAL;
  2848					goto free_maps;
  2849				}
  2850				sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
  2851				n--;
  2852			}
  2853			/* calculate the root hash and verify it's signature */
  2854			sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&buffer);
  2855			memcpy(buffer+4, hash, sizeof(hash));
  2856			sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
  2857			err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
  2858					     VERIFY_USE_SECONDARY_KEYRING,
  2859					     VERIFYING_EBPF_SIGNATURE,
  2860					     NULL, NULL);
  2861	free_maps:
  2862			kfree(used_maps);
  2863		}
  2864	
  2865	free_sig:
  2866		kfree(signature);
  2867	out:
  2868		prog->aux->signature_verified = !err;
  2869		return err;
  2870	}
  2871	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
