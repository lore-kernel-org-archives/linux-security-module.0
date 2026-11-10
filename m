Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318135;
	b=yBeVJsPc+k9H/XR6IyFimYT8FS4dy9ry7ZI/enVVuKcziekq8Wn6qQ+YPMhBexgzodkh
	 qS8xyk/1hLkOX/aK6CgWZ5mm7/Nw+XraeJZu8AQiF1I5QYZlhvOTuSCXSZpd4q8ziTYuq
	 rCMp1Q7Rq0hdeikCx0xafA88hzjg2k9d7e4EQdEZNA8slgsiaTAeXcE3mAmowjmMB/aaV
	 LJ40EGZ73hrMPzx8ZIv8m7Pg0hSYJsMiINvjtEhp/Vl1101nncNc7MYdo51W52Ez+ickj
	 Oyhra8F6P0Q97PirGAZ/8VxsYkW+heADxFEXl2mig6gJXl4MtHfsRuqBXV++e98YI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318135;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eYs+Fegr6eB0PcIdRKpfDtRPaQfHYvt3G6SFzIB7RsU=;
	b=N+TyVh1choJ7aU0Xe0SgrYliyKlHHlXJ8+f6STu0JZaP+9KRqckzZJEG5RNhj+JF2C9r
	 z0hESO6KbAxp0J8LJZyRDgcPQlHiRTgotnIO1UpKfm81E4OwWzaQEagqPTXpkUnlUoPiO
	 UY16l6Kzef2fcB45rcVIciSvbmWOjqZbe3s+YW79n8sjwm0WA9sROex0EjdefBDkopBel
	 xo9EwldqiOE25sf4f/R3mfn0KIvqEk6t0WiFkxAlREy84LBVMj1GeUU/MYj4NMokw7pEU
	 y6uVS/RJ1qhNUzUD/uN3JGQtuEgLFOQYBSSgXwJptXnqGyXXopCPxzoxYpQdMSweTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b="OWss4i/Y";
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C8606A31C;
	Tue, 10 Nov 2026 13:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=OWss4i/Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794318130; bh=bcXqt42XRNdswsbMlIOG2xwf1uaEU0fPAUEiWxCSUDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWss4i/Yjw9dRrX/LmMsLYgUWxJ+o8/z5DZn9qibpbXXSzkPbDUzYwDYLCIYs1gcx
	 fEeMyosyxsEliU4a7CKhRtCAgJpAd4xKRfQvdPBogMWiJriO77hH6kNmGuV8+8wL8s
	 9XYH70cmhye5WlBAdtKFf+mMY7XnwRnE6/u36uVXysk5lebN9EdFUUh0qsPRs9B51m
	 guCg9DQtsLm29wpsXciDSxRk09AKEV/I+Ta86fX0XjWKs2zNR+Vh1s5chdAoLYrL9b
	 D0NQ2IzyqjN3e8kjqe2n3NCgFZcewfqvtrEYJRSZr8wdyB5lpuYGUJNtFvUMAK6NKE
	 qD6nEVIwRnuww==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E5727B8D; Tue, 10 Nov 2026 07:42:10 -0600 (CST)
Date: Tue, 10 Nov 2026 07:42:10 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
	paul@paul-moore.com, jmorris@namei.org, shuah@kernel.org,
	kalevi@kolttonen.fi, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next -v2 6/8] lockdown: bound the status string with
 scnprintf
Message-ID: <avMfMnoJUb9bIYbG@hallyn.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-7-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110132818.2231593-7-caixinchen1@huawei.com>

On Tue, Nov 10, 2026 at 09:28:16PM +0800, Cai Xinchen wrote:
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

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/lockdown/lockdown.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 84efd533fe5a..26cac7628a48 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -14,13 +14,17 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
> +static const char lockdown_label_none[] = "none";
> +static const char lockdown_label_integrity[] = "integrity";
> +static const char lockdown_label_confidentiality[] = "confidentiality";
> +
>  /*
>   * These are descriptions of the reasons that can be passed to the
>   * security_locked_down() LSM hook, used for the denial message and the
>   * securityfs status file.
>   */
>  static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
> -	[LOCKDOWN_NONE] = "none",
> +	[LOCKDOWN_NONE] = lockdown_label_none,
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>  	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
> @@ -41,7 +45,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
>  	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
>  	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
> -	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> +	[LOCKDOWN_INTEGRITY_MAX] = lockdown_label_integrity,
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_BPF_READ_KERNEL] = "use of bpf to read kernel RAM",
> @@ -50,7 +54,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_TRACEFS] = "use of tracefs",
>  	[LOCKDOWN_XMON_RW] = "xmon read and write access",
>  	[LOCKDOWN_XFRM_SECRET] = "xfrm SA secret",
> -	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> +	[LOCKDOWN_CONFIDENTIALITY_MAX] = lockdown_label_confidentiality,
>  };
>  
>  static enum lockdown_reason kernel_locked_down;
> @@ -137,6 +141,16 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>  	char temp[80] = "";
>  	int i, offset = 0;
>  
> +	/*
> +	 * Size the buffer for the worst case: the active level is
> +	 * confidentiality, with brackets and trailing spaces, plus the
> +	 * terminating NUL.  The label sizeof() values include their own
> +	 * NULs, so only three more bytes are needed.
> +	 */
> +	BUILD_BUG_ON(sizeof(temp) < sizeof(lockdown_label_none) +
> +				    sizeof(lockdown_label_integrity) +
> +				    sizeof(lockdown_label_confidentiality) + 3);

Awesome, thanks.  It also might be worth it to replace the 80 in temp[80]
with the calculated size, but this is safe enough.

> +
>  	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
>  		enum lockdown_reason level = lockdown_levels[i];
>  
> @@ -144,9 +158,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>  			const char *label = lockdown_reasons[level];
>  
>  			if (kernel_locked_down == level)
> -				offset += sprintf(temp+offset, "[%s] ", label);
> +				offset += scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "[%s] ", label);
>  			else
> -				offset += sprintf(temp+offset, "%s ", label);
> +				offset += scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "%s ", label);
>  		}
>  	}
>  
> -- 
> 2.18.0.huawei.25
> 
