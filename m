From: john.johansen@canonical.com (John Johansen)
Date: Wed, 8 Nov 2017 07:54:53 -0800
Subject: [apparmor_mmap_file] WARNING: bad unlock balance detected!
In-Reply-To: <20171107013821.2b34a6i6uez37stu@wfg-t540p.sh.intel.com>
References: <20171107013821.2b34a6i6uez37stu@wfg-t540p.sh.intel.com>
Message-ID: <a2bd530e-b3a4-09b3-227b-b095cfd8a1ce@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/06/2017 05:38 PM, Fengguang Wu wrote:
> Hi,
> 
> Here is a warning in 4.14-rc8 -- it's not necessarily a new bug.
> 
sigh, yep its older than 4.14 but I have haven't finished bisecting it yet

thanks

> Please press Enter to activate this console.
> [?? 45.117766] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> [?? 45.122174] 8021q: adding VLAN 0 to HW filter on device eth0
> [?? 45.247159] [?? 45.247451] =====================================
> [?? 45.248021] WARNING: bad unlock balance detected!
> [?? 45.248608] 4.14.0-rc8 #158 Not tainted
> [?? 45.249087] -------------------------------------
> [?? 45.249672] fw3/1183 is trying to release lock (rcu_preempt_state) at:
> [?? 45.250443] [<c10e4348>] rcu_read_unlock_special+0x5f8/0x620
> [?? 45.251136] but there are no more locks to release!
> [?? 45.251752] [?? 45.251752] other info that might help us debug this:
> [?? 45.252561] 1 lock held by fw3/1183:
> [?? 45.253019]? #0:? (rcu_read_lock){....}, at: [<c16e24c0>] aa_file_perm+0x0/0x460
> [?? 45.253925] [?? 45.253925] stack backtrace:
> [?? 45.254526] CPU: 0 PID: 1183 Comm: fw3 Not tainted 4.14.0-rc8 #158
> [?? 45.255275] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [?? 45.256266] Call Trace:
> [?? 45.256628]? dump_stack+0x16/0x1c
> [?? 45.257082]? print_unlock_imbalance_bug+0xb9/0xd0
> [?? 45.257676]? ? rcu_read_unlock_special+0x5f8/0x620
> [?? 45.258259]? ? rcu_read_unlock_special+0x5f8/0x620
> [?? 45.258871]? lock_release+0x1cc/0x490
> [?? 45.259347]? ? rcu_read_unlock_special+0x5f8/0x620
> [?? 45.259969]? ? _raw_spin_unlock_irqrestore+0x86/0xd0
> [?? 45.260581]? rt_mutex_unlock+0x1e/0xb0
> [?? 45.261054]? rcu_read_unlock_special+0x5f8/0x620
> [?? 45.261643]? __rcu_read_unlock+0xa7/0xb0
> [?? 45.262152]? aa_file_perm+0x5a/0x460
> [?? 45.262633]? ? pvclock_clocksource_read+0xd5/0x230
> [?? 45.263203]? ? pvclock_clocksource_read+0xd5/0x230
> [?? 45.263797]? common_file_perm+0x81/0x240
> [?? 45.264308]? ? kvm_sched_clock_read+0x9/0x20
> [?? 45.264843]? common_mmap+0x93/0xd0
> [?? 45.265283]? ? apparmor_file_mprotect+0x30/0x30
> [?? 45.265867]? apparmor_mmap_file+0x12/0x20
> [?? 45.266388]? security_mmap_file+0xaf/0x170
> [?? 45.266903]? vm_mmap_pgoff+0x35/0x100
> [?? 45.267381]? ? __fget+0x1c3/0x1d0
> [?? 45.267831]? SyS_mmap_pgoff+0x16d/0x370
> [?? 45.268318]? do_int80_syscall_32+0x95/0x290
> [?? 45.268840]? entry_INT80_32+0x2f/0x2f
> [?? 45.269313] EIP: 0xb7f7c2d4
> [?? 45.269713] EFLAGS: 00000202 CPU: 0
> [?? 45.270169] EAX: ffffffda EBX: b7f63000 ECX: 000002ad EDX: 00000003
> [?? 45.270901] ESI: 00000012 EDI: 00000003 EBP: 00000004 ESP: bff29f24
> [?? 45.271637]? DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
> [?? 45.351763] 8021q: adding VLAN 0 to HW filter on device eth0
> LKP: HOSTNAME vm-lkp-nhm-dp1-openwrt-ia32-6, MAC , kernel 4.14.0-rc8 158, serial console /dev/ttyS0
> [?? 47.390581] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> 
> Thanks,
> Fengguang

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
