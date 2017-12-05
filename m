From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 5 Dec 2017 08:29:46 -0800
Subject: [PATCH 5/9] LSM: Manage remaining security blobs
In-Reply-To: <201712051929.JCJ90110.QVJOtFOHFMSOLF@I-love.SAKURA.ne.jp>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
	<d3bd7b64-020b-ac7c-8fef-eed6a1ad5185@schaufler-ca.com>
	<201711292021.CIC57334.OSQMFHOtOJFVLF@I-love.SAKURA.ne.jp>
	<b7a76b4d-b492-83c4-72ce-ca1e81c10ef3@schaufler-ca.com>
	<201712051929.JCJ90110.QVJOtFOHFMSOLF@I-love.SAKURA.ne.jp>
Message-ID: <3ea363ca-d82a-69cd-76ea-187b2d34cc7e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/5/2017 2:29 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 11/29/2017 3:21 AM, Tetsuo Handa wrote:
>>> Hello.
>>>
>>> I browsed https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1734686
>>> and found a problem with how security blob is initialized.
>>>
>>> Casey Schaufler wrote:
>>>> +/**
>>>> + * lsm_sock_alloc - allocate a composite sock blob
>>>> + * @sock: the sock that needs a blob
>>>> + * @priority: allocation mode
>>>> + *
>>>> + * Allocate the sock blob for all the modules
>>>> + *
>>>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>>>> + */
>>>> +int lsm_sock_alloc(struct sock *sock, gfp_t priority)
>>>> +{
>>>> +#ifdef CONFIG_SECURITY_LSM_DEBUG
>>>> +	if (sock->sk_security)
>>>> +		pr_info("%s: Inbound sock blob is not NULL.\n", __func__);
>>>> +#endif
>>> If none of LSM modules use sock->sk_security, sock->sk_security is not
>>> initialized to NULL (and sk_prot_alloc() does not always use __GFP_ZERO).
>> Thank you. I will be working on the next revision real soon and
>> will include a fix for this.
>>
> Below is a patch to avoid uninitialized ->security field. (Strictly speaking,
> we can remove more lines because kmalloc(0) != NULL. But this patch does not
> remove such lines in case we want to check for ->security != NULL in future
> code.)

Thank you. I will incorporate this.

>
> ----------
> diff -ur linux-4.13.0-17.20.orig/security/security.c linux-4.13.0-17.20/security/security.c
> --- linux-4.13.0-17.20.orig/security/security.c
> +++ linux-4.13.0-17.20/security/security.c
> @@ -324,12 +324,10 @@
>   */
>  int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (cred->security)
> -		pr_info("%s: Inbound cred blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_cred == 0)
> +	if (blob_sizes.lbs_cred == 0) {
> +		cred->security = NULL;
>  		return 0;
> +	}
>  
>  	cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
>  	if (cred->security == NULL)
> @@ -406,12 +404,10 @@
>   */
>  int lsm_file_alloc(struct file *file)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (file->f_security)
> -		pr_info("%s: Inbound file blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_file == 0)
> +	if (blob_sizes.lbs_file == 0) {
> +		file->f_security = NULL;
>  		return 0;
> +	}
>  
>  	file->f_security = kzalloc(blob_sizes.lbs_file, GFP_KERNEL);
>  	if (file->f_security == NULL)
> @@ -487,12 +483,10 @@
>   */
>  int lsm_task_alloc(struct task_struct *task)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (task->security)
> -		pr_info("%s: Inbound task blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_task == 0)
> +	if (blob_sizes.lbs_task == 0) {
> +		task->security = NULL;
>  		return 0;
> +	}
>  
>  	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>  	if (task->security == NULL)
> @@ -518,12 +512,10 @@
>   */
>  int lsm_inode_alloc(struct inode *inode)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (inode->i_security)
> -		pr_info("%s: Inbound inode blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_inode == 0)
> +	if (blob_sizes.lbs_inode == 0) {
> +		inode->i_security = NULL;
>  		return 0;
> +	}
>  
>  	inode->i_security = kzalloc(blob_sizes.lbs_inode, GFP_KERNEL);
>  	if (inode->i_security == NULL)
> @@ -560,12 +552,10 @@
>   */
>  int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (kip->security)
> -		pr_info("%s: Inbound ipc blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_ipc == 0)
> +	if (blob_sizes.lbs_ipc == 0) {
> +		kip->security = NULL;
>  		return 0;
> +	}
>  
>  	kip->security = kzalloc(blob_sizes.lbs_ipc, GFP_KERNEL);
>  	if (kip->security == NULL)
> @@ -584,12 +574,10 @@
>   */
>  int lsm_key_alloc(struct key *key)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (key->security)
> -		pr_info("%s: Inbound key blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_key == 0)
> +	if (blob_sizes.lbs_key == 0) {
> +		key->security = NULL;
>  		return 0;
> +	}
>  
>  	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
>  	if (key->security == NULL)
> @@ -608,12 +596,10 @@
>   */
>  int lsm_msg_msg_alloc(struct msg_msg *mp)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (mp->security)
> -		pr_info("%s: Inbound msg_msg blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_msg_msg == 0)
> +	if (blob_sizes.lbs_msg_msg == 0) {
> +		mp->security = NULL;
>  		return 0;
> +	}
>  
>  	mp->security = kzalloc(blob_sizes.lbs_msg_msg, GFP_KERNEL);
>  	if (mp->security == NULL)
> @@ -632,13 +618,10 @@
>   */
>  int lsm_sock_alloc(struct sock *sock, gfp_t priority)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (sock->sk_security)
> -		pr_info("%s: Inbound sock blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_sock == 0)
> +	if (blob_sizes.lbs_sock == 0) {
> +		sock->sk_security = NULL;
>  		return 0;
> -
> +	}
>  	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
>  	if (sock->sk_security == NULL)
>  		return -ENOMEM;
> @@ -655,12 +638,10 @@
>   */
>  int lsm_superblock_alloc(struct super_block *sb)
>  {
> -#ifdef CONFIG_SECURITY_LSM_DEBUG
> -	if (sb->s_security)
> -		pr_info("%s: Inbound superblock blob is not NULL.\n", __func__);
> -#endif
> -	if (blob_sizes.lbs_superblock == 0)
> +	if (blob_sizes.lbs_superblock == 0) {
> +		sb->s_security = NULL;
>  		return 0;
> +	}
>  
>  	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
>  	if (sb->s_security == NULL)
> ----------
>
> I noticed that Ubuntu 17.10 kernel crashes upon boot if the administrator tried to
> specify one of (or none of) major LSM modules other than AppArmor using security=
> parameter. It turned out that the cause is that we are failing to disable
> AppArmor when security= parameter is used (and apparmor=0 is not used).
>
> ----------
> [    0.000000] Linux version 4.13.0-17-generic (buildd at lcy01-amd64-011) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #20-Ubuntu SMP Mon Nov 6 10:04:08 UTC 2017 (Ubuntu 4.13.0-17.20-generic 4.13.8)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=none
> (...snipped...)
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=none
> [    0.000000] LSM: command line set 'none' security module(s).
> (...snipped...)
> [    0.040322] Security Framework initialized
> [    0.041502] Yama: becoming mindful.
> [    0.050757] BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
> [    0.052000] IP: apparmor_init+0x26f/0x2fa
> [    0.052000] PGD 0 
> [    0.052000] P4D 0 
> [    0.052000] 
> [    0.052000] Oops: 0002 [#1] SMP
> [    0.052000] Modules linked in:
> [    0.052000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.0-17-generic #20-Ubuntu
> [    0.052000] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
> [    0.052000] task: ffffffffa6410480 task.stack: ffffffffa6400000
> [    0.052000] RIP: 0010:apparmor_init+0x26f/0x2fa
> [    0.052000] RSP: 0000:ffffffffa6403e38 EFLAGS: 00010206
> [    0.052000] RAX: ffff8c6279012800 RBX: 0000000000000000 RCX: ffff8c6279012b98
> [    0.052000] RDX: 0000000000000020 RSI: 0000000000000080 RDI: 0000000000000000
> [    0.052000] RBP: ffffffffa6403e78 R08: ffff8c6278820000 R09: ffff8c6279006a00
> [    0.052000] R10: ffffffffa6403dd0 R11: 0000000000020120 R12: ffffffffa6457fe0
> [    0.052000] R13: 0000000000017210 R14: ffffffffa636e3e0 R15: 0000000000000000
> [    0.052000] FS:  0000000000000000(0000) GS:ffff8c6279600000(0000) knlGS:0000000000000000
> [    0.052000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.052000] CR2: 0000000000000020 CR3: 000000006bc09000 CR4: 00000000000406b0
> [    0.052000] Call Trace:
> [    0.052000]  do_security_initcalls+0x1c/0x25
> [    0.052000]  security_init+0x49/0x4d
> [    0.052000]  start_kernel+0x465/0x4e1
> [    0.052000]  ? early_idt_handler_array+0x120/0x120
> [    0.052000]  x86_64_start_reservations+0x24/0x26
> [    0.052000]  x86_64_start_kernel+0x13e/0x161
> [    0.052000]  secondary_startup_64+0x9f/0x9f
> [    0.052000] Code: ff 48 8b 05 ac 43 3f 00 48 63 15 0d 2d e8 ff 49 03 54 24 78 48 8b 40 68 48 89 c1 48 81 c1 98 03 00 00 74 07 f0 ff 80 98 03 00 00 <48> 89 0a be 3b 00 00 00 48 c7 c2 13 96 2c a6 48 c7 c7 00 38 38 
> [    0.052000] RIP: apparmor_init+0x26f/0x2fa RSP: ffffffffa6403e38
> [    0.052000] CR2: 0000000000000020
> [    0.052000] ---[ end trace 754b9ec1da9bb5fc ]---
> [    0.052000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.052000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>
>
>
> [    0.000000] Linux version 4.13.0-17-generic (buildd at lcy01-amd64-011) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #20-Ubuntu SMP Mon Nov 6 10:04:08 UTC 2017 (Ubuntu 4.13.0-17.20-generic 4.13.8)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=selinux
> (...snipped...)
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=selinux
> [    0.000000] LSM: command line set 'selinux' security module(s).
> (...snipped...)
> [    0.038014] Security Framework initialized
> [    0.039119] Yama: becoming mindful.
> [    0.040019] SELinux:  Disabled at boot.
> [    0.049252] AppArmor: AppArmor initialized
> [    0.076808] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.091667] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.092461] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.096417] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.099552] Disabled fast string operations
> [    0.100007] CPU: Physical Processor ID: 0
> [    0.101090] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.102650] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.104008] mce: CPU supports 0 MCE banks
> [    0.105095] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> [    0.108003] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> [    0.109930] Freeing SMP alternatives memory: 36K
> [    0.121143] smpboot: Max logical packages: 128
> [    0.124000] x2apic enabled
> [    0.124026] Switched APIC routing to physical x2apic.
> [    0.130183] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.132000] smpboot: CPU0: Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz (family: 0x6, model: 0x2a, stepping: 0x7)
> [    0.132556] Performance Events: SandyBridge events, core PMU driver.
> [    0.135024] core: CPUID marked event: 'cpu cycles' unavailable
> [    0.136007] core: CPUID marked event: 'instructions' unavailable
> [    0.138399] core: CPUID marked event: 'bus cycles' unavailable
> [    0.140008] core: CPUID marked event: 'cache references' unavailable
> [    0.142397] core: CPUID marked event: 'cache misses' unavailable
> [    0.144004] core: CPUID marked event: 'branch instructions' unavailable
> [    0.146528] core: CPUID marked event: 'branch misses' unavailable
> [    0.148022] ... version:                1
> [    0.149754] ... bit width:              48
> [    0.151620] ... generic registers:      4
> [    0.152006] ... value mask:             0000ffffffffffff
> [    0.154124] ... max period:             000000007fffffff
> [    0.156004] ... fixed-purpose events:   0
> [    0.157598] ... event mask:             000000000000000f
> [    0.159990] Hierarchical SRCU implementation.
> [    0.160195] BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
> [    0.163303] IP: __kmalloc_node+0x135/0x2a0
> [    0.164000] PGD 0 
> [    0.164000] P4D 0 
> [    0.164000] 
> [    0.164000] Oops: 0000 [#1] SMP
> [    0.164000] Modules linked in:
> [    0.164000] CPU: 0 PID: 2 Comm: kthreadd Not tainted 4.13.0-17-generic #20-Ubuntu
> [    0.164000] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
> [    0.164000] task: ffff980cf8658000 task.stack: ffffb809c0654000
> [    0.164000] RIP: 0010:__kmalloc_node+0x135/0x2a0
> [    0.164000] RSP: 0000:ffffb809c0657c70 EFLAGS: 00010246
> [    0.164000] RAX: 0000000000000000 RBX: 00000000014080c0 RCX: 0000000000000178
> [    0.164000] RDX: 0000000000000177 RSI: 0000000000000000 RDI: 000000000001f420
> [    0.164000] RBP: ffffb809c0657cb0 R08: ffff980cf961f420 R09: ffff980cf9007900
> [    0.164000] R10: ffffffffffffc000 R11: ffffd809bfffffff R12: 00000000014080c0
> [    0.164000] R13: 0000000000000020 R14: 000000000000000b R15: ffff980cf9007900
> [    0.164000] FS:  0000000000000000(0000) GS:ffff980cf9600000(0000) knlGS:0000000000000000
> [    0.164000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.164000] CR2: 000000000000000b CR3: 000000012b009000 CR4: 00000000000406f0
> [    0.164000] Call Trace:
> [    0.164000]  ? __vmalloc_node_range+0xd4/0x260
> [    0.164000]  __vmalloc_node_range+0xd4/0x260
> [    0.164000]  copy_process.part.31+0x662/0x1ae0
> [    0.164000]  ? _do_fork+0xdf/0x3f0
> [    0.164000]  ? kthread_create_on_node+0x70/0x70
> [    0.164000]  ? pick_next_task_fair+0x48e/0x560
> [    0.164000]  _do_fork+0xdf/0x3f0
> [    0.164000]  ? __schedule+0x293/0x890
> [    0.164000]  kernel_thread+0x29/0x30
> [    0.164000]  kthreadd+0x29f/0x2f0
> [    0.164000]  ? kthread_create_on_cpu+0xa0/0xa0
> [    0.164000]  ret_from_fork+0x25/0x30
> [    0.164000] Code: 89 cf 4c 89 4d c0 e8 0b 7f 01 00 49 89 c7 4c 8b 4d c0 4d 85 ff 0f 85 47 ff ff ff 45 31 f6 eb 3c 49 63 47 20 49 8b 3f 48 8d 4a 01 <49> 8b 1c 06 4c 89 f0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 20 ff 
> [    0.164000] RIP: __kmalloc_node+0x135/0x2a0 RSP: ffffb809c0657c70
> [    0.164000] CR2: 000000000000000b
> [    0.164000] ---[ end trace 8bd0169accb86cdb ]---
>
>
>
> [    0.000000] Linux version 4.13.0-17-generic (buildd at lcy01-amd64-011) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #20-Ubuntu SMP Mon Nov 6 10:04:08 UTC 2017 (Ubuntu 4.13.0-17.20-generic 4.13.8)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=tomoyo
> (...snipped...)
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.13.0-17-generic root=UUID=379f2d1d-c10e-4423-a3fd-a64863cda7b0 ro console=ttyS0,115200n8 console=tty security=tomoyo
> [    0.000000] LSM: command line set 'tomoyo' security module(s).
> (...snipped...)
> [    0.038327] Security Framework initialized
> [    0.040005] Yama: becoming mindful.
> [    0.040999] TOMOYO Linux initialized
> [    0.049585] AppArmor: AppArmor initialized
> [    0.077621] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.092942] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.095309] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.096408] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.100988] Disabled fast string operations
> [    0.102220] CPU: Physical Processor ID: 0
> [    0.103379] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.104004] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
> [    0.105951] mce: CPU supports 0 MCE banks
> [    0.108017] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> [    0.109524] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> [    0.111426] Freeing SMP alternatives memory: 36K
> [    0.117374] BUG: unable to handle kernel NULL pointer dereference at 0000000000000003
> [    0.119676] IP: __kmalloc+0x9b/0x200
> [    0.120000] PGD 0 
> [    0.120000] P4D 0 
> [    0.120000] 
> [    0.120000] Oops: 0000 [#1] SMP
> [    0.120000] Modules linked in:
> [    0.120000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.0-17-generic #20-Ubuntu
> [    0.120000] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/02/2015
> [    0.120000] task: ffffffff9a810480 task.stack: ffffffff9a800000
> [    0.120000] RIP: 0010:__kmalloc+0x9b/0x200
> [    0.120000] RSP: 0000:ffffffff9a803c58 EFLAGS: 00010206
> [    0.120000] RAX: 0000000000000000 RBX: 0000000000008000 RCX: 0000000000000037
> [    0.120000] RDX: 0000000000000036 RSI: 0000000000000000 RDI: 000000000001f3e0
> [    0.120000] RBP: ffffffff9a803c88 R08: ffff9a55b961f3e0 R09: ffff9a55b9007c00
> [    0.120000] R10: 0000000000000000 R11: 00000000000200c8 R12: 0000000000000003
> [    0.120000] R13: 00000000014080c0 R14: 0000000000000008 R15: ffff9a55b9007c00
> [    0.120000] FS:  0000000000000000(0000) GS:ffff9a55b9600000(0000) knlGS:0000000000000000
> [    0.120000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.120000] CR2: 0000000000000003 CR3: 00000000ba809000 CR4: 00000000000406f0
> [    0.120000] Call Trace:
> [    0.120000]  ? security_prepare_creds+0x73/0x90
> [    0.120000]  security_prepare_creds+0x73/0x90
> [    0.120000]  prepare_creds+0xbd/0xf0
> [    0.120000]  copy_creds+0x2f/0x120
> [    0.120000]  copy_process.part.31+0x2e5/0x1ae0
> [    0.120000]  ? enqueue_task_fair+0xaf/0x6b0
> [    0.120000]  ? kthread_create_on_cpu+0xa0/0xa0
> [    0.120000]  ? sched_clock+0x9/0x10
> [    0.120000]  _do_fork+0xdf/0x3f0
> [    0.120000]  ? update_rq_clock+0x30/0x80
> [    0.120000]  ? do_set_mempolicy+0x30/0x130
> [    0.120000]  kernel_thread+0x29/0x30
> [    0.120000]  rest_init+0x74/0xc0
> [    0.120000]  start_kernel+0x4c0/0x4e1
> [    0.120000]  ? early_idt_handler_array+0x120/0x120
> [    0.120000]  x86_64_start_reservations+0x24/0x26
> [    0.120000]  x86_64_start_kernel+0x13e/0x161
> [    0.120000]  secondary_startup_64+0x9f/0x9f
> [    0.120000] Code: 08 65 4c 03 05 f7 07 3e 66 49 83 78 10 00 4d 8b 20 0f 84 f7 00 00 00 4d 85 e4 0f 84 ee 00 00 00 49 63 41 20 49 8b 39 48 8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 49 63 
> [    0.120000] RIP: __kmalloc+0x9b/0x200 RSP: ffffffff9a803c58
> [    0.120000] CR2: 0000000000000003
> [    0.120000] ---[ end trace bee324c32248c3f4 ]---
> [    0.120000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.120000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> ----------
>
> cred->security for AppArmor will not be allocated (and therefore will trigger
> NULL pointer dereference) because security_add_blobs(&apparmor_blob_sizes) is
> not called when the administrator asked not to enable AppArmor. We need to
> reset apparmor_enabled to 0 in order to prevent apparmor_init() from calling
> set_init_ctx().
>
> ----------
> static inline struct aa_task_ctx *apparmor_cred(const struct cred *cred)
> {
> #ifdef CONFIG_SECURITY_STACKING
>         return cred->security + apparmor_blob_sizes.lbs_cred;
> #else
>         return cred->security;
> #endif
> }
>
> static int __init set_init_ctx(void)
> {
>         struct cred *cred = (struct cred *)current->real_cred;
>         struct aa_task_ctx *ctx;
>
>         lsm_early_cred(cred);
>         ctx = apparmor_cred(cred);
>
>         ctx->label = aa_get_label(ns_unconfined(root_ns));
>
>         return 0;
> }
> ----------
>
> Thus, please also apply below patch.

Thank you. I will incorporate this, too.

>
> ----------
> diff -ur linux-4.13.0-17.20.orig/security/apparmor/lsm.c linux-4.13.0-17.20/security/apparmor/lsm.c
> --- linux-4.13.0-17.20.orig/security/apparmor/lsm.c
> +++ linux-4.13.0-17.20/security/apparmor/lsm.c
> @@ -1562,6 +1562,8 @@
>  		    security_module_enable("apparmor",
>  				IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED)))
>  			security_add_blobs(&apparmor_blob_sizes);
> +		else
> +			apparmor_enabled = 0;
>  		finish = 1;
>  		return 0;
>  	}
> ----------
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
