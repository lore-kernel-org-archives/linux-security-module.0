Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981B349CD0;
	Fri, 12 Jun 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280186; cv=none; b=jn5sAgOZQgO+QIV0uqIXon7DCH0ultX0dRTiI4KlXjHAPzuNjErdSK1tMm/nHFIWvPes34Sh8WhlaUoEcTsGIsb7yOB5gZmybbkOQtlA6vnJ7aw7Vx63hvdYc1w4u52/2lwq7BXSbAqwjmSxnoIWhembL8RiP0/O44G7bM/4ToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280186; c=relaxed/simple;
	bh=mw6XEzpUHgFyX/3CQtJiGQS3wlyuzRzkAVcdVgqLqtM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrcjBG7uD6PiNUpw9Urid13aCRBNkkI5XdCDZVTy/F/VEPABIZHNt8h1NKAsB+IpAW7yUoWctG/q6l2PeKMvpDv9J3v7PZvPQ8WrcIFwEHY9TUksVc30qDv7mSMWAXt2JPra+wcT1FvYYX2VJVl5G1cIUBSUXic0R3v4ZfQxgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zmFDSfxq; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zmFDSfxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781280179; bh=5K9LmwVu9oORjjSCeF/aiuH8N36KFvnRHm/K+VIXTic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zmFDSfxqzCWSDDFjPAZn/fnxFRhbx45wcMEhJLf4ncpOe9VyABQsBf5XRkkXfowPi
	 tm2DBStp/T7VHMasPHRCk8a6XngQYAnP3FGaC5kiSQ1S2SzVqZA3Fxmuh//VIkTvQ8
	 JhiGHKLblz23W5pHOxJ5wYgFfjAkdtbb8FZQWnHY=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279977tkpwkjfmu
Message-ID: <tencent_9C8FD8C64E11E0DED95D122C95B326EE1209@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7KXFrWB0Rw4KPvtKFEcvA6MDQcKdpmvOqnfcAbo0b/uMnUnKOs9
	 sEG+tYmdKPZI0XqylRj6fcOVSvK1+eEmzSRCWmMZbD6AeYoHhEVk2TkoDof8GD4LHT9uE1svlif6
	 dMLT/Id0oYbzax01XQoY0QI6Dmb0Be3A+jX+JPFMKHKQxwMVPkJ28tYr/L5Oin+8bALHzpRg2/VV
	 KyTKbtozKvhvaDR4k9mESN4QJQG8PP+JdOAm0iOmMKYGBTJBnRM1D7AnAGqknjB1U0WRAzRrBDGG
	 eZmSezWnfa/TNlXmwfX1pbA8TrwkWBUelwQALGdhT37kTk1DoQT1jgMUeCraV+yzsak8vkwFK5WT
	 AQAxM/mpwKIJj+ES/GltKR3vdwtD8wSfkx9AuRWOrl+bAfLaTfSC5OjomHfhwSMlIy/90LuDNG2A
	 NHsC7bxdV+Ja9Wq0G7Wyyq4rKdXZXhTfdqdWDIEY2MjPo6+9sd1ZJo9UuG0e+qBsDm1yhoQZeRTH
	 1skXOI34jtx4ZHPmSmiHVhfmsn+YfGdCMCP0WoNh4+i4vdliuoGVusXIJAmi3fhwJI/lFJZfWnfN
	 E4i7z5uXQ0L2kSK6IW4IgkH9dl5YhAf9q+ss2Tn0ZPyRNwXhv7L/uUaS9zPnEWDrBmI5vEpvtl4j
	 z7j8B8NwnR/0mtktxZLDrwjYz7jpIKJM553uXnddx4AoWw+RA2zm62Ajo6H6ivLzfPw7pqKYffBW
	 oFKAzwm98k4In5M9+2mS/ZmSUVMEH0zi1ld5xPM9IDKILYZZGPFZMXXZOj+djhiSrFppUjTabuSy
	 sCLRqS7jochfc3eV9IJB0KJ5tUV+Y9xKdUFNEsKjaWoeATFmFe8PzY+Qefe+Ta4Dyvr3LbtgKF5T
	 zYLMXZAwn122wXyeR/Jc8DOp89bLjnE8Mt2bCcqh7ynQvX5sLHkqELFuHY4XS503Py+ilztkLHhh
	 rmQKFPN/XixoQ9nA30WWnc7TENqvW0dMwKX5lchtRCe7YeziMIrflhaGf/i8fTtieCJAy64Do1Oc
	 Z8HsXDRdTFGfKMbvrydiSG9Ex8TyyCfOO2/bS/UD4qGaBT92FK5zQUNUFEUGfZg2RYsSqFEmIafP
	 vsA8+th7ujo/SkCpL3L/A7C6sOEdHERKThvQ9gTi8D3bYA+ulb0V4mvTALnZdmf9xChPoo
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Subject: [PATCH 08/10] docs/zh_CN: add LSM/SafeSetID Chinese translation
Date: Fri, 12 Jun 2026 23:58:27 +0800
X-OQ-MSGID: <ba3fc742adf3247666399050689ac1c9d3ac4fe0.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/SafeSetID.rst into Chinese.

Update the translation through commit c34921670736
("Documentation: Fix admin-guide typos")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/SafeSetID.rst       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst b/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
new file mode 100644
index 000000000000..3f96df3ed776
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/SafeSetID.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+=========
+SafeSetID
+=========
+
+SafeSetID 是一个 LSM 模块，用于对 setid 系列系统调用进行门控，限制 UID/GID
+的转变只能在系统范围的白名单中批准的 UID/GID 之间进行。这些限制还禁止给定的
+UID/GID 获得与 ``CAP_SET{U/G}ID`` 关联的辅助特权，例如允许用户设置用户命名空
+间的 UID/GID 映射。
+
+背景
+====
+在缺少文件能力的情况下，需要切换到其他用户的进程必须具备 ``CAP_SETUID`` 权限。
+``CAP_SETUID`` 只授予以 root 身份运行的程序或显式获得 ``CAP_SETUID`` 运行时
+能力的非 root 程序。相较于文件能力，通常更推荐使用 Linux 运行时能力，因为使
+用文件能力以提升的权限运行程序会带来潜在的安全风险——任何拥有该文件访问权限的
+用户都可以通过 ``exec()`` 运行该程序来获得提升的特权。
+
+虽然可以通过为完整的 ``CAP_SET{U/G}ID`` 能力给进程树授予权限来实现，但这与在
+非 root 用户下运行进程树的目标相冲突。尤其 ``CAP_SETUID`` 允许切换到系统上任
+何用户，包括 root，这在很多场景中过于强大。实际中多数程序仅调用 ``setuid()``
+降低特权，而非提升特权。Linux 并未提供通用机制限制用户通过 ``setuid()`` 能切
+换到的 UID 范围，除非允许其切换到系统上任意用户。SafeSetID LSM 正是为了解决
+这一问题。
+
+主要使用场景是允许非 root 程序在不拥有完整 ``CAP_SETUID`` 能力的情况下，安全
+地切换到其他非受信任的 UID。该非 root 程序仍需 ``CAP_SETUID`` 才能执行任何转
+变，但SafeSetID 施加的额外限制，使其成为 ``CAP_SETUID`` 的“安全版”，防止其进
+行未授权操作（如切换到 UID 0 或创建/进入新的用户命名空间）。这为系统服务提供
+基于UID 的沙箱化提供了可能，而无需在大量非 root 程序上分配完整的
+``CAP_SETUID``。
+
+其他已考虑的方案
+================
+
+在用户空间解决此问题
+--------------------
+可以通过在用户空间完全移除 setid 能力并使用特权帮助程序来完成进程的 UID/GID
+转换。然而，这会影响大量与进程生成相关的语义，如 ``fork()`` 后不立即
+``exec()`` 的行为、父进程自定义环境变量或命令行参数、以及文件句柄跨
+``fork()/exec()`` 的继承等。因此，此类方案对依赖特定进程生成语义的现有项目
+支持度较低。
+
+使用用户命名空间
+----------------
+另一种思路是在独立的用户命名空间中运行进程树，并在该命名空间内授予 setid 能力。
+这样，进程可以在自己的命名空间内自由切换 UID/GID，但只能映射到系统范围白名单
+中的 UID/GID。遗憾的是，用户命名空间往往需要与其他命名空间配合使用，例如网络
+或 PID 命名空间，否则会导致失去 ``CAP_NET_ADMIN`` 等关键能力，限制了实际可用
+性。
+
+使用已有 LSM
+------------
+当前树中没有任何其他 LSM 能够对 setid 转换进行门控，也没有实现
+``security_task_fix_setuid`` 钩子。SELinux 对此钩子声明：
+"由于setuid仅影响当前进程，并且由于SELinux的权限控制不基于Linux标识属性。
+因此，SELinux不需要控制此操作。"
+
+使用方法
+========
+SafeSetID 在 ``securityfs`` 中通过写入 ``safesetid/uid_allowlist_policy``
+与 ``safesetid/gid_allowlist_policy`` 文件来配置策略。策略的格式为
+``<UID>:<UID>`` 或 ``<GID>:<GID>``（使用十进制数字），并以换行符结束，例如
+``123:456\n``。写入空字符串 ``""`` 可清空策略。为特定 UID/GID 配置策略后，将
+阻止该 UID/GID 获得 ``CAP_SET{U/G}ID`` 相关的辅助特权，例如设置用户命名空间
+UID/GID 映射。
+
+GID 策略与 ``setgroups()``
+==========================
+在 v5.9 中已加入对 ``CAP_SETGID`` 限制的支持，与之前对 ``CAP_SETUID`` 的处理
+相同。然而，为了兼容用户空间常见的沙箱化代码规范，目前允许具有 ``CAP_SETGID``
+限制的进程调用任意 ``setgroups()``。这意味着在这些 ``setgroups()`` 限制策略
+检查代码就位之前，**当前的 GID 策略并未提供任何有意义的安全保障**。
+``setgroups()`` 的限制将在未来版本中加入策略检查代码后真正生效，该代码将依赖
+于 v5.9 中加入的 GID 策略配置代码。
-- 
2.43.0

