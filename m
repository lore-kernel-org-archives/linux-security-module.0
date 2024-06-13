Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB782F34;
	Thu, 13 Jun 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307245; cv=none; b=q6tP0ychUBmKHzCipco5HjOXlTNdO/Oln6VCOtWe+BjmkV+6rjprQnZiidbrWHm8lX4f6/m8zOLjkoWQ+D5BAGY968eDiytfX3IR7ldSFFMSnW276DlmFpYvl5je0cGPPNErgZuDeKdls90YuGsMF1U0ssFX3g9K0oaknmgTFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307245; c=relaxed/simple;
	bh=wQgy/X/ZKA/Ff/1MORDRSuKE/dgil05TxOFG6mU+pjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6o/xWIR6Fbo+zDXC0d+KzeHTBnwxG4eI0jCtWhz2ofDWgZaj6ApsKbm7EbDWE+auiNGSqwgpRx31Cnu0euYl+krb3s8FV9nA71K1N+3f9yJ82ADbdotBgFOAklESIGeO6bCJsEje8OOcPRq1iY/K1+nAAZlMuIdbhUz02Dpky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E94C2BBFC;
	Thu, 13 Jun 2024 19:34:03 +0000 (UTC)
Date: Thu, 13 Jun 2024 15:34:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-ID: <20240613153402.3b067d4b@rorschach.local.home>
In-Reply-To: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 22:22:18 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> g++ doesn't like forward enum declarations:
>=20
> 	error: use of enum =E2=80=98E=E2=80=99 without previous declaration
> 	   64 | enum E;

But we don't care about g++. Do we?

I would make that a separate patch.

>=20
> Delete those which aren't used.
>=20
> Delete some unused/unnecessary forward struct declarations for a change.

This is a clean up, but should have a better change log. Just something
simple like:

  Delete unnecessary forward struct declarations.

Thanks,

-- Steve


>=20
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>=20
>  fs/ramfs/inode.c         |    1 -
>  include/linux/console.h  |    2 --
>  include/linux/device.h   |    3 ---
>  include/linux/ftrace.h   |    4 ----
>  include/linux/security.h |    6 ------
>  include/linux/signal.h   |    2 --
>  include/linux/syscalls.h |    7 -------
>  include/linux/sysfs.h    |    2 --
>  mm/internal.h            |    4 ----
>  mm/shmem.c               |    1 -
>  10 files changed, 32 deletions(-)
>=20
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -51,7 +51,6 @@ struct ramfs_fs_info {
> =20
>  #define RAMFS_DEFAULT_MODE	0755
> =20
> -static const struct super_operations ramfs_ops;
>  static const struct inode_operations ramfs_dir_inode_operations;
> =20
>  struct inode *ramfs_get_inode(struct super_block *sb,
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -21,10 +21,8 @@
>  #include <linux/vesa.h>
> =20
>  struct vc_data;
> -struct console_font_op;
>  struct console_font;
>  struct module;
> -struct tty_struct;
>  struct notifier_block;
> =20
>  enum con_scroll {
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -36,10 +36,7 @@
>  struct device;
>  struct device_private;
>  struct device_driver;
> -struct driver_private;
>  struct module;
> -struct class;
> -struct subsys_private;
>  struct device_node;
>  struct fwnode_handle;
>  struct iommu_group;
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -531,8 +531,6 @@ extern const void *ftrace_expected;
> =20
>  void ftrace_bug(int err, struct dyn_ftrace *rec);
> =20
> -struct seq_file;
> -
>  extern int ftrace_text_reserved(const void *start, const void *end);
> =20
>  struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
> @@ -1147,8 +1145,6 @@ static inline void unpause_graph_tracing(void) { }
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> =20
>  #ifdef CONFIG_TRACING
> -enum ftrace_dump_mode;
> -
>  #define MAX_TRACER_SIZE		100
>  extern char ftrace_dump_on_oops[];
>  extern int ftrace_dump_on_oops_enabled(void);
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -41,7 +41,6 @@ struct rlimit;
>  struct kernel_siginfo;
>  struct sembuf;
>  struct kern_ipc_perm;
> -struct audit_context;
>  struct super_block;
>  struct inode;
>  struct dentry;
> @@ -59,8 +58,6 @@ struct xfrm_sec_ctx;
>  struct mm_struct;
>  struct fs_context;
>  struct fs_parameter;
> -enum fs_value_type;
> -struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> =20
> @@ -183,8 +180,6 @@ struct sock;
>  struct sockaddr;
>  struct socket;
>  struct flowi_common;
> -struct dst_entry;
> -struct xfrm_selector;
>  struct xfrm_policy;
>  struct xfrm_state;
>  struct xfrm_user_sec_ctx;
> @@ -219,7 +214,6 @@ extern unsigned long dac_mmap_min_addr;
>  #define LSM_PRLIMIT_WRITE 2
> =20
>  /* forward declares to avoid warnings */
> -struct sched_param;
>  struct request_sock;
> =20
>  /* bprm->unsafe reasons */
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -274,8 +274,6 @@ static inline int valid_signal(unsigned long sig)
>  	return sig <=3D _NSIG ? 1 : 0;
>  }
> =20
> -struct timespec;
> -struct pt_regs;
>  enum pid_type;
> =20
>  extern int next_signal(struct sigpending *pending, sigset_t *mask);
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -11,8 +11,6 @@
> =20
>  struct __aio_sigset;
>  struct epoll_event;
> -struct iattr;
> -struct inode;
>  struct iocb;
>  struct io_event;
>  struct iovec;
> @@ -20,14 +18,12 @@ struct __kernel_old_itimerval;
>  struct kexec_segment;
>  struct linux_dirent;
>  struct linux_dirent64;
> -struct list_head;
>  struct mmap_arg_struct;
>  struct msgbuf;
>  struct user_msghdr;
>  struct mmsghdr;
>  struct msqid_ds;
>  struct new_utsname;
> -struct nfsctl_arg;
>  struct __old_kernel_stat;
>  struct oldold_utsname;
>  struct old_utsname;
> @@ -38,7 +34,6 @@ struct rusage;
>  struct sched_param;
>  struct sched_attr;
>  struct sel_arg_struct;
> -struct semaphore;
>  struct sembuf;
>  struct shmid_ds;
>  struct sockaddr;
> @@ -48,14 +43,12 @@ struct statfs;
>  struct statfs64;
>  struct statx;
>  struct sysinfo;
> -struct timespec;
>  struct __kernel_old_timeval;
>  struct __kernel_timex;
>  struct timezone;
>  struct tms;
>  struct utimbuf;
>  struct mq_attr;
> -struct compat_stat;
>  struct old_timeval32;
>  struct robust_list_head;
>  struct futex_waitv;
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -23,9 +23,7 @@
>  #include <linux/atomic.h>
> =20
>  struct kobject;
> -struct module;
>  struct bin_attribute;
> -enum kobj_ns_type;
> =20
>  struct attribute {
>  	const char		*name;
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1095,10 +1095,6 @@ unsigned int reclaim_clean_pages_from_list(struct =
zone *zone,
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOM=
IC|ALLOC_OOM)
> =20
> -enum ttu_flags;
> -struct tlbflush_unmap_batch;
> -
> -
>  /*
>   * only for MM internal work items which do not depend on
>   * any allocations or locks which might depend on allocations
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -261,7 +261,6 @@ static const struct inode_operations shmem_dir_inode_=
operations;
>  static const struct inode_operations shmem_special_inode_operations;
>  static const struct vm_operations_struct shmem_vm_ops;
>  static const struct vm_operations_struct shmem_anon_vm_ops;
> -static struct file_system_type shmem_fs_type;
> =20
>  bool shmem_mapping(struct address_space *mapping)
>  {

