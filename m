Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7174C433B4
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Apr 2021 20:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B050E610E5
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Apr 2021 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhDJUXP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 10 Apr 2021 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJUXO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 10 Apr 2021 16:23:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295FBC06138A;
        Sat, 10 Apr 2021 13:22:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m3so10444479edv.5;
        Sat, 10 Apr 2021 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CRFM4ogKqdLYgnqdE8EkoNEQHBN6U7dScp6fLoIKDKw=;
        b=oYQRelbqZXz7f1ww5s0sjkCn/8PEBBN2LxGoMwpoKINRB2gWqYPxScGENWINFlJphg
         mGg09ME2dHsK1kt6DOaTWZPPhz5IPamSfzj9HJwxdX7G7dNapcdumxopDRQcnM3sa8Za
         jTtebv+kS9E08OUCjnaM//f0B6gp3bmxz+u7DqZ8ooTtm7nCuB4xsuAQdmCZRKirorNU
         a+ZliVLxVm0NYjY5K/92kXsbtvSm+Gkzz5TLWiuBeldxlmRUy0ViYFRJ7dD1aT25bJ3I
         ki2u54wOvBmUmbsVe22BGe05Ji7C8V9RMHZ1joKDkbrk4CsGxdlzostbSI4hsZVusJ0J
         AxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CRFM4ogKqdLYgnqdE8EkoNEQHBN6U7dScp6fLoIKDKw=;
        b=UzB2Pfx4IOsyme4Ygpa12pDHkd81KeCTma5QlLC8cdOvDjBcXSxOB6VlAW8a1tL89S
         vZIitqjSFU+9WhreTY2INDE2gYnN4gbKHwv759mEcmd9tkEe+cPi+0UzKZQ9EXBFT7Re
         fDT30xW1pFAhoRmNZBvBGTgqcH0dfPNxOTUWHu/RexNGha+LG1rgeeG0xO94+Lrxckpz
         AAlT//z+bhYDBj+AjTtBavZL14Vm+FGLYyOVw70JiRAP0JSVt2qh8vUo1GW9YHoYxTJX
         cV6EQ5pyslFuzvLXWvUtM9hbGDwBBXJzHcMMIfgjOijFKqYQ2wlQ4FcKKKMESPHwZ+lB
         vdyA==
X-Gm-Message-State: AOAM530g9QUfJIg6UHGdutEv7XHv7GGONrfCZD2qm64Fy1Pk9zIQhfy2
        R+/YxI0+ODj3b4ehSFHygUBrlixDhA==
X-Google-Smtp-Source: ABdhPJydrI3DgK1rF/8/x6Rbqpl1jJXjyQ+KB+HHIkhg7/i6+qXMJgR4Canw71W1kw2f1qalZXVTlg==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr22974346edq.141.1618086176819;
        Sat, 10 Apr 2021 13:22:56 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.21])
        by smtp.gmail.com with ESMTPSA id l15sm3533297edb.48.2021.04.10.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 13:22:56 -0700 (PDT)
Date:   Sat, 10 Apr 2021 23:22:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     oleg@redhat.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Tainting tasks after poking at them
Message-ID: <YHIJHpUq4mE9KwCT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I'm not a security guy, but

The idea is to irrevocably mark task as tainted after its registers
and/or memory have been changed by another task.

The list definitely includes
* ptrace PTRACE_POKEUSER, PTRACE_POKETEXT, PTRACE_POKEDATA,
  PTRACE_SETREGS, PTRACE_SETFPREGS.
* process_vm_writev(2)

If an attacker gets an arbitrary code execution in context of task T,
then every task which can be attached to from T is compromised as well
via registers/memory manipulating system calls.

Tainted flag can be examined in kernel coredumps and maybe even help
with post mortem analysis (no idea if it is really true).

Note:
struct mm_struct should be tainted as well (i've noticed right before
sending this email).

---

 arch/x86/kernel/process_64.c |    2 ++
 arch/x86/kernel/ptrace.c     |    7 +++++++
 arch/x86/kernel/tls.c        |    2 ++
 fs/proc/base.c               |   10 ++++++++++
 include/linux/sched.h        |   14 ++++++++++++++
 kernel/ptrace.c              |    3 +++
 mm/process_vm_access.c       |    4 ++++
 7 files changed, 42 insertions(+)

--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -468,6 +468,7 @@ void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
 	WARN_ON_ONCE(task == current);
 
 	task->thread.fsbase = fsbase;
+	task_set_tainted(task);
 }
 
 void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
@@ -475,6 +476,7 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	WARN_ON_ONCE(task == current);
 
 	task->thread.gsbase = gsbase;
+	task_set_tainted(task);
 }
 
 static void
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -214,6 +214,8 @@ static int set_segment_reg(struct task_struct *task,
 		task_user_gs(task) = value;
 	}
 
+	task_set_tainted(task);
+
 	return 0;
 }
 
@@ -315,6 +317,8 @@ static int set_segment_reg(struct task_struct *task,
 		break;
 	}
 
+	task_set_tainted(task);
+
 	return 0;
 }
 
@@ -349,6 +353,8 @@ static int set_flags(struct task_struct *task, unsigned long value)
 
 	regs->flags = (regs->flags & ~FLAG_MASK) | (value & FLAG_MASK);
 
+	task_set_tainted(task);
+
 	return 0;
 }
 
@@ -382,6 +388,7 @@ static int putreg(struct task_struct *child,
 	}
 
 	*pt_regs_access(task_pt_regs(child), offset) = value;
+	task_set_tainted(child);
 	return 0;
 }
 
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -106,6 +106,8 @@ static void set_tls_desc(struct task_struct *p, int idx,
 		load_TLS(t, cpu);
 
 	put_cpu();
+
+	task_set_tainted(p);
 }
 
 /*
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3149,6 +3149,14 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_STACKLEAK_METRICS */
 
+static int proc_pid_tainted(struct seq_file *m, struct pid_namespace *_,
+			    struct pid *__, struct task_struct *tsk)
+{
+	seq_putc(m, '0' + task_is_tainted(tsk));
+	seq_putc(m, '\n');
+	return 0;
+}
+
 /*
  * Thread groups
  */
@@ -3265,6 +3273,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+	ONE("tainted", S_IRUGO, proc_pid_tainted),
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
@@ -3598,6 +3607,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+	ONE("tainted", S_IRUGO, proc_pid_tainted),
 };
 
 static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -668,6 +668,7 @@ struct task_struct {
 	/* Per task flags (PF_*), defined further below: */
 	unsigned int			flags;
 	unsigned int			ptrace;
+	bool				tainted;
 
 #ifdef CONFIG_SMP
 	int				on_cpu;
@@ -2026,6 +2027,19 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 unsigned long sched_cpu_util(int cpu, unsigned long max);
 #endif /* CONFIG_SMP */
 
+static inline bool task_is_tainted(const struct task_struct *tsk)
+{
+	return READ_ONCE(tsk->tainted);
+}
+
+static inline void task_set_tainted(struct task_struct *tsk)
+{
+	/* Self-flagellation is OK. */
+	if (tsk != current) {
+		WRITE_ONCE(tsk->tainted, true);
+	}
+}
+
 #ifdef CONFIG_RSEQ
 
 /*
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1297,6 +1297,9 @@ int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
 
 	copied = ptrace_access_vm(tsk, addr, &data, sizeof(data),
 			FOLL_FORCE | FOLL_WRITE);
+	if (copied > 0) {
+		task_set_tainted(tsk);
+	}
 	return (copied == sizeof(data)) ? 0 : -EIO;
 }
 
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -228,6 +228,10 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 
 	mmput(mm);
 
+	if (vm_write && rc > 0) {
+		task_set_tainted(task);
+	}
+
 put_task_struct:
 	put_task_struct(task);
 
