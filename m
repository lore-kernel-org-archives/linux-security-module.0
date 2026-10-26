Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.101.248.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009549;
	b=bkwWny/8x2b+zHUFWdB7r52ykeR2w6bC7amK6ZRI6bgyvSZZs4To6jBAquNOmoewU+D3
	 meG4CFHxA/y0sF0gcTlizAg9SVSSzvoJwfuUFgNUvhwkeeHoli5hZoY8skghArHagRIDt
	 xe7EGPwek2scyeM+I0le//AQrxJDN+ZYY67LT7JrfcIolIkRdiOfWvYbbL1+3ZJyI7P3/
	 6hWhfrKNvFU1qJTnN2UOSdLoEs/TrdI4mmk/NP4dGB4DvlTxCN+kLNlyjtpuDdCWpT0vw
	 aweiuHswqi2vRrs8zHpevU0t3fHW9nA9dMtDE9bssu3E5yxa/D8LTZ3cwBEC5tjMbKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009549;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=PRmtjk36aY/2PzhUQwWQYugKp2hIbBEswnNK0M8D9I8=;
	b=Agz2hxfZZxprpUMM3w/wTaTJYnT5rG7t7cYaTtBkSFfwPTHOBKkCQoDQbzPS8TCQS/Mt
	 qPpmOpQOeoKwIT5Z7XKP5+960OAFy3PK/CjKrha67aifydUfvETsFiAwAWhPgUiT/Gw1E
	 +RCfuLO7wHm8q5npZKAtKxbVlaprs1dlZBbxzgoeX+t5P7lSnJr3aJ/eI3KmsaphrtkQI
	 MQj+X+lDII07dIYczsDTT54TdQyRJpFB7BFsg0MRczWdFvXIgw29QhAWThLd7P6h9BXI5
	 YU81XVRH7NlJKnhWMrozdxW/7P6YMvbrYzh87lBaZSj6FdVokGhrg9yzDqBBDbKEDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=46.101.248.176
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20004606A31A;
	Mon, 26 Oct 2026 10:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20004606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with UTF8SMTP id IQEQrMD2HXeCJ99q7alcAA--.45360S2;
	Mon, 26 Oct 2026 18:12:18 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wCnOi19J99qgqYPAA--.31490S2;
	Mon, 26 Oct 2026 18:12:15 +0800 (CST)
Message-ID: <e708b270-3adc-4c7e-a48d-9804faed6c44@hust.edu.cn>
Date: Mon, 26 Oct 2026 18:12:13 +0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs/zh_CN: add LSM/landlock Chinese translation
To: Yan Zhu <zhuyan2015@qq.com>, alexs@kernel.org, si.yanteng@linux.dev,
 corbet@lwn.net, mic@digikod.net
Cc: skhan@linuxfoundation.org, gnoack@google.com, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_B27B8B8B80A567D6C21DDDD1C6981982DE06@qq.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <tencent_B27B8B8B80A567D6C21DDDD1C6981982DE06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMD2HXeCJ99q7alcAA--.45360S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4rJw43AFykXr45JrW5Jrb_yoWfKF4Up3
	ZrKrWxKw43CryUCa4UW3srXrW7A3W0yFs7GF9xKry8tFs0yrZ7KF1jvryDWFWkurZ7Aa98
	Xr1xCry0ywnruaDanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02
	Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0P73PUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/12/26 11:58 PM, Yan Zhu wrote:
> Translate Documentation/admin-guide/LSM/landlock.rst into Chinese.
>
> Update the translation through commit de4b09abf088
> ("landlock: Document audit blocker field format")
>
> Assisted-by: Claude:deepseek-4-pro
> Signed-off-by: Yan Zhu <zhuyan2015@qq.com>

Sorry for my late response. I missed this patchset.

This patch seems good to me. However, this document has some new 
commits. Would you like to catch up the latest version?

It is fine if you keep the current patch unchanged since it already 
marks the commit you try to catch up with.

Dongliang Mu

> ---
>   .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++++++++++++++++
>   1 file changed, 169 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
>
> diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst b/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
> new file mode 100644
> index 000000000000..7c465ce1c774
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
> @@ -0,0 +1,169 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright © 2025 Microsoft Corporation
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/LSM/landlock.rst
> +:翻译:
> + 朱岩 Yan Zhu <zhuyan2015@qq.com>
> +
> +
> +========================
> +Landlock：系统范围的管理
> +========================
> +
> +:Author: Mickaël Salaün
> +:Date: 2026年1月
> +
> +Landlock 可以利用审计框架记录事件。
> +
> +用户空间文档位于：Documentation/userspace-api/landlock.rst。
> +
> +审计
> +====
> +
> +默认情况下，若启用了 ``audit``，沙箱程序的被拒访问请求会被记录。此默认行为可
> +通过 ``sys_landlock_restrict_self()`` 标志更改（参见
> +Documentation/userspace-api/landlock.rst）。审计规则也可以屏蔽 Landlock 日志。
> +Landlock 能生成两种审计记录类型。
> +
> +记录类型
> +--------
> +
> +AUDIT_LANDLOCK_ACCESS
> +    此记录标识对内核资源的拒绝访问请求。``domain`` 字段指示阻止该请求的
> +    域 ID。``blockers`` 字段列出导致拒绝的原因（逗号分隔），随后字段标识
> +    内核对象（类似 SELinux）。一次审计事件可能出现多个此类记录。
> +
> +    示例：同一事件中两条文件链接请求记录::
> +
> +        domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
> +        domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365
> +
> +    ``blockers`` 字段使用点分前缀标识限制类型：
> +
> +    **fs.*** – 文件系统访问权（ABI 1+）:
> +        - fs.execute, fs.write_file, fs.read_file, fs.read_dir
> +        - fs.remove_dir, fs.remove_file
> +        - fs.make_char, fs.make_dir, fs.make_reg, fs.make_sock
> +        - fs.make_fifo, fs.make_block, fs.make_sym
> +        - fs.refer (ABI 2+)
> +        - fs.truncate (ABI 3+)
> +        - fs.ioctl_dev (ABI 5+)
> +
> +    **net.*** – 网络访问权（ABI 4+）:
> +        - net.bind_tcp – TCP 端口绑定被拒绝
> +        - net.connect_tcp – TCP 连接被拒绝
> +
> +    **scope.*** – IPC 范围限制（ABI 6+）:
> +        - scope.abstract_unix_socket – 抽象 UNIX 套接字连接被拒绝
> +        - scope.signal – 信号发送被拒绝
> +
> +    当多个访问权缺失时，可出现多个 ``blockers``（逗号分隔），例如缺少
> +    ``make_reg`` 与 ``refer`` 权限时会显示 ``blockers=fs.make_reg,fs.refer``。
> +
> +    对象标识字段（路径、设备、inode 等）根据被阻止的访问类型提供上下文信息。
> +
> +AUDIT_LANDLOCK_DOMAIN
> +    此记录描述 Landlock 域的状态。``status`` 字段为 ``allocated`` 或
> +    ``deallocated``。
> +
> +    ``allocated`` 状态随同首条 ``AUDIT_LANDLOCK_ACCESS`` 记录出现，
> +    提供以下信息：
> +
> +    - 域 ID（``domain``）
> +    - 强制模式（``mode``）
> +    - 创建域的 PID（``pid``）
> +    - 创建域的 UID（``uid``）
> +    - 创建域的可执行路径（``exe``）
> +    - 创建域的命令行（``comm``）
> +
> +    示例::
> +
> +        domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 ...
> +
> +    ``deallocated`` 为单独事件，表示域释放。此后该域 ID 不会在系统生命周期中
> +    再次使用。``deallocated`` 记录包含域 ID 与 ``denials`` 字段，后者统计该
> +    域被拒绝的请求数。
> +
> +    示例::
> +
> +        domain=195ba459b status=deallocated denials=3
> +
> +事件示例
> +--------
> +
> +以下为两组审计日志示例（含序列号）。
> +
> +示例 1：沙箱程序 ``kill`` 试图向 init 进程发送信号，
> +被 ``scope.signal`` 限制拒绝::
> +
> +  $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
> +
> +此命令生成两个事件，每个事件都由一个时间戳后跟一个唯一的序列号标识
> +（``msg=audit(1729738800.268:30)``）。第一个事件（序列号为“30”）包含 4 条记
> +录。第一条记录（``type=LANDLOCK_ACCESS``）显示域 `1a6fdc66f` 拒绝了访问。拒
> +绝的原因是信号范围限制（``blockers=scope.signal``）。本应接收此信号的进程是
> +init 进程（``opid=1 ocomm="systemd"``）。
> +
> +第二个记录（``type=LANDLOCK_DOMAIN``） 描述了（``status=allocated``）域
> +`1a6fdc66f`。此域由进程 ``286`` 创建，该进程执行了由 root 用户启动的
> +`/root/sandboxer` 程序。
> +
> +第三个记录（``type=SYSCALL``）描述了系统调用、其提供的参数、其结果
> +``success=no exit=-1`` 以及调用它的进程。
> +
> +第四个记录（``type=PROCTITLE``）以十六进制值的形式显示命令名称。这可以通过执
> +行 ``python -c 'print(bytes.fromhex("6B696C6C0031"))'`` 进行转换。
> +
> +最后一条记录（``type=LANDLOCK_DOMAIN``）也是第二个事件（序列号“31”）中的唯一
> +一条记录。它并非与直接的用户空间操作相关，而是异步操作以释放与 Landlock 域相
> +关的资源（``status=deallocated``）。这有助于了解后续的日志将不再涉及域
> +`1a6fdc66f`。此记录还总结了该域拒绝的请求数量（``denials=1``），以及这些请求
> +是否被记录。
> +
> +
> +.. code-block::
> +
> +  type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
> +  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
> +  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1
> +
> +
> +示例 2：文件系统访问控制示例::
> +
> +    $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"
> +
> +相关的审计日志包含由同一个域 `1a6fdc679` 创建的 3 个不同事件（序列号 33、34
> +和 35）的 8 条记录::
> +
> +  type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
> +  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
> +  type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
> +  type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
> +  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
> +  type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2
> +
> +
> +过滤审计日志
> +------------
> +
> +如果审计日志数量过多，可通过以下两种方式过滤噪声：
> +
> +- 使用 ``sys_landlock_restrict_self()`` 的标志对沙箱程序进行配置；
> +- 或使用审计规则（参见 :manpage:`auditctl(8)`）过滤。
> +
> +补充文档
> +--------
> +
> +* `Linux Audit Documentation`_
> +* Documentation/userspace-api/landlock.rst
> +* Documentation/security/landlock.rst
> +* https://landlock.io
> +
> +.. 链接
> +.. _Linux Audit Documentation:
> +   https://github.com/linux-audit/audit-documentation/wiki

