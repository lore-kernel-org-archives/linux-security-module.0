Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D451DBB3A;
	Tue, 17 Dec 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418328; cv=none; b=RWG9KtuyIHmlVIwi5853Iy/i6VqU4xW77VVN58Dwtnt1c3GILIpIPgK7FiPOWUWRGSa6d6emvMez2dNj8o1sKDjEGJ5oAepFpGWZr62Mn9CmE9GS7ZKEE/AbJ0r4eCppVkPkcz5OrF6Uh9OFKQ/QtjvagQHW60vNbvWxfkshAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418328; c=relaxed/simple;
	bh=DlWOrYmMj/yNG14rYAy4f+JEtnYxOdPX/YxHgvXje8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAlGkx4OsPH9Ek3pJJU84bxQ9p/0Sqc5u6pREVs9bPsTdj2ddkthdYrMMYQ7E8WE8ieCVZ9JF4JAhfsCvE4pbHCDQ0OFOoVFjSf+Mj5aSrURJIM3qMbMtDZcZ1D1uGmh3n3j40ao7VzHUJddFuoEl9cBqP6Ok6I3eN1tOtfFKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=icwSJkzF; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="icwSJkzF"
Received: from localhost.localdomain (unknown [123.53.36.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5f3aea5c;
	Tue, 17 Dec 2024 14:46:53 +0800 (GMT+08:00)
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
Subject: [PATCH 2/2] docs/zh_CN: Add security lsm Chinese translation
Date: Tue, 17 Dec 2024 14:46:25 +0800
Message-ID: <a0c872eced10c0d1f918df46639966f873f547d5.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
References: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ08eVk8eQxpIGh1MTk9CGlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVTkhVSE1VSk1IWVdZFhoPEhUdFFlBWU9LSFVKS0hKTENKVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a93d35e9c0d03a3kunm5f3aea5c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6KAw6DDIQEB46ISICCSFP
	KxFPFCJVSlVKTEhPT0pDS0pPSk1PVTMWGhIXVQETGhQCDh4TDhI7GAoIFB0PDBoJHlUYFBZVGBVF
	WVdZEgtZQVlKSUhVTkhVSE1VSk1IWVdZCAFZQU1MSEg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=icwSJkzFi0gPcpv2GgPj5UgYvIF57p2Y/P+9C9t6kB4MGmVqE5l54IC9u/n4eeUC0QH4GBiy8EtolbrSaYRehnktIHzkrbj2jh4Tjzibnm3gTga/4flKdVIBlOLRNxl9lXalnTAmMN41jhRYEpGJ03RCIPmKRy+l8K+tkgZZSWg=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=hllLUsMLdEQReUfE9qjC7V/PZ2ytTmm/Gjosx4dcFwI=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/lsm.rst into Chinese.

Signed-off-by: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
---
 .../translations/zh_CN/security/index.rst     |  3 +-
 .../translations/zh_CN/security/lsm.rst       | 92 +++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
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
index 000000000000..820b1a3a5fa2
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/lsm.rst
@@ -0,0 +1,92 @@
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
+    本书中描述的api已经过时了。
+
+介绍
+====
+在2001年3月，美国国家安全局（NSA）在2.5 Linux内核峰会上介绍了安全增强的
+Linux（SELinux）。SELinux是Linux内核中一种实现灵活且细粒度不可任意支配的
+访问控制，最初作为自己的特定内核补丁实现。其他一些安全项目（例如RSBAC、
+Medusa）也为Linux内核开发了灵活的访问控制架构，并且多个项目为Linux开发了
+特定的访问控制模型（例如LIDS、DTE、SubDomain）。每个项目都开发并维护了自
+己的内核补丁，以支持其安全需求。
+
+针对美国国家安全局的报告，Linus Torvalds发表了一系列言论，描述了一个他愿
+意考虑纳入主流Linux内核的安全框架。他描述了一个通用的框架，该框架将提供一
+组安全钩子来控制对内核对象的操作和内核数据结构中的一组不透明的安全字段来
+维护安全属性。这个框架可以被可加载的内核模块用来实现任何所需的安全模型。
+Linus还提出了将Linux功能代码迁移到这样一个模块中的可能性。
+
+Linux安全模块（LSM）项目是由WireX发起开发的这样一个框架。LSM是几个安全
+项目共同开发的成果，包括immununix、SELinux、SGI和Janus，以及包括
+Greg Kroah-Hartman和James Morris在内的几个人，来开发一个实现这一框架的
+Linux内核补丁。这项工作在2003年12月被纳入主流内核。此技术报告概述了该框
+架和功能安全模块的内容。
+
+LSM框架
+=======
+LSM框架提供了一个通用的内核框架来支持安全模块。特别地，LSM框架主要关注
+支持访问控制模块，尽管未来的开发可能会解决其他安全需求，比如沙箱。就其
+本身而言，框架不提供任何额外的安全；它仅提供了支持安全模块的基础设施。
+LSM框架是可选的，要求启用 `CONFIG_SECURITY` 配置。功能逻辑作为一个安全
+模块实现。该功能模块将在 `LSM功能模块`_ 一节中进一步讨论。
+
+LSM框架在内核数据结构中包含安全字段，并在内核代码的关键点调用钩子函数来
+管理这些安全字段并执行访问控制。它还增加了注册安全模块的函数。接口
+/sys/kernel/security/lsm记录了一个以逗号分隔的安全模块列表，这些模块在
+系统中是活跃的。
+
+LSM安全字段只是 ``void*`` 指针。数据被称为blob，这些数据可以由框架或使用它
+的各个安全模块进行管理。多个安全模块共同使用的安全blob通常由框架管理。
+对于进程和程序执行的安全信息，安全字段包含在  :c:type:
+`struct task_struct <task_struct>` 和 :c:type: `struct cred <cred>` 中。
+对于文件系统的安全信息，安全字段包含在 :c:type:
+`struct super_block <super_block>` 中。对于管道、文件和套接字的安全信息，
+安全字段包含在 :c:type: `struct inode <inode>` 和 :c:type: `struct file <file>`
+中。对于System V IPC的安全信息，安全字段被添加到 :c:type:
+`struct kern_ipc_perm <kern_ipc_perm>` 和 :c:type: `struct msg_msg <msg_msg>`
+中；另外，:c:type: `struct msg_msg <msg_msg>` 、struct msg_queue和
+struct shmid_kernel的定义被移动到头文件中（ ``include/linux/msg.h`` 和
+``include/linux/shm.h`` 视情况而定），以允许安全模块使用这些定义。
+
+对于数据包和网络设备的安全信息，安全字段被添加到 :c:type:
+`struct sk_buff <sk_buff>` 和 :c:type: `struct scm_cookie <scm_cookie>` 中。
+与其他安全模块数据不同，这里使用的数据是一个32位整数。安全模块需要将这些值
+进行映射或关联到真正的安全属性。
+
+LSM钩子被维护在链表中。每个钩子函数都维护一个链表，这些钩子按照CONFIG_LSM中
+指定的顺序被调用。每个钩子的详细文档都包含在 `security/security.c` 源文件中。
+
+LSM框架提供了一种接近通用安全模块堆栈。它定义了security_add_hooks()，每个安
+全模块向它传递一个 :c:type: `struct security_hooks_list <security_hooks_list>`
+，该结构会被添加到链表中。LSM框架没有提供移除已注册钩子的机制。SELinux 安全
+模块已经实现了一种移除自身的方法，然而该功能已被弃用。
+
+这些钩子可以分为两大类：用于管理安全字段的钩子和用于执行访问控制的钩子。
+第一类钩子的示例包括security_inode_alloc()和security_inode_free()，这些
+钩子用于为inode对象分配和释放安全结构。第二类钩子的示例是
+security_inode_permission()钩子，该钩子在访问inode时检查权限。
+
+LSM功能模块
+===========
+POSIX.1e 功能逻辑作为一个安全模块维护，存储在文件 ``security/commoncap.c``
+中。功能模块使用 :c:type: `lsm_info` 描述中的order字段来标识它为第一个注册
+的安全模块。与其他模块不同，功能安全模块不使用通用的安全blob。其原因是历史
+性的，主要基于开销、复杂性和性能的考虑。
-- 
2.43.5

