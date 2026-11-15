Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751737;
	b=aQkxLT7bEEE15FMCxMXRo+j+63mB/dT9BVYlyblKkyVDHoooOYrWmpU+u/YsbB5iA03p
	 stmcChvnDn/bMDBztLE5umAnWhLJ3wbVLVqIbssRlA5GKNeOqwxXN6p7dLYMKSn5DSv0l
	 b3nbRcogeZj3fdmKbpkHAoXUSB4FYqsoxzNbYXihT8VKpwVY1Wf2sFhHCvlRkHcV9tqTT
	 HYhZqjSOs/qmWbm3su7ev4ss1gdFHAeBDV6Og5lgSaZnZ3D1wk2A46h5pUYFXWyOtL2Fd
	 36b1Mg6n7wzwX2L8rSsOhH04aDoiUplU2Ie+CGUzzxLCEEVdjwbV2ZYwbXCMdjeRvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751737;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3pkVyad1n5ka2XaVqEBw+nxPOdvxToFI+8fr9VQy/Y4=;
	b=DHqs6gk6ns1zJfuE2PeZjrB1ORESkY/nV1DKLjvdKPOo/Kiu7iM46sZFQhzKlWXu7TD1
	 N81BfDqwbSUqXkjVJd5LuK0oGPmWD1/PEV4ZlZv3BP8eJGvPaiWMNomNX1M00jil1lC2z
	 et+Cz7lXJgTq0OkuawBDXilcgWDp3Z/XRsqBLqmtTgZj92dASOSjSgqEj4VCCBAg4I+uq
	 kx9WBBxcxQzUgGz7vX9IOCgGa8LwA0k+L0bF4raHH6IQBs0NT3SbsSMNRFxIJ9Zk8GdjP
	 9uK44fbHSRdkMITeqSEBq9XHz2+lK9cTkL9TcUfVJ1driGt/zo6yFg6TwI8xWMIBf3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VAeZ65cj;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADE606A31D;
	Sun, 15 Nov 2026 14:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24ADE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VAeZ65cj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794751725; bh=3pkVyad1n5ka2XaVqEBw+nxPOdvxToFI+8fr9VQy/Y4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VAeZ65cjoRW/uaOCov72IT2MIeCJAN83bHVWwYiRT/0C/29u9rYAJmLsnG++g6J+M
	 a0ChP0LK83fgwTXHuZ98yZFQipPzNhnNBr7nwi9T+RTrUpf/3hAX1bcaG/HLRN6UiQ
	 4iW8mxq6S68jZQChSNyHOP+fjb2HocPagx+CeJjY=
Received: from [192.168.1.9] ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 22B0B8F7; Sun, 15 Nov 2026 22:08:43 +0800
X-QQ-mid: xmsmtpt1794751723t3pgmrnd8
Message-ID: <tencent_FF4D207CBC1BBA505912653DDC6D1F358F0A@qq.com>
X-QQ-XMAILINFO: NlxXso1y1wBF4I4u62Tkztw3VZUfEm5D2UQpIgxQwmrD/tnWddAT70VS9B6oW2
	 XX6qb94ZZOrRP8YjxTpG3VK820CWTKxNFCcf9JY2QV8UVxKcddfnsM4KSzXkIX5goZLNfy8hCfeN
	 FILjvaYH1BI5BZWudA+oBors4TtVQhHfO0V6hW307gXOtdwmTcf3agrmblviwjTFpIQHDFKpwSy2
	 L/nWNMkLZu71kSTyjN7BJLs05BUnAhA+7rHqxumjwnP54Glua/3ozbpV4vWyT+iTRDwQXZqn65rg
	 R61cfNSMXqcewXnZfMqellFs4AzGHYJTM2R7KgnH5NnYrOZsI/PuX39zwyomfm/GnoI6mRvL5zlD
	 1A0q5derIxuHbkIrISC2RDsQo9186UFrXAnSTsY3Jnh9p4cWoy6JX5Y5dkDYb0MxxhPZDsaHQWDg
	 AO/2cV8CgBJzwBk3k60lI4j/IuO7GjzYcHkB3y4tMSCtejbMi1t46S5oP5EiqckTKT+FG8m2rpM2
	 RsbI0LA0/mUvBhzvwSyEBQI2THswE7ceLVc+HAE+D89Os+OC138fEpDF9gA5AAOe5eh38RpZwqbc
	 fdxm0bCooldNgRGGCOw/hnIXbo0jHzbzXRkhPud416/GCOZimrS74qMzVpN+VBQC9woulIT9lIxf
	 0YvmgGNT6nenfVlP8ZEK5LgPm+jw0fQkiBZ7ckQIF94uoxZx+XEqmgSSZQQlEzcLaseJXxsS8d1D
	 mVUx9bjuRNswwIXb2J+OVjlk3roaa3aGkdO6vNe0J2tqsLX22YikmuOWsIGWK6ie0oh1k+VFcOa4
	 CzombA68J3Cx72IiE8vG/j0x2wqgpJVn7DwBQ0DCiXJVHAF4yFGyguPKpCULCOn0FjyZCwFYWBCr
	 QBkntNcBHekOO9Ln1m6fhhdYIXdsasvvvobe9ublboWpJt0/mHNT8srm7LAWWY5MYLmk6GdFW8hX
	 TulIah5OBCy2rFS+kChzn26vDtMR5dr8Qgg6AaeB6VRUPE6/RxgC7JdjXFAhJ2VejMZn45KJVwbN
	 zwNGNsHxvHCcG9M72L4B120Xs1/YY6hm9wBRKHQSmtNimSrh+H3a3zxG9Eqtfj7BI4Xfy/E51rdj
	 q2Ij69iLw9NCouCDAY36JyuHDlsYkwa+EU1RerKvvTyPcJtZY=
X-QQ-XMRINFO: MSVp+SPm3vtSN4aDrKkeg9kxuN5gPH2Mdg==
X-OQ-MSGID: <f60d3c92-34c3-445c-b370-08950fa4903a@qq.com>
Date: Sun, 15 Nov 2026 22:12:51 +0800
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
To: Dongliang Mu <dzm91@hust.edu.cn>, alexs@kernel.org, si.yanteng@linux.dev,
 corbet@lwn.net, mic@digikod.net
Cc: skhan@linuxfoundation.org, gnoack@google.com, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_B27B8B8B80A567D6C21DDDD1C6981982DE06@qq.com>
 <e708b270-3adc-4c7e-a48d-9804faed6c44@hust.edu.cn>
From: Yan Zhu <zhuyan2015@qq.com>
In-Reply-To: <e708b270-3adc-4c7e-a48d-9804faed6c44@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/2026 6:12 PM, Dongliang Mu wrote:
> 
> On 6/12/26 11:58 PM, Yan Zhu wrote:
>> Translate Documentation/admin-guide/LSM/landlock.rst into Chinese.
>>
>> Update the translation through commit de4b09abf088
>> ("landlock: Document audit blocker field format")
>>
>> Assisted-by: Claude:deepseek-4-pro
>> Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
> 
> Sorry for my late response. I missed this patchset.
> 
> This patch seems good to me. However, this document has some new 
> commits. Would you like to catch up the latest version?
> 
> It is fine if you keep the current patch unchanged since it already 
> marks the commit you try to catch up with.

Sorry for the late reply. Due to the large number of patches, I still 
hope to close them first. Later, see which patches need to be adapted to 
the latest version.

> 
> Dongliang Mu
> 
>> ---
>>   .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/ 
>> landlock.rst
>>
>> diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/ 
>> landlock.rst b/Documentation/translations/zh_CN/admin-guide/LSM/ 
>> landlock.rst
>> new file mode 100644
>> index 000000000000..7c465ce1c774
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
>> @@ -0,0 +1,169 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. Copyright © 2025 Microsoft Corporation
>> +.. include:: ../../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/admin-guide/LSM/landlock.rst
>> +:翻译:
>> + 朱岩 Yan Zhu <zhuyan2015@qq.com>
>> +
>> +
>> +========================
>> +Landlock：系统范围的管理
>> +========================
>> +
>> +:Author: Mickaël Salaün
>> +:Date: 2026年1月
>> +
>> +Landlock 可以利用审计框架记录事件。
>> +
>> +用户空间文档位于：Documentation/userspace-api/landlock.rst。
>> +
>> +审计
>> +====
>> +
>> +默认情况下，若启用了 ``audit``，沙箱程序的被拒访问请求会被记录。此默 
>> 认行为可
>> +通过 ``sys_landlock_restrict_self()`` 标志更改（参见
>> +Documentation/userspace-api/landlock.rst）。审计规则也可以屏蔽 
>> Landlock 日志。
>> +Landlock 能生成两种审计记录类型。
>> +
>> +记录类型
>> +--------
>> +
>> +AUDIT_LANDLOCK_ACCESS
>> +    此记录标识对内核资源的拒绝访问请求。``domain`` 字段指示阻止该请求的
>> +    域 ID。``blockers`` 字段列出导致拒绝的原因（逗号分隔），随后字段标识
>> +    内核对象（类似 SELinux）。一次审计事件可能出现多个此类记录。
>> +
>> +    示例：同一事件中两条文件链接请求记录::
>> +
>> +        domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" 
>> ino=351
>> +        domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/ 
>> local" dev="vda2" ino=365
>> +
>> +    ``blockers`` 字段使用点分前缀标识限制类型：
>> +
>> +    **fs.*** – 文件系统访问权（ABI 1+）:
>> +        - fs.execute, fs.write_file, fs.read_file, fs.read_dir
>> +        - fs.remove_dir, fs.remove_file
>> +        - fs.make_char, fs.make_dir, fs.make_reg, fs.make_sock
>> +        - fs.make_fifo, fs.make_block, fs.make_sym
>> +        - fs.refer (ABI 2+)
>> +        - fs.truncate (ABI 3+)
>> +        - fs.ioctl_dev (ABI 5+)
>> +
>> +    **net.*** – 网络访问权（ABI 4+）:
>> +        - net.bind_tcp – TCP 端口绑定被拒绝
>> +        - net.connect_tcp – TCP 连接被拒绝
>> +
>> +    **scope.*** – IPC 范围限制（ABI 6+）:
>> +        - scope.abstract_unix_socket – 抽象 UNIX 套接字连接被拒绝
>> +        - scope.signal – 信号发送被拒绝
>> +
>> +    当多个访问权缺失时，可出现多个 ``blockers``（逗号分隔），例如缺少
>> +    ``make_reg`` 与 ``refer`` 权限时会显示 
>> ``blockers=fs.make_reg,fs.refer``。
>> +
>> +    对象标识字段（路径、设备、inode 等）根据被阻止的访问类型提供上下 
>> 文信息。
>> +
>> +AUDIT_LANDLOCK_DOMAIN
>> +    此记录描述 Landlock 域的状态。``status`` 字段为 ``allocated`` 或
>> +    ``deallocated``。
>> +
>> +    ``allocated`` 状态随同首条 ``AUDIT_LANDLOCK_ACCESS`` 记录出现，
>> +    提供以下信息：
>> +
>> +    - 域 ID（``domain``）
>> +    - 强制模式（``mode``）
>> +    - 创建域的 PID（``pid``）
>> +    - 创建域的 UID（``uid``）
>> +    - 创建域的可执行路径（``exe``）
>> +    - 创建域的命令行（``comm``）
>> +
>> +    示例::
>> +
>> +        domain=195ba459b status=allocated mode=enforcing pid=300 
>> uid=0 ...
>> +
>> +    ``deallocated`` 为单独事件，表示域释放。此后该域 ID 不会在系统生 
>> 命周期中
>> +    再次使用。``deallocated`` 记录包含域 ID 与 ``denials`` 字段，后者 
>> 统计该
>> +    域被拒绝的请求数。
>> +
>> +    示例::
>> +
>> +        domain=195ba459b status=deallocated denials=3
>> +
>> +事件示例
>> +--------
>> +
>> +以下为两组审计日志示例（含序列号）。
>> +
>> +示例 1：沙箱程序 ``kill`` 试图向 init 进程发送信号，
>> +被 ``scope.signal`` 限制拒绝::
>> +
>> +  $ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1
>> +
>> +此命令生成两个事件，每个事件都由一个时间戳后跟一个唯一的序列号标识
>> +（``msg=audit(1729738800.268:30)``）。第一个事件（序列号为“30”）包含 
>> 4 条记
>> +录。第一条记录（``type=LANDLOCK_ACCESS``）显示域 `1a6fdc66f` 拒绝了访 
>> 问。拒
>> +绝的原因是信号范围限制（``blockers=scope.signal``）。本应接收此信号的 
>> 进程是
>> +init 进程（``opid=1 ocomm="systemd"``）。
>> +
>> +第二个记录（``type=LANDLOCK_DOMAIN``） 描述了（``status=allocated``）域
>> +`1a6fdc66f`。此域由进程 ``286`` 创建，该进程执行了由 root 用户启动的
>> +`/root/sandboxer` 程序。
>> +
>> +第三个记录（``type=SYSCALL``）描述了系统调用、其提供的参数、其结果
>> +``success=no exit=-1`` 以及调用它的进程。
>> +
>> +第四个记录（``type=PROCTITLE``）以十六进制值的形式显示命令名称。这可 
>> 以通过执
>> +行 ``python -c 'print(bytes.fromhex("6B696C6C0031"))'`` 进行转换。
>> +
>> +最后一条记录（``type=LANDLOCK_DOMAIN``）也是第二个事件（序列号“31”） 
>> 中的唯一
>> +一条记录。它并非与直接的用户空间操作相关，而是异步操作以释放与 
>> Landlock 域相
>> +关的资源（``status=deallocated``）。这有助于了解后续的日志将不再涉及域
>> +`1a6fdc66f`。此记录还总结了该域拒绝的请求数量（``denials=1``），以及 
>> 这些请求
>> +是否被记录。
>> +
>> +
>> +.. code-block::
>> +
>> +  type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f 
>> blockers=scope.signal opid=1 ocomm="systemd"
>> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f 
>> status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" 
>> comm="sandboxer"
>> +  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 
>> success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] 
>> comm="kill" [...]
>> +  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
>> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f 
>> status=deallocated denials=1
>> +
>> +
>> +示例 2：文件系统访问控制示例::
>> +
>> +    $ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo 
>> > /etc/passwd"
>> +
>> +相关的审计日志包含由同一个域 `1a6fdc679` 创建的 3 个不同事件（序列号 
>> 33、34
>> +和 35）的 8 条记录::
>> +
>> +  type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 
>> blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
>> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 
>> status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" 
>> comm="sandboxer"
>> +  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e 
>> syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 
>> gid=0 [...] comm="sh" [...]
>> +  type=PROCTITLE msg=audit(1729738800.221:33): 
>> proctitle=7368002D63006563686F203E202F6574632F706173737764
>> +  type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 
>> blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
>> +  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e 
>> syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 
>> gid=0 [...] comm="sh" [...]
>> +  type=PROCTITLE msg=audit(1729738800.221:34): 
>> proctitle=7368002D63006563686F203E202F6574632F706173737764
>> +  type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 
>> status=deallocated denials=2
>> +
>> +
>> +过滤审计日志
>> +------------
>> +
>> +如果审计日志数量过多，可通过以下两种方式过滤噪声：
>> +
>> +- 使用 ``sys_landlock_restrict_self()`` 的标志对沙箱程序进行配置；
>> +- 或使用审计规则（参见 :manpage:`auditctl(8)`）过滤。
>> +
>> +补充文档
>> +--------
>> +
>> +* `Linux Audit Documentation`_
>> +* Documentation/userspace-api/landlock.rst
>> +* Documentation/security/landlock.rst
>> +* https://landlock.io
>> +
>> +.. 链接
>> +.. _Linux Audit Documentation:
>> +   https://github.com/linux-audit/audit-documentation/wiki

-- 
Thanks
Yan Zhu

