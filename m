Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A872904;
	Sun,  1 Jun 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748772805; cv=none; b=p2tKAXLiAJFWDmG7kfX5FRQZXm8NSLSVoVdpKaKhJky3gVBZyk8kuAYE94FSe8P3vXAtRmgJqqvGs2onaojQwH6fmvrhIVQ6AxOYkKuhSHlsv3IORkwY1pR2d6a3diXpipakVveGBhxv/ttKS5Yj3qOV+paEo67M0xYt9tAIUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748772805; c=relaxed/simple;
	bh=WGIMC8or1ylOGe7eH03KRvnuyztmwdx3VRrhjE82Ycg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJc5VOqU51hEDz9za/B6q3lAHENoF5PD63xv5l4xq7qZd0WSYMAajZOAR6T0jIhYo9QZ+q5DGwD8By2BdRc1emIe5ji6VXuHndCwwlMkSxCArD7b9FGiGrOIS2QbBRou3H61WU0IPa8mdf6HdnHiH6ZVI8AJeoxV28lBF2bicuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=aI61GYzL; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="aI61GYzL"
Received: from [192.168.1.46] (88-123-72-235.subs.proxad.net [88.123.72.235])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 77B111087A91;
	Sun, 01 Jun 2025 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1748772791;
	bh=WGIMC8or1ylOGe7eH03KRvnuyztmwdx3VRrhjE82Ycg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aI61GYzLmjJuAstMK+4GGDc/0VB78lqQSJA488LUy+E1p/JfzjjeQWetPe20i64iM
	 iQhH9eqXS+0T4qlo6ZhVXyZFl3kzn6PK8ZhKZq3uX26ng5jmKawTv2b1qQirgGNhsQ
	 3mMnGvdRAbPPijHDuyA30drsnuiU7FlqyMG4i7/p4RRN2Co3RTgJuQdiL8cfy6jEbI
	 GAyOTsOki3y7h2EIvRzDPPCmv0U9uVI/JQ8AoP1xtB8JLZwudqUw5foC+nOSMgE8md
	 ECCHtqpXPO/bZ6p9VA0/bJcr65aC4/D41Dm4DJ2RYLFf40wQW1p3FNbelzB1dOFLGa
	 W/JzJz/0G6e/g==
Message-ID: <c2c99401-530e-4f29-aaf5-29c04f4f2d33@nightmared.fr>
Date: Sun, 1 Jun 2025 12:13:10 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] security: add Lilium - Linux Integrity Lock-In User
 Module
To: =?UTF-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?=
 <milesonerd@outlook.com>, "serge@hallyn.com" <serge@hallyn.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SCYP152MB62611CB2B296124E47CB1C7CB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <SCYP152MB62611CB2B296124E47CB1C7CB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/25 03:04, ℰ𝓃𝓏ℴ ℱ𝓊𝓀ℯ wrote:
> From f34a53c7e615fb6e60b21bdcb5b1979edaf52088 Mon Sep 17 00:00:00 2001
> From: Enzo Fuke <milesonerd@outlook.com>
> Date: Sun, 1 Jun 2025 00:26:43 +0000
> Subject: [PATCH] Lilium LSM
> 
> ---
>  security/lilium/Kconfig         |  82 ++++++
>  security/lilium/Makefile        |  10 +
>  security/lilium/lilium_config.h |  24 ++
>  security/lilium/lilium_lsm.c    | 468 ++++++++++++++++++++++++++++++++
>  security/lilium/lilium_rust.rs  |  83 ++++++
>  5 files changed, 667 insertions(+)
>  create mode 100644 security/lilium/Kconfig
>  create mode 100644 security/lilium/Makefile
>  create mode 100644 security/lilium/lilium_config.h
>  create mode 100644 security/lilium/lilium_lsm.c
>  create mode 100644 security/lilium/lilium_rust.rs
> 
> diff --git a/security/lilium/Kconfig b/security/lilium/Kconfig
> new file mode 100644
> index 0000000..3072964
> --- /dev/null
> +++ b/security/lilium/Kconfig
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Lilium (Linux Integrity Lock-In User Module)
> +# Copyright (C) 2025 Enzo Fuke
> +#
> +config SECURITY_LILIUM
> +   bool "Lilium (Linux Integrity Lock-In User Module) Support"
> +   depends on SECURITY
> +   help
> +     This enables the Lilium Linux Security Module, which provides
> +     modular security mechanisms for restricting various system
> +     operations including ptrace, mmap/mprotect with PROT_EXEC,
> +     kexec_load, clone/unshare, module management, and file operations.
> +    
> +     All security mechanisms are disabled by default and can be
> +     enabled individually through sysctl.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_PTRACE
> +   bool "Lilium ptrace restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables ptrace access restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.

Perhps you could be a bit more explicit about what each option does
(= what restrictions does this add to ptrace)?

The same goes for the following lines.

> +
> +config SECURITY_LILIUM_MPROTECT
> +   bool "Lilium mmap/mprotect restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables mmap/mprotect with PROT_EXEC restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_KEXEC
> +   bool "Lilium kexec_load restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables kexec_load restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_CLONE
> +   bool "Lilium clone/unshare restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables clone and unshare restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_MODULE
> +   bool "Lilium module management restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables module loading/unloading restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_OPEN
> +   bool "Lilium file open restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables open/openat restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_LILIUM_IOCTL
> +   bool "Lilium ioctl restrictions"
> +   depends on SECURITY_LILIUM
> +   default n
> +   help
> +     This enables ioctl restrictions in Lilium.
> +    
> +     If you are unsure how to answer this question, answer N.
> +
> diff --git a/security/lilium/Makefile b/security/lilium/Makefile
> new file mode 100644
> index 0000000..17aeb04
> --- /dev/null
> +++ b/security/lilium/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Lilium (Linux Integrity Lock-In User Module)
> +# Copyright (C) 2025 Enzo Fuke
> +#
> +obj-$(CONFIG_SECURITY_LILIUM) += lilium.o
> +
> +lilium-y := lilium_lsm.o
> +lilium-$(CONFIG_RUST) += lilium_rust.o
> +
> diff --git a/security/lilium/lilium_config.h b/security/lilium/lilium_config.h
> new file mode 100644
> index 0000000..1633c7e
> --- /dev/null
> +++ b/security/lilium/lilium_config.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +#ifndef _SECURITY_LILIUM_CONFIG_H
> +#define _SECURITY_LILIUM_CONFIG_H
> +
> +/* Default disabled state for all Lilium features */
> +#define LILIUM_FEATURE_DISABLED 0
> +#define LILIUM_FEATURE_ENABLED  1
> +
> +/* Feature control flags - all disabled by default */
> +#define LILIUM_DEFAULT_PTRACE   LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_MPROTECT LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_KEXEC    LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_CLONE    LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_MODULE   LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_OPEN     LILIUM_FEATURE_DISABLED
> +#define LILIUM_DEFAULT_IOCTL    LILIUM_FEATURE_DISABLED
> +
> +#endif /* _SECURITY_LILIUM_CONFIG_H */
> +
> diff --git a/security/lilium/lilium_lsm.c b/security/lilium/lilium_lsm.c
> new file mode 100644
> index 0000000..82bac41
> --- /dev/null
> +++ b/security/lilium/lilium_lsm.c
> @@ -0,0 +1,468 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +#include <linux/lsm_hooks.h>
> +#include <linux/ptrace.h>
> +#include <linux/prctl.h>
> +#include <linux/ratelimit.h>
> +#include <linux/workqueue.h>
> +#include <linux/string_helpers.h>
> +#include <linux/task_work.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/mman.h>
> +#include <linux/kexec.h>
> +#include <linux/slab.h>
> +#include <linux/nsproxy.h>
> +#include <linux/security.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <uapi/linux/lsm.h>
> +
> +#include "lilium_config.h"
> +
> +/* Feature control variables - all disabled by default */
> +static int lilium_ptrace_enabled = LILIUM_DEFAULT_PTRACE;
> +static int lilium_mprotect_enabled = LILIUM_DEFAULT_MPROTECT;
> +static int lilium_kexec_enabled = LILIUM_DEFAULT_KEXEC;
> +static int lilium_clone_enabled = LILIUM_DEFAULT_CLONE;
> +static int lilium_module_enabled = LILIUM_DEFAULT_MODULE;
> +static int lilium_open_enabled = LILIUM_DEFAULT_OPEN;
> +static int lilium_ioctl_enabled = LILIUM_DEFAULT_IOCTL;
> +
> +/* Kobject for Lilium sysfs interface */
> +static struct kobject *lilium_kobj;
> +
> +/* Sysfs attribute show/store functions */
> +static ssize_t ptrace_enabled_show(struct kobject *kobj,
> +                 struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_ptrace_enabled);
> +}
> +
> +static ssize_t ptrace_enabled_store(struct kobject *kobj,
> +                  struct kobj_attribute *attr,
> +                  const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_ptrace_enabled = val;
> +   return count;
> +}

For this and the next ones you probably could get by with a table of
sysctls instead of defining all the methods yourself (see for example
https://github.com/torvalds/linux/blob/7d4e49a77d9930c69751b9192448fda6ff9100f1/kernel/panic.c#L89-L97).

In addition, for this to be more useful as a security measure, you
could allow locking these values, so that once a system is hardened,
users cannot disable the hardening options without rebooting.

Finally, for ptrace specifically, isn't the Yama LSM already doing that,
and more? See https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
for the options it provides, but I believe your suggested ptrace restrictions
to be a duplicate.

> +
> +static ssize_t mprotect_enabled_show(struct kobject *kobj,
> +                   struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_mprotect_enabled);
> +}
> +
> +static ssize_t mprotect_enabled_store(struct kobject *kobj,
> +                    struct kobj_attribute *attr,
> +                    const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_mprotect_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t kexec_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_kexec_enabled);
> +}
> +
> +static ssize_t kexec_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_kexec_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t clone_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_clone_enabled);
> +}
> +
> +static ssize_t clone_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_clone_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t module_enabled_show(struct kobject *kobj,
> +                 struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_module_enabled);
> +}
> +
> +static ssize_t module_enabled_store(struct kobject *kobj,
> +                  struct kobj_attribute *attr,
> +                  const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_module_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t open_enabled_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_open_enabled);
> +}
> +
> +static ssize_t open_enabled_store(struct kobject *kobj,
> +                struct kobj_attribute *attr,
> +                const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_open_enabled = val;
> +   return count;
> +}
> +
> +static ssize_t ioctl_enabled_show(struct kobject *kobj,
> +                struct kobj_attribute *attr, char *buf)
> +{
> +   return sysfs_emit(buf, "%d\n", lilium_ioctl_enabled);
> +}
> +
> +static ssize_t ioctl_enabled_store(struct kobject *kobj,
> +                 struct kobj_attribute *attr,
> +                 const char *buf, size_t count)
> +{
> +   int ret, val;
> +
> +   ret = kstrtoint(buf, 10, &val);
> +   if (ret < 0)
> +       return ret;
> +
> +   if (val != 0 && val != 1)
> +       return -EINVAL;
> +
> +   lilium_ioctl_enabled = val;
> +   return count;
> +}
> +
> +/* Define sysfs attributes */
> +static struct kobj_attribute ptrace_attr =
> +   __ATTR(ptrace_enabled, 0644, ptrace_enabled_show, ptrace_enabled_store);
> +static struct kobj_attribute mprotect_attr =
> +   __ATTR(mprotect_enabled, 0644, mprotect_enabled_show, mprotect_enabled_store);
> +static struct kobj_attribute kexec_attr =
> +   __ATTR(kexec_enabled, 0644, kexec_enabled_show, kexec_enabled_store);
> +static struct kobj_attribute clone_attr =
> +   __ATTR(clone_enabled, 0644, clone_enabled_show, clone_enabled_store);
> +static struct kobj_attribute module_attr =
> +   __ATTR(module_enabled, 0644, module_enabled_show, module_enabled_store);
> +static struct kobj_attribute open_attr =
> +   __ATTR(open_enabled, 0644, open_enabled_show, open_enabled_store);
> +static struct kobj_attribute ioctl_attr =
> +   __ATTR(ioctl_enabled, 0644, ioctl_enabled_show, ioctl_enabled_store);
> +
> +/* Attribute group */
> +static struct attribute *lilium_attrs[] = {
> +   &ptrace_attr.attr,
> +   &mprotect_attr.attr,
> +   &kexec_attr.attr,
> +   &clone_attr.attr,
> +   &module_attr.attr,
> +   &open_attr.attr,
> +   &ioctl_attr.attr,
> +   NULL,
> +};
> +
> +static struct attribute_group lilium_attr_group = {
> +   .attrs = lilium_attrs,
> +};
> +
> +/* LSM Hook Implementations */
> +
> +static int lilium_ptrace_access_check(struct task_struct *child,
> +                    unsigned int mode)
> +{
> +   if (!lilium_ptrace_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for ptrace restrictions */
> +   if (mode & PTRACE_MODE_ATTACH) {
> +       /* Allow if caller has CAP_SYS_PTRACE */
> +       if (capable(CAP_SYS_PTRACE))
> +           return 0;
> +      
> +       /* Deny ptrace access */
> +       return -EPERM;
> +   }
> +
> +   return 0;
> +}

As discussed above, this is already covered by Yama.

There is also the deny_ptrace SELinux boolean that perhaps
does the same thing (I'm unsure about that one).

> +
> +static int lilium_file_mprotect(struct vm_area_struct *vma,
> +                  unsigned long reqprot,
> +                  unsigned long prot)
> +{
> +   if (!lilium_mprotect_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mprotect restrictions */
> +   if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> +       /* Allow if caller has CAP_SYS_ADMIN */
> +       if (capable(CAP_SYS_ADMIN))
> +           return 0;
> +      
> +       /* Deny making non-executable memory executable */
> +       return -EPERM;
> +   }
> +
> +   return 0;
> +}

Isn't this covered by the SELinux boolean deny_execmem?
It won't strictly prevent users from setting a mapping as
executable, but it will prevent users from creating W^X regions.

> +
> +static int lilium_mmap_file(struct file *file, unsigned long reqprot,
> +              unsigned long prot, unsigned long flags)
> +{
> +   if (!lilium_mprotect_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mmap restrictions */
> +   if ((prot & PROT_EXEC) && (flags & MAP_ANONYMOUS)) {
> +       /* Allow if caller has CAP_SYS_ADMIN */
> +       if (capable(CAP_SYS_ADMIN))
> +           return 0;
> +      
> +       /* Deny executable anonymous mappings */
> +       return -EPERM;
> +   }
> +
> +   return 0;
> +}

Won't this break some programs (this is an honest question,
I don't know the answer)?
I fear some software, like JIT or interpreters may create anonymous
memory mappings.
If so, this feature can still be useful in some contexts, but a
mention of the eventual breakage should be added in the Kconfig description
of the option.

> +
> +static int lilium_task_create(struct task_struct *task,
> +                struct task_struct *child)
> +{
> +   if (!lilium_clone_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for clone restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific clone flags or namespace creation
> +    */
> +  
> +   return 0;
> +}

I sugest removing this for now, and only re-adding it at a later stage once it
does something.

> +
> +static int lilium_task_fix_setuid(struct task_struct *task,
> +                struct cred *new,
> +                const struct cred *old,
> +                int flags)
> +{
> +   if (!lilium_clone_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for unshare restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific unshare flags or namespace creation
> +    */
> +  
> +   return 0;
> +}

Ditto

> +
> +static int lilium_kernel_module_request(char *kmod_name)
> +{
> +   if (!lilium_module_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for module loading restrictions */
> +   /* Allow if caller has CAP_SYS_MODULE */
> +   if (capable(CAP_SYS_MODULE))
> +       return 0;
> +  
> +   /* Deny module loading */
> +   return -EPERM;
> +}

Isn't this the default behaviour?

> +
> +static int lilium_kernel_module_from_file(struct file *file)
> +{
> +   if (!lilium_module_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for module loading restrictions */
> +   /* Allow if caller has CAP_SYS_MODULE */
> +   if (capable(CAP_SYS_MODULE))
> +       return 0;
> +  
> +   /* Deny module loading */
> +   return -EPERM;
> +}
> +
> +static int lilium_file_open(struct file *file)
> +{
> +   if (!lilium_open_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for file open restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific file paths or attributes
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_file_ioctl(struct file *file, unsigned int cmd,
> +               unsigned long arg)
> +{
> +   if (!lilium_ioctl_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for ioctl restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific ioctl commands
> +    */
> +  
> +   return 0;
> +}
> +
> +static int lilium_sb_mount(const char *dev_name, const struct path *path,
> +             const char *type, unsigned long flags, void *data)
> +{
> +   if (!lilium_open_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for mount restrictions */
> +   /* This is a placeholder - actual implementation would check
> +    * specific mount flags or filesystem types
> +    */
> +  
> +   return 0;
> +}

Remove all functions that do nothing please.

> +
> +static int lilium_kexec_kernel_load(struct kimage *image)
> +{
> +   if (!lilium_kexec_enabled)
> +       return 0;
> +
> +   /* Implement contextual logic for kexec_load restrictions */
> +   /* Allow if caller has CAP_SYS_BOOT */
> +   if (capable(CAP_SYS_BOOT))
> +       return 0;
> +  
> +   /* Deny kexec_load */
> +   return -EPERM;
> +}
> +
> +/* LSM Hook Definitions */
> +static struct security_hook_list lilium_hooks[] = {
> +   LSM_HOOK_INIT(ptrace_access_check, lilium_ptrace_access_check),
> +   LSM_HOOK_INIT(file_mprotect, lilium_file_mprotect),
> +   LSM_HOOK_INIT(mmap_file, lilium_mmap_file),
> +   LSM_HOOK_INIT(task_create, lilium_task_create),
> +   LSM_HOOK_INIT(task_fix_setuid, lilium_task_fix_setuid),
> +   LSM_HOOK_INIT(kernel_module_request, lilium_kernel_module_request),
> +   LSM_HOOK_INIT(kernel_module_from_file, lilium_kernel_module_from_file),
> +   LSM_HOOK_INIT(file_open, lilium_file_open),
> +   LSM_HOOK_INIT(file_ioctl, lilium_file_ioctl),
> +   LSM_HOOK_INIT(sb_mount, lilium_sb_mount),
> +   LSM_HOOK_INIT(kexec_kernel_load, lilium_kexec_kernel_load),
> +};
> +
> +static const struct lsm_id lilium_lsmid = {
> +   .name = "lilium",
> +   .id = LSM_ID_MAJOR_MAX,
> +};
> +
> +static void lilium_exit(void)
> +{
> +   if (lilium_kobj) {
> +       sysfs_remove_group(lilium_kobj, &lilium_attr_group);
> +       kobject_put(lilium_kobj);
> +   }
> +}
> +
> +static int __init lilium_init(void)
> +{
> +   int ret;
> +
> +   /* Create sysfs interface */
> +   lilium_kobj = kobject_create_and_add("lilium", kernel_kobj);
> +   if (!lilium_kobj)
> +       return -ENOMEM;
> +
> +   ret = sysfs_create_group(lilium_kobj, &lilium_attr_group);
> +   if (ret) {
> +       kobject_put(lilium_kobj);
> +       return ret;
> +   }
> +
> +   /* Register LSM hooks */
> +   security_add_hooks(lilium_hooks, ARRAY_SIZE(lilium_hooks), &lilium_lsmid);
> +
> +   pr_info("Lilium: Linux Integrity Lock-In User Module initialized\n");
> +   return 0;
> +}
> +
> +security_initcall(lilium_init);
> +module_exit(lilium_exit);
> +
> +MODULE_DESCRIPTION("Lilium (Linux Integrity Lock-In User Module)");
> +MODULE_AUTHOR("Enzo Fuke");
> +MODULE_LICENSE("GPL v2");
> +
> diff --git a/security/lilium/lilium_rust.rs b/security/lilium/lilium_rust.rs
> new file mode 100644
> index 0000000..7901d9d
> --- /dev/null
> +++ b/security/lilium/lilium_rust.rs
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Lilium (Linux Integrity Lock-In User Module)
> + * Copyright (C) 2025 Enzo Fuke
> + */
> +
> +
> +use kernel::prelude::*;
> +use kernel::security;
> +use kernel::file::File;
> +use kernel::task::Task;
> +use kernel::cred::Credential;
> +
> +const LILIUM_FEATURE_DISABLED: i32 = 0;
> +const LILIUM_FEATURE_ENABLED: i32 = 1;
> +
> +extern "C" {
> +    static lilium_ptrace_enabled: i32;
> +    static lilium_mprotect_enabled: i32;
> +    static lilium_kexec_enabled: i32;
> +    static lilium_clone_enabled: i32;
> +    static lilium_module_enabled: i32;
> +    static lilium_open_enabled: i32;
> +    static lilium_ioctl_enabled: i32;
> +}
> +
> +pub struct LiliumOps;
> +
> +impl security::SecurityHooks for LiliumOps {
> +    fn ptrace_access_check(
> +        &self,
> +        child: &Task,
> +        mode: u32,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_ptrace_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +        if mode & security::PTRACE_MODE_ATTACH != 0 {
> +            if kernel::current_cred().has_capability(kernel::CAP_SYS_PTRACE) {
> +                return Ok(security::SecurityHookResult::Default);
> +            }
> +            
> +            return Ok(security::SecurityHookResult::Reject);
> +        }
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +
> +    fn file_mprotect(
> +        &self,
> +        vma: &kernel::mm::VirtualMemoryArea,
> +        reqprot: u64,
> +        prot: u64,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_mprotect_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +        if (prot & kernel::mm::PROT_EXEC) != 0 && (vma.flags() & kernel::mm::VM_EXEC) == 0 {
> +            if kernel::current_cred().has_capability(kernel::CAP_SYS_ADMIN) {
> +                return Ok(security::SecurityHookResult::Default);
> +            }
> +            
> +            return Ok(security::SecurityHookResult::Reject);
> +        }
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +
> +    fn file_open(
> +        &self,
> +        file: &File,
> +    ) -> Result<security::SecurityHookResult> {
> +        if unsafe { lilium_open_enabled } == LILIUM_FEATURE_DISABLED {
> +            return Ok(security::SecurityHookResult::Default);
> +        }
> +
> +
> +        Ok(security::SecurityHookResult::Default)
> +    }
> +}
> +
> --
> 2.49.0

Did you reimplement some of the methods above in Rust?
If so, you are not enabling them anywhere (that I can see), so
this file is currently dead code.

Why did you include it?

I may be going out on a limb here, but I feel like this was
LLM-generated or a LLM "helped" in the writing of this patch.
If so, please take the time to properly review, amend and fix
any code that come from it before submitting (I won't get into
the eventual copyright issues, I'm not a lawyer). Otherwise,
that's disrespectful to people reviewing your code.

Thanks
