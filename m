Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376FD3921CE;
	Fri, 12 Jun 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279990; cv=none; b=VD5afazkMkZKStAOyEFtljUJP+h5MHcrImy0whglFoDMo1id73xVPXkIaUWeptosVqCxBmhPF1108BwxYDda386ahl1mf1F0dfFzsVsOB3VrNysXnZENOWkevJI2oOsu136JZooPKsx+TpTvC7g9684/E1Eex7GKPG76eG6K+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279990; c=relaxed/simple;
	bh=kYdO28r0RVma9cZT/GrvT/B9J1r1N+sdEJF3GVlnvLM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIlpkXklCk1S82rWnxCAhbW4YIvzJmufv4hHsqpvDb3jR1SVnQrxuWuUhJkbTRoGq8zI5Gzkh2NdnG64a26CXWrX0cvVAly/+IpsduKl2XYyPmHHtjINwqtavsDZwnvzn2nDhzHKaudaoP+PKxc8hP7zFcfUUoe5X6ns4sqXdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IypFrzNL; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IypFrzNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279976; bh=NXhfH8Arxv+yFktWhGJqQC1efoll/y+baK9wE0TZ/to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IypFrzNLn31gWKl3kjbK4T5+Jembijdtu7HRCmp9/RjKG9Soyp+aY7fwQkcRU14ZA
	 6m8cc47CGT1NOX9+PbiPOZEI1txIyvfeaWbElKQeAWfMza8Y7K8I2l73XtChR0bWnI
	 98OdzoDOiK3fwl7TRQajyQmZQQlzh+ZpLWBP/KOk=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279974ts1dlk9vx
Message-ID: <tencent_BABBA8A3BDB14504B377071745CBB3ACB607@qq.com>
X-QQ-XMAILINFO: MAzH0d/SQFdIUn1LNI9c5BZid+4yb98djvKtrGQZnufjBjZFVJkSkzxMiapeK7
	 gqBab/Z0pHmVDX7PEtUgxTMta+DLbqkx1yLtLIus8FX2Kn7SxtBJcrchp/JzSeSrdrGzuiD+V+7P
	 jzgqnqZNc6DQ/jLxf07S2PZLKX2h8K5FZz1Wbw1g6Lh1D/ei56nVMNw4teGSdV9VWD6VE6PqQ2dz
	 06vKF6IEw3b1EZjra52gnOpDFZh4mpgk+pdndFa7tKJPukJj4e2Jku+gOat9SfLAA5UiuvM69s7C
	 oEtl9dDMdMMNiOWL8tzi500VJ9UrhYE+5Vqu4rt6G8QG24tiA21Vq4Bcv2jarBchp+pBhRzYM87Z
	 EzvA17NpXEqpqPrcRaQWQ3O4Ya/KwVDOYQcld/3dNF6s/ouwBCshLh4SwhurUz55uk8Xk0O3aQ06
	 9i5UtxszBkzkJ2DXzXurlTnqnkEXdzqXYrs7l5jIuAeaSb539wp9DHAmmS+7Vndc4JMuJkmJHXY6
	 KyS9h2EGppo4pMPGtsmQ1nvvfSAJU3M4NMLDRVVGl6ITatS6fTI2aEw9pbl8qtA9PVHQUk/qYHjf
	 HW1tGUG+MGqZcB5pMjU7LEVW4BFGlVoN4dHlxcoj4TJCrHIBM+nHgiuSEetHWTjbzB1hPmtcLYUT
	 Yn2lnvPFsbucEyrLiRB8altdDl77Zx0AwpMCPlbtYlnM8tD/raOJKB4eaaLPBvwoOmRYxxxSWQWt
	 ink36daRM+pxgRAtGH2uUBCs3CUZWg2GWkMknTsWKunevb3jrQDx3SlIFW/v2XiI3fHIDuCHFsYO
	 T1HwmxWXpB2JVH7KBB5Yqy5WpyrPK1oNs1OAQQEjsfnXh3qNBCaomiKk6yiX3Xl90DyiOGzN3T8v
	 jzdiP9gjJ62mIXbyvOYPlEPBA1XFa+5tynuxCCrf90fpR6+dJQwQm9x2CpNuL+2HQ7rDcSV4g69d
	 Ufv4FapDk1fxkh0zqEcC2RHS4PYrDReLuFqfkBgnueUJhYD2pSaL5D6HsTc9fuDozftAgMUWOJSE
	 wpwZEb2df3bMI/ABj/ICvEdBsOU7n5f1Bs7I34CWnbL7xUI8pBXkJ34ftEHWyKCRqKW1Qa0nZFlx
	 PZYhlYrDV0acJkXR2haHlTEtffGuDKbCzZIgH+QF9pZvxr5DRNzZqRWaUTEceMX1OiKXLH9hlhyU
	 AIcWw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH 05/10] docs/zh_CN: add LSM/Smack Chinese translation
Date: Fri, 12 Jun 2026 23:58:24 +0800
X-OQ-MSGID: <8a962f82e4865453c0fe27444800492c26e28e62.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/Smack.rst into Chinese.

Update the translation through commit 674e2b24791c
("smack: fix bug: setting task label silently ignores input garbage")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/Smack.rst           | 722 ++++++++++++++++++
 1 file changed, 722 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst b/Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst
new file mode 100644
index 000000000000..cdc5221624a5
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst
@@ -0,0 +1,722 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/Smack.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+=====
+Smack
+=====
+
+"Good for you, you've decided to clean the elevator!"
+- The Elevator, from Dark Star
+
+Smack 是简化的强制访问控制 (MAC) 内核实现。
+它是一种基于内核的强制访问控制方案，设计目标强调
+简洁性。
+
+Smack 不是 Linux 唯一可用的 MAC 机制。首次接触 MAC
+的用户应将 Smack 与其他机制进行比较，以决定哪种最适合
+当前需求。
+
+Smack 由三大部分组成：
+
+- 内核
+- 基本工具（有帮助但非必需）
+- 配置数据
+
+内核部分实现为 Linux 安全模块 (LSM)。它依赖 netlabel，
+并在支持扩展属性的文件系统上表现最佳，但扩展属性支
+持并非严格要求。在标准发行版（"vanilla"）上运行 Smack
+内核是安全的。
+
+Smack 内核使用 CIPSO IP 选项。某些网络配置不接受 IP
+选项，可能会阻碍使用 Smack 的系统。
+
+Smack 已在 Tizen 操作系统中使用。了解 Smack 在 Tizen 中
+的使用方式，请访问 http://wiki.tizen.org 。
+
+当前 Smack 用户空间的 git 仓库为：
+
+    git://github.com/smack-team/smack.git
+
+大多数现代发行版都可以直接编译并安装。
+smackutil 中包含五个命令：
+
+chsmack:
+    显示或设置 Smack 扩展属性值
+
+smackctl:
+    加载 Smack 访问规则
+
+smackaccess:
+    检查具有某标签的进程是否能访问另一个标签的对象
+
+这两个命令已被以下接口取代：
+    smackfs/load2 和 smackfs/cipso2
+
+smackload:
+    为写入 smackfs/load 格式化数据
+
+smackcipso:
+    为写入 smackfs/cipso 格式化数据
+
+在 Smack 的理念下，配置数据极少且非强制要求。最关键
+的步骤是挂载 smackfs 伪文件系统。如果已安装 smackutil，
+启动脚本会自动完成；也可以手动完成。
+
+在 ``/etc/fstab`` 中加入如下行可实现自动挂载::
+
+    smackfs /sys/fs/smackfs smackfs defaults 0 0
+
+``/sys/fs/smackfs`` 目录由内核创建。
+
+Smack 使用扩展属性 (xattr) 在文件系统对象上存储标签，
+这些属性位于 security 命名空间。改变标签需要
+CAP_MAC_ADMIN 权限。
+
+Smack 使用的扩展属性如下：
+
+SMACK64
+    用于访问控制决策。新创建文件对象默认获得创建进程的标签。
+
+SMACK64EXEC
+    当带该属性的程序被 exec 时，进程将使用该属性值作为标签。
+
+SMACK64MMAP
+    若进程的 Smack 标签不允许某个该属性所含标签的进程被授予的全部访问
+    权限，则禁止对该文件进行 mmap。这是一个针对共享库的特定使用场景。
+
+SMACK64TRANSMUTE
+    仅能设置为 "TRUE"。若目录具有该属性，并且在目录中创建对象时，
+    允许写入该目录的 Smack 规则包含 transmute（"t"）模式，则对象将
+    继承目录标签而非创建进程标签。若创建的对象是目录，则
+    SMACK64TRANSMUTE 属性也会被一并设置。
+
+SMACK64IPIN
+    仅对套接字的文件描述符可用。使用该属性中的 Smack 标签对递送到
+    该套接字的数据包进行访问控制决策。
+
+SMACK64IPOUT
+    仅对套接字的文件描述符可用。使用该属性中的 Smack 标签对从该
+    套接字发出的数据包进行访问控制决策。
+
+设置 Smack 标签的方式示例::
+
+    # attr -S -s SMACK64 -V "value" path
+    # chsmack -a value path
+
+进程可通过读取 ``/proc/self/attr/current`` 查看自身标签，
+具备 ``CAP_MAC_ADMIN`` 的进程可写入该文件修改标签。
+
+多数 Smack 配置通过写入 smackfs 文件系统完成，该伪文件系统挂载在
+``/sys/fs/smackfs`` 上。
+
+access
+    为向后兼容保留；推荐使用 ``access2`` 接口。
+    此接口报告具有指定 Smack 标签的主体是否对具有指定 Smack 标签
+    的客体拥有特定访问权限。向该文件写入一条固定格式的访问规则，
+    下一次读取将指示访问是否被允许。内容为 "1" 表示允许访问，
+    "0" 表示拒绝。
+
+access2
+    此接口报告具有指定 Smack 标签的主体是否对具有指定 Smack 标签
+    的客体拥有特定访问权限。向该文件写入一条长格式的访问规则，
+    下一次读取将指示访问是否被允许。内容为 "1" 表示允许访问，
+    "0" 表示拒绝。
+
+ambient
+    包含对未标记网络数据包应用的 Smack 标签。
+
+change-rule
+    此接口允许修改已有的访问控制规则。写入格式为::
+
+        "%s %s %s %s"
+
+    其中第一个字符串为主体标签，第二个为客体标签，第三个为允许的
+    访问权限，第四个为拒绝的访问权限。访问字符串只能包含 "rwxat-"
+    字符。如果给定主体和客体的规则已存在，将通过启用第三个字符串中
+    的权限并禁用第四个字符串中的权限来修改该规则。如果不存在这样
+    的规则，将使用第三和第四个字符串中指定的访问权限创建新规则。
+
+cipso
+    为向后兼容保留；推荐使用 ``cipso2`` 接口。
+    此接口允许将特定的 CIPSO 标头分配给 Smack 标签。
+    写入格式为::
+
+        "%24s%4d%4d"["%4d"]...
+
+    第一个字符串是固定长度的 Smack 标签。第一个数字是要使用的级别。
+    第二个数字是类别数量。后续数字是类别::
+
+        "level-3-cats-5-19          3   2   5  19"
+
+cipso2
+    此接口允许将特定的 CIPSO 标头分配给 Smack 标签。
+    写入格式为::
+
+        "%s%4d%4d"["%4d"]...
+
+    第一个字符串是长 Smack 标签。第一个数字是要使用的级别。
+    第二个数字是类别数量。后续数字是类别::
+
+        "level-3-cats-5-19   3   2   5  19"
+
+direct
+    包含用于网络数据包中 Smack 直接标签表示的 CIPSO 级别。
+
+doi
+    包含网络数据包中使用的 CIPSO 解释域。
+
+ipv6host
+    此接口允许将特定的 IPv6 互联网地址视为单标签主机。数据包仅从
+    对主机标签具有 Smack 写访问权限的进程发送到单标签主机。所有从
+    单标签主机接收的数据包将被赋予指定标签。写入格式为::
+
+        "%h:%h:%h:%h:%h:%h:%h:%h label" 或
+        "%h:%h:%h:%h:%h:%h:%h:%h/%d label"
+
+    不支持 "::" 地址缩写。如果标签为 "-DELETE"，将删除匹配的条目。
+
+load
+    为向后兼容保留；推荐使用 ``load2`` 接口。
+    此接口允许指定系统定义规则之外的访问控制规则。
+    写入格式为::
+
+        "%24s%24s%5s"
+
+    其中第一个字符串为主体标签，第二个为客体标签，第三个为请求的
+    访问权限。访问字符串只能包含 "rwxat-" 字符，用于指定允许的访问
+    类型。"-" 是不允许的权限的占位符。字符串 "r-x--" 表示读和执行
+    访问。标签长度限制为 23 个字符。
+
+load2
+    此接口允许指定系统定义规则之外的访问控制规则。
+    写入格式为::
+
+        "%s %s %s"
+
+    其中第一个字符串为主体标签，第二个为客体标签，第三个为请求的
+    访问权限。访问字符串只能包含 "rwxat-" 字符，用于指定允许的访问
+    类型。"-" 是不允许的权限的占位符。字符串 "r-x--" 表示读和执行
+    访问。
+
+load-self
+    为向后兼容保留；推荐使用 ``load-self2`` 接口。
+    此接口允许定义进程特定的访问规则。这些规则仅在访问本来会被允许
+    时才被查询，旨在对进程施加额外的限制。格式与 ``load`` 接口相同。
+
+load-self2
+    此接口允许定义进程特定的访问规则。这些规则仅在访问本来会被允许
+    时才被查询，旨在对进程施加额外的限制。格式与 ``load2`` 接口相同。
+
+logging
+    包含 Smack 日志状态。
+
+mapped
+    包含用于网络数据包中 Smack 映射标签表示的 CIPSO 级别。
+
+netlabel
+    此接口允许将特定的互联网地址视为单标签主机。数据包不带 CIPSO
+    标头发送到单标签主机，但仅从对主机标签具有 Smack 写访问权限的
+    进程发送。所有从单标签主机接收的数据包将被赋予指定标签。
+    写入格式为::
+
+        "%d.%d.%d.%d label" 或 "%d.%d.%d.%d/%d label"
+
+    如果指定的标签是 "-CIPSO"，则该地址被视为支持 CIPSO 标头的主机。
+
+onlycap
+    包含进程必须具有的标签，才能使 ``CAP_MAC_ADMIN`` 和
+    ``CAP_MAC_OVERRIDE`` 生效。如果此文件为空，这些能力对具有任何
+    标签的进程都有效。通过向文件写入所需标签（用空格分隔）来设置值，
+    或通过写入 "-" 来清除。
+
+ptrace
+    用于定义当前的 ptrace 策略::
+
+        0 - default（默认）：
+            依赖 Smack 访问规则的策略。对于 ``PTRACE_READ``，主体需要
+            对客体具有读访问权限。对于 ``PTRACE_ATTACH``，需要读写访问
+            权限。
+
+        1 - exact（精确）：
+            限制 ``PTRACE_ATTACH`` 的策略。仅当主体和客体标签相同时才
+            允许 attach。``PTRACE_READ`` 不受影响。可通过
+            ``CAP_SYS_PTRACE`` 覆盖。
+
+        2 - draconian（严格）：
+            此策略行为与上述 'exact' 相同，但不能通过
+            ``CAP_SYS_PTRACE`` 覆盖。
+
+revoke-subject
+    向此文件写入一个 Smack 标签，会将所有以该标签为主体的访问规则中
+    的访问权限设置为 '-'。
+
+unconfined
+    如果内核配置了 ``CONFIG_SECURITY_SMACK_BRINGUP``，具有
+    ``CAP_MAC_ADMIN`` 的进程可以向此接口写入一个标签。此后，涉及该
+    标签的访问将被记录，并且即使本来不会被允许的访问也会被放行。
+    请注意，这是危险的，可能会破坏系统的正确标签设置。切勿在生产环境
+    中使用。
+
+relabel-self
+    此接口包含进程可以通过写入 ``/proc/self/attr/current`` 转换到的
+    标签列表。通常进程可以将自己的标签更改为任何合法值，但前提是具有
+    ``CAP_MAC_ADMIN``。此接口允许没有 ``CAP_MAC_ADMIN`` 的进程将自身
+    重新标记为预定义列表中的某个标签。没有 ``CAP_MAC_ADMIN`` 的进程
+    只能更改自己的标签一次。更改后，此列表将被清空。
+    通过向文件写入所需标签（用空格分隔）来设置值，或通过写入 "-"
+    来清除。
+
+如果使用 smackload 工具，可以在 ``/etc/smack/accesses`` 中添加访问规则。
+格式为::
+
+    subjectlabel objectlabel access
+
+其中 access 是字母 rwxatb 的组合，指定具有 subjectlabel 的主体对具有
+objectlabel 的客体所允许的访问类型。如果不存在规则，则不允许任何访问。
+
+更多程序请访问 http://schaufler-ca.com 。
+
+简化强制访问控制内核（白皮书）
+====================================
+
+Casey Schaufler
+casey@schaufler-ca.com
+
+强制访问控制
+------------
+
+计算机系统采用多种方案来约束信息在使用机器的用户和服务之间的共享方式。其
+中一些方案允许程序或用户自行决定哪些其他程序或用户可以访问数据片段。这类
+方案被称为自主访问控制（DAC）机制，因为访问控制由用户自主指定。另一些方案
+则不允许用户或程序自行决定能访问什么。这类方案被称为强制访问控制（MAC）机
+制，因为在哪些用户或程序能够访问数据片段的问题上，你没有选择余地。
+
+Bell & LaPadula
+---------------
+
+从 20 世纪 80 年代中期到世纪之交，强制访问控制（MAC）一直与美国国防部标记
+纸质文件的 Bell & LaPadula 安全模型紧密关联。这种形式的 MAC 在 Capital
+Beltway 地区以及斯堪的纳维亚超级计算机中心拥有追随者，但也常被指未能满足
+通用需求。
+
+域类型强制（DTE）
+-----------------
+
+世纪之交前后，域类型强制（DTE）开始流行。此方案将用户、程序和数据组织进相
+互隔离的域中。该方案已作为流行 Linux 发行版的组成部分被广泛部署。然而，维
+护此方案所需的管理开销，以及提供安全域映射所需的对整个系统的深入理解，导致
+该方案在大多数情况下要么被禁用，要么仅以受限方式使用。
+
+Smack
+-----
+
+Smack 是一种强制访问控制机制，旨在提供有用的 MAC 功能，同时避免前人的缺陷。
+针对 Bell & LaPadula 的限制，Smack 通过提供一种方案使访问控制可以依据系统
+需求及目的灵活调整，而非受制于晦涩的政府政策。针对域类型强制的复杂性，Smack
+通过用已有的访问模式定义访问控制来加以避免。
+
+Smack 术语
+----------
+
+以下用于讨论 Smack 的术语，对接触过其他 MAC 系统的人来说会很熟悉，对初学者
+也不应太难掌握。其中四个术语有特定用法，尤为重要：
+
+  主体（Subject）：
+	主体是计算机系统上的活动实体。在 Smack 中，主体即任务（task），
+	任务又是执行的基本单元。
+
+  客体（Object）：
+	客体是计算机系统上的被动实体。在 Smack 中，各类文件、IPC 和任务
+	都可以是客体。
+
+  访问（Access）：
+	主体试图向客体写入信息或从客体读取信息的任何尝试都是一次访问。
+
+  标签（Label）：
+	标识主体或客体强制访问控制特征的数据。
+
+这些定义与安全社区中的传统用法一致。此外，还有一些来自 Linux 且可能频繁出
+现的术语：
+
+  能力（Capability）：
+	拥有某项能力的任务有权违反系统安全策略的某个特定方面，该方面由
+	该项具体能力所标识。拥有一项或多项能力的任务是特权任务，而没有
+	任何能力的任务是非特权任务。
+
+  特权（Privilege）：
+	被允许违反系统安全策略的任务称为拥有特权。截至本文撰写时，任务
+	可以通过拥有 capabilities 或者拥有 root 的有效用户来获得特权。
+
+Smack 基础
+----------
+
+Smack 是对 Linux 系统的扩展。它根据附加在主体和客体上的标签，对哪些主体可
+以访问哪些客体施加额外的限制。
+
+标签
+~~~~
+
+Smack 标签是 ASCII 字符串。标签最长可达 255 个字符，但建议控制在 23 个字符
+以内。使用特殊字符（即字母或数字以外的任何字符）的单字符标签保留给 Smack
+开发团队使用。Smack 标签是无结构的、大小写敏感的，对标签执行的唯一操作是相
+等性比较。Smack 标签不能包含不可打印字符、"/"（斜线）、"\"（反斜线）、"'"
+（单引号）和 '"'（双引号）字符。
+
+Smack 标签不能以 '-' 开头。该字符保留给特殊选项使用。
+
+存在一些预定义的标签::
+
+	_ 	读作 "floor"，单个下划线字符。
+	^ 	读作 "hat"， 单个抑扬符号字符。
+	* 	读作 "star"，单个星号字符。
+	? 	读作 "huh"，  单个问号字符。
+	@ 	读作 "web"， 单个 at 符号字符。
+
+Smack 系统上的每个任务都会被分配一个标签。进程的 Smack 标签通常由系统初始
+化机制分配。
+
+访问规则
+~~~~~~~~
+
+Smack 使用 Linux 的传统访问模式。这些模式包括读（read）、执行（execute）、
+写（write），有时还包括追加（append）。有几种情况下访问模式可能不那么显而易
+见，包括：
+
+  信号（Signals）：
+	信号是从主体任务到客体任务的一次写操作。
+
+  Internet 域 IPC：
+	数据包的传输被视为从源任务到目标任务的一次写操作。
+
+Smack 根据主体所附标签及其试图访问的客体所附标签来限制访问。所强制执行的规
+则按优先级依次为：
+
+	1. 任何由标签为 "*" 的任务请求的访问一律拒绝。
+	2. 任何由标签为 "^" 的任务请求的读或执行访问一律允许。
+	3. 任何对标签为 "_" 的客体请求的读或执行访问一律允许。
+	4. 任何对标签为 "*" 的客体请求的访问一律允许。
+	5. 任何由任务对其标签相同的客体请求的访问一律允许。
+	6. 任何在已加载规则集中明确定义的访问请求一律允许。
+	7. 任何其他访问一律拒绝。
+
+Smack 访问规则
+~~~~~~~~~~~~~~
+
+借助 Smack 提供的隔离性，访问分离变得简单。同时也有许多有趣的场景，需要主体
+对不同标签的客体进行有限制的访问。一个例子是熟悉的敏感性间谍模型：从事高度
+机密项目的科学家可以阅读低密级文档，而她撰写的内容将会"诞生"为高密级。为
+了适应此类方案，Smack 包含了一种用于指定允许跨标签访问的规则机制。
+
+访问规则格式
+~~~~~~~~~~~~
+
+访问规则的格式为::
+
+	subject-label object-label access
+
+其中 subject-label 是任务的 Smack 标签，object-label 是被访问对象的 Smack
+标签，access 是一个指定所允许访问类型的字符串。访问规格说明中会查找以下描述
+访问模式的字母：
+
+	a:	表示应授予追加（append）访问权限。
+	r:	表示应授予读（read）访问权限。
+	w:	表示应授予写（write）访问权限。
+	x:	表示应授予执行（execute）访问权限。
+	t:	表示该规则请求 transmutation（标签转变）。
+	b:	表示该规则应报告用于 bring-up 调试。
+
+规格说明字母的大写形式同样有效。访问模式规格说明的顺序可以任意。以下是一些
+可接受规则的示例::
+
+	TopSecret Secret  rx
+	Secret    Unclass R
+	Manager   Game    x
+	User      HR      w
+	Snap      Crackle rwxatb
+	New       Old     rRrRr
+	Closed    Off     -
+
+以下是一些不可接受规则的示例::
+
+	Top Secret Secret     rx
+	Ace        Ace        r
+	Odd        spells     waxbeans
+
+标签中不允许包含空格。由于主体总是可以访问具有相同标签的文件，因此为此类情
+况指定规则没有意义。访问规格说明中只允许有效的字母（rwxatbRWXATB）和破折号
+（'-'）。破折号是占位符，因此 "a-r" 与 "ar" 相同。单独一个破折号用于指明不
+允许任何访问。
+
+应用访问规则
+~~~~~~~~~~~~
+
+Linux 的开发者很少定义全新的事物类型，通常是从其他系统中引入方案和概念。最
+常见的情况是，这些其他系统是 Unix 的变体。Unix 有许多讨人喜欢的特性，但访
+问控制模型的一致性并非其中之一。Smack 力求在尽可能保持一致地处理访问的同时，
+不失底层机制的精神。
+
+文件系统对象（包括文件、目录、命名管道、符号链接和设备）所需的访问权限与
+mode bit 访问所使用的权限紧密匹配。打开文件进行读取需要对文件具有读访问权限。
+搜索目录需要执行访问权限。创建文件并写访问需要对包含目录具有读写访问权限。
+删除文件需要对文件以及包含目录具有读写访问权限。用户可能能够看到某个文件存
+在，但由于对包含目录具有读访问权限而对具有不同标签的文件没有读访问权限，因
+此看不到它的任何属性。这是文件名作为目录中的数据而非文件一部分所带来的现象。
+
+如果目录被标记为 transmuting（SMACK64TRANSMUTE=TRUE），并且某访问规则允许
+进程在该目录中创建对象且该规则包含 't' 访问模式，则新对象将被赋予目录的标
+签而非创建进程的标签。这使得两个拥有不同标签的进程更容易共享数据，而无需授
+予对彼此所有文件的访问权限。
+
+IPC 对象（消息队列、信号量集合和内存段）存在于扁平的名字空间中，访问请求只
+需与目标对象匹配即可。
+
+进程对象反映系统上的任务，用于访问它们的 Smack 标签与任务用于自身访问尝试
+的 Smack 标签相同。通过 kill() 系统调用发送信号是从发送者到接收者的一次写
+操作。调试进程需要读写两种访问权限。创建新任务是一个内部操作，会产生两个具
+有相同 Smack 标签的任务，并且无需访问检查。
+
+套接字（Socket）是附加在进程上的数据结构，从一个进程向另一个进程发送数据包
+要求发送者对接收者具有写访问权限。接收者不需要对发送者具有读访问权限。
+
+设置访问规则
+~~~~~~~~~~~~
+
+配置文件 /etc/smack/accesses 包含需要在系统启动时设置的规则。其内容会被写
+入特殊文件 /sys/fs/smackfs/load2。规则可以随时添加并立即生效。对于任意一对
+主体标签和客体标签，只能存在一条规则，最后指定的规则将覆盖之前的规定。
+
+任务属性
+~~~~~~~~
+
+进程的 Smack 标签可以从 ``/proc/<pid>/attr/current`` 读取。进程可以从
+``/proc/self/attr/current`` 读取自身的 Smack 标签。特权进程可以通过向
+``/proc/self/attr/current`` 写入来更改自身的 Smack 标签，但不能更改其他进程
+的标签。
+
+写入格式为：仅写入标签本身，或者标签后跟以下三种尾部字符之一：``\n``
+（根据 ``/proc/...`` 接口的通用约定）、``\0`` （因为某些应用程序会错误地包含
+它）、``\n\0`` （因为我们认为某些应用程序可能会错误地包含它）。
+
+文件属性
+~~~~~~~~
+
+文件系统对象的 Smack 标签以扩展属性形式存储在文件上，属性名为 SMACK64。此
+属性位于 security 名字空间。只能由具有特权的进程更改。
+
+特权
+~~~~
+
+拥有 CAP_MAC_OVERRIDE 或 CAP_MAC_ADMIN 的进程是特权进程。CAP_MAC_OVERRIDE
+允许进程访问原本会被拒绝的客体。CAP_MAC_ADMIN 允许进程更改 Smack 数据，包括
+规则和属性。
+
+Smack 网络
+~~~~~~~~~~
+
+如前所述，Smack 对网络协议传输强制执行访问控制。Smack 进程发送的每个数据包
+都带有其 Smack 标签。这是通过在 IP 数据包头部添加 CIPSO 标签实现的。每个接
+收的数据包都应有一个标识标签的 CIPSO 标签，如果没有，则假定为网络环境标签。
+在数据包投递之前，会检查数据包上标签对应的主体是否对接收进程具有写访问权限，
+如果不满足，数据包将被丢弃。
+
+CIPSO 配置
+~~~~~~~~~~
+
+通常不需要指定 CIPSO 配置。系统使用的默认值可以处理所有内部情况。Smack 会
+自动组合 CIPSO 标签值以匹配正在使用的 Smack 标签，无需管理员干预。进入系统
+的未标记数据包将被赋予环境标签。
+
+当可能遇到来自非 Smack 但支持 CIPSO 的系统时，Smack 需要额外配置。通常这
+会是 Trusted Solaris 系统，但还有其他较少部署的系统存在。CIPSO 为每个数据包
+提供 3 个重要值：解释域（DOI）、级别（level）和类别集（category set）。DOI
+用于标识一组使用兼容标记方案的系统，Smack 系统上指定的 DOI 必须与远程系统
+匹配，否则数据包将被丢弃。DOI 的默认值为 3。该值可以从 /sys/fs/smackfs/doi
+读取，也可以通过写入 /sys/fs/smackfs/doi 来更改。
+
+标签和类别集被映射为 /etc/smack/cipso 中定义的 Smack 标签。
+
+Smack/CIPSO 映射的形式为::
+
+	smack level [category [category]*]
+
+Smack 不要求 level 或 category 集合以任何特定方式相互关联，也不基于它们假
+定或分配访问权限。一些映射示例::
+
+	TopSecret 7
+	TS:A,B    7 1 2
+	SecBDE    5 2 4 6
+	RAFTERS   7 12 26
+
+Smack 标签中允许使用 ":" 和 "," 字符，但没有特殊含义。
+
+Smack 标签到 CIPSO 值的映射通过写入 /sys/fs/smackfs/cipso2 来定义。
+
+除显式映射外，Smack 还支持直接 CIPSO 映射。其中一个 CIPSO 级别用于指示数据
+包中传递的类别集实际上是 Smack 标签的编码。默认使用的级别是 250。该值可以
+从 /sys/fs/smackfs/direct 读取，并通过写入 /sys/fs/smackfs/direct 来更改。
+
+套接字属性
+~~~~~~~~~~
+
+有两个属性与套接字相关联。这些属性只能由特权任务设置，但任何任务都可以读取
+自己套接字的这些属性。
+
+  SMACK64IPIN：
+	任务对象的 Smack 标签。一个将强制执行策略的特权程序可以将其设置
+	为 star 标签。
+
+  SMACK64IPOUT：
+	随传出数据包传输的 Smack 标签。特权程序可以将其设置为希望与之通
+	信的另一个任务的标签。
+
+带有 BSD 地址的 UNIX 域套接字（UDS）既是文件系统中的文件也是套接字。作为文
+件，它携带 SMACK64 属性。此属性不参与 Smack 安全强制执行，并被不可变地分配
+标签 "*"。
+
+Smack Netlabel 例外
+~~~~~~~~~~~~~~~~~~~
+
+你会发现带有标签的应用程序经常需要与外部未标记的世界通信。为此，有一个特殊
+文件 /sys/fs/smackfs/netlabel，你可以在其中添加例外，格式为::
+
+	@IP1	   LABEL1 或
+	@IP2/MASK  LABEL2
+
+这意味着，如果你的应用程序对 LABEL1 具有写访问权限，则它将对 @IP1 具有未标
+记访问权限；如果它对 LABEL2 具有写访问权限，则将对子网 @IP2/MASK 具有访问
+权限。
+
+/sys/fs/smackfs/netlabel 文件中的条目按最长掩码优先进行匹配，类似于无类别
+IPv4 路由。
+
+其中还可以使用特殊标签 '@' 和选项 '-CIPSO'::
+
+	@      表示互联网，任何标签的应用程序都可以访问它
+	-CIPSO 表示标准 CIPSO 网络
+
+如果你不知道 CIPSO 是什么并且不打算使用它，只需执行::
+
+	echo 127.0.0.1 -CIPSO > /sys/fs/smackfs/netlabel
+	echo 0.0.0.0/0 @      > /sys/fs/smackfs/netlabel
+
+如果在 192.168.0.0/16 局域网中使用 CIPSO 同时还需要未标记的互联网访问::
+
+	echo 127.0.0.1      -CIPSO > /sys/fs/smackfs/netlabel
+	echo 192.168.0.0/16 -CIPSO > /sys/fs/smackfs/netlabel
+	echo 0.0.0.0/0      @      > /sys/fs/smackfs/netlabel
+
+为 Smack 编写应用程序
+---------------------
+
+在 Smack 系统上将运行三类应用程序。应用程序如何与 Smack 交互，决定了它需要
+做些什么才能在 Smack 下正常工作。
+
+不了解 Smack 的应用程序
+-----------------------
+
+绝大多数应用程序完全不需要关心 Smack 的独特属性。由于调用程序不会影响与进程
+关联的 Smack 标签，唯一可能引起关注的是进程是否对程序具有执行访问权限。
+
+了解 Smack 的应用程序
+---------------------
+
+有些程序可以通过了解 Smack 而变得更好用，但它们本身不做安全决策。ls(1) 命令
+就是这样一个程序的例子。
+
+强制执行 Smack 的应用程序
+-------------------------
+
+这些是特殊的程序，不仅了解 Smack，还参与系统策略的执行。在大多数情况下，这
+些是设置用户会话的程序。还有一些网络服务，为以不同标签运行的进程提供信息。
+
+文件系统接口
+------------
+
+Smack 使用扩展属性在文件系统对象上维护标签。可以使用 getxattr(2) 获取文件、
+目录或其他文件系统对象的 Smack 标签::
+
+	len = getxattr("/", "security.SMACK64", value, sizeof (value));
+
+将把根目录的 Smack 标签放入 value 中。特权进程可以使用 setxattr(2) 设置文件
+系统对象的 Smack 标签::
+
+	len = strlen("Rubble");
+	rc = setxattr("/foo", "security.SMACK64", "Rubble", len, 0);
+
+如果程序具有适当特权，将把 /foo 的 Smack 标签设置为 "Rubble"。
+
+套接字接口
+----------
+
+可以使用 fgetxattr(2) 读取套接字属性。
+
+特权进程可以使用 fsetxattr(2) 设置传出数据包的 Smack 标签::
+
+	len = strlen("Rubble");
+	rc = fsetxattr(fd, "security.SMACK64IPOUT", "Rubble", len, 0);
+
+如果程序具有适当特权，将把从该套接字发出的数据包的 Smack 标签设置为
+"Rubble"::
+
+	rc = fsetxattr(fd, "security.SMACK64IPIN, "*", strlen("*"), 0);
+
+如果程序具有适当特权，将把 Smack 标签 "*" 设置为检查传入数据包的客体标签。
+
+管理
+----
+
+Smack 支持一些挂载选项：
+
+  smackfsdef=label:
+	指定分配给缺少 Smack 标签扩展属性的文件的标签。
+
+  smackfsroot=label:
+	指定分配给文件系统根目录的标签（如果它缺少 Smack 扩展属性）。
+
+  smackfshat=label:
+	指定一个标签，该标签必须对文件系统上设置的所有标签具有读访问权限。
+	尚未强制执行。
+
+  smackfsfloor=label:
+	指定一个标签，文件系统上设置的所有标签必须对其具有读访问权限。
+	尚未强制执行。
+
+  smackfstransmute=label:
+	行为与 smackfsroot 完全一致，只是在挂载的根目录上同时设置
+	transmute 标志。
+
+这些挂载选项适用于所有文件系统类型。
+
+Smack 审计
+----------
+
+如果需要对安全事件进行 Smack 审计，需要在内核配置中设置 CONFIG_AUDIT。
+默认情况下，所有被拒绝的事件都会被审计。可以通过向 /sys/fs/smackfs/logging
+文件写入单个字符来更改此行为::
+
+	0 : 不记录日志
+	1 : 记录被拒绝的事件（默认）
+	2 : 记录被接受的事件
+	3 : 记录被拒绝和被接受的事件
+
+事件以 'key=value' 对的形式记录。对于每个事件，至少会得到主体、客体、请求
+的权限、动作、触发事件的内核函数，以及根据审计事件类型而定的其他键值对。
+
+Bringup 模式
+------------
+
+Bringup 模式提供了日志记录功能，可以使应用程序配置和系统 bringup 更加容易。
+在内核中配置 CONFIG_SECURITY_SMACK_BRINGUP 以启用这些功能。启用 bringup 模
+式后，由于标记了 "b" 访问模式的规则而成功的访问将被记录。当为进程引入新标签
+时，可以积极地添加标记了 "b" 的规则。日志记录使你可以跟踪哪些规则实际上被用
+于该标签。
+
+Bringup 模式的另一个功能是 "unconfined" 选项。向 /sys/fs/smackfs/unconfined
+写入一个标签，将使具有该标签的主体能够访问任何客体，同时使具有该标签的客体
+能被所有主体访问。任何由于标签被设置为 unconfined 而被允许的访问都将被记录。
+此功能是危险的，因为文件和目录可能会在策略正常执行时不允许的位置被创建。
-- 
2.43.0

