Received: from mail-m12783.qiye.163.com (mail-m12783.qiye.163.com [115.236.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AA7082A;
	Thu, 19 Dec 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734590169; cv=none; b=fwKQvVkk2BG43TVuge9LOmHZX2fHRbUPrU5aJzkiiwzFhcelTq4uEQG53RkDQ7sQJi6p6oa03vofkZ6TFgFZpeMWg3//oAJq4fzyZZWI2mBvY/vkC+ddx1BPZFEWVKH23zSJ58X46j1kOt52pLKWA0sp8ZIZvFs6XArfwxRoDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734590169; c=relaxed/simple;
	bh=xFj2C0TeVO4NtNI6E9ROrfYkVTX/2GvRVZuqyOPGF7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJvXi2ERvuJHyiOTQNWADSc+z1wnxdwJ25mQY9pyh1i2fdxM93aWqewh2+iE5NpFalu9/C1Y0P0wGMoIrEYTGd9+cXggCngYMsDvnJM5lgQx1rfgYgLW0ghh5syD/QV4ekG7vy1R5AsmCKI7IIvaT3exoaLbT+IsHaJlzvzHjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=Eod0uYXb; arc=none smtp.client-ip=115.236.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="Eod0uYXb"
Received: from localhost.localdomain (unknown [123.149.2.140])
	by smtp.qiye.163.com (Hmail) with ESMTP id 63054557;
	Thu, 19 Dec 2024 14:30:47 +0800 (GMT+08:00)
From: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net
Cc: dzm91@hust.edu.cn,
	mic@digikod.net,
	gnoack@google.com,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
Subject: [PATCH v2 2/2] docs/zh_CN: Add security lsm Chinese translation
Date: Thu, 19 Dec 2024 14:30:35 +0800
Message-ID: <d7582527ff42abf20b56ca6b145bfb91873c9ded.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
References: <cover.1734575890.git.zhaoyuehui@cqsoftware.com.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUlNVk9OHUgfGU4dH01MSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSk9CVUlVSk9LWVdZFhoPEhUdFFlBWU9LSFVKS0hKTENKVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a93dd9c96b503a3kunm63054557
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46CRw4FDIRPhUzPxQRLh8x
	AggKCyNVSlVKTEhPTkNCQ09DSUxIVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVSk9CVUlVSk9LWVdZCAFZQU1DT083Bg++
DKIM-Signature:a=rsa-sha256;
	b=Eod0uYXbWlnYKjoJVVb16a0ZAVmJuKLRkKAAvYe9eFvQ3Mz6H8AUCCKWBfNJK9joR/Jyx2uNuIZAWhdjyByhcY7Gc58dP9kotZrjL0E5IP+Yiz7yAI+hFUsZ8Py8BkWUb0b8i2K/DcJxhxhiITscEAYmTmgUCrzZGOWOWkHXyns=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=VaLt2rPSfqtlGWCHK8+MuC/3m2hpM2fDzcZr9Qd51kk=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/lsm.rst into Chinese.

Update the translation through commit 6d2ed653185b ("lsm: move hook
 comments docs to security/security.c")

Signed-off-by: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
---
 .../translations/zh_CN/security/index.rst     |  3 +-
 .../translations/zh_CN/security/lsm.rst       | 95 +++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/lsm.rst

diff --git a/Documentation/translations/zh_CN/security/index.rst b/Documentation/translations/zh_CN/security/index.rst
index 6b56b4f87315..92e2d8a7dec8 100644
--- a/Documentation/translations/zh_CN/security/index.rst
+++ b/Documentation/translations/zh_CN/security/index.rst
@@ -15,12 +15,13 @@
 .. toctree::
    :maxdepth: 1
 
+   lsm
+
 TODOLIST:
 * credentials
 * snp-tdx-threat-model
 * IMA-templates
 * keys/index
-* lsm
 * lsm-development
 * sak
 * SCTP
diff --git a/Documentation/translations/zh_CN/security/lsm.rst b/Documentation/translations/zh_CN/security/lsm.rst
new file mode 100644
index 000000000000..941f94fb2acc
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/lsm.rst
@@ -0,0 +1,95 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/security/lsm.rst
+
+:翻译:
+
+ 赵岳辉 Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
+
+================================
+Linux安全模块：Linux通用安全钩子
+================================
+
+:作者: Stephen Smalley
+:作者: Timothy Fraser
+:作者: Chris Vance
+
+.. note::
+
+    本文中描述的api已经过时了。
+
+介绍
+====
+
+在2001年3月，美国国家安全局（NSA）在2.5 Linux内核峰会上做了一个关于安全
+增强Linux（SELinux）的报告。SELinux是Linux内核中一种实现灵活且细粒度的非
+自主访问控制，最初作为自己特定的内核补丁实现。其他一些安全项目（例如RSBAC、
+Medusa）也为Linux内核开发了灵活的访问控制架构，并且多个项目为Linux开发了
+特定的访问控制模型（例如LIDS、DTE、SubDomain）。每个项目都开发并维护了自
+己的内核补丁，以支持其安全需求。
+
+针对美国国家安全局的报告，Linus Torvalds发表了一系列言论，描述了一个他愿
+意考虑纳入主流Linux内核的安全框架。他描述了一个通用的框架，该框架将提供
+一组安全钩子来控制对内核对象的操作，同时在内核数据结构中提供一组不透明的
+安全域来维护安全属性。这个框架可以被可加载的内核模块用来实现任何所需的安
+全模型。Linus还提出了将Linux权能代码迁移到这样一个模块中的可能性。
+
+Linux安全模块（LSM）项目是由WireX发起开发的这样一个框架。LSM是几个安全
+项目共同开发的成果，包括immununix、SELinux、SGI和Janus，以及包括
+Greg Kroah-Hartman和James Morris在内的几个人，来开发一个实现这一框架的
+Linux内核补丁。这项工作在2003年12月被纳入主流内核。此技术报告概述了该框
+架和权能安全模块的内容。
+
+LSM框架
+=======
+
+LSM框架提供了一个通用的内核框架来支持安全模块。特别地，LSM框架主要关注
+支持访问控制模块，尽管未来的开发可能会解决其他安全需求，比如沙箱。就其
+本身而言，框架不提供任何额外的安全；它仅提供了支持安全模块的基础架构。
+LSM框架是可选的，要求开启 `CONFIG_SECURITY` 配置。权能逻辑作为一个安全
+模块被实现。该权能模块将在 `LSM权能模块`_ 一节中进一步讨论。
+
+LSM框架在内核数据结构中包含安全域，并在内核代码的关键点调用钩子函数来
+管理这些安全域并执行访问控制。它还增加了注册安全模块的函数。接口
+/sys/kernel/security/lsm记录了一个以逗号分隔的安全模块列表，这些模块在
+系统中是激活的。
+
+LSM安全域只是 ``void*`` 指针。数据被称为blob，这些数据可以由框架或使用
+它的各个安全模块进行管理。多个安全模块共同使用的安全blob通常由框架管理。
+对于进程和程序执行的安全信息，安全域包含在  :c:type:
+`struct task_struct <task_struct>` 和 :c:type: `struct cred <cred>` 中。
+对于文件系统的安全信息，安全域包含在 :c:type:
+`struct super_block <super_block>` 中。对于管道、文件和套接字的安全信息，
+安全域包含在 :c:type: `struct inode <inode>` 和 :c:type: `struct file <file>`
+中。对于System V IPC的安全信息，安全域被添加到 :c:type:
+`struct kern_ipc_perm <kern_ipc_perm>` 和 :c:type: `struct msg_msg <msg_msg>`
+中；另外，:c:type: `struct msg_msg <msg_msg>` 、struct msg_queue和
+struct shmid_kernel的定义被移动到头文件中（ ``include/linux/msg.h`` 和
+``include/linux/shm.h`` 视情况而定），以允许安全模块使用这些定义。
+
+对于数据包和网络设备的安全信息，安全域被添加到 :c:type:
+`struct sk_buff <sk_buff>` 和 :c:type: `struct scm_cookie <scm_cookie>` 中。
+与其他安全模块数据不同，这里使用的数据是一个32位整数。安全模块需要将这些值
+进行映射或关联到真正的安全属性。
+
+LSM钩子被维护在链表中。每个钩子函数都维护一个链表，这些钩子按照CONFIG_LSM中
+指定的顺序被调用。每个钩子的详细文档都包含在 `security/security.c` 源文件中。
+
+LSM框架提供了一种近似通用的安全模块堆栈。它定义了security_add_hooks()，每个安
+全模块向它传递一个 :c:type: `struct security_hooks_list <security_hooks_list>`
+，该结构会被添加到链表中。LSM框架没有提供移除已注册钩子的机制。SELinux安全
+模块已经实现了一种移除自身的方法，然而该特性已被弃用。
+
+这些钩子可以分为两大类：用于管理安全域的钩子和用于执行访问控制的钩子。
+第一类钩子的示例包括security_inode_alloc()和security_inode_free()，这些
+钩子用于为inode对象分配和释放安全结构。第二类钩子的示例是
+security_inode_permission()钩子，该钩子在访问inode时检查权限。
+
+LSM权能模块
+===========
+
+POSIX.1e 权能逻辑作为一个安全模块维护，存储在文件 ``security/commoncap.c``
+中。权能模块使用 :c:type: `lsm_info` 描述中的order域来标识它为第一个注册
+的安全模块。与其他模块不同，权能安全模块不使用通用的安全blob。其原因是历史
+性的，主要基于开销、复杂性和性能的考虑。
-- 
2.43.5

