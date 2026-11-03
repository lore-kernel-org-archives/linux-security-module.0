Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683352;
	b=nu6xZWHk4eFlGpvkF7bnh1Q7yERbPsjC4+h/d4rOBAGeT4Gq0+qAZsyhZOI4hPHS1qxG
	 Orvg/fJ+3OMuKiRkUeGVlNpKeVmLhoOSbUiLoeXZuUR6qfBQrUlZgSepUrpve7CSWvohA
	 KNPZ9r4rpxDx306qwfqc7i0T8HmkgbowiG5ScVMa+mXPh5PYuC/0cAtUEeBkpBVUYTrHU
	 R3DIgtI3T0AgeQgwq1Ce9EzBsnkKq6EnPSBslfA1Vbhxl23WLZLg3O8uPugyK00QE5Y/+
	 F9vP+1P+b0KlLSH0Fe/BXMow8WP/9RQD/TyxOTmX1hOOBB68SSSdHPUUGEhv/mmnkaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683352;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cXrwTRaFh730XU9FBjkOIkE8uahxHCf45WfqpSbWrTY=;
	b=cRnAtIon/0kdRFh+gOTX2lt6tDFKzVF83lQPR4t/+t5w+kqJGFQjawTBGzimaBFnQWDz
	 t8baddUBO8W5Fg3RI2C3ihDeErBmQYXWc4i/tE/6TAJHBv5LBQKjpIJORsVMgcy4mQRIP
	 4JhMdH+x0vcKspS0yazDJSzujunS226sK5EtNQva6A5K79799TUeVQcVYTWNCiaX7ge3N
	 l9J13aqHLsMQXCwuv54mJjKnWvSjbte5ZSNWxJlBgamfihegAfEbyCzK6mURPuu5tJ94E
	 /uaNbOKLS9O7Aiczxw4g/HrpMPvc2gE/CYGXrVV7z1k5tgIPlLfeAIs/1TAhjrYUApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b+OLuOjC;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52D606A326;
	Tue,  3 Nov 2026 05:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF52D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b+OLuOjC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793683350; x=1825219350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMatKSt4uMBT5J2fCIlLezQmGdMHSyDkTfNuNe6/7NE=;
  b=b+OLuOjCHEXnCtpFxZ6xV+8I9IcVrudOsS561jxeWMrbyS+VJhb7Su2Y
   bDJmF2Dk8yz4IQPQnM9WBQASNoy5D8nyucE5E87WHAziVrJt9Nk1xvR2F
   CBCGK4FlOOExGjsjZUUVpTzZyRfM+OHO+7336Ve5UhuQFGgt68HxbtVjk
   sBrT1SZwlnGgSOsk88VJN2giUzcdiBWVBMDQOHShYabFFHucRpvG6IamM
   AuAToaaJQKXR+ggi94bdEmxic4IZDwr4t7Z1AEOWs7DJkA3BRSokk0hwS
   RyeN6fg0b+P/kFCbnLrhioebLK286vC5laSM9BH1OYj/cr/BrZR27YcHD
   g==;
X-CSE-ConnectionGUID: lMZDKT5fTGymzlD8lW7Lgw==
X-CSE-MsgGUID: qtzAsDU5Q7yvj97AeiFe4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2283394"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2283394"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 21:22:30 -0800
X-CSE-ConnectionGUID: ZmmZyUYuR8GtXBR9RhPIBw==
X-CSE-MsgGUID: nPEiGOL7TayBCbJ9Tfahvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6180891"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Nov 2026 21:22:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xO6yW-00000000iKO-2rOm;
	Tue, 03 Nov 2026 05:22:24 +0000
Date: Tue, 3 Nov 2026 13:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Oxana Kharitonova <webprosto@gmail.com>, mic@digikod.net,
	brauner@kernel.org, viro@zeniv.linux.org.uk, gnoack@google.com,
	utilityemal77@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: Re: [PATCH v2 3/4] Landlock: Add POSIX message queue scoping
Message-ID: <202611031330.RRP6ch5h-lkp@intel.com>
References: <20261102144708.920232-4-webprosto@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102144708.920232-4-webprosto@gmail.com>

Hi Oxana,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on linus/master next-20261030]
[cannot apply to shuah-kselftest/fixes trace/for-next brauner-vfs/vfs.all v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oxana-Kharitonova/ipc-Move-MQUEUE_MAGIC-to-a-shared-header/20261102-144557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20261102144708.920232-4-webprosto%40gmail.com
patch subject: [PATCH v2 3/4] Landlock: Add POSIX message queue scoping
config: nios2-randconfig-1000-20261103 (https://download.01.org/0day-ci/archive/20261103/202611031330.RRP6ch5h-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031330.RRP6ch5h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031330.RRP6ch5h-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/landlock/task.c: In function 'landlock_check_posix_mqueue_open':
   security/landlock/task.c:579:18: error: 'struct landlock_request' has no member named 'other_domain_id'
     579 |                 .other_domain_id = creator_domain ? creator_domain->hierarchy->id : 0,
         |                  ^~~~~~~~~~~~~~~
>> security/landlock/task.c:579:78: error: 'struct landlock_hierarchy' has no member named 'id'
     579 |                 .other_domain_id = creator_domain ? creator_domain->hierarchy->id : 0,
         |                                                                              ^~


vim +579 security/landlock/task.c

   528	
   529	/**
   530	 * landlock_check_posix_mqueue_open - Deny opening a POSIX message queue
   531	 * created by a task from a different (non-ancestor) domain
   532	 *
   533	 * @file: The mqueuefs file being opened.
   534	 *
   535	 * Return: -EPERM if the open must be denied, 0 otherwise.
   536	 */
   537	int landlock_check_posix_mqueue_open(struct file *const file)
   538	{
   539		const struct inode *const inode = file_inode(file);
   540		const struct landlock_cred_security *subject;
   541		struct landlock_object *object;
   542		struct landlock_domain *creator_domain = NULL;
   543		bool is_scoped;
   544		size_t handle_layer;
   545	
   546		if (!landlock_is_posix_mqueue_inode(inode))
   547			return 0;
   548	
   549		subject = landlock_get_applicable_subject(
   550			file->f_cred, posix_mqueue_scope, &handle_layer);
   551		if (!subject)
   552			return 0;
   553	
   554		rcu_read_lock();
   555		object = rcu_dereference(landlock_inode(inode)->object);
   556		/* The temporary reference protects against concurrent object release. */
   557		if (object && !refcount_inc_not_zero(&object->usage))
   558			object = NULL;
   559		rcu_read_unlock();
   560	
   561		if (object) {
   562			spin_lock(&object->lock);
   563			creator_domain = object->domain;
   564			landlock_get_domain(creator_domain);
   565			spin_unlock(&object->lock);
   566		}
   567	
   568		/* Untagged queues were created outside any Landlock domain. */
   569		is_scoped = domain_is_scoped(subject->domain, creator_domain,
   570					     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
   571		if (!is_scoped) {
   572			landlock_put_domain_deferred(creator_domain);
   573			landlock_put_object(object);
   574			return 0;
   575		}
   576	
   577		landlock_log_denial(subject, &(struct landlock_request) {
   578			.type = LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
 > 579			.other_domain_id = creator_domain ? creator_domain->hierarchy->id : 0,
   580			.audit = {
   581				.type = LSM_AUDIT_DATA_FILE,
   582				.u.file = file,
   583			},
   584			.layer_plus_one = handle_layer + 1,
   585		});
   586		landlock_put_domain_deferred(creator_domain);
   587		landlock_put_object(object);
   588		return -EPERM;
   589	}
   590	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
