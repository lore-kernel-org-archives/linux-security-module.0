Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006526;
	b=VXHdMgWGic5vvITVIvd588l7by1/AB3k6UhlmKyBd8byLR8Hm2PGB/ak9NrSv96Uak78
	 Ryp2zv5kg+Ks/R+R1OBms5XIIV76A9wv/mVEkJLeSN8KcaNGGQ6kSpaZRQTLeFeBhGeHY
	 YyJEl7ZmOLaJFUfU9rRPGwef3POrYPPKtDWFOh5AjLTam/dkBRpXdT8q9yxGc/1JfwRTO
	 0vjoBl/0mCZwzJVe/9uo8QzTV+52A/aIng+b02yy5iKkVOxop0H6nie+ka9GiyNrIP/D4
	 t4rMq93EPDRCdNmQJQjTw6NiCOT7LtMr+KFG/7oC9YzhcIyRgtVQWfSR4To/ovdoWdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006526;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=A8D3nIxhr5bal3Mn0kwblN+gP6Dp0HIaeR34R++ab2Q=;
	b=OTl3pF2+uWsyDitKZR3GtkKhobDzpyJb0dhnuF0So5jkyEd6Iuc9lik17XAtv0JV8pZ3
	 FnqcmeiSkFyqRGDTjJLYhSQXkpT2n+HFQvpjnRbOu8XJGtiSMYX4FSpjUjfymhylGhYu2
	 U5a0hSSYhH3hSzMHh+YmEpxO3psQrLhOk2CS7t7kbbovj/B7YmF9WdnYBw7zjgmCFaoiC
	 srxJ9xCKIeyYwhduYsy7hrg7+S+n+vL76YlshiGT9CwLgcNnYG6q2Nxhwwfv9Cm4dalHu
	 hwOaPQljRP4U4bu+J0AOqUiRRiR6T2JnZkuNqbOQlHpyrTsCC2zm2v37qmcRN2ziC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83B606A31A;
	Mon, 26 Oct 2026 09:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C83B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with UTF8SMTP id IQEQrMAWPneyG99qrY9cAA--.45505S2;
	Mon, 26 Oct 2026 17:21:54 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wC3Si2uG99qpnwPAA--.31241S2;
	Mon, 26 Oct 2026 17:21:51 +0800 (CST)
Message-ID: <895533d5-99d7-406e-acc2-1f8659075f91@hust.edu.cn>
Date: Mon, 26 Oct 2026 17:21:50 +0800
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
Subject: Re: [PATCH 03/10] docs/zh_CN: add LSM/LoadPin Chinese translation
To: Yan Zhu <zhuyan2015@qq.com>, alexs@kernel.org, si.yanteng@linux.dev,
 corbet@lwn.net, mic@digikod.net
Cc: skhan@linuxfoundation.org, gnoack@google.com, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_4D8EDAC71A10FADF8B5C682C57B266EE1A09@qq.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <tencent_4D8EDAC71A10FADF8B5C682C57B266EE1A09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMAWPneyG99qrY9cAA--.45505S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4rJF47JF1fCw1DuFykXwb_yoW5ur13pF
	n7KFWxKw40k343GrZ3GFZxC3W5Aa18uasrCF1xK3Z7Arn8JrZIywsrKry5Jrn7GFyrKayk
	ZFW3KFWFkryjy3DanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0P73PUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/12/26 11:58 PM, Yan Zhu wrote:
> Translate Documentation/admin-guide/LSM/LoadPin.rst into Chinese.
>
> Update the translation through commit 0860b72d535f
> ("security/loadpin: Update the changing interface in the source code.")
>
> Assisted-by: Claude:deepseek-4-pro

Assisted-by can be removed in your next version. Apply it to other patches.

> Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
> ---
>   .../zh_CN/admin-guide/LSM/LoadPin.rst         | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
>
> diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst b/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
> new file mode 100644
> index 000000000000..d75a06f515f6
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/LSM/LoadPin.rst
> +:翻译:
> + 朱岩 Yan Zhu <zhuyan2015@qq.com>
> +
> +
> +=======
> +LoadPin
> +=======
> +
> +LoadPin 是一种 Linux 安全模块（LSM），保证所有内核加载的文件（模块、固件等）
> +均来自同一文件系统，并且该文件系统应当以只读设备（如 dm-verity 或 CDROM）为后
> +端存储。这使得在拥有经过验证和/或不可更改的文件系统的系统上，能够在不对每个文
> +件单独签名的前提下，强制模块和固件的加载限制。
> +
> +该 LSM 在编译时通过 ``CONFIG_SECURITY_LOADPIN`` 进行选择，并且可以在启动时通
> +过内核命令行参数 ``loadpin.enforce`` 进行控制。默认情况下该功能是启用的，亦可
> +在启动时通过 ``loadpin.enforce=0`` 将其关闭。
> +
> +LoadPin 会在检测到首个文件被加载时开始生效。如果承载该文件系统的块设备不是只
> +读的，系统会创建一个 sysctl 条目 ``/proc/sys/kernel/loadpin/enabled`` 用于切
> +换锁定功能。可写的文件系统意味着锁定功能亦可被修改，但通过 sysctl 可以在可
> +写文件系统上便捷地进行测试。
> +
> +也可以使用内核命令行参数 ``loadpin.exclude`` 将特定文件类型从 LoadPin 中排除。
> +默认情况下所有文件均被包含，但可以通过
> +``loadpin.exclude=kernel-module,kexec-image`` 等方式排除相应类型。这允许在使
> +用 ``CONFIG_MODULE_SIG``、``CONFIG_KEXEC_VERIFY_SIG`` 等机制对内核模块和内核

Sorry for the late review. This patch is accidentally missed in my todo 
list.

This translation needs update since commit eb0b0d222a832 removes a  
kerne config.

Dongliang Mu

> +镜像进行校验的同时，仍然利用 LoadPin 保护其他内核加载文件的完整性。有效文件类
> +型的完整列表可在 ``include/linux/kernel_read_file.h`` 中的
> +``kernel_read_file_str`` 找到。

