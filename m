Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD0153BE9
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222910; cv=none; b=MAzuWdVM4YZJGxNB86cNhGyt/2u3snQAjVThaYlxs3Pk8pOZSrVfDmcr5MZ05JyIwsi3S3RpRkJAw0EpUf3FY4EUB0cXIRmAlB1jal58V5ZrwytGCscJa1sThcIyANH6vvdUk90ymcVdfz5H9droebrv7Nopvyw65qKVfmFJ/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222910; c=relaxed/simple;
	bh=CdX8Qwb4P1o/hcHptjiAg9CZgwE1KcXgvFcvzc961dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtp0/g5oq8EYbzVTMDssL2CH0IzfjFPLkGCynUv1FLLFQTunbPK7QCPWTxzyTePgiUqbUuALtd4xzmwrya4vdTp8cwYGpITE9I5OphNxPfmg+Zh6ZGDSGmii4x1UV05nC21q/sen3PyFpuW0olP/cvVPElcbrwqAv8FZnaUYX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQYdYFyl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQYdYFyl"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5177945a279so3761781cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781222908; x=1781827708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKG4KW6S/RXhkFtQLuUCBdwnT8PSZQpyI8y4jFz+S04=;
        b=IQYdYFyl5haIjJPowgCvMDhVmGhtOlKqPrIZwLERV+tl6jHyj6ISRn57hCkZTTpLzs
         JzLps3HqWFoOAr2raldq8vDOgdAE5Kq5VvjYqsmNKJV6OPfYgQ781t7tclzV4LB6gCQW
         kLPlEaMUon4Mmg7AlbmECD2tvq51cCpQtznOYNnmD70zH4AxA1JYDfQk3JNYPmX4q1SE
         P6ADQudmVeMRITf+sSgHlbBnfjyyiwyfvbicNFD9ak16OjZxTxZ3cJbxVcG/iPRWwexU
         7lDd4el6GkSzywOJSC76M7VGV5bNSNOy5EtwErIPUDDwZdYOkQq3NOvguXeI/ouSB7FF
         vC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781222908; x=1781827708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKG4KW6S/RXhkFtQLuUCBdwnT8PSZQpyI8y4jFz+S04=;
        b=Q7qrCDm2w/jtb3zJ36+yG5ExP0/mGgCg3rr2u2KuU11/Ta0Lzs4QSDrdu6HG3llu8s
         qu8SchpCQVXtB1UxH1erWZrBr0eSiKVInJTYyMTx5TtT+eHYA7wkSYgfC2MPi1KjM3eo
         W7jPp5wWu4jBiF5GYygWNY/a6Ciw7bY91vvAEESUVrgjG/efILQpUK0UXtbgFAgsO8qw
         KnNGgfdXTYY1ys5JcC4bgLge/OPBTYB9US6WrSDE4uVFCEnV+AbWMcSf4dQTOII/HIHB
         M4smnXp6Xt9JB8BXnP87oK1h3GF1fzwzVRWmaYSoSyYgX0/PWvKxQxMfspTHjcWCcHmy
         4y9w==
X-Forwarded-Encrypted: i=1; AFNElJ/ajVSPpTk0fewgOnCyZRfPhClazncy2hXhll0VR3Y7w3oE/0/J4osavjkauf+yyHvUK9wTRW3QWGHOw+mB59LQ+pbCwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjiq04VV9OfwvleJmeWGA5XPgNH7GY0nmTQ2e20Whm5VuF9CXz
	odlMVOTXMhNEUUR5SHFYupwAd9+0d5tBjoZwbMPE5LUlolUvXzDlTIwe
X-Gm-Gg: Acq92OF4FzqCGDjySdLymS75h3r1TcMjZyuMNTh7ey+VV4TNNCgk2RujguWtVU2+KhB
	l9mA2FlJuf7O5YfoRISBEAWgjhw0WfAGrGohBgL17qVxCcfAiAWTaJbMh0pdE5Iz6Y+DV4yk8pj
	AlxF3YTQryXz9x3R+MyKN50Y8KfhsVvXyyewBLbf6dQgHT9aUQ3ghrzTIapTdHlslWh5GvdDEdt
	FV2/smbaxyHUbkhQH897a76MLeVVloU4VqB6aFPI8rX+vpRemclnp6S72qG6dmFiB4/l5j0JVMz
	vKLYPXyg6DNCSfSkYC+CkMuD5HPym1XQ3IRyRlpkQgYtl+uG6UoGJCg26PpRDDHyZ9ZZ5XqMlNC
	KFt9USOv2uJn7TJCiAo6DEe69WNmoIcHCgdy+NDVB47R2yJW5138FfpAuKs4q1hcDLJeCGitcZo
	nao1r4fXWHnAcUsOEbLT1v18sHDhGecww71g/44C/yfX2r5TLp0qfsbg7/FCRPpN9I1pTzQeLKi
	CH+aPkeCiok1AnZA2ooI4BCjA==
X-Received: by 2002:a05:622a:8c1b:b0:517:c65c:3dba with SMTP id d75a77b69052e-517fe5edd81mr5583751cf.38.1781222908419;
        Thu, 11 Jun 2026 17:08:28 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79df4dsm6590911cf.15.2026.06.11.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 17:08:27 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: alex.roberts109@outlook.com,
	Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
Date: Thu, 11 Jun 2026 20:08:25 -0400
Message-ID: <20260612000825.105100-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 01:59:10PM -0500, Alex Roberts wrote:
> +static int loadpin_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
> +				  struct bpf_token *token, bool is_kernel)
> +{
> +	int res = 0;
> +	struct file *exe_file = NULL;
> +	struct mm_struct *mm = current->mm;
> +
> +	if (is_kernel || !mm)
> +		return 0;
> +
> +	exe_file = get_mm_exe_file(mm);
> +	if (!exe_file)
> +		return 0;
> +
> +	res = loadpin_check(exe_file, READING_EBPF);

Why are we checking current here? IIUC this will be whoever calls
bpf(2), which would be the loader, which would then be able to load bpf
programs from an untrusted source.

In the kmod case loadpin_check() sees the .ko itself.
