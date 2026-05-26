Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585E3F65E6
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796718; cv=none; b=d2gWsBllOsj6/RfINRGAKh12nq3B3i/JVSKM8Elaf3d8MRn/d86jeiy8qxU9JyfUJaqnkCf0I6cBavjbKU8+wjVC/nxlsMv4AGrGFbcLCHl+coFKFxjTazbdknskUkubX2hvoO0dxB5KLc0/Gs0ABQqDce1S/nEXl1atmbYbOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796718; c=relaxed/simple;
	bh=5W28sDVkarRvqQjMAW82poEsdm8er4gFoT6JmY4x6m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HATz1KQn95q+hlmNZRmvP9l9wqzHq4Nf6zlt74H5el+CZO90GvOHl0SgtfG9yfMBv31DuZB2D9bEbagFT22Rnc0brmpCRKTaiz/Snu1yQNzhjB/ACrEBX1Nt2KX1wC3BWbTJy6AaAevyrINZn3QCpkieOtQlZf38zaxJz5L36lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VA0Jqz6j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VA0Jqz6j"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d75312379so8844805f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779796711; x=1780401511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=VA0Jqz6jVFQ3yG6JwjGmfh7ff1Fgh1ZUasbed4oLwSnhPy7hmDa+VJXhPlslsr2lf3
         dCfGJ/BlvpK1djedBbs/RsSwK5sU6gfpJx8y7ghea+Iex1zA1kt4/BJ1gJrVVakaU4uW
         3eykLx+EnyHxFFSbLmeIbeX83v8kggpomupg3YRCqE80PBMwgzB+a6ZAKXoX5sh9fJdZ
         0yplQBP9f+MfgOhTiS5MqoerJ7SFFfLvBkmvNjcQWynCwIsp0xAQczN02eM+05m7iAnS
         adXc25rRVCCaBiYcu+s0zDLRDRgYRepTcPicuWltRB26Bf8Zx40bV1/0tKp1NQ5Nttxq
         x78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796711; x=1780401511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=gO6Z4hjIj8D7qweWdZbJzG0hbwBBu9rRLnbZ5uZ7hjyX4TTrmufFqqo8rSclrWi+tV
         Zple3dDY1KahWAt7xWl3xXxn+O4JP38efc6y/MuvR7eApoenxeFn2DtAdBd+EuU71nMh
         bsJH5ayB45r+U46ugkWul0V+6dijCp1vLw7lKspN3NVkNo9IqtvwJj1a7MitARKEHYWN
         SzUSC+DN3E9kgjaL09AWcgHeXKXQTT1mRtVA/B8KwSoqok9+c88TPBd8nnIRwK4fUzQ6
         +d/vmHQKETINrfK/i+JF0WEYRsN2n4F56IQi6CzgmX1u9Cbv/5vCwpIXMElF38Ec5Vlt
         BZdw==
X-Forwarded-Encrypted: i=1; AFNElJ/dkvkv6OiiZ+gsC9cG60USSf9BrqoTrTmAxysEQF1J5jSixly/05/q5tx6s0ktENli3Nn4mhVsKjL0goU4SaIPnTzwCHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Imf6T83o8nMQ1rIrvSuSMMzpzddMrhubMrxnW3gOmsu4HSqk
	xWju6uAIL9UmRdZWCMCBFaSa5A+c7HFUFLoEhYn7zPh2ygaIrjvKwc1yOhW7nGvYLOM=
X-Gm-Gg: Acq92OHz/JU3UkyK1S+4MTGc71xwZPKJt34Bc25sNeVg0KM1UxtNXh8DADw14mAVPg7
	//G5RoaEsBczCde649EJMut22D5NwFKfDyAjdbI3WpOEDHDIh3BN6OVR4mzyUQBI1x1KJbN29qd
	GNMF1xDbRLfIejXDIeoUed0ZeYvvZaJGAr0I18qu8LhsUalsuDhf3KzNMkabp8peSgkyIAM/f2t
	wMwzlM0YEK0NBR+LnOKu5x9yu3ky7bn0JGY825GuuONtCyo8Jjtc7uEsmLD4hfOLD5tie6wWl3C
	HC4RksB1k9Ecrs/flVAurSRG6OS4xjFQ/RU9fEDJm0N+F8UZ7AO5yZXGIxoG9ZgJ2RI00/avzSE
	BlZwEM/KNnqjQjSx6sfd5UCWbUHdGdlIgAcIDaFiURjIKBo0C688whnpKpv/JFQ2mzP2qlgcWVy
	NxyUg8n+zGXpW+JhAsXPF9KlF75AKGyTGD2YzfbsIDxwaHNwLjHKAq78VrjQ67H0rLuLpegKZMO
	JNBN9a7m6rYuxI/M8av3RknrxqvDNmmLbQ6aCw/SMPspVjXhUXt87ezsf0SiMWwK/Xv1g==
X-Received: by 2002:a05:6000:2888:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45eb30de822mr28814928f8f.5.1779796711490;
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm36462739f8f.22.2026.05.26.04.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Message-ID: <885a7940-3fcd-4fc4-b80e-cd82a817defd@suse.com>
Date: Tue, 26 May 2026 13:58:29 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] module: Move authentication logic into dedicated
 new file
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> The module authentication functionality will also be used by the
> hash-based module authentication. To make it usable even if
> CONFIG_MODULE_SIG is disabled, move it to a new file.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/auth.c b/kernel/module/auth.c
> index 956ac63d9d33..831a13eb0c9b 100644
> --- a/kernel/module/auth.c
> +++ b/kernel/module/auth.c
> @@ -5,10 +5,16 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> +#include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/module_signature.h>
>  #include <linux/moduleparam.h>
> +#include <linux/security.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
> +#include <uapi/linux/module.h>
> +#include "internal.h"
>  
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX "module."
> @@ -30,3 +36,82 @@ void set_module_sig_enforced(void)
>  {
>  	sig_enforce = true;
>  }
> +
> +static int mod_verify_sig(const void *mod, struct load_info *info)
> +{
> +	struct module_signature ms;
> +	size_t sig_len, modlen = info->len;
> +	int ret;
> +
> +	if (modlen <= sizeof(ms))
> +		return -EBADMSG;
> +
> +	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> +
> +	ret = mod_check_sig(&ms, modlen, "module");
> +	if (ret)
> +		return ret;
> +
> +	sig_len = be32_to_cpu(ms.sig_len);
> +	modlen -= sig_len + sizeof(ms);
> +	info->len = modlen;
> +
> +	return module_sig_check(mod, modlen, mod + modlen, sig_len);
> +}
> +
> +int module_auth_check(struct load_info *info, int flags)
> +{
> +	int err = -ENODATA;
> +	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
> +	const char *reason;
> +	const void *mod = info->hdr;
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	/*
> +	 * Do not allow mangled modules as a module with version information
> +	 * removed is no longer the module that was signed.
> +	 */
> +	if (!mangled_module &&
> +	    info->len > markerlen &&
> +	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
> +		/* We truncate the module to discard the signature */
> +		info->len -= markerlen;
> +		err = mod_verify_sig(mod, info);
> +		if (!err) {
> +			info->auth_ok = true;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * We don't permit modules to be loaded into the trusted kernels
> +	 * without a valid signature on them, but if we're not enforcing,
> +	 * certain errors are non-fatal.
> +	 */
> +	switch (err) {
> +	case -ENODATA:
> +		reason = "unsigned module";
> +		break;
> +	case -ENOPKG:
> +		reason = "module with unsupported crypto";
> +		break;
> +	case -ENOKEY:
> +		reason = "module with unavailable key";
> +		break;
> +
> +	default:
> +		/*
> +		 * All other errors are fatal, including lack of memory,
> +		 * unparseable signatures, and signature check failures --
> +		 * even if signatures aren't required.
> +		 */
> +		return err;
> +	}
> +
> +	if (is_module_sig_enforced()) {
> +		pr_notice("Loading of %s is rejected\n", reason);
> +		return -EKEYREJECTED;
> +	}
> +
> +	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +}

The resulting call chain of the module authentication/signature
functions is as follows:

ima_read_modsig() -----------------------------,
                                               v
module_auth_check() -> mod_verify_sig() -> mod_check_sig()
                             |
                             |-> module_sig_check()
                             '-> module_hash_check()

I think this logic is quite hard to follow because mod_verify_sig(),
mod_check_sig() and module_sig_check() have very similar names.

The naming of module_auth_check(), module_sig_check() and
module_hash_check() looks good to me, but I would prefer to rename
mod_check_sig() and mod_verify_sig(). Perhaps mod_check_sig() could be
renamed to mod_check_sig_header(), and mod_verify_sig() to
mod_dispatch_auth_check()?

Otherwise, the patch looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
