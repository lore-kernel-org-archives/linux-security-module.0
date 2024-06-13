Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDD149E0A;
	Thu, 13 Jun 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306544; cv=none; b=Gszfz3pJvZaqvjilrNQQ37RABK1j59muBcxBLWpW6q+oozcoWTXqIhp5Hp7CHL+HN7lYRUbAoDYSwEntQDyX+4AY79sV/Ym/nDmn4kTvRVGqPXVJ1tfHr/gUydpzfn05dcOH2PJI2F/n6kV/dMZ9g+qz8273sRTQk5IQXmIgupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306544; c=relaxed/simple;
	bh=m99D/EYeY9r1H12JBRzT3mckwwjIV8/NOX61Q0pTF9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DgFhTqjjBwyoD/syCpcOQTAVMJGB2HkSvfvbZuwKsqijveGYMRaUyXhEeANJp6h/BAQwDPvQdXqE4cz+haDuuixc43i0ckcj8evZbbz1gQe5u/zix5T9JrZ2pSeGey9WFERW44ZM2n5YBBYQ3RmYbkaocsTl+F54fZfFU4oMl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm29ljGR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm29ljGR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so9084335e9.1;
        Thu, 13 Jun 2024 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718306541; x=1718911341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imGPK4z3NEfZjdDaqJiJJhSbCgQiRrtwTd3vB04zoVI=;
        b=Rm29ljGR4yrgriaQNWtggaMRdlX5ElvYS4veCg5aw5D8Ik18XuawdNDKNIct4jh2m3
         dTN5rqgmZwY61C27h2QqfZQpvZAKFGh+t3+FkqIECQm6hSswvz51tWrDP+vIbSNowswu
         DNONSAhn7qB/pUGEOQ3j0c9xS0fval4Yz/5vOhiAnujwplQFQs+3rcT2DdSS0RAWPRFz
         Pj0k5mBSsoxCLN/8kpU3FksnmxSPtick8n4Bd3GA5wlEWGRb1W0IjuWJiUcDlADEZzB+
         eDN/K361pS74xRKf/75lhrXnZYhT5ibfV0a98Ja4KUgR3GVTLub89/NihqTX0DlY8RaR
         eaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306541; x=1718911341;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imGPK4z3NEfZjdDaqJiJJhSbCgQiRrtwTd3vB04zoVI=;
        b=lV24802W19IBSb/DwgdXsVX0ok4BX9vf23P/KSofJjHez8xaxdJzzX+060OdpyTln0
         tKRl+U2qyQM1tkkWSzfDkluZkk7RrQx/OHzGG1PB+DhTXXK3IUW11LZB/kIQ1f683k1m
         ZhiBbnt1PRg0S4wGMSLSgZovVAUN/hps56YOItAQDk8YF7cEeQ9nSjLDFAlwbx137We8
         x7LwZ/f6UsVSuV4YpCD2drYBblL/ZSu3UyAi9RZPDY6lxR/RO+9G4cDgS+TIU80lkJaQ
         hWF8RPZi/KhG4cJSxYrZRa7y08Sv7RHN7cgi1c92BYhEDR0oICZswGkQc4dui87pL4hl
         16Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXyXuyvh/ByvldoGkDkptrCIoOlWF14qKr8yJxioagOAnMvZNGgl5/HOkOk6FT6hOEZCgSRi5hiuwEAKFOQUETJb+hq4SM+LKJH7LsKAmppNupnfuz4fsGoni9U9U9K9gd6U/P/hcUxnqLg68Vndg6Na16m2mqvo2g4
X-Gm-Message-State: AOJu0YzE7DgwRfXB+Tyb1z0igmeShWgfEmn1sfYHB/WdceBiPf/XExOI
	msM5/cF7Hjg9sA+FzI6sENzJb++sUOj3sYiWLwti2az01yT91Bw=
X-Google-Smtp-Source: AGHT+IFH3yjMnIlYZVz60Gd2uWIgUoqeFphBchYabfiO5ee8/amBOEzYRoX9UrhLZ9icxXjC3KMjCw==
X-Received: by 2002:a05:600c:19cf:b0:421:7ab8:59c with SMTP id 5b1f17b1804b1-42304825ce7mr8523605e9.10.1718306541180;
        Thu, 13 Jun 2024 12:22:21 -0700 (PDT)
Received: from p183 ([46.53.250.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm34575855e9.26.2024.06.13.12.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:22:20 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:22:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] linux++: delete some forward declarations
Message-ID: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

g++ doesn't like forward enum declarations:

	error: use of enum ‘E’ without previous declaration
	   64 | enum E;

Delete those which aren't used.

Delete some unused/unnecessary forward struct declarations for a change.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/ramfs/inode.c         |    1 -
 include/linux/console.h  |    2 --
 include/linux/device.h   |    3 ---
 include/linux/ftrace.h   |    4 ----
 include/linux/security.h |    6 ------
 include/linux/signal.h   |    2 --
 include/linux/syscalls.h |    7 -------
 include/linux/sysfs.h    |    2 --
 mm/internal.h            |    4 ----
 mm/shmem.c               |    1 -
 10 files changed, 32 deletions(-)

--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -51,7 +51,6 @@ struct ramfs_fs_info {
 
 #define RAMFS_DEFAULT_MODE	0755
 
-static const struct super_operations ramfs_ops;
 static const struct inode_operations ramfs_dir_inode_operations;
 
 struct inode *ramfs_get_inode(struct super_block *sb,
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -21,10 +21,8 @@
 #include <linux/vesa.h>
 
 struct vc_data;
-struct console_font_op;
 struct console_font;
 struct module;
-struct tty_struct;
 struct notifier_block;
 
 enum con_scroll {
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -36,10 +36,7 @@
 struct device;
 struct device_private;
 struct device_driver;
-struct driver_private;
 struct module;
-struct class;
-struct subsys_private;
 struct device_node;
 struct fwnode_handle;
 struct iommu_group;
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -531,8 +531,6 @@ extern const void *ftrace_expected;
 
 void ftrace_bug(int err, struct dyn_ftrace *rec);
 
-struct seq_file;
-
 extern int ftrace_text_reserved(const void *start, const void *end);
 
 struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
@@ -1147,8 +1145,6 @@ static inline void unpause_graph_tracing(void) { }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #ifdef CONFIG_TRACING
-enum ftrace_dump_mode;
-
 #define MAX_TRACER_SIZE		100
 extern char ftrace_dump_on_oops[];
 extern int ftrace_dump_on_oops_enabled(void);
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -41,7 +41,6 @@ struct rlimit;
 struct kernel_siginfo;
 struct sembuf;
 struct kern_ipc_perm;
-struct audit_context;
 struct super_block;
 struct inode;
 struct dentry;
@@ -59,8 +58,6 @@ struct xfrm_sec_ctx;
 struct mm_struct;
 struct fs_context;
 struct fs_parameter;
-enum fs_value_type;
-struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
@@ -183,8 +180,6 @@ struct sock;
 struct sockaddr;
 struct socket;
 struct flowi_common;
-struct dst_entry;
-struct xfrm_selector;
 struct xfrm_policy;
 struct xfrm_state;
 struct xfrm_user_sec_ctx;
@@ -219,7 +214,6 @@ extern unsigned long dac_mmap_min_addr;
 #define LSM_PRLIMIT_WRITE 2
 
 /* forward declares to avoid warnings */
-struct sched_param;
 struct request_sock;
 
 /* bprm->unsafe reasons */
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -274,8 +274,6 @@ static inline int valid_signal(unsigned long sig)
 	return sig <= _NSIG ? 1 : 0;
 }
 
-struct timespec;
-struct pt_regs;
 enum pid_type;
 
 extern int next_signal(struct sigpending *pending, sigset_t *mask);
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -11,8 +11,6 @@
 
 struct __aio_sigset;
 struct epoll_event;
-struct iattr;
-struct inode;
 struct iocb;
 struct io_event;
 struct iovec;
@@ -20,14 +18,12 @@ struct __kernel_old_itimerval;
 struct kexec_segment;
 struct linux_dirent;
 struct linux_dirent64;
-struct list_head;
 struct mmap_arg_struct;
 struct msgbuf;
 struct user_msghdr;
 struct mmsghdr;
 struct msqid_ds;
 struct new_utsname;
-struct nfsctl_arg;
 struct __old_kernel_stat;
 struct oldold_utsname;
 struct old_utsname;
@@ -38,7 +34,6 @@ struct rusage;
 struct sched_param;
 struct sched_attr;
 struct sel_arg_struct;
-struct semaphore;
 struct sembuf;
 struct shmid_ds;
 struct sockaddr;
@@ -48,14 +43,12 @@ struct statfs;
 struct statfs64;
 struct statx;
 struct sysinfo;
-struct timespec;
 struct __kernel_old_timeval;
 struct __kernel_timex;
 struct timezone;
 struct tms;
 struct utimbuf;
 struct mq_attr;
-struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
 struct futex_waitv;
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -23,9 +23,7 @@
 #include <linux/atomic.h>
 
 struct kobject;
-struct module;
 struct bin_attribute;
-enum kobj_ns_type;
 
 struct attribute {
 	const char		*name;
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1095,10 +1095,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
-enum ttu_flags;
-struct tlbflush_unmap_batch;
-
-
 /*
  * only for MM internal work items which do not depend on
  * any allocations or locks which might depend on allocations
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -261,7 +261,6 @@ static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
-static struct file_system_type shmem_fs_type;
 
 bool shmem_mapping(struct address_space *mapping)
 {
