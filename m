From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 May 2018 09:43:16 +0800
Subject: [PATCH ghak81 V3 3/3] audit: collect audit task parameters
In-Reply-To: <fbed63483b5206009ee43ae889b30d43051f386c.1526430313.git.rgb@redhat.com>
References: <fbed63483b5206009ee43ae889b30d43051f386c.1526430313.git.rgb@redhat.com>
Message-ID: <201805170921.vSuTk8UB%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Richard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180516]
[cannot apply to linus/master tip/sched/core v4.17-rc5 v4.17-rc4 v4.17-rc3 v4.17-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Richard-Guy-Briggs/audit-group-task-params/20180517-090703
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/fork.c: In function 'copy_process':
>> kernel/fork.c:1739:3: error: 'struct task_struct' has no member named 'audit'
     p->audit = NULL;
      ^~

vim +1739 kernel/fork.c

  1728	
  1729		p->default_timer_slack_ns = current->timer_slack_ns;
  1730	
  1731		task_io_accounting_init(&p->ioac);
  1732		acct_clear_integrals(p);
  1733	
  1734		posix_cpu_timers_init(p);
  1735	
  1736		p->start_time = ktime_get_ns();
  1737		p->real_start_time = ktime_get_boot_ns();
  1738		p->io_context = NULL;
> 1739		p->audit = NULL;
  1740		cgroup_fork(p);
  1741	#ifdef CONFIG_NUMA
  1742		p->mempolicy = mpol_dup(p->mempolicy);
  1743		if (IS_ERR(p->mempolicy)) {
  1744			retval = PTR_ERR(p->mempolicy);
  1745			p->mempolicy = NULL;
  1746			goto bad_fork_cleanup_threadgroup_lock;
  1747		}
  1748	#endif
  1749	#ifdef CONFIG_CPUSETS
  1750		p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
  1751		p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
  1752		seqcount_init(&p->mems_allowed_seq);
  1753	#endif
  1754	#ifdef CONFIG_TRACE_IRQFLAGS
  1755		p->irq_events = 0;
  1756		p->hardirqs_enabled = 0;
  1757		p->hardirq_enable_ip = 0;
  1758		p->hardirq_enable_event = 0;
  1759		p->hardirq_disable_ip = _THIS_IP_;
  1760		p->hardirq_disable_event = 0;
  1761		p->softirqs_enabled = 1;
  1762		p->softirq_enable_ip = _THIS_IP_;
  1763		p->softirq_enable_event = 0;
  1764		p->softirq_disable_ip = 0;
  1765		p->softirq_disable_event = 0;
  1766		p->hardirq_context = 0;
  1767		p->softirq_context = 0;
  1768	#endif
  1769	
  1770		p->pagefault_disabled = 0;
  1771	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
