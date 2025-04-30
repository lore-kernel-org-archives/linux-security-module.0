Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321EC2DC791;
	Wed, 30 Apr 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039404; cv=none; b=kUlO7FdqYh9fch2i0xDrfXBzFElpAFN0tmc3jmIziqTKkaF7qWno9xfKG/4AvMXcNyOowY/TwnEMBq+7xexMk25byOb68/j81gjvHk6KNjBkuNdI291HGQycDBo2odq17Y6w26+kcnYZH5OGP2/NE8eSXyjTeBljzDzbx+aRDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039404; c=relaxed/simple;
	bh=E8Dg28eLfWM0Bp27HfmoqYVosUDnKw+dSGVkNPWm+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Pk47cda5uiQ43FkScOrOvz/FuuMyFMn6ec04nfbEe69DBv6kIKu0seRtiFEl0wgzK39ZNTOCv/YqWWn5NiRwor/ZeMOL0RjNN/j9H6gv4dlyn6/9ZkVOz/zwybqkFsoKqHsiYRSP0/+ADGKZor4Zo7xKvqDg54ki0BTnNBu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM6lS6Mz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM6lS6Mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3593C4CEE7;
	Wed, 30 Apr 2025 18:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746039404;
	bh=E8Dg28eLfWM0Bp27HfmoqYVosUDnKw+dSGVkNPWm+t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sM6lS6Mz8dWP55ow90MyM3Mbyw3jy961LcZc5oC2YA0QQwp3rfFIy42KVuTLaydO+
	 rvPnZkgNdLq+gDn6REqgCRCD+qGPU1PyR/mIjiMZ7lmNN3zMB91W0E+RWTbA4pwnP7
	 ykOBmwgcUnmZue5g0VYaIwWcZCILnt629I/TmpZ+mJQcm/ZIRETTfF7JXiM7kEi5+4
	 k1CE8AucFzceDYOu3Q2QnMxVNtwsBTtM1Uuf2MreJBt8mhQ5DOQ4BsUb08hx+uEvYS
	 BLU8h+o5nubKrJMhcB6g+Wq5D90EBoHXcreFP5HLVBaXY6yOhfKGLnNP24gnB3HgsQ
	 ApPSk9akjLlBw==
Date: Wed, 30 Apr 2025 11:56:41 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] lib/tests: Add randstruct KUnit test
Message-ID: <202504301156.5DA54A7@keescook>
References: <20250427013836.877214-2-kees@kernel.org>
 <202504271150.Be642Srg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504271150.Be642Srg-lkp@intel.com>

On Sun, Apr 27, 2025 at 11:47:19AM +0800, kernel test robot wrote:
> Hi Kees,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on kees/for-next/hardening]
> [also build test WARNING on linus/master v6.15-rc3 next-20250424]
> [cannot apply to akpm-mm/mm-nonmm-unstable soc/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/randstruct-gcc-plugin-Remove-bogus-void-member/20250427-093946
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> patch link:    https://lore.kernel.org/r/20250427013836.877214-2-kees%40kernel.org
> patch subject: [PATCH 2/3] lib/tests: Add randstruct KUnit test
> config: riscv-randconfig-001-20250427 (https://download.01.org/0day-ci/archive/20250427/202504271150.Be642Srg-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504271150.Be642Srg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504271150.Be642Srg-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> lib/tests/randstruct_kunit.c:36:36: warning: '_Static_assert' with no message is a C23 extension [-Wc23-extensions]
>       36 | _Static_assert(MEMBER_NAME_MAX == 8);
>          |                                    ^
>          |                                    , ""
>    1 warning generated.

Thanks! I've fixed this locally.

-- 
Kees Cook
