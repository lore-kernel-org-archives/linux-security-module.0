Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E849F123
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418517; cv=none; b=UoHZd6bOSynpvIXu/wDX9FvDdID5ino5sEQ3kwtqR4VgCqVrUgKKLhgwK97+JSntKoR+22xFktQB89iO+R5z+5dZ/xsoH9Sy3CQJHn3b9EJxAuZ9pnqi5v1lWenUVd2xq9lNOkO8S2XTqPHWPuCsm9QBcE1ijHqjN3i8mVFqa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418517; c=relaxed/simple;
	bh=NGWB4j6Qtj1I45qJXTxUF3DXiZ03+1wrOcaEWMEdRtc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hSMjPK02TEC9/DExOTb8GISuU0qm+hU9Oy5NMZt5c3ZvRULdV6e3OxaAFLiwPeDduskRRl/VpftxD7rh1I1RMv9fnqPonqMSSzvAHO3UB7EYTqyqAz38Jk2G7wmYN6w1U/6ZjkAcGD3eligZcjRaIa29BO3cvrNSLdNnB5b8Iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BKJZYJqx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BKJZYJqx"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53024149d40so19122241cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418512; x=1790023312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=BKJZYJqxLJgFemMBcjr5I/aDXNKPtJB3WRJtLpLBN90kCCOc2ISZa//Hx+A9+uy7hz
         KotROizMJXWX9tEzVf5O2jdHFH3zcLlGP6MzE7D9BcffRwl5dnFhOwNpSiEVpj1HEnJ7
         EvvPhvn7MfJE76qXhcCt4bZKswpUqfwd0aWhG8mfZX2zxmbfWiqBIzrihkzUvkRM4+pU
         0txeqCV4C+FMMdpJa03B+HismbOogUi7Ezhk+FqcN08IynGTUWXRYeAFxW76NBiVlJ0L
         L414LmF6/TYULPjGTgneeLNYrcAk3bxDHO3JN/fQrYxHr7NjczBjhvGl0Vfc2MBYNYf7
         gRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418512; x=1790023312;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=kuvISBLIpQ3bEHNUzGVdgwgSv7jUHg7OTIKXvrlKVqpf8UDyQh1vzR+mMZprG+8SRJ
         5OAzc4gqmDIAx32c6YhSSGxf56JUe2C2zh9GQAzPwBUnoq7biD7Egwp9SACJlgGxHueE
         r/hXF7k5rApvxwZ2gb1LGHOl2cGggSxzI1+A83qKQmun5xdXL5tJrgowjvs2a4D7yv+j
         d5LXuWCduJJV/CXV2S0Vk9iWFuM7DFsFCpuqN8I/JJk9ak7e+NbwPWot47IctfxeFO12
         iF43GFaN3nlG1CrWiljGZ/HseQG96aQuY5fbG4OfiWLkAaK1LfxLfyq3T6VRBZ0R+NUX
         Fn2A==
X-Forwarded-Encrypted: i=1; AKwUvBym00T4bFywwk3zamQilOyR0ml6HEibi2dFaQN4t69E+Jjg0EhH9kmz0UBitztCi0n8CqC9KKx/+dWduCsqJvbcBS6D95s=@vger.kernel.org
X-Gm-Message-State: AFuF++ks2rIvNqT20OyOD1NA82+3n0XkHcmwo4Aosq9klU76F0ef3W1c
	wuk0k9BJEA0OIP+uURDgBNRWQeKKU8lvSC/WUp84D5X43sw03vaBHmLzzg2FHQ/Wlg==
X-Gm-Gg: AYBFou0DFrpqwKSf+ShLXfz/bgL0teYj+FUOR7OghHb+wsB4bbc6P6KcS7yycre4bl6
	PCccmd7HkGLOx48J/CTso2eMvwyNCEW/f36dCfu5W174zfdKfvIxwA2aKbTMkAMucsN0CmfLvJp
	Ek7ngEVVxDLKv7MMKW7Aoc9H5q/EmGb3ocl4JXnqFfzoHaYz18L7sQJsfk5C4KZTZloY0vjPs/s
	M5XmjpP9m5yhoHBKuRLgGfWbtr6D609r7fuC9OftIw7/iQgkcRb/+z1sYKKoP41BfG3gS9KrlTC
	8JfmIUribc9997Ss/lyhHO8nc7JAj8Jn9ekwLsBYSuEKedxZb+9fUXziev55Nm5B4k2OD+GVpz9
	G1RMOPRYG5RNb9aJxgKq9+vuu3Wm3P3F1JNsbDuMgt/NfUt8dBIApEbD5ZCb+D/auPrzFplPvAw
	kyEAjHKWRQ60M5wkc/OVL4AccVA+8OflSuvDEgPecsFZeSKbHUXcAXj2MbC6D9mXV876JJRi7Gz
	7cCP0vQicvyMLL9flimmPipZE/NizQ9LzXser9ZHn8HGL/DtHpk72YrzEOtyx+69pqiyn+feG+/
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr64295201cf.51.1789418511760;
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm108403901cf.3.2026.09.14.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:50 -0400
Message-ID: <af4448a7a2b428d0f4af0ea4c19abeff@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit records
References: <20260910144837.381855-2-mic@digikod.net>
In-Reply-To: <20260910144837.381855-2-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Ioctl commands are unsigned int values, with their encoded direction and
> size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
> a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
> 0xfeee and makes distinct commands with matching low 16 bits
> indistinguishable.
> 
> Change cmd to unsigned int and use %x.  Pass the full command through
> ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
> derived from the same low 16 bits, so SELinux enforcement does not
> change.  Commands that fit in 16 bits keep the same audit text.
> 
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  security/selinux/hooks.c  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

This looks good, thanks Mickaël.

However, I am going to drop the stable tag and merge this via lsm/dev
instead of lsm/stable-7.3 simply because we're changing the audit field
(going from a 16-bit to 32-bit hex string) and I don't want that to catch
anyone by surprise in a stable kernel release.  I will leave the 'Fixes:'
tag for reference in case there is a downstream that wants to pick this
up as a fix.

--
paul-moore.com
