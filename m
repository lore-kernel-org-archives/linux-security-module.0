Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CD33D4EE;
	Fri, 12 Jun 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279992; cv=none; b=SeFw6YRFMTi6wovIOTxgN4MHtc9cwMYmzLZs3wZ/sCyfhknTMtXttckvTu9iImcZWute+SDJfLlYlCxsNNWsniX4NjDiFCLbx3kFVd/qv9f8EU1IGGHzDYNBH1x/f577T8YfMTb3cSjDS1MBC0eVy2Y7TRtBPzemL1uAWjPg9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279992; c=relaxed/simple;
	bh=Ew1+yRj0mAB6btFfr+rtsamkyA5KB03tenXrtDq+tPE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plqenMG7aTWR3x4reD6/Cg0a8Q5A2Y1tubPuVYcci2Fm0Jqsl8ssI0v/RhXwJCrMwyMqjvBGdijwjIA7ZKJ6lNnVtHuuT0dW1cHNykvkWjWP7iowodDu1RjwZgGmga5NOV3t/cb/jgYsPe3CR/mAc1YQ9xfQM6HXEfwsifofRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fzqb+6H3; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fzqb+6H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279981; bh=49o0b21LzW8/BpFFIz1WHnAexPoQhD+mfoIRicfbkqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzqb+6H3eNZaeDt+vIGcrIvh+whXObU+BKb02QrkTMnIkWHYnfvHalv4kUNwhzUQP
	 tFEtqs+lDowrxzNNCSCx6gqPyqb5EcOGVo/eEMQEqvJsIihxZVzaWoLlTbbYNtB4qs
	 DsuH+daQx6D27Csy89mAEm3eZHg6RJA1UztR3qEM=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279979tjlwikxgg
Message-ID: <tencent_B27B8B8B80A567D6C21DDDD1C6981982DE06@qq.com>
X-QQ-XMAILINFO: MVhBsdG5jI6hUlMmbomLb6W7mvgq7/zHaMPIBaCZicgKnBd5p2dfQD1hWow7ad
	 lDt5VZf35GQ/E/Vct/xGzP7vv2WFbt44TQHT+gGlpsSL8mJNslujmpKmd6ibREAtE6fp6TD8WnkC
	 yZId3ttME99exCwkl5Yn7WA1RfWshCq86pSUj+7ztWVUjuBBAObLlMV8fUTqUduIyoxdvuTAh011
	 hoyMFZOMLfIz0c08xKGpezsNSQsTJ4xnStnvtzxKwRvVUQ2cKxVnKhUR4dwsOQNy0NIR8wzy25xn
	 FcaKJB0kpPys0DpMZWPVlUca368ihJymZddMBcP0e27v6XJ0jQWlJJJ36spl5n6HxEjPfWiOJFJ/
	 u9NiNF98mp8MZ2bNqtknWjgtOC2SnkMtbKbPKm3U4cveM77xLFZjFrXdDsdZEOxOiRrT+7EWRL/R
	 A8RtTP1K21NxCe/wVDj2WuKM86ROv2ovYi0ClU982k+OyjFH2J1FG1lvub7jtoYqYhRLd/i14IBp
	 arkSlD08/ZPLP95AYNlt3fhlP5+UG5zFBBv4Ya8EZFZY8zH3Ph30fd9p3xnKROXIUzTv4ch/VSR8
	 4n9GO09QFsURPoaI/nruwzwxz7bd7cUTt07FjwXjUrM4nZxmyAhs2EyBD5b+Y/EHENQ+EcN0zNUO
	 7VdN+3FCJTgvRIUDADwPZzfRXDcNdH9AM3fE6PLAKrw10FKFh0JFRrgjt8Pep2Yl5jSJCJXKf2m9
	 YgD7Y83YJlzPQQH0BKD4ZMl+S/gFEaIgIBwyIIgDm5bqeVvmGVyw3Dt8+TKEk40w815FkmoQdAEt
	 iwHSlobALb6wrPiYVgjMo21+XN75wcsCyvYKam8k4HsQsxOLVFsFN862oAjdpH8kQ2vZvaXpB8e1
	 zkENjaRkoqJUdGBXwSTYwayCL07Y0KlDagR7q2ayGTYqQK46pd9mU6rWmvgZrrhTtQ7wc1uo9TwJ
	 ch/4eghH6aC4IW0G/OhWuaBY2f/xnsKQohd0AXp0v8pxquE9RVYfbb5FH1+ttlW3yiycj++rw3Jf
	 Jbt3FRBMVhzxm5P5qhYZ1ekbea5zc6D/ShJYHJENivcUxtZW88PeXWDGNAN/ykxL6MjWvsTRBsjv
	 RGBinHd1D2dSkjUEMAvsOZajCRPnd+78msDRLijiWeZp8cC+J0z3C9EGnzp0fSttOvWVOpRxFOAQ
	 igrU4zUtc5HGl1Hw==
X-QQ-XMRINFO: NyFYKkN4Ny6F/RgSyQIppvxaoEvAYLeaow==
From: Yan Zhu <zhuyan2015@qq.com>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net,
	mic@digikod.net
Cc: dzm91@hust.edu.cn,
	skhan@linuxfoundation.org,
	gnoack@google.com,
	zhuyan2015@qq.com,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 10/10] docs/zh_CN: add LSM/landlock Chinese translation
Date: Fri, 12 Jun 2026 23:58:29 +0800
X-OQ-MSGID: <dcc307f698be1e92fdb2dbeb7c88b61f7c999ba4.1781105672.git.zhuyan2015@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781105672.git.zhuyan2015@qq.com>
References: <cover.1781105672.git.zhuyan2015@qq.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/admin-guide/LSM/landlock.rst into Chinese.

Update the translation through commit de4b09abf088
("landlock: Document audit blocker field format")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst b/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
new file mode 100644
index 000000000000..7c465ce1c774
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright © 2025 Microsoft Corporation
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/landlock.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+========================
+Landlock：系统范围的管理
+========================
+
+:Author: Mickaël Salaün
+:Date: 2026年1月
+
+Landlock 可以利用审计框架记录事件。
+
+用户空间文档位于：Documentation/userspace-api/landlock.rst。
+
+审计
+====
+
+默认情况下，若启用了 ``audit``，沙箱程序的被拒访问请求会被记录。此默认行为可
+通过 ``sys_landlock_restrict_self()`` 标志更改（参见
+Documentation/userspace-api/landlock.rst）。审计规则也可以屏蔽 Landlock 日志。
+Landlock 能生成两种审计记录类型。
+
+记录类型
+--------
+
+AUDIT_LANDLOCK_ACCESS
+    此记录标识对内核资源的拒绝访问请求。``domain`` 字段指示阻止该请求的
+    域 ID。``blockers`` 字段列出导致拒绝的原因（逗号分隔），随后字段标识
+    内核对象（类似 SELinux）。一次审计事件可能出现多个此类记录。
+
+    示例：同一事件中两条文件链接请求记录::
+
+        domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
+        domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365
+
+    ``blockers`` 字段使用点分前缀标识限制类型：
+
+    **fs.*** – 文件系统访问权（ABI 1+）:
+        - fs.execute, fs.write_file, fs.read_file, fs.read_dir
+        - fs.remove_dir, fs.remove_file
+        - fs.make_char, fs.make_dir, fs.make_reg, fs.make_sock
+        - fs.make_fifo, fs.make_block, fs.make_sym
+        - fs.refer (ABI 2+)
+        - fs.truncate (ABI 3+)
+        - fs.ioctl_dev (ABI 5+)
+
+    **net.*** – 网络访问权（ABI 4+）:
+        - net.bind_tcp – TCP 端口绑定被拒绝
+        - net.connect_tcp – TCP 连接被拒绝
+
+    **scope.*** – IPC 范围限制（ABI 6+）:
+        - scope.abstract_unix_socket – 抽象 UNIX 套接字连接被拒绝
+        - scope.signal – 信号发送被拒绝
+
+    当多个访问权缺失时，可出现多个 ``blockers``（逗号分隔），例如缺少
+    ``make_reg`` 与 ``refer`` 权限时会显示 ``blockers=fs.make_reg,fs.refer``。
+
+    对象标识字段（路径、设备、inode 等）根据被阻止的访问类型提供上下文信息。
+
+AUDIT_LANDLOCK_DOMAIN
+    此记录描述 Landlock 域的状态。``status`` 字段为 ``allocated`` 或
+    ``deallocated``。
+
+    ``allocated`` 状态随同首条 ``AUDIT_LANDLOCK_ACCESS`` 记录出现，
+    提供以下信息：
+
+    - 域 ID（``domain``）
+    - 强制模式（``mode``）
+    - 创建域的 PID（``pid``）
+    - 创建域的 UID（``uid``）
+    - 创建域的可执行路径（``exe``）
+    - 创建域的命令行（``comm``）
+
+    示例::
+
+        domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 ...
+
+    ``deallocated`` 为单独事件，表示域释放。此后该域 ID 不会在系统生命周期中
+    再次使用。``deallocated`` 记录包含域 ID 与 ``denials`` 字段，后者统计该
+    域被拒绝的请求数。
+
+    示例::
+
+        domain=195ba459b status=deallocated denials=3
+
+事件示例
+--------
+
+以下为两组审计日志示例（含序列号）。
+
+示例 1：沙箱程序 ``kill`` 试图向 init 进程发送信号，
+被 ``scope.signal`` 限制拒绝::
+
+  $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
+
+此命令生成两个事件，每个事件都由一个时间戳后跟一个唯一的序列号标识
+（``msg=audit(1729738800.268:30)``）。第一个事件（序列号为“30”）包含 4 条记
+录。第一条记录（``type=LANDLOCK_ACCESS``）显示域 `1a6fdc66f` 拒绝了访问。拒
+绝的原因是信号范围限制（``blockers=scope.signal``）。本应接收此信号的进程是
+init 进程（``opid=1 ocomm="systemd"``）。
+
+第二个记录（``type=LANDLOCK_DOMAIN``） 描述了（``status=allocated``）域
+`1a6fdc66f`。此域由进程 ``286`` 创建，该进程执行了由 root 用户启动的
+`/root/sandboxer` 程序。
+
+第三个记录（``type=SYSCALL``）描述了系统调用、其提供的参数、其结果
+``success=no exit=-1`` 以及调用它的进程。
+
+第四个记录（``type=PROCTITLE``）以十六进制值的形式显示命令名称。这可以通过执
+行 ``python -c 'print(bytes.fromhex("6B696C6C0031"))'`` 进行转换。
+
+最后一条记录（``type=LANDLOCK_DOMAIN``）也是第二个事件（序列号“31”）中的唯一
+一条记录。它并非与直接的用户空间操作相关，而是异步操作以释放与 Landlock 域相
+关的资源（``status=deallocated``）。这有助于了解后续的日志将不再涉及域
+`1a6fdc66f`。此记录还总结了该域拒绝的请求数量（``denials=1``），以及这些请求
+是否被记录。
+
+
+.. code-block::
+
+  type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
+  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
+  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1
+
+
+示例 2：文件系统访问控制示例::
+
+    $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"
+
+相关的审计日志包含由同一个域 `1a6fdc679` 创建的 3 个不同事件（序列号 33、34
+和 35）的 8 条记录::
+
+  type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
+  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
+  type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
+  type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
+  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
+  type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
+  type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2
+
+
+过滤审计日志
+------------
+
+如果审计日志数量过多，可通过以下两种方式过滤噪声：
+
+- 使用 ``sys_landlock_restrict_self()`` 的标志对沙箱程序进行配置；
+- 或使用审计规则（参见 :manpage:`auditctl(8)`）过滤。
+
+补充文档
+--------
+
+* `Linux Audit Documentation`_
+* Documentation/userspace-api/landlock.rst
+* Documentation/security/landlock.rst
+* https://landlock.io
+
+.. 链接
+.. _Linux Audit Documentation:
+   https://github.com/linux-audit/audit-documentation/wiki
-- 
2.43.0

