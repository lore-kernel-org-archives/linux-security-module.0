Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930232;
	b=YmPjDyRsSNUCG3j4BXP26ZP9x8bByvEozk5v0j8x7Ins9CcCGmmGUZHMJ2N7X2s+QUJ2
	 XKspHzORmzOW/OAxcyI3QR/M06QBRWbO4S8zG7NcU9wu9AYEfTLo+hly7oJCRROwbzTwU
	 j4SW/xZIVnYWiWOPJdWFAYYJayuhBbQh8cycfrXzcv9Ln1MDa5m69pNnX6pxNpgHk76tH
	 Y1nmv0FiScLaZlfzwpZzVx2HT7by45XK+c0s5eWYhfoj/nBTJS5wrgkpr1123sPlPPt/e
	 WCFD+FX1+AesjXGt5Cg4umI+97V23Zvv/QSY8fIPc58hglJZFeC9ZJ28I+w3FMZVR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Wd1stQW0PnAi11G70cjVexCVdL0BocGOfoLmEtZFQiM=;
	b=PEsZ/XgV1QB1FGxdvTYfBlNzEmSEyXBz19h5JJhRnELhAMKB1USfy6s74d0MZhvrfDz9
	 YUuc9L31g9Es6qLwMJWUuSKz8fAw4rpk8j0ixOvb+Y9Tq7LIJLW8EIHXUFWCj7u+CT7o6
	 aBgkKdA8iiqQaIYepf3Gfva5GrLgRHfG6yeOgvH30n/IWNlF1F5t7pXYFtXV7KVtu60w8
	 BLvFAYLeFyYgW7gV0VnkugQZqwDrUePvo3xVtqiPNAYuKoRQAccLv5uvEsm6L7exOHnjU
	 RN+9CqaCmKu95NAyIKbr1hip+3n+2AfpZD3Eh1dJYz1ERZ5hnHySOt5TwFAfdjBKGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ODHK5hx+;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CA606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ODHK5hx+
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so31925e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794930230; x=1795535030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wd1stQW0PnAi11G70cjVexCVdL0BocGOfoLmEtZFQiM=;
        b=ODHK5hx+CJtmtLLRX9383lNNMFawi9iv9cvkjFR+rdOwyyvJedpqLeXMOxleYJuw3q
         gu/tHsFeimW6HYfsF9dmqVesit7SL+ADMo/MQDoHeL2NjKYV0WJLXuDbEPgop54jTwF0
         jmOJTMC+mx8xLm7u8uNmUv9rwf9jlV9hgpCgq5J7BJMpQzKtaJhTqyS1RGxYXRJikPiH
         MbrHJxHBHda9Z+92/MZwgR2HIB6vK7Mmnr6BAOH4xwhjDPdbO09n/gx7vzHKBYZbeSvW
         H9MLH7n7C0A+6kjnPtGh1HVgt9UOayqImdWlqsaxzpAfjnwUJ8mt0jbQdalCSgKSj7m3
         oWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794930230; x=1795535030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wd1stQW0PnAi11G70cjVexCVdL0BocGOfoLmEtZFQiM=;
        b=1pktqqc+QGPHBewxYaKHR4lR7oLgtgkvQbTtTasDBz508z6KAP18soCjfFw7Meca2X
         qVWj4PsgXuKlMlF251X4vOAd0SOiO21EVL0HXBBzQnHiKoU84P4MwW8f11Wh2dSzemNj
         OIEE0B6w6wvjQRx4KIBxUt5/bZlAMnaD0s7llUmZwvL7MpDYVpfNVqcWuzu9TxreARyy
         aZma2S62utbXRU0gf/v6It6Fflk9pi3YNzuePPV93qZVRvJLDoox0yqbHtY+0oysHWlH
         tCPcIH39aAwZMWCUDSQpXzE1vQta9jAsEp4CAXPDN9OZrPJH51qBSDmZm/bUrQeK/Fe2
         YMDA==
X-Forwarded-Encrypted: i=1; AL+hErG7eReY3HB2V3A/otUoXoZN1YB/2hrSZpaN6ve6Xg40rxYglaEpKlY9ybIm9LMbsP/Ao+IeB+DmP9UtOIU1ItnLzovRgr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JTM+if8tZwh8nIah0TF2bJE7IN3GOqxnvHo3n2NnODakh1JCU
	haVNtApB+apbFFOobdDlt/r1iROZ5prlu9La9QOy2tcgg/YnH/ipPACcOrBNjr0/+w==
X-Gm-Gg: AYBFou2QyobHOHMBeV+iPZJ7/EaY2ZVKTGLRf5UHtX9ROLItZqJF9RTsVC0n/7tPtV7
	vcK3lZxlN/27F79mPLwpbAQ8YhBITGO3uj98lXkBuWPe4ty0O4MeicvaZoBBJ3dj9/RGHBlZ9fs
	xOUEsIdfHYqs0KuVJOAYSlsmpH3pHVE0NKZvTqJURkcPjh+6up5YWNBKfOMnM/iRg1v0FSnWbPx
	OaSV7avk7il/4pjI5Yr8Mp+r+IkT5BL/BAh97ehAkWbJLreTLEOhEAzGA/rS5RkHn8JfXV7FC+H
	aPOMItVXdzpRNO4H9TnBEKAb/LkCZceEyEgTUo30CN/l856U72eTbV+YRFHIMf5tooCLiWivjZo
	Oq/AWgjnf8kBSwgig8DxLaslzdCKGj96MdrfO1++9dmkIRiadzTR/oijzaeiHR26wZ4jv/rMSwl
	3aXOAhdO1kyO8gDpOIzqnucWKBDUF5gixP5/KVOCgo0I4PzaDhmo50PHYUKr5L5RY03Cj6qu4y2
	QMs1597OC1TUOO3077YTegnhgKOssYJeL6YXhP6mcCihTrMYq6OfyyK7GKO+2mKQMMf3dvT1bMw
	nOcr7YJjEBCXHB/zeDyoarcmOJ95Y/TTzChLmrkZXDxjrFirA20OxbErg6lf
X-Received: by 2002:a05:600c:c166:b0:4ba:6d8:df8f with SMTP id 5b1f17b1804b1-4bb55a832c0mr330308195e9.15.1794930229860;
        Tue, 17 Nov 2026 07:43:49 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:12e4:4602:d8d8:3043])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm265535875e9.3.2026.11.17.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:43:49 -0800 (PST)
Date: Tue, 17 Nov 2026 16:43:43 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin
 memory reserve
Message-ID: <avx2Lzzv-i9KrKFO@google.com>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-5-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117101157.2520463-5-mic@digikod.net>

On Tue, Nov 17, 2026 at 11:11:54AM +0100, Mickaël Salaün wrote:
> With vm.overcommit_memory set to 2, __vm_enough_memory() keeps the
> vm.admin_reserve_kbytes reserve for callers whose LSMs all agree that
> they hold CAP_SYS_ADMIN.  cap_vm_enough_memory() checks it with
> cap_capable(), so a process in a domain that denies CAP_SYS_ADMIN could
> still use this reserve, which is meant to let an administrator recover
> from memory exhaustion.
> 
> Add a Landlock vm_enough_memory hook that withholds the reserve when the
> domain denies CAP_SYS_ADMIN.  Like commoncap and SELinux, do not audit
> this check: it only selects a limit, it runs for every accounted
> mapping, and withholding the reserve can only make an allocation fail
> with -ENOMEM.  As with the previous hooks, LSMs implement their own
> policy in this hook: SELinux already checks CAP_SYS_ADMIN in its own
> vm_enough_memory hook, so making commoncap call security_capable() would
> make SELinux check it twice.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://patch.msgid.link/20261110202436.2408244-5-mic@digikod.net
> - Add Serge Hallyn's Acked-by.
> ---
>  security/landlock/cap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> index c89e8d76db8c..c9a900888f3b 100644
> --- a/security/landlock/cap.c
> +++ b/security/landlock/cap.c
> @@ -140,10 +140,32 @@ static int hook_mmap_addr(unsigned long addr)
>  	return check_cap(current_cred(), CAP_SYS_RAWIO, CAP_OPT_NONE);
>  }
>  
> +/**
> + * hook_vm_enough_memory - Restrict the admin memory reserve
> + *
> + * @mm: Address space being charged (unused).
> + * @pages: Number of pages being charged (unused).
> + *
> + * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
> + * reserve, but calls cap_capable() directly, which skips hook_capable().  Check
> + * the same capability against the domain.  commoncap runs first, so this only
> + * sees tasks that commoncap let use the reserve.  Like commoncap, do not log
> + * denials: this only selects a memory limit.
> + *
> + * Return: 0 if the domain does not withhold the reserve, -EPERM if
> + * CAP_SYS_ADMIN use is denied.  An error does not fail the allocation by
> + * itself, but without the reserve, the allocation may fail with -ENOMEM.
> + */
> +static int hook_vm_enough_memory(struct mm_struct *mm, long pages)
> +{
> +	return check_cap(current_cred(), CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, hook_capable),
>  	LSM_HOOK_INIT(capset, hook_capset),
>  	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
> +	LSM_HOOK_INIT(vm_enough_memory, hook_vm_enough_memory),
>  };
>  
>  __init void landlock_add_cap_hooks(void)
> -- 
> 2.56.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
