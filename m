Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681790;
	b=4bZp8PAFATwPjhXEWrLjZ9prESshqMFPBQ+p55/2i4bi8pKDiqUKCynJulrrJNb0O1qk
	 cWzKfc5MrfQ4o0xOt55H3uXyt9ghYF7WKHW2Th310R2/0CAHECe1uJ6qfZhq8ZFk2Vkqk
	 yMKNQMaPkfvebSaGTRBPgrEpAnvnFEchcWtxbUQF4d5U3e1LWXn62ZR7LGq8jUS0pg/X1
	 4+OpnnH2RpIjyK+ZpAgnjY7aiSC0pK7vsk9Ig9o8qSVt+p7h9kIJq4cFJpxdJtVKdAyXs
	 5odLwC2QleBBYiK2KQgAS6WKjBSRTMoza7k2Q199E3DtEGSSxnQHx7rEFjXXwDNdv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681790;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QKqJB95B3xM1yXLGq6ZKJkPFTWUW4kEAaA6Evoxuu4Q=;
	b=sqBb2weomt20Vg1PYcU6O1Zhh4kU3V0hR0NPJt2QYzv72aED1lowUF9hnDMTZ209Di59
	 v+AZHGb240rJeZiMYfbTSbD46+qxPDiwROSS7pjUV+2g6exwoIfH+UNwp+GEdr0W1PfxO
	 /eP9wtdRO3zY3m/FHVYnOTDqS1HfYUw95eCISN2m5vPH+wlLyu1mv711KbNqcPN/RjkWf
	 s/45GGaLNqHFac5EI+Hvses48P4szeUecgDOT86eANrmZPoP7xKf4m3ZtUNlvXZ+1msJa
	 0bVY77d4/LPBoOAIAJA9wTaWasJ5AI4CMEtEZk50YQQ9lj/ld4H7j6i6aE83mJ0+/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPXyLiNz;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68B606A324;
	Tue,  3 Nov 2026 04:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F68B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPXyLiNz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793681789; x=1825217789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lCD1UoGaBAd8VaiHfFf8MOSoSmyKD980JlNHOxuzq08=;
  b=TPXyLiNzyM/mdx/5NWDnynLkPsaoMFzTN8vLpNgrKalLMVhHX1XSzSU2
   SLyglw0bF+8kQ/0TQO/JHTsKmQZ0+BoIIjYvQyJLkRp/W1gtETTwF87kE
   NxVmfZ+uX1Tsmcr9zF04y+es4SPCoFmXBGZ3hWqu9lVksiMpEPT5+RGvl
   WXI8SfdjLZOw9sbMrp3klrJNJwxe5LhCDk1vldIEbPsLo9zj2Jlx/UTju
   9ocnzXIaqOfp9ulk4Fdey3ubAolsNJrf+2iwPnXlE6aUAO0a3wRYw3r45
   MmT9bFtFHiKkeYUFb9316GTiVlLJm+n3HVV/N5vXeRDS1e1bA5qqRrZ2E
   A==;
X-CSE-ConnectionGUID: hKTA+x3qTWuyg+zeJWXNBA==
X-CSE-MsgGUID: R9seE1nWQkOcMN+0n9JdkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2269875"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2269875"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 20:56:28 -0800
X-CSE-ConnectionGUID: 7tI6NU7NQXSEJGacSe6FoA==
X-CSE-MsgGUID: M6nOKmUzTOSJgONiNDWXzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6664743"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Nov 2026 20:56:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xO6ZL-00000000iJk-1DAi;
	Tue, 03 Nov 2026 04:56:23 +0000
Date: Tue, 3 Nov 2026 12:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Oxana Kharitonova <webprosto@gmail.com>, mic@digikod.net,
	brauner@kernel.org, viro@zeniv.linux.org.uk, gnoack@google.com,
	utilityemal77@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: Re: [PATCH v2 3/4] Landlock: Add POSIX message queue scoping
Message-ID: <202611031209.bINuNiz5-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261103/202611031209.bINuNiz5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031209.bINuNiz5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031209.bINuNiz5-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/landlock/task.c: In function 'landlock_check_posix_mqueue_open':
>> security/landlock/task.c:579:18: error: 'struct landlock_request' has no member named 'other_domain_id'
     579 |                 .other_domain_id = creator_domain ? creator_domain->hierarchy->id : 0,
         |                  ^~~~~~~~~~~~~~~


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
