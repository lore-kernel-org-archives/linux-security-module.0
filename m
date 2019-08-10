Return-Path: <SRS0=8uvB=WG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC85C32751
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Aug 2019 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1D220B7C
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Aug 2019 06:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfHJGlR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:41:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:25109 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfHJGlR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 10 Aug 2019 02:41:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 23:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,368,1559545200"; 
   d="gz'50?scan'50,208,50";a="177834521"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2019 23:41:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hwL3y-000BRY-C3; Sat, 10 Aug 2019 14:41:14 +0800
Date:   Sat, 10 Aug 2019 14:40:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     kbuild-all@01.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [security:next-lockdown 1/29] init/main.c:572:2: error: implicit
 declaration of function 'early_security_init'; did you mean 'security_init'?
Message-ID: <201908101412.oAv2QdH9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ocagms47at2sq6rt"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--ocagms47at2sq6rt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown
head:   05ef41e93e1a40d6b2d9846284824ec6f67fe422
commit: 45d29f9e9b8b9533e0ba1b3051d9d39ba29abad6 [1/29] security: Support early LSMs
config: i386-alldefconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        git checkout 45d29f9e9b8b9533e0ba1b3051d9d39ba29abad6
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c: In function 'start_kernel':
>> init/main.c:572:2: error: implicit declaration of function 'early_security_init'; did you mean 'security_init'? [-Werror=implicit-function-declaration]
     early_security_init();
     ^~~~~~~~~~~~~~~~~~~
     security_init
   cc1: some warnings being treated as errors

vim +572 init/main.c

   550	
   551	asmlinkage __visible void __init start_kernel(void)
   552	{
   553		char *command_line;
   554		char *after_dashes;
   555	
   556		set_task_stack_end_magic(&init_task);
   557		smp_setup_processor_id();
   558		debug_objects_early_init();
   559	
   560		cgroup_init_early();
   561	
   562		local_irq_disable();
   563		early_boot_irqs_disabled = true;
   564	
   565		/*
   566		 * Interrupts are still disabled. Do necessary setups, then
   567		 * enable them.
   568		 */
   569		boot_cpu_init();
   570		page_address_init();
   571		pr_notice("%s", linux_banner);
 > 572		early_security_init();
   573		setup_arch(&command_line);
   574		mm_init_cpumask(&init_mm);
   575		setup_command_line(command_line);
   576		setup_nr_cpu_ids();
   577		setup_per_cpu_areas();
   578		smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
   579		boot_cpu_hotplug_init();
   580	
   581		build_all_zonelists(NULL);
   582		page_alloc_init();
   583	
   584		pr_notice("Kernel command line: %s\n", boot_command_line);
   585		/* parameters may set static keys */
   586		jump_label_init();
   587		parse_early_param();
   588		after_dashes = parse_args("Booting kernel",
   589					  static_command_line, __start___param,
   590					  __stop___param - __start___param,
   591					  -1, -1, NULL, &unknown_bootoption);
   592		if (!IS_ERR_OR_NULL(after_dashes))
   593			parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
   594				   NULL, set_init_arg);
   595	
   596		/*
   597		 * These use large bootmem allocations and must precede
   598		 * kmem_cache_init()
   599		 */
   600		setup_log_buf(0);
   601		vfs_caches_init_early();
   602		sort_main_extable();
   603		trap_init();
   604		mm_init();
   605	
   606		ftrace_init();
   607	
   608		/* trace_printk can be enabled here */
   609		early_trace_init();
   610	
   611		/*
   612		 * Set up the scheduler prior starting any interrupts (such as the
   613		 * timer interrupt). Full topology setup happens at smp_init()
   614		 * time - but meanwhile we still have a functioning scheduler.
   615		 */
   616		sched_init();
   617		/*
   618		 * Disable preemption - early bootup scheduling is extremely
   619		 * fragile until we cpu_idle() for the first time.
   620		 */
   621		preempt_disable();
   622		if (WARN(!irqs_disabled(),
   623			 "Interrupts were enabled *very* early, fixing it\n"))
   624			local_irq_disable();
   625		radix_tree_init();
   626	
   627		/*
   628		 * Set up housekeeping before setting up workqueues to allow the unbound
   629		 * workqueue to take non-housekeeping into account.
   630		 */
   631		housekeeping_init();
   632	
   633		/*
   634		 * Allow workqueue creation and work item queueing/cancelling
   635		 * early.  Work item execution depends on kthreads and starts after
   636		 * workqueue_init().
   637		 */
   638		workqueue_init_early();
   639	
   640		rcu_init();
   641	
   642		/* Trace events are available after this */
   643		trace_init();
   644	
   645		if (initcall_debug)
   646			initcall_debug_enable();
   647	
   648		context_tracking_init();
   649		/* init some links before init_ISA_irqs() */
   650		early_irq_init();
   651		init_IRQ();
   652		tick_init();
   653		rcu_init_nohz();
   654		init_timers();
   655		hrtimers_init();
   656		softirq_init();
   657		timekeeping_init();
   658	
   659		/*
   660		 * For best initial stack canary entropy, prepare it after:
   661		 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
   662		 * - timekeeping_init() for ktime entropy used in rand_initialize()
   663		 * - rand_initialize() to get any arch-specific entropy like RDRAND
   664		 * - add_latent_entropy() to get any latent entropy
   665		 * - adding command line entropy
   666		 */
   667		rand_initialize();
   668		add_latent_entropy();
   669		add_device_randomness(command_line, strlen(command_line));
   670		boot_init_stack_canary();
   671	
   672		time_init();
   673		printk_safe_init();
   674		perf_event_init();
   675		profile_init();
   676		call_function_init();
   677		WARN(!irqs_disabled(), "Interrupts were enabled early\n");
   678	
   679		early_boot_irqs_disabled = false;
   680		local_irq_enable();
   681	
   682		kmem_cache_init_late();
   683	
   684		/*
   685		 * HACK ALERT! This is early. We're enabling the console before
   686		 * we've done PCI setups etc, and console_init() must be aware of
   687		 * this. But we do want output early, in case something goes wrong.
   688		 */
   689		console_init();
   690		if (panic_later)
   691			panic("Too many boot %s vars at `%s'", panic_later,
   692			      panic_param);
   693	
   694		lockdep_init();
   695	
   696		/*
   697		 * Need to run this when irqs are enabled, because it wants
   698		 * to self-test [hard/soft]-irqs on/off lock inversion bugs
   699		 * too:
   700		 */
   701		locking_selftest();
   702	
   703		/*
   704		 * This needs to be called before any devices perform DMA
   705		 * operations that might use the SWIOTLB bounce buffers. It will
   706		 * mark the bounce buffers as decrypted so that their usage will
   707		 * not cause "plain-text" data to be decrypted when accessed.
   708		 */
   709		mem_encrypt_init();
   710	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ocagms47at2sq6rt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7XMRL/Wi1bscqyH3DLD/A+BQR7gFnQAA

--ocagms47at2sq6rt--
