Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E437BE6A
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529173; cv=none; b=fWDfBzcHg9C7zf/2LmFIBp7DyxXg3um8kcJquMiBw9VLi2IYrUgkrHdzw8+pVj9FmN2BM54fmDATmf0QvzdTKhqHHrNcARVQdkR3xG81x1l9ilmfmWXQ/71JfDDMkFbdbyDoF4V4pfymOlAurEb+Cc7eoG4hpB8y90J9ATfVjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529173; c=relaxed/simple;
	bh=0tf1vl0SQGqUQbLj6jwYNf1qsghLHDsVRNEO69K9iPw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cWpRgpkthuiJ0y1gRronBHLMKittkEgE5QvllAncgNAtGIjkJShULxQOmUi26vmuNH79jsEbvKPmKjonb2os5ChUreDl74hxZcy5jyXDvJo4MVNB5HwxVk5ftg5H5dvVqvBculM26D9ysoDwzsHEOXsUR5vqZkjcdHBVFwHwdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=biyWdz0x; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="biyWdz0x"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90ce49af8easo8609885a.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529171; x=1779133971; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkJDSYXLDBh3wMcKjMLlLmxdhkbb1kc+xmdwPKDFOfA=;
        b=biyWdz0xBCqjy+IfyiVgCjYv1+E6xKH7Pn/z6rpid7y6nDkJvy2rty9GGpqO5x5uzg
         kdGplr9BasU6iasMX0EGI7BSesr189NpyJN9lDwJ2GgECV0HIVHVYJqrE6g9Uws1/D+z
         q/FW8fwydK1s+IVrhG8x5DAWKLLowphUDJPER4Wq9DbAad/9ylgG70WS31OS4noz0CgQ
         cGiCdNU3rY/OAwru59eIXBZO4CEsJqAvnybTIddF01nER1QeLX1eb/Mbo8kErJt2FKZx
         k8zJX0pnmbtmYmsQrdO7mzzlU6NbaFwhmhZNMinf8K1vBkfwk2/HcatFKKNuCl41ozaL
         T6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529171; x=1779133971;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkJDSYXLDBh3wMcKjMLlLmxdhkbb1kc+xmdwPKDFOfA=;
        b=qhI7SlotgcJJUHS2x3DMscydzmP2Hxzf5QEsKLiGp5aeKfxlRwERdCpkTENk905nNv
         y/LFfncxv8ssUCkBhDWnx2HU+cisHOT6BnqkmJxgCGVXMqwYqFr1YQ/cUAN5rNlPmwSp
         6+fyhVIDy5yW5L9JijLRIlLno8L7XpBAEQbhttjtgj/SxxSY2XeDUX/FRbNC9PoVoHqf
         XLEGzqqeEvaCqjVAtRtYo4wQsyO2ybmEjmc3xFRnx6td/Eg7oDktKuQnIH3/0YF4EzbZ
         mXRBposadld2InXRJVBbZ8G0SFlzrGFrekubugkPsyVqaJMFwX03+LjMTfG5qmVTn1Sb
         IVcw==
X-Forwarded-Encrypted: i=1; AFNElJ9u1bgp/kLx10qokpOWB0gbB3Yz1rUDxhjXodlrpWgBNt35qcHI+qtg3GWyNB4PCm/aASKOHx8n93Mu8jyWTOQ3tM2HqfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmp/Gmk8rUntg1nZNcLTmoS6UubHScifRO7mdNgsn/XlV/Fma
	psV/ETLV1DhEzClLG5AGSfjy7LMlAk0VtCdss+7ROYl4bOAqwbb68W2iwcytpzsrUA==
X-Gm-Gg: Acq92OFVFQb+wkyuoyPxmBuBBVfujpZD5aIfuszGBYDVMhAR7aUh2Do+288XDkJP5gP
	bbgtBoKtYD/El/rLEaNbxKettxYW8Z0y5tIolypLiGSmc66cl1biog3T5s3LKlMWSdiVj0jiCae
	2LikDrX7GAdYIFt5UKqp0h5yhaPDJxmFeILweCCPZkXNtzOp2gyYfRy1ANpQaBOasZuCdYrDheS
	gzHj3WRika4N4XaMJrnK83CrBtnbob4pOQxfjnpB4g7+CXPY2IQxSIFxX4jkAQUzx5yMipk5nW9
	gXkfDkIIyFE8Nv200SfNzmcADz7TreWYx1SvLo67ysDZCu51hpZZ70+NpwGxVaxQXjqrc6Wzi2j
	BweK9IC++Wyj9WlbQrR27qck5lS9Lo4re9aCK1cirLNHwITF4bQ81mSaEPqDcfG7FKXHnzeCFzI
	ORwKHaRKwXpuOaPcmezEo1gqUvxyTWSe3oRVQ2k1aHnFhuE6Nh2gHI9R23c19lSa/G82LLLE8S1
	bQ+43dofRIgi3Vp1Q==
X-Received: by 2002:a05:620a:2954:b0:8ed:d6df:c778 with SMTP id af79cd13be357-907badfc044mr2333240085a.37.1778529170980;
        Mon, 11 May 2026 12:52:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-904f810e354sm1742542385a.45.2026.05.11.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:47 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:46 -0400
Message-ID: <eb3d42b49940d9ecdc4ef384989d8f8d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: mic@digikod.net, gnoack@google.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 5/7] landlock: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-6-song@kernel.org>
In-Reply-To: <20260509015208.3853132-6-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace hook_sb_mount() with granular mount hooks. Landlock denies
> all mount operations for sandboxed processes regardless of flags,
> so all new hooks share a common hook_mount_deny() helper. The
> mount_move hook reuses hook_move_mount().
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/landlock/fs.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)

Mickaël, Günther, are you okay with this patch?

--
paul-moore.com
