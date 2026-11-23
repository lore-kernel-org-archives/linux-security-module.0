Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475564;
	b=WfJU26mJlLYPV4VKIbf08gIOOQn4HDL0ekwKFXfqXzlDC3uRh5UKoqJTePtECT3KT2AR
	 o+kAcmIkcCG/QyPYPVx1PH7M3dARXLebQl4WehfFL2gNt7resUoHvUNNPqlwK12CVIaJb
	 fTmwajhuH+axQe0XluoAyUTt44HSqknFUoPxAxhS5lNcLA4iI/1JbL4UB3yUsfnKjO8wf
	 HatJPyhkdgKN7eCEUMrgpDXAGSubPC9hvVZjfibfvUxg0VJQdkIkh2kHx5B9xEvdTeh+a
	 Kgxb2e+qji66OV4X6adUmtpA8dWVVugOWW+KM5FLAJF2+DNUBUYXc4JqtYAeF/HH3Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=q2TFBSFs2Zy87zyz/nbhCDASHv4d4kOnFRJqrbZETyI=;
	b=BEzedujdiRVxEJJyHSklyEsojllD+HfC63+M08nYFi27NnljllccLXE9G7hVYCDR2Z8s
	 9z5rofJYIhX31YvYb3p8NSIqbU6NPcX4Y7jQEOCaEhk7fXzjjd/gSIVXNKjqz1CcRNGc0
	 l1SwV9l/1wJaghHxCY6H+mC+9nAluNQ3WxzyZZ/fyHYq8Iye4+/D9P95nEU4U9HChwMbg
	 Zlk96ZGyGBxq0bB4aht4MbH64pMO2PHkQPQAjJXcszNSfHebEFKchusSnkzOQxXF8JQSL
	 inT9ZG9atcERAf5/jSFqvMa6Y+dO9d+zVdhdHuELrLdQ+oxBNaUaFUt2TQ2tsdSCE6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NwQuR+rd;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E4606A69A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 23:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 756E4606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NwQuR+rd
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949dcf80821so164753185a.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 15:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475556; x=1796080356; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2TFBSFs2Zy87zyz/nbhCDASHv4d4kOnFRJqrbZETyI=;
        b=NwQuR+rdudvF44s8WBteFdxW7kQ1HOg/x9RZBnpoGf407WA2apwsVFTAMqugIsJvQ4
         jz/xenkD0cc2o1gP9+B3hZCnSxd60ZA5FgXnQAHds3CcccSaRrxxM2wEhV0kEtXNDfFM
         kjpo5QZy6aQYLwi+WtVNjfIzVyLFVj/EyaeFvNt7nefp4C9EXKzOSQ0Be6gls731RDE9
         YmOE+YO75sf+1J3CMOXS1KCVmDxjK9ypsRzeT5NNQWm9vmJgjXJJwrBoyazIbc5d9WlK
         EL/LpGQOcctRSMhBqXF8L2OGf1NP+bUAo4LKyeLCYrfwTIjhDrCdxfpno5fl9ZIJ67Ci
         KwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475556; x=1796080356;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2TFBSFs2Zy87zyz/nbhCDASHv4d4kOnFRJqrbZETyI=;
        b=SpcaGiQMkYEEwD/kthCKAMUZrca2dTZoT8fgfDfDZwrQBapI9mR/o2rlCKihRhtcB4
         kgcd1FMxqFgixn+sI+mGXDSznG+7jc4oNtcyTaGEAxIQm6t2YZC4efPCDMS08NvSA4Me
         o6grQSVaxlOUoGjS+uAFNgOZpwzYyk+jgkp0Mr69fMOAYxjrftpiaHse4ZVWPmHg3tDa
         xhGjLKNG0y2ryxDmhZ8bWCUnkDIWshv0iJTJwNBAZ9hYbZzBR6XWM5MfZqKOXZX2CwGX
         REBPrkll1o7pc2nucFfLYug12fwhLi5q3H3MRVWLuLwVKn68hqHH773a6H4RWW8uiPM/
         bsCA==
X-Gm-Message-State: APuU4Z8U0x+KvKktZad8D6Aiy4jBa3wflWg+lqF/kSOrB5PIk2yuD1M0
	GtoMR9glBA7wZG8GNTo3sTKOPp6Z7/cy9SZFaihULYQ5eBgJ97Cu5qr8JJpz6YIKttU2Ed1hxGT
	njClV/Q==
X-Gm-Gg: AZFdTZeDudJ1VCkgJ8r9lwWGvDRmBaj7f8H+igivxdlKzTZn0KRjURBwuiU6im7dXyz
	4AktAvuDwjoMQW5opgPinG89IAJ3OJjm6fdEvVKS5KE8jhDdV+hQfR+JWzTq/jbNSM2j7i3g6uW
	QL9aTpxyrGPLVASCjgFheql+p4+ddOLL7bi4XbXzQGaUKF5OggFxOLG4oupQgIgdtrp7mbfmswY
	MjOoIRWJPCjF1NVCrWKvJ6IifGnniuuc4+lUkdQfZvIiuc7b8G/vMZSpABfB+extYEUAcyylMa/
	AoxSvVh0PnstciRfaXvisXI4FkKcstL4uhGFBb1qDMidlY2QyHVLvXT0u2JPMGI0c9BFuNYeszf
	AaHF1Bfmo68hdw3am4u2MuGS5jHGWGtPxv021ASfyNzrEam3JUOSK89bSe2q/yq6nsph4GDripb
	GKz/qj88D+p0+3c6jpwNQsPZZs9lMAytm3CE+aK/5jAy2QmJIX9uxWydw/HgfNO1Tkzs9RrOo8A
	SBWWaZTc8QBUN/R+9AuGcA6gE7QUly97jqHO3+MZ7DHxtQL6nkQrXklm0Sa6oX6vKqEYfYiL6Mw
	zwLJYpv2t4e2i7BK9E3BUhGRDpC5uKehw+B5Xa0sNR1RSEilpNIUZQBRYn//JxqOxSOU8mRXL9Z
	m1zx7NWbVyeWUSIw8nE94VeEgt+zfWg==
X-Received: by 2002:a05:620a:448e:b0:949:673f:72b8 with SMTP id af79cd13be357-949bab7c484mr2132887585a.82.1795475556414;
        Mon, 23 Nov 2026 15:12:36 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ae74sm908987385a.8.2026.11.23.15.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:12:35 -0800 (PST)
Date: Mon, 23 Nov 2026 18:12:35 -0500
Message-ID: <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261123_1724/pstg-lib:20261123_1443/pstg-pwork:20261123_1724
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/7] lsm: always call the namespace_free hook
References: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>

On Oct 29, 2026 sashiko-bot@kernel.org wrote:
> 
> security_namespace_free() returns early if ns->ns_security is NULL and
> skips the namespace_free hook. But ns->ns_security is only allocated if
> an LSM requests a namespace blob via lbs_ns and currently no LSM does.
> So the namespace_free hook is never called at all.
> 
> Landlock only uses namespace_init and namespace_install so it doesn't
> care. But the bpf LSM attaches to every hook and a program attached to
> namespace_free never runs. We want to use it in systemd-nsresourced to
> get notified when a user namespace goes away. Right now it has to kprobe
> retire_userns_sysctls() for that.
> 
> Note that a bpf program can't work around this. The size of the
> namespace blob is fixed at boot and the bpf LSM doesn't request one.
> And security_namespace_init() allocates the blob before the
> namespace_init hooks are called anyway.
> 
> The check isn't needed. __ns_common_free() is only ever called after
> __ns_common_init() succeeded and security_namespace_init() only calls
> security_namespace_free() after the blob has been allocated. So if an
> LSM requests a namespace blob it is always there when the hook runs.
> Call the hook unconditionally like security_sb_free(),
> security_file_free() and security_bpf_map_free() do.
> 
> The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
> stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
> prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:
> 
>   bpftrace -e 'fentry:bpf_lsm_namespace_init { @init = count(); }
>                fentry:bpf_lsm_namespace_free { @free = count(); }' &
>   for i in $(seq 100); do unshare -Uu true; done
> 
>   before: @init: 200 @free: 0
>   after:  @init: 200 @free: 200
> 
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: stable@kernel.org # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/security.c | 3 ---
>  1 file changed, 3 deletions(-)

I just merged this into the lsm/topic-7.5-02-lsm_ns_free_change branch
with a corrected subject line (namespace_free is the callback to
security_namespace_free()) and the stable tag removed; both changes are
annotated in the metadata section.  I'll be pushing that branch up to
kernel.org shortly.

--
paul-moore.com
