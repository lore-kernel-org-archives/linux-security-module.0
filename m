Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCA443308;
	Mon,  7 Sep 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818386; cv=none; b=oIjj52FQ8E4zJf32Vwo2eqx/htd8Jv3acMAYpjO23VV+9opQeD3DHecr1wfZw5OiNAIX9zXW+QjMO2/QW5qryW8q7soyOKL0g0/6vc/CvGr6iOFGSo4EDdq9puWhUPBXmltEsA3LsjTQteN8jXfu3uTNshYyqlYz9NGNtvk05jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818386; c=relaxed/simple;
	bh=r65CDcHWr0z3eA9/ubS4hZ4+/sbcVXJDw5ZA38MifW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN8X8kb8cJtq/ZZD1qv/fm/hpb8b3aBrKP0HXtbG277dGFBZae576W1Y6iql8SHQ6uW953zLTly+mS/G5Y61hXYu7zcgmcYwzB5W9cEpYV+dqRn3wP76mobe588vOiUUEoTdOvccqsKG1qgbYhpSHah/LognsEj+/RkE7ze59Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHDE/7II; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHDE/7II"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788818384; x=1820354384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r65CDcHWr0z3eA9/ubS4hZ4+/sbcVXJDw5ZA38MifW8=;
  b=dHDE/7IIJknhhecfVwmrFI1Pq5BvUC07Glv7YcmmFFqvzLT3oed97e6w
   ccRn8sZGkSqkwdz7T+lK+xLpJLHwKhObDxHNZrvXJO+CHKqD/x4SjjnH3
   IW24kw/31x4DbkbeEAG6LXwA0lT6T3Qvo2h7JaEhGM/sxi27rOD7kjB9d
   SItgx9uANWeiTs95NI7l6vHZy3GTjnxkgriSpnIO0CDsny9KLdRz9rYEX
   fa5lYhpDlurhDg187dhpUYuZKZXKWuuqhrXUD7i00cqVUxKnDAi24IP+4
   n7hmkZJzZkYG7gDoqZBMpqfKcl//PHADOIYbWL+tCRHzaXsDMg9jDw52j
   A==;
X-CSE-ConnectionGUID: Q+qB1/bVRA6dWt2ctKJbtw==
X-CSE-MsgGUID: otM5c9IySU276TC2dXE4FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88152042"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="88152042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 14:59:44 -0700
X-CSE-ConnectionGUID: 8NWTMYYgSIGCQB0adp1Deg==
X-CSE-MsgGUID: HeYaaeU4Q2uPmLoLfhjo5w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Sep 2026 14:59:41 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3hNL-000000001Ml-2447;
	Mon, 07 Sep 2026 21:59:39 +0000
Date: Tue, 8 Sep 2026 05:59:33 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, torvalds@linux-foundation.org,
	linux-media@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: Re: [PATCH v2] media: dvb-core: extirpate defective and unsafe ULE
 debug block
Message-ID: <202609080524.kwJEdv90-lkp@intel.com>
References: <20260905142222.22818-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905142222.22818-1-breno3011alves@gmail.com>

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linuxtv-media-pending/master media-tree/master sailus-media-tree/master linus/master linux/master sailus-media-tree/streams v7.3-rc2 next-20260907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Rodrigues-Alves/media-dvb-core-extirpate-defective-and-unsafe-ULE-debug-block/20260905-112222
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260905142222.22818-1-breno3011alves%40gmail.com
patch subject: [PATCH v2] media: dvb-core: extirpate defective and unsafe ULE debug block
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260908/202609080524.kwJEdv90-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260908/202609080524.kwJEdv90-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609080524.kwJEdv90-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/media/dvb-core/dvb_net.c: In function 'dvb_net_ule':
>> drivers/media/dvb-core/dvb_net.c:806:51: warning: passing argument 2 of 'dvb_net_ule_check_crc' makes pointer from integer without a cast [-Wint-conversion]
     806 |                         dvb_net_ule_check_crc(&h, ule_crc, expected_crc);
         |                                                   ^~~~~~~
         |                                                   |
         |                                                   u32 {aka unsigned int}
   drivers/media/dvb-core/dvb_net.c:626:47: note: expected 'struct kvec *' but argument is of type 'u32' {aka 'unsigned int'}
     626 |                                   struct kvec iov[3],
         |                                   ~~~~~~~~~~~~^~~~~~
>> drivers/media/dvb-core/dvb_net.c:806:25: error: too few arguments to function 'dvb_net_ule_check_crc'
     806 |                         dvb_net_ule_check_crc(&h, ule_crc, expected_crc);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/media/dvb-core/dvb_net.c:625:13: note: declared here
     625 | static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/dvb_net_ule_check_crc +806 drivers/media/dvb-core/dvb_net.c

   721	
   722	static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
   723	{
   724		int ret;
   725		struct dvb_net_ule_handle h = {
   726			.dev = dev,
   727			.priv = netdev_priv(dev),
   728			.ethh = NULL,
   729			.buf = buf,
   730			.buf_len = buf_len,
   731			.skipped = 0L,
   732			.ts = NULL,
   733			.ts_end = NULL,
   734			.from_where = NULL,
   735			.ts_remain = 0,
   736			.how_much = 0,
   737			.new_ts = 1,
   738			.error = false,
   739		};
   740	
   741		/*
   742		 * For all TS cells in current buffer.
   743		 * Appearently, we are called for every single TS cell.
   744		 */
   745		for (h.ts = h.buf, h.ts_end = h.buf + h.buf_len;
   746		     h.ts < h.ts_end; /* no incr. */) {
   747			if (h.new_ts) {
   748				/* We are about to process a new TS cell. */
   749				if (dvb_net_ule_new_ts_cell(&h))
   750					continue;
   751			}
   752	
   753			/* Synchronize on PUSI, if required. */
   754			if (h.priv->need_pusi) {
   755				if (dvb_net_ule_ts_pusi(&h))
   756					continue;
   757			}
   758	
   759			if (h.new_ts) {
   760				if (dvb_net_ule_new_ts(&h))
   761					continue;
   762			}
   763	
   764			/* Check if new payload needs to be started. */
   765			if (h.priv->ule_skb == NULL) {
   766				ret = dvb_net_ule_new_payload(&h);
   767				if (ret < 0)
   768					return;
   769				if (ret)
   770					continue;
   771			}
   772	
   773			/* Copy data into our current skb. */
   774			h.how_much = min(h.priv->ule_sndu_remain, (int)h.ts_remain);
   775			skb_put_data(h.priv->ule_skb, h.from_where, h.how_much);
   776			h.priv->ule_sndu_remain -= h.how_much;
   777			h.ts_remain -= h.how_much;
   778			h.from_where += h.how_much;
   779	
   780			/* Check for complete payload. */
   781			if (h.priv->ule_sndu_remain <= 0) {
   782				/* Check CRC32, we've got it in our skb already. */
   783				__be16 ulen = htons(h.priv->ule_sndu_len);
   784				__be16 utype = htons(h.priv->ule_sndu_type);
   785				const u8 *tail;
   786				struct kvec iov[3] = {
   787					{ &ulen, sizeof ulen },
   788					{ &utype, sizeof utype },
   789					{ h.priv->ule_skb->data,
   790					  h.priv->ule_skb->len - 4 }
   791				};
   792				u32 ule_crc = ~0L, expected_crc;
   793				if (h.priv->ule_dbit) {
   794					/* Set D-bit for CRC32 verification,
   795					 * if it was set originally. */
   796					ulen |= htons(0x8000);
   797				}
   798	
   799				ule_crc = iov_crc32(ule_crc, iov, 3);
   800				tail = skb_tail_pointer(h.priv->ule_skb);
   801				expected_crc = *(tail - 4) << 24 |
   802					       *(tail - 3) << 16 |
   803					       *(tail - 2) << 8 |
   804					       *(tail - 1);
   805	
 > 806				dvb_net_ule_check_crc(&h, ule_crc, expected_crc);
   807	
   808				/* Prepare for next SNDU. */
   809				reset_ule(h.priv);
   810			}
   811	
   812			/* More data in current TS (look at the bytes following the CRC32)? */
   813			if (h.ts_remain >= 2 && *((unsigned short *)h.from_where) != 0xFFFF) {
   814				/* Next ULE SNDU starts right there. */
   815				h.new_ts = 0;
   816				h.priv->ule_skb = NULL;
   817				h.priv->ule_sndu_type_1 = 0;
   818				h.priv->ule_sndu_len = 0;
   819				// pr_warn("More data in current TS: [%#x %#x %#x %#x]\n",
   820				//	*(h.from_where + 0), *(h.from_where + 1),
   821				//	*(h.from_where + 2), *(h.from_where + 3));
   822				// pr_warn("h.ts @ %p, stopped @ %p:\n", h.ts, h.from_where + 0);
   823				// hexdump(h.ts, 188);
   824			} else {
   825				h.new_ts = 1;
   826				h.ts += TS_SZ;
   827				h.priv->ts_count++;
   828				if (h.priv->ule_skb == NULL) {
   829					h.priv->need_pusi = 1;
   830					h.priv->ule_sndu_type_1 = 0;
   831					h.priv->ule_sndu_len = 0;
   832				}
   833			}
   834		}	/* for all available TS cells */
   835	}
   836	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
