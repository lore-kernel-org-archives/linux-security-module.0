Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69630EF89;
	Fri, 12 Jun 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279991; cv=none; b=qucZHti3oogQIsre/Njza8041EtarDQRGVaKTdAZiGOvkDNgDLgqNgTRwdJGoYmIo0xqAvIq7VU0CFiOR2eVq0lu4g+ev8o9zi9BN4vT+3ukgnJ52FlwXcJGJCI/mW6JwgGcfbfvbyBRL0ijVDBhn5CNCr0VdWOxKdeV4LLBdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279991; c=relaxed/simple;
	bh=ly9QLdgBPdoAKdFjNQD+GL8QWOswAZLgv/73pnjAgcc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD3OpshqeHFjm29Hw2BoA40MT/Ij/rwV5xl7lyqad9xYfHGU55PmydU6GHci7HmsDCxAPI+ESyRtrj+sVsCdQpdr/9VSwHBDbNbwhg+1zq+HVRuVgsZRcD/s+nZya6CAYZFuYqEJz43cG6/jppecwLC4gkFSW3fPk1t4mZIR7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GDZq3Nwu; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GDZq3Nwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279981; bh=u8N2UIIg42+tsB2D83Me3JhRE1prNdOAMGaRtzvXPCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GDZq3NwudUXxLL3mURuLCJnWFgSFu00HWEZqu2K5ymejkIzMvQfwcMycmxid9ZLWZ
	 eqqg1LrYtW8YRLWQOpjLIMWiiYxn5OdelUQ+cQ1mG7jWpPRCjNjZTx9CRCYc9LqL2W
	 33TZnKpzGfs0R6t2en5FsFxKjJXma2XW7bcmlfnw=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279978t7n33v31x
Message-ID: <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
X-QQ-XMAILINFO: N7oYokiVZ6fqPnGlzoY+6869MiZm6URxlPBnRDx11AAGxka7edsvAhKahSJF7g
	 bQ+/iwcdpf+EQ0IUBSlnvlRPY9XBYiu1jlrQ7yomFPCYwuZWNz6Rst33lhWCDxrvWlbCOPlBCRvb
	 XxpJvqT6WUOjfkDtSWIo3lBYV9F7T/ZyIpo0h4+N9pleueCjrvcBz5bg8SxEF2HBSkZ4MUxYnL9P
	 Al0gd8QGIBuj+AlnDsOxybWFbVfg+E7KMOoJYC0Vth9oaJLnGCxviUu35YkGnd57skBUD6atbJAo
	 cutBoaUTHhNVgEcuehugzC5JJGZlwOjx63Nq1/09Q2N+fMQizwJxRskGKjj29mGT/su/kIhB6Ps2
	 tVc7yoOAEgYvLTp+WbWZOroAyh0q7FaanDBFUQceUNljpoql5h++ft3EttNYjEr1V3AYKiVI4fVm
	 wrqPWEGqgybZ8IibDTQTtQKdcl8E1G0FKep7JdZAYkMWvCScTFuaBmiLwXJKWEkuP7ytsUFmtkjP
	 Hwxh1UIZ5+PpUeIIp1uU+VP1txjxjCV6qwouExct5cgXXc0GTMVR/uBK8D8WpPrPaADcGa94ktU+
	 2sL5F6woOAoL3N52ORnMpWKIQd7UcDQ6BL3+6YBKUbKsj+3x0urfM5Ci5Yawc/diCfZ+0KGdkFzX
	 aXuHsqyMizr65MwclCfkF55MpwfZhOd8PIsQZZMJ65QHk4wrOCMSYMFWeoPB0vm2ojwLDiWbgvve
	 pm0Wgw3/Vhz8EnFcMLIzz2DOB8SPmYBNTfNRfBBt+PEdyCRUv3aUEU3354bz/44yUlQoyLUMV6oW
	 lbUcOW/d1lTlnEsMarHtLs5i04dGqP8e5CV7IgJoPVnMvr4+9jrK6thXU+FwTCyCNB960vWAklcG
	 TGJRqENF9Qi8BDO4KHmt40rHgPNONGCf4fZkh5pS/qT4EJb74dQu7CxSPeW0O09YOazhd49ETUVL
	 ZhTZgpkJUim5/m5lzYuSelxKaxq8Rog7XJn8BG5+tIxShoahovcKOI13dKVgNcAy2T8ZGz9W3l+F
	 5cOrPXSTIB7FKweBHa/jFpv7WJMoX9qn1OnUCVPxWBwmUQ93r432zlrj82bSM2am+W/Wbp+jHcag
	 F2vft7ntdyIK/5mBaUA9j+8lonoc7k3D97kK7Ji/ft++KIgYcNkNLN2Okfc5Yh+IvPIskSb6w4fG
	 6QhaXKN5EGFDudyr9WPm8DIs1tYa+V2qUaGPA0bJvxoC9IWg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH 09/10] docs/zh_CN: add LSM/ipe Chinese translation
Date: Fri, 12 Jun 2026 23:58:28 +0800
X-OQ-MSGID: <34599ac92b47af7b8acf319a71e870daeac92a89.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/ipe.rst into Chinese.

Update the translation through commit d7ba853c0e47
("ipe: Update documentation for script enforcement")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/ipe.rst             | 723 ++++++++++++++++++
 1 file changed, 723 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst b/Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst
new file mode 100644
index 000000000000..08af2d03d400
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst
@@ -0,0 +1,723 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/ipe.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+==================================
+Integrity Policy Enforcement (IPE)
+==================================
+
+.. NOTE::
+
+   本文档面向管理员、系统构建者或尝试使用 IPE 的个人。如需面向开发者的 IPE 文
+   档，请参阅 :doc:`设计文档 </security/ipe>`。
+
+概览
+----
+
+Integrity Policy Enforcement (IPE) 是一种 Linux 安全模块，采用与传统访问控制
+互补的方式。不同于依赖标签和路径进行决策的传统访问控制机制，IPE 关注系统组件
+固有的不可变安全属性。这些属性是系统组件的基本特征或特性，无法被更改，从而为
+安全决策提供一致且可靠的基础。
+
+具体而言，在 IPE 的语境中，系统组件主要指文件或这些文件所在的设备。但这只是个
+起点。系统组件的概念是灵活的，可以随着系统演进而扩展以涵盖新的元素。不可变属
+性包括文件的来源，它随时间保持不变且不可更改。例如，IPE 策略可以被设计为信任
+来自 initramfs 的文件。由于 initramfs 通常由引导加载程序验证，其中的文件被认
+为是可信的；因而 "文件来自initramfs" 成为 IPE 考量的不可变属性。
+
+不可变属性的概念还延伸到文件来源上启用的安全特性，例如 dm-verity 或
+fs-verity，它们提供了完整性与信任的附加层。例如，IPE 允许定义信任来自
+dm-verity 保护设备的文件的策略。dm-verity 通过提供可验证且不可变的内容状态来
+确保整个设备的完整性。类似地，fs-verity 提供文件系统级别的完整性检查，允许
+IPE 强制执行信任受 fs-verity 保护的文件的策略。这两项特性一旦建立便无法关闭，
+因此被视为不可变属性。这些示例展示了 IPE 如何利用不可变属性（如文件来源及其完
+整性保护机制）来进行访问控制决策。
+
+具体而言，IPE 策略通过依据策略中定义的参考值评估安全属性，来实施严格的访问控
+制。评估既可以基于安全属性的存在与否（如验证文件是否源自 initramfs），也可以
+评估不可变安全属性的内部状态。后者包括检查 dm-verity 保护设备的 roothash、判
+断 dm-verity 是否拥有有效签名、评估 fs-verity 保护文件的摘要、或判断
+fs-verity 是否拥有有效的内建签名。这种精细的策略执行方法实现了高度安全且可定
+制的系统防御机制，能够适应特定的安全需求和信任模型。
+
+要启用 IPE，请确保在 :menuselection:`Security --> Integrity Policy
+Enforcement (IPE)` 下的 ``CONFIG_SECURITY_IPE`` 配置选项已打开。
+
+使用场景
+--------
+
+IPE 最适用于固定功能设备：即用途明确定义且不应更改的设备（如数据中心的网络防
+火墙设备、IoT 设备等），其中所有软件和配置均由系统所有者构建和部署。
+
+IPE 在通用计算领域还有很长的路要走：Linux 社区整体倾向于采用去中心化的信任模
+型（即 web of trust），而 IPE 目前尚不支持此模型。相反，IPE 支持 PKI（公钥基
+础设施），通常指定一组受信任的实体来提供一定程度的绝对信任。
+
+此外，虽然当今大多数软件包已经过签名，但包内的文件（例如可执行文件）通常未签
+名。这使得在需要包管理器正常工作的系统中难以利用 IPE，除非对包管理器及其背后
+的生态系统进行重大更改。
+
+digest_cache LSM [#digest_cache_lsm]_ 是一个系统，当与 IPE 结合使用时，可
+用于启用和支持通用计算场景。
+
+已知限制
+--------
+
+IPE 无法验证匿名可执行内存的完整性，例如 gcc 闭包和 libffi (<3.4.2) 创建的跳
+转表，或 JIT 编译的代码。不幸的是，由于这些是动态生成的代码，IPE 无法确保其完
+整性从而形成信任基础。
+
+IPE 无法验证解释型语言的程序完整性，当这些脚本通过以解释器传递程序文件的方式
+被调用时。这是因为解释器执行这些文件的方式所致；脚本本身并不通过 IPE 的任一钩
+子被评估为可执行代码，它们只是作为文本文件被读取（与已编译的可执行文件相对）。
+然而，随着 ``AT_EXECVE_CHECK`` 标志的引入
+(:doc:`AT_EXECVE_CHECK </userspace-api/check_exec>`)，解释器可以使用它来通知
+内核一个脚本文件即将被执行，并请求内核对其执行 LSM 安全检查。
+
+IPE 的 EXECUTE 操作执行策略在已编译可执行文件和解释型脚本之间有所不同：对于已
+编译可执行文件，执行检查在内核执行 ``execve()``、``execveat()``、``mmap()``
+和 ``mprotect()`` 系统调用加载可执行内容时自动触发。对于解释型脚本，执行检查
+需要解释器显式集成，使用带 ``AT_EXECVE_CHECK`` 标志的 ``execveat()``。与 IPE
+在执行过程中拦截的 exec 系统调用不同，这一机制需要解释器主动配合，除非加入信
+号调用，否则现有解释器不会自动获得支持。
+
+威胁模型
+--------
+
+IPE 专门针对内核初始引导后用户空间可执行代码被篡改的风险，包括通过
+``modprobe`` 或 ``insmod`` 从用户空间加载的内核模块。
+
+举例说明，设想一个场景：一个不受信任的二进制文件（可能是恶意的）连同各种必要
+的依赖项（包括加载器和 libc）一起被下载。IPE 在此场景中的主要功能是阻止此类二
+进制文件及其依赖项的执行。
+
+IPE 通过在执行前验证所有可执行代码的完整性和真实性来实现这一目标。它进行彻底
+的检查，确保代码的完整性完好无损，并且代码与既定策略中授权的参考值（摘要、签
+名等）匹配。如果二进制文件未通过此验证过程——无论是因其完整性受到破坏还是不符
+合授权条件——IPE 将拒绝其执行。此外，IPE 还会生成审计日志，可用于检测和分析因
+策略违规而导致的失败。
+
+篡改威胁场景包括各类行为者对可执行代码的修改或替换，包括：
+
+-  对硬件有物理访问权限的行为者
+-  对系统有本地网络访问权限的行为者
+-  对部署系统有访问权限的行为者
+-  处于外部控制下的受感染内部系统
+-  系统的恶意终端用户
+-  系统受感染的终端用户
+-  系统的远程（外部）入侵
+
+IPE 不缓解来自恶意但已获授权的开发者（持有签名证书），或其使用的受感染开发工
+具（即面向返回编程攻击）所带来的威胁。此外，IPE 在用户空间与内核空间之间划定
+了硬安全边界。因此，内核级别的漏洞利用被视为IPE 范围之外，应由其他机制来缓解。
+
+策略
+----
+
+IPE 策略是一种纯文本 [#devdoc]_ 格式，由多条分布在多行上的语句组成。策略顶部
+有一行必需的内容，用于指明策略名称和策略版本，例如::
+
+   policy_name=Ex_Policy policy_version=0.0.0
+
+策略名称唯一键值，以人类可读的名称标识该策略。它用于在 securityfs 下创建节点，
+以及唯一标识策略以部署新策略或更新现有策略。
+
+策略版本表示策略的当前版本（**非** 策略语法版本）。用于防止将策略回滚到可能不
+安全的旧版本。
+
+IPE 策略的下一部分是规则。规则由 ``key=value`` 对组成，称为属性。IPE 规则需
+要两个属性：``action`` 决定了 IPE 在匹配到该规则时的行为，以及 ``op`` 决定了
+该规则何时应该被评估。顺序很重要，规则必须以 ``op`` 开头，以 ``action`` 结尾。
+因此，最小规则是::
+
+   op=EXECUTE action=ALLOW
+
+此示例将允许任何执行。其他属性用于评估被评估文件的不可变安全属性。这些属性旨
+在描述内核中能够提供完整性验证度量的系统，使得 IPE 能够根据属性的取值来判断资
+源的可信度。
+
+规则从上到下进行评估。因此，任何撤销规则或拒绝规则应放在文件的较早位置，以确
+保这些规则在带有 ``action=ALLOW`` 的规则之前被评估。
+
+IPE 策略支持注释。字符 '#' 起到注释的作用，忽略 '#' 右侧直到换行符之前的所有
+字符。
+
+IPE 评估的默认行为也可以通过 ``DEFAULT`` 语句在策略中表达。可以在全局级别或
+按操作级别设置::
+
+   # 全局
+   DEFAULT action=ALLOW
+
+   # 按操作级别
+   DEFAULT op=EXECUTE action=ALLOW
+
+必须为 IPE 中所有已知操作设置默认值。如果您希望保留旧策略与新内核的兼容性（新
+内核可能引入新操作），可以设置 ``ALLOW`` 的全局默认值，然后在每个操作的基础上
+覆盖默认值（如上所示）。
+
+对于基于可配置策略的 LSM，在启动时实施可配置策略存在若干问题，围绕策略的读取
+和解析：
+
+1. 内核 **不应** 从用户空间读取文件，因此直接读取策略文件是被禁止的。
+2. 内核命令行有字符长度限制，一个内核模块不应为自身配置占用整个字符限制。
+3. 内核生态系统中存在各种引导加载程序，因此通过传递内存块的方式成本高昂，难以
+   维护。
+
+为此，IPE 通过 "boot policy" 的概念来解决这个问题。启动策略是一份编译进内核
+的最小策略。该策略旨在将系统引导至用户空间已设置好并可以接收命令的状态，届时
+可以通过 securityfs 部署更复杂的策略。启动策略可以通过
+``SECURITY_IPE_BOOT_POLICY`` 配置选项指定，该选项接受要应用的 IPE 策略纯文本
+版本的路径。此策略将被编译进内核。如果未指定，IPE 将保持禁用状态，直到通过
+securityfs 部署并激活策略。
+
+部署策略
+~~~~~~~~
+
+策略可以通过 securityfs 从用户空间部署。这些策略通过 PKCS#7 消息格式进行签名，
+以实施某种程度的策略授权（防止攻击者获得无限制的 root 权限并部署 "allow all"
+策略）。这些策略必须由可链至 ``SYSTEM_TRUSTED_KEYRING`` 的证书签名，或者如果
+分别启用了 ``CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING`` 和/或
+``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING``，则可链至次级和/或平台密钥环。使
+用 openssl，可以通过以下命令对策略进行签名::
+
+   openssl smime -sign \
+      -in "$MY_POLICY" \
+      -signer "$MY_CERTIFICATE" \
+      -inkey "$MY_PRIVATE_KEY" \
+      -noattr \
+      -nodetach \
+      -nosmimecap \
+      -outform der \
+      -out "$MY_POLICY.p7b"
+
+部署策略通过 securityfs 的 ``new_policy`` 节点完成。要部署策略，只需将文件内
+容 cat 到 securityfs 节点::
+
+   cat "$MY_POLICY.p7b" > /sys/kernel/security/ipe/new_policy
+
+成功后，这将在 ``/sys/kernel/security/ipe/policies/`` 下创建一个子目录。该子
+目录将是所部署策略的 ``policy_name`` 字段，因此对于上述示例，目录将是
+``/sys/kernel/security/ipe/policies/Ex_Policy``。在该目录中，将包含七个文件:
+``pkcs7``、``policy``、``name``、``version``、``active``、``update`` 和
+``delete``。
+
+``pkcs7`` 文件为只读。读取它将返回提供给内核的原始 PKCS#7 数据，即策略的表示。
+如果正在读取的是启动策略，将返回 ``ENOENT``，因为它未经签名。
+
+``policy`` 文件为只读。读取它将返回 PKCS#7 的内部内容，即纯文本策略。
+
+``active`` 文件用于将某个策略设置为当前活动策略。此文件可读写，接受值 ``"1"``
+以将策略设置为活动状态。由于同一时间只能有一个策略处于活动状态，所有其他策略
+将被标记为非活动。被标记为活动的策略必须具有大于或等于当前运行版本的策略版本。
+
+``update`` 文件用于更新内核中已存在的策略。此文件为只写，接受 PKCS#7 签名的
+策略。对此策略将始终执行两项检查：第一，``policy_names`` 必须在更新版本和现有
+版本之间匹配。第二，更新策略的版本必须大于当前运行版本的策略版本。这是为了防
+止回滚攻击。
+
+``delete`` 文件用于删除不再需要的策略。此文件为只写，接受值 ``1`` 以删除策略。
+删除时，代表该策略的 securityfs 节点将被移除。但是，不允许删除当前活动策略，
+将返回操作不允许的错误。
+
+类似地，写入 ``update`` 和 ``new_policy`` 可能导致错误消息（策略语法错误）或
+文件存在错误。后一种错误发生在尝试部署具有某 ``policy_name`` 的策略时，而内核
+中已部署了具有相同 ``policy_name`` 的策略。
+
+部署策略 **不会** 导致 IPE 开始强制执行该策略。IPE 只会强制执行标记为活动的
+策略。请注意，同一时间只能有一个策略处于活动状态。
+
+部署成功后，可以通过写入文件
+``/sys/kernel/security/ipe/policies/$policy_name/active`` 来激活策略。例如，
+可以通过以下命令激活 ``Ex_Policy``::
+
+   echo 1 > "/sys/kernel/security/ipe/policies/Ex_Policy/active"
+
+从此刻起，``Ex_Policy`` 成为系统上强制执行的策略。
+
+IPE 还提供了删除策略的方法。这可以通过 ``delete`` securityfs 节点
+``/sys/kernel/security/ipe/policies/$policy_name/delete`` 来完成。
+向该文件写入 ``1`` 以删除策略::
+
+   echo 1 > "/sys/kernel/security/ipe/policies/$policy_name/delete"
+
+删除策略只有一个要求：被删除的策略必须处于非活动状态。
+
+.. NOTE::
+
+   如果启用了传统 MAC 系统（SELinux、apparmor、smack），所有对 IPE
+   securityfs 节点的写入都需要 ``CAP_MAC_ADMIN``。
+
+模式
+~~~~
+
+IPE 支持两种操作模式：宽松模式（permissive，类似 SELinux 的 permissive 模式）
+和强制模式（enforced）。在宽松模式下，所有事件都会被检查，策略违规会被记录，
+但策略不会真正被强制执行。这允许用户在强制执行之前先测试策略。
+
+默认模式为强制模式（enforce），可以通过内核命令行参数 ``ipe.enforce=(0|1)``
+或 securityfs 节点 ``/sys/kernel/security/ipe/enforce`` 进行更改。
+
+.. NOTE::
+
+   如果启用了传统 MAC 系统（SELinux、apparmor、smack 等），所有对
+   IPE securityfs 节点的写入都需要 ``CAP_MAC_ADMIN``。
+
+审计事件
+~~~~~~~~
+
+1420 AUDIT_IPE_ACCESS
+^^^^^^^^^^^^^^^^^^^^^
+事件示例::
+
+   type=1420 audit(1653364370.067:61): ipe_op=EXECUTE ipe_hook=MMAP enforcing=1 pid=2241 comm="ld-linux.so" path="/deny/lib/libc.so.6" dev="sda2" ino=14549020 rule="DEFAULT action=DENY"
+   type=1300 audit(1653364370.067:61): SYSCALL arch=c000003e syscall=9 success=no exit=-13 a0=7f1105a28000 a1=195000 a2=5 a3=812 items=0 ppid=2219 pid=2241 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=2 comm="ld-linux.so" exe="/tmp/ipe-test/lib/ld-linux.so" subj=unconfined key=(null)
+   type=1327 audit(1653364370.067:61): 707974686F6E3300746573742F6D61696E2E7079002D6E00
+
+   type=1420 audit(1653364735.161:64): ipe_op=EXECUTE ipe_hook=MMAP enforcing=1 pid=2472 comm="mmap_test" path=? dev=? ino=? rule="DEFAULT action=DENY"
+   type=1300 audit(1653364735.161:64): SYSCALL arch=c000003e syscall=9 success=no exit=-13 a0=0 a1=1000 a2=4 a3=21 items=0 ppid=2219 pid=2472 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=2 comm="mmap_test" exe="/root/overlake_test/upstream_test/vol_fsverity/bin/mmap_test" subj=unconfined key=(null)
+   type=1327 audit(1653364735.161:64): 707974686F6E3300746573742F6D61696E2E7079002D6E00
+
+此事件表明 IPE 做出了访问控制决策；IPE 特有记录 (1420) 始终与
+``AUDITSYSCALL`` 记录一起发出。
+
+可以通过 ``AUDITSYSCALL`` 记录的 ``success`` 属性和退出码来判断 IPE 处于宽松
+模式还是强制模式。
+
+字段说明:
+
++-----------+----------+--------+--------------------------------------------+
+| 字段      | 值类型   | 可选?  | 值说明                                     |
++===========+==========+========+============================================+
+| ipe_op    | string   | 否     | 与日志关联的 IPE 操作名称                  |
++-----------+----------+--------+--------------------------------------------+
+| ipe_hook  | string   | 否     | 触发 IPE 事件的 LSM 钩子名称               |
++-----------+----------+--------+--------------------------------------------+
+| enforcing | integer  | 否     | 当前 IPE 强制执行状态,1:强制模式,0:宽松模式|
++-----------+----------+--------+--------------------------------------------+
+| pid       | integer  | 否     | 触发 IPE 事件的进程 PID                    |
++-----------+----------+--------+--------------------------------------------+
+| comm      | string   | 否     | 触发 IPE 事件的进程命令行程序名            |
++-----------+----------+--------+--------------------------------------------+
+| path      | string   | 是     | 被评估文件的绝对路径                       |
++-----------+----------+--------+--------------------------------------------+
+| ino       | integer  | 是     | 被评估文件的 inode 号                      |
++-----------+----------+--------+--------------------------------------------+
+| dev       | string   | 是     | 被评估文件的设备名,如 vda                  |
++-----------+----------+--------+--------------------------------------------+
+| rule      | string   | 否     | 匹配的策略规则                             |
++-----------+----------+--------+--------------------------------------------+
+
+
+1421 AUDIT_IPE_CONFIG_CHANGE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+事件示例::
+
+   type=1421 audit(1653425583.136:54): old_active_pol_name="Allow_All" old_active_pol_version=0.0.0 old_policy_digest=sha256:E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855 new_active_pol_name="boot_verified" new_active_pol_version=0.0.0 new_policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1
+   type=1300 audit(1653425583.136:54): SYSCALL arch=c000003e syscall=1 success=yes exit=2 a0=3 a1=5596fcae1fb0 a2=2 a3=2 items=0 ppid=184 pid=229 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=4294967295 comm="python3" exe="/usr/bin/python3.10" key=(null)
+   type=1327 audit(1653425583.136:54): PROCTITLE proctitle=707974686F6E3300746573742F6D61696E2E7079002D66002E2
+
+此事件表明 IPE 将活动策略从一个切换到了另一个，同时记录了这两个策略的版本和哈
+希摘要。请注意，IPE 同一时间只能有一个活动策略，所有访问决策评估均基于当前活
+动策略。部署新策略的常规流程是先将策略加载到内核中，然后再将活动策略切换至它。
+
+此记录始终与 ``write`` 系统调用的 ``AUDITSYSCALL`` 记录一起发出。
+
+字段说明:
+
++------------------------+-----------+--------+----------------------------+
+| 字段                   | 值类型    | 可选？ | 值说明                     |
++========================+===========+========+============================+
+| old_active_pol_name    | string    | 是     | 前一个活动策略的名         |
++------------------------+-----------+--------+----------------------------+
+| old_active_pol_version | string    | 是     | 前一个活动策略的版本       |
++------------------------+-----------+--------+----------------------------+
+| old_policy_digest      | string    | 是     | 前一个活动策略的哈希值     |
++------------------------+-----------+--------+----------------------------+
+| new_active_pol_name    | string    | 否     | 当前活动策略的名称         |
++------------------------+-----------+--------+----------------------------+
+| new_active_pol_version | string    | 否     | 当前活动策略的版本         |
++------------------------+-----------+--------+----------------------------+
+| new_policy_digest      | string    | 否     | 当前活动策略的哈希值       |
++------------------------+-----------+--------+----------------------------+
+| auid                   | integer   | 否     | 登录用户 ID                |
++------------------------+-----------+--------+----------------------------+
+| ses                    | integer   | 否     | 登录会话 ID                |
++------------------------+-----------+--------+----------------------------+
+| lsm                    | string    | 否     | 与该事件关联的 LSM 名称    |
++------------------------+-----------+--------+----------------------------+
+| res                    | integer   | 否     | 审计操作的结果（成功/失败）|
++------------------------+-----------+--------+----------------------------+
+
+1422 AUDIT_IPE_POLICY_LOAD
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+事件示例::
+
+   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1 errno=0
+   type=1300 audit(1653425529.927:53): arch=c000003e syscall=1 success=yes exit=2567 a0=3 a1=5596fcae1fb0 a2=a07 a3=2 items=0 ppid=184 pid=229 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=4294967295 comm="python3" exe="/usr/bin/python3.10" key=(null)
+   type=1327 audit(1653425529.927:53): PROCTITLE proctitle=707974686F6E3300746573742F6D61696E2E7079002D66002E2E
+
+此记录表明新策略已加载到内核中，包含策略名称、策略版本和策略哈希。
+
+此记录始终与 ``write`` 系统调用的 ``AUDITSYSCALL`` 记录一起发出。
+
+字段说明:
+
++----------------+-----------+--------+-----------------------------------+
+| 字段           | 值类型    | 可选？ | 值说明                            |
++================+===========+========+===================================+
+| policy_name    | string    | 是     | 策略名称                          |
++----------------+-----------+--------+-----------------------------------+
+| policy_version | string    | 是     | 策略版本                          |
++----------------+-----------+--------+-----------------------------------+
+| policy_digest  | string    | 是     | 策略哈希                          |
++----------------+-----------+--------+-----------------------------------+
+| auid           | integer   | 否     | 登录用户 ID                       |
++----------------+-----------+--------+-----------------------------------+
+| ses            | integer   | 否     | 登录会话 ID                       |
++----------------+-----------+--------+-----------------------------------+
+| lsm            | string    | 否     | 与该事件关联的 LSM 名称           |
++----------------+-----------+--------+-----------------------------------+
+| res            | integer   | 否     | 审计操作的结果（成功/失败）       |
++----------------+-----------+--------+-----------------------------------+
+| errno          | integer   | 否     | 策略加载操作的错误码（见下表）    |
++----------------+-----------+--------+-----------------------------------+
+
+策略错误码 (errno):
+
+下表列出了在加载或更新策略时可能出现在 errno 字段中的错误码:
+
++----------------+------------------------------------------------------+
+| 错误码         | 说明                                                 |
++================+======================================================+
+| 0              | 成功                                                 |
++----------------+------------------------------------------------------+
+| -EPERM         | 权限不足                                             |
++----------------+------------------------------------------------------+
+| -EEXIST        | 同名策略已部署                                       |
++----------------+------------------------------------------------------+
+| -EBADMSG       | 策略无效                                             |
++----------------+------------------------------------------------------+
+| -ENOMEM        | 内存不足 (OOM)                                       |
++----------------+------------------------------------------------------+
+| -ERANGE        | 策略版本号溢出                                       |
++----------------+------------------------------------------------------+
+| -EINVAL        | 策略版本解析错误                                     |
++----------------+------------------------------------------------------+
+| -ENOKEY        | 签名 IPE 策略的密钥未在密钥环中找到                  |
++----------------+------------------------------------------------------+
+| -EKEYREJECTED  | 策略签名验证失败                                     |
++----------------+------------------------------------------------------+
+| -ESTALE        | 尝试使用旧版本更新 IPE 策略                          |
++----------------+------------------------------------------------------+
+| -ENOENT        | 策略在更新期间被删除                                 |
++----------------+------------------------------------------------------+
+
+1404 AUDIT_MAC_STATUS
+^^^^^^^^^^^^^^^^^^^^^
+
+事件示例::
+
+   type=1404 audit(1653425689.008:55): enforcing=0 old_enforcing=1 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
+   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
+   type=1327 audit(1653425689.008:55): proctitle="-bash"
+
+   type=1404 audit(1653425689.008:55): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
+   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
+   type=1327 audit(1653425689.008:55): proctitle="-bash"
+
+此记录始终与 ``write`` 系统调用的 ``AUDITSYSCALL`` 记录一起发出。
+
+字段说明:
+
++--------------+-----------+--------+-------------------------------------------------------+
+| 字段         | 值类型    | 可选？ | 值说明                                                |
++==============+===========+========+=======================================================+
+| enforcing    | integer   | 否     | IPE 切换到的强制执行状态,1:强制模式,0:宽松模式        |
++--------------+-----------+--------+-------------------------------------------------------+
+| old_enforcing| integer   | 否     | IPE 切换前的强制执行状态,1:强制模式,0:宽松模式        |
++--------------+-----------+--------+-------------------------------------------------------+
+| auid         | integer   | 否     | 登录用户 ID                                           |
++--------------+-----------+--------+-------------------------------------------------------+
+| ses          | integer   | 否     | 登录会话 ID                                           |
++--------------+-----------+--------+-------------------------------------------------------+
+| enabled      | integer   | 否     | 新的 TTY 审计启用设置                                 |
++--------------+-----------+--------+-------------------------------------------------------+
+| old-enabled  | integer   | 否     | 旧的 TTY 审计启用设置                                 |
++--------------+-----------+--------+-------------------------------------------------------+
+| lsm          | string    | 否     | 与该事件关联的 LSM 名称                               |
++--------------+-----------+--------+-------------------------------------------------------+
+| res          | integer   | 否     | 审计操作的结果（成功/失败）                           |
++--------------+-----------+--------+-------------------------------------------------------+
+
+
+成功审计
+^^^^^^^^
+
+IPE 支持成功审计。启用后，所有通过 IPE 策略且未被阻止的事件都将生成审计事件。
+此功能默认关闭，可以通过内核命令行参数 ``ipe.success_audit=(0|1)`` 或
+securityfs 文件 ``/sys/kernel/security/ipe/success_audit`` 启用。
+
+这会产生 **大量** 日志，因为 IPE 会检查系统上的每一个用户空间二进制文件，但
+在调试策略时非常有用。
+
+.. NOTE::
+
+   如果启用了传统 MAC 系统（SELinux、apparmor、smack 等），所有对 IPE
+   securityfs 节点的写入都需要 ``CAP_MAC_ADMIN``。
+
+属性
+----
+
+如上所述，IPE 属性是 IPE 策略中以 ``key=value`` 对表示的表达式。策略解析器内
+置了两个属性：'op' 和 'action'。其他属性用于限定被评估文件的不可变安全属性。
+目前这些属性包括：'``boot_verified``'、'``dmverity_signature``'、
+'``dmverity_roothash``'、'``fsverity_signature``'、'``fsverity_digest``'。
+以下列出了 IPE 支持的所有属性的说明：
+
+op
+~~
+
+表示规则适用于的操作。必须作为第一条标记出现在每条规则中。IPE 支持
+以下操作：
+
+   ``EXECUTE``
+
+      适用于任何试图被执行或作为可执行文件加载的文件。
+
+   ``FIRMWARE``:
+
+      适用于通过 firmware_class 接口加载的固件。涵盖预分配缓冲区和固件文件本
+      身。
+
+   ``KMODULE``:
+
+      适用于通过 ``modprobe`` 或 ``insmod`` 加载的内核模块。
+
+   ``KEXEC_IMAGE``:
+
+      适用于通过 ``kexec`` 加载的内核镜像。
+
+   ``KEXEC_INITRAMFS``
+
+      适用于通过 ``kexec --initrd`` 加载的 initrd 镜像。
+
+   ``POLICY``:
+
+      通过内核空间发起的读取操作控制策略加载。
+
+      例如，将策略文件路径写入 ``$securityfs/ima/policy`` 来加载 IMA 策略。
+
+   ``X509_CERT``:
+
+      通过 Kconfig 选项 ``CONFIG_IMA_X509_PATH`` 和
+      ``CONFIG_EVM_X509_PATH`` 控制 IMA 证书的加载。
+
+action
+~~~~~~
+
+   决定 IPE 在规则匹配时的行为。必须作为最后一条子句出现在每条规则中。可以取
+   以下值：
+
+   ``ALLOW``:
+
+      如果规则匹配，显式允许访问资源并继续执行，不再评估后续规则。
+
+   ``DENY``:
+
+      如果规则匹配，显式禁止访问资源并停止执行，不再评估后续规则。
+
+boot_verified
+~~~~~~~~~~~~~
+
+   此属性可用于对来自 initramfs 的文件进行授权。
+   此属性的格式是::
+
+         boot_verified=(TRUE|FALSE)
+
+   .. WARNING::
+
+      此属性将信任来自 initramfs(rootfs) 的文件。它应仅在早期引导阶段使用。
+      在实际根文件系统挂载到 initramfs 之上之前，initramfs 脚本将递归删除
+      initramfs 上的所有文件和目录。这通常通过使用
+      switch_root(8) [#switch_root]_ 来实现。因此在实际根文件系统接管后，
+      initramfs 将为空且不可访问。建议在此之后切换到不依赖该属性的其他策略。
+      这样可以确保信任策略在整个系统运行期间保持相关和有效。
+
+dmverity_roothash
+~~~~~~~~~~~~~~~~~
+
+   此属性可用于授权或撤销特定的 dm-verity 卷，通过其根哈希进行标识。它依赖于
+   DM_VERITY 模块。此属性由 ``IPE_PROP_DM_VERITY`` 配置选项控制，当
+   ``SECURITY_IPE`` 和 ``DM_VERITY`` 都启用时它将自动被选中。
+   此属性的格式是::
+
+      dmverity_roothash=DigestName:HexadecimalString
+
+   dmverity_roothash 支持的 DigestName 有 [#dmveritydigests]_
+
+      + blake2b-512
+      + blake2s-256
+      + sha256
+      + sha384
+      + sha512
+      + sha3-224
+      + sha3-256
+      + sha3-384
+      + sha3-512
+      + sm3
+      + rmd160
+
+dmverity_signature
+~~~~~~~~~~~~~~~~~~
+
+   此属性可用于授权所有具有已签名 roothash 的 dm-verity 卷，该签名需由
+   dm-verity 配置中指定的密钥环（系统受信任密钥环或次级密钥环）验证有效。它依
+   赖于 ``DM_VERITY_VERIFY_ROOTHASH_SIG`` 配置选项，并由
+   ``IPE_PROP_DM_VERITY_SIGNATURE`` 配置选项控制，当 ``SECURITY_IPE``、
+   ``DM_VERITY`` 和 ``DM_VERITY_VERIFY_ROOTHASH_SIG`` 都启用时它将自动被选中。
+   此属性的格式是::
+
+      dmverity_signature=(TRUE|FALSE)
+
+fsverity_digest
+~~~~~~~~~~~~~~~
+
+   此属性可用于授权特定的启用了 fsverity 的文件，通过其 fsverity 摘要进行标
+   识。它依赖于 ``FS_VERITY`` 配置选项，并由 ``IPE_PROP_FS_VERITY`` 配置选项
+   控制，当 ``SECURITY_IPE`` 和 ``FS_VERITY`` 都启用时它将自动被选中。
+   此属性的格式是::
+
+      fsverity_digest=DigestName:HexadecimalString
+
+   fsverity_digest 支持的 DigestName 有 [#fsveritydigest]_
+
+      + sha256
+      + sha512
+
+fsverity_signature
+~~~~~~~~~~~~~~~~~~
+
+   此属性用于授权所有已通过 fs-verity 内建签名机制验证的启用了 fs-verity 的
+   文件。签名验证依赖于存储在 ".fs-verity" 密钥环中的密钥。它依赖于
+   ``FS_VERITY_BUILTIN_SIGNATURES`` 配置选项，并由 ``IPE_PROP_FS_VERITY``
+   配置选项控制，当 ``SECURITY_IPE``、``FS_VERITY`` 和
+   ``FS_VERITY_BUILTIN_SIGNATURES`` 都启用时它将自动被选中。
+   此属性的格式是::
+
+      fsverity_signature=(TRUE|FALSE)
+
+策略示例
+--------
+
+全部允许
+~~~~~~~~
+
+::
+
+   policy_name=Allow_All policy_version=0.0.0
+   DEFAULT action=ALLOW
+
+仅允许 initramfs
+~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_Initramfs policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+
+允许任意已签名并验证的 dm-verity 卷和 initramfs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_Signed_DMV_And_Initramfs policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+   op=EXECUTE dmverity_signature=TRUE action=ALLOW
+
+禁止从特定 dm-verity 卷执行
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Deny_DMV_By_Roothash policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE dmverity_roothash=sha256:cd2c5bae7c6c579edaae4353049d58eb5f2e8be0244bf05345bc8e5ed257baff action=DENY
+
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+   op=EXECUTE dmverity_signature=TRUE action=ALLOW
+
+仅允许特定 dm-verity 卷
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_DMV_By_Roothash policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE dmverity_roothash=sha256:401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW
+
+允许任意带有有效内建签名的 fs-verity 文件
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_Signed_And_Validated_FSVerity policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE fsverity_signature=TRUE action=ALLOW
+
+允许执行特定 fs-verity 文件
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=ALLOW_FSV_By_Digest policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE fsverity_digest=sha256:fd88f2b8824e197f850bf4c5109bea5cf0ee38104f710843bb72da796ba5af9e action=ALLOW
+
+附加信息
+--------
+
+- `Github 仓库 <https://github.com/microsoft/ipe>`_
+- :doc:`IPE 开发者和设计文档 </security/ipe>`
+
+FAQ
+---
+
+Q:
+   IPE 与其他提供基于信任的访问控制的 LSM 有什么区别？
+
+A:
+
+   一般而言，另外有两种 LSM 可以提供类似的功能：IMA 和 Loadpin。
+
+   IMA 和 IPE 在功能上非常相似。两者之间的显著区别在于策略。 [#devdoc]_
+
+   Loadpin 与 IPE 差异相当大，因为 Loadpin 只覆盖了 IPE 的内核读取操作，而
+   IPE 除了内核读取外还能控制执行。信任模型也不同；Loadpin 的信任根植于初始
+   超级块，而 IPE 的信任来源于内核自身（通过 ``SYSTEM_TRUSTED_KEYS``）。
+
+------------
+
+.. [#digest_cache_lsm] https://lore.kernel.org/lkml/20240415142436.2545003-1-roberto.sassu@huaweicloud.com/
+
+.. [#devdoc] 关于此主题的更多信息，请参阅 :doc:`设计文档 </security/ipe>`。
+
+.. [#switch_root] https://man7.org/linux/man-pages/man8/switch_root.8.html
+
+.. [#dmveritydigests] 这些哈希算法基于 Linux 加密 API 接受的值；IPE 不限制摘
+                      要算法本身；因此，此列表可能不是最新的。
+
+.. [#fsveritydigest] 这些哈希算法基于内核 fsverity 支持接受的值；IPE 不限制
+                     摘要算法本身；因此，此列表可能不是最新的。
-- 
2.43.0

