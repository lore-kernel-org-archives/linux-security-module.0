Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594693;
	b=35FQmQA2ySmb8KSfPPwlyMU3+QdGV8aTe+djUAS/EvFxNzBAR0neSz8EjC1lnVm0jyWi
	 5wXW7jmKSew2myjiQZZANh6AwvFZhjd4+9O1SnFg8GgYp0pbsDk8iPp2DWUoyRgeWJXS3
	 wqUMrtzCjEOmHsTWdDps6EhXC1FVg91UFCIozN93W6Ub3M0RKdVQ5eKKKrzCjDq2EY3a2
	 2qdKWuZihYbe1y4ARdp667Z5IsoIw4Jhgw2AAx4BFnKjw/jcuiRQzG5vuvN70hXSLpFNn
	 ZYAqtUlEB2vyEm2UiDFJI47VsVKGJtJm2kjhZXG9hrOzWWS6JLNZM4tKSEuSpq+iE6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594693;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=MbyGB8U9YRrniG9snzlWgjemL8IXXkOYk25rFewhrkE=;
	b=zcGDSqfdkexhsYqIX0HuTFYOWsFhwpn7kALZWHzjq4nocJTntyK9qAOj2WkwJarGcO9u
	 L7MhDOrlhJKYEZ8P+IZ6ADWJ/scSSLI5Vp8IPg/N7oNMN1TRDrOQu4nvfGToqaQv+Zpp/
	 CNAUmH7Kj1E3NtFs5xQaJB5T56OilqX0b77z6H12W/e6WK88fNjsHfvS2MPGzRMRY6A/T
	 EoGiBAq1OhLZkxXprgJ/Y2ILjXlGT2DjFnAtISPqyYuNYR3S3xBwmeSmZehefBHaFkvW8
	 UqunvrKQa7Occerx3vDasNBkwMlkCAeXMRvahwLLgb53ULhxYue4FLYKCn5Dh6JclbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ycn2FL+t;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEEA606A327;
	Wed, 25 Nov 2026 08:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEEA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ycn2FL+t
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MbyGB8U9YRrniG9snzlWgjemL8IXXkOYk25rFewhrkE=;
	b=Ycn2FL+tIkW1u9EHTKdSwJpvHnV15x8giz6KN/9y5ezCzneFIfeGfOxKe4NyUIApTEOQh4Dla
	LDNrQ2Y+DenE39xInHvztvM4CrczFu3AC2fGRJ0QkdpSEvvHRHQzV4rNgKxvGBpKQNhuzM2DgTF
	oYFztxIbNZ16gF5xCo2eLRc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jZCG62Fvmz1T4fK;
	Wed, 25 Nov 2026 16:17:18 +0800 (CST)
Received: from kwepemk300018.china.huawei.com (unknown [7.202.194.246])
	by mail.maildlp.com (Postfix) with ESMTPS id F249F40579;
	Wed, 25 Nov 2026 16:18:07 +0800 (CST)
Received: from [10.34.206.67] (10.34.206.67) by kwepemk300018.china.huawei.com
 (7.202.194.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 16:18:07 +0800
Message-ID: <bbc7ff8b-ef89-45e1-9f6c-3596c5e5c921@huawei.com>
Date: Wed, 25 Nov 2026 16:18:06 +0800
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
Subject: Re: [PATCH -next -v2 6/8] lockdown: bound the status string with
 scnprintf
To: Cai Xinchen <caixinchen1@huawei.com>,
	<nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-7-caixinchen1@huawei.com>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20261110132818.2231593-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk300018.china.huawei.com (7.202.194.246)

On 11/10/2026 9:28 PM, Cai Xinchen wrote:
> Use scnprintf() instead of sprintf() when composing the lockdown status
> string in lockdown_read().  The current set of levels fits well within the
> 80 byte buffer, but sprintf() provides no protection if more or longer
> labels are added later.  scnprintf() makes the buffer bounds explicit.
> 
> Store the level label strings in named arrays and point the matching
> lockdown_reasons[] entries at them.  Their sizes are compile-time
> constants, so a BUILD_BUG_ON() can verify that the status buffer is large
> enough for all level labels, their trailing spaces, and the brackets
> around the active one.
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>   security/lockdown/lockdown.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 84efd533fe5a..26cac7628a48 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -14,13 +14,17 @@
>   #include <linux/lsm_hooks.h>
>   #include <uapi/linux/lsm.h>
>   
> +static const char lockdown_label_none[] = "none";
> +static const char lockdown_label_integrity[] = "integrity";
> +static const char lockdown_label_confidentiality[] = "confidentiality";
> +
>   /*
>    * These are descriptions of the reasons that can be passed to the
>    * security_locked_down() LSM hook, used for the denial message and the
>    * securityfs status file.
>    */
>   static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
> -	[LOCKDOWN_NONE] = "none",
> +	[LOCKDOWN_NONE] = lockdown_label_none,
>   	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>   	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>   	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
> @@ -41,7 +45,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>   	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
>   	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
>   	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
> -	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> +	[LOCKDOWN_INTEGRITY_MAX] = lockdown_label_integrity,
>   	[LOCKDOWN_KCORE] = "/proc/kcore access",
>   	[LOCKDOWN_KPROBES] = "use of kprobes",
>   	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
> @@ -50,7 +54,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>   	[LOCKDOWN_TRACEFS] = "use of tracefs",
>   	[LOCKDOWN_XMON_RW] = "xmon read and write access",
>   	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
> -	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> +	[LOCKDOWN_CONFIDENTIALITY_MAX] = lockdown_label_confidentiality,
>   };
>   
>   static enum lockdown_reason kernel_locked_down;
> @@ -137,6 +141,16 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>   	char temp[80] = "";
>   	int i, offset = 0;
>   
> +	/*
> +	 * Size the buffer for the worst case: the active level is

The comment is incorrect, the total length is the same whichever level 
is active.

> +	 * confidentiality, with brackets and trailing spaces, plus the
> +	 * terminating NUL.  The label sizeof() values include their own
> +	 * NULs, so only three more bytes are needed.
> +	 */
> +	BUILD_BUG_ON(sizeof(temp) < sizeof(lockdown_label_none) +
> +				    sizeof(lockdown_label_integrity) +
> +				    sizeof(lockdown_label_confidentiality) + 3);
> +
>   	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
>   		enum lockdown_reason level = lockdown_levels[i];
>   
> @@ -144,9 +158,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>   			const char *label = lockdown_reasons[level];
>   
>   			if (kernel_locked_down == level)
> -				offset += sprintf(temp+offset, "[%s] ", label);
> +				offset += scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "[%s] ", label);
>   			else
> -				offset += sprintf(temp+offset, "%s ", label);
> +				offset += scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "%s ", label);
>   		}
>   	}
>   

