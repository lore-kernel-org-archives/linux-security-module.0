Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8671DC99C
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985191; cv=none; b=N92ZcYEXeMREovDOl2UmEhmgleyXbvP0zjaipTmi2Z86ZqwWe36pDdMSeYZIorn4VhBne3ghoA72JJjOEPuov7Lbic6DJ6RILQXy2kQxGOjUb9l3AZRh0SU73lXe6cuKH9Nw0htzPWkbhZENhbHN6Ji5EJhVNTcUrm0sooc9fJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985191; c=relaxed/simple;
	bh=VD4HZMMruEXK3cWYgeMKyhT73yPU3eGiPRX9oJ6qcNA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gE1/2y/mPPe3QD7dk9303PRUyR5iVGkAy7nGE6OWi5vHAhka5kkJxhdnq4QO4EIlO/FE+fov3+uvGXniBD7mersclwesZLy5r9v02OauIpLPdSKAi3D1Kh3MGgOR/+xXiT7JPYXwyJfuTrdsGHZ6i7/MvdNubv36xmiXff1x53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bncMIhVU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bncMIhVU"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4679ea3b13bso3491461cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 15:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736985187; x=1737589987; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X1Qgkk1oWMSBXVfaHGiDjtsWRKN/BWSKCTADzfhM94=;
        b=bncMIhVUKzOSxKC3Mq63MHv1s+59LuyJiIjKQqLJeREW1mQi59S+Ssj1+laDdk6LtD
         IJmCmoObbyNDwpjLejpAYcTX1u+3LwCrB49RjV+pYsaErMWq8bkA4Ad8WVIhks9eJlge
         OTRWGUmu/MoVzcFCjhe7sqnZkutgAfUqlKGqfMKjud2jaX48V6IO8YAwnpG+QbwQ83Xo
         NxT5Vq3COMwU+7ubVSJunpg9DosFezpwuYPQVJMC39VnGb4QgLAoJodCcKgGNk9jTNAO
         h5bgPuiVrUiJmYN9dM/Ho0GTNeuJJeCmG7LwAJNjNKRBbDOpII7j3sXYBHFHVQdXgKXn
         9HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985187; x=1737589987;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5X1Qgkk1oWMSBXVfaHGiDjtsWRKN/BWSKCTADzfhM94=;
        b=PP22zAX1ohxJDzeF5QXAoYc2U8UC9w5HwQVWaHszNc3+BGiD+z3qHmVx2RmHcLfq6t
         M+I6WRZWbJ2Coj25D3jssdlFFV90ni6wQSGNivxMig46deOgQRnYl84M4o5d1WrtyHdZ
         eLvoXiDhPn3zJXCbitn2AYy1nVUeOPRII1Sk7y/A0BHKkyJYD1TLksOKE9O0p7Ufe9/8
         4M6lhUO/sNXv3dYmog1bidhVhnbT+YhfubQGDIgnn+To4iQhsc3cZzGEwUTcopgzu/6d
         DEBVwbeX5E+ZsfMd/yZSGhkTkmOKSPEAiiiD/KyyxVlOtXrY2u2TZI7Zbam6mjabVAYn
         PfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv7r2Ih/ZvKqiTSPVQHoc6xZAazAAccr4zt+ZQT0T6lh4Ipk/86dQS9EticYn7aypZhyfXPfWaysCpqQE5S1bjULgELyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgpQCIas2+4nwqVChlwZFnDOFXNMBWXDi5m7nhRmKPlEDCob+
	E8DPRtgZQxAppmNjhObUxl4ZW/OJw8p7fliqhZ6gh6PKny8CusWWMqOz8+AQYQ==
X-Gm-Gg: ASbGncuD8Pt43Nb25MyzC9+P0GMeUYSYc1X08VeiJv+vdpASLUH15lMi/il08hGmjhk
	MEcUqh0Ckpw3aK2PQEu4pkKF7umkJTDDh8T8SkEM/ElcMvOq+DRD/d56k7XF5wZ9YQDQVyqZOJR
	DuIf4xcY8lV2UgYNuZmxWFfR90Kvnw1GDc2BIXAxsbmCKv2lyqaOPtMUMy/t+BDcSUEORXDa/vR
	wkkqziq6Y0cZqpufEoLDI7nShuGeNglnNbzzyvgEbHz4AglEtc=
X-Google-Smtp-Source: AGHT+IGIHtyRoNutItU5LCDTdU6jNgI0Qs73ZHfm/NG1vsDq/TQ3ibefz9r6vrtgc2RPzEV1qHCiHg==
X-Received: by 2002:a05:622a:15c9:b0:467:6e88:4548 with SMTP id d75a77b69052e-46c7108c109mr550006181cf.39.1736985187203;
        Wed, 15 Jan 2025 15:53:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46c873dd754sm69938751cf.69.2025.01.15.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:53:06 -0800 (PST)
Date: Wed, 15 Jan 2025 18:53:06 -0500
Message-ID: <081bd4a2a44a80e046662667e0aeb309@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250115_1512/pstg-lib:20250114_2216/pstg-pwork:20250115_1512
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 8/30] landlock: Add AUDIT_LANDLOCK_DENY and log ptrace  denials
References: <20250108154338.1129069-9-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-9-mic@digikod.net>

On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
> denials.

...

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..60c909c396c0 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -33,7 +33,7 @@
>   * 1100 - 1199 user space trusted application messages
>   * 1200 - 1299 messages internal to the audit daemon
>   * 1300 - 1399 audit event messages
> - * 1400 - 1499 SE Linux use
> + * 1400 - 1499 access control messages
>   * 1500 - 1599 kernel LSPP events
>   * 1600 - 1699 kernel crypto events
>   * 1700 - 1799 kernel anomaly records
> @@ -146,6 +146,7 @@
>  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> +#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */

I didn't have an opportunity to respond to your reply to my v3 comments
before you posted v4, but I see you've decided to stick with _DENY as
opposed to _ACCESS (or something similar).  Let me copy your reply
below so I can respond appropriately ...

> A stronger type with the "denied" semantic makes more sense to me,
> especially for Landlock which is unprivileged, and it makes it clear
> that it should only impact performance and log size (i.e. audit log
> creation) for denied actions.

This is not consistent with how audit is typically used.  Please
convert to AUDIT_LANDLOCK_ACCESS, or something similar.

> The next patch
> series will also contain a new kind of audit rule to specifically
> identify the origin of the policy that created this denied event, which
> should make more sense.

Generally speaking audit only wants to support a small number of message
types dedicated to a specific LSM.  If you're aware of additional message
types that you plan to propose in a future patchset, it's probably a
time to discuss those now.

> Because of its unprivileged nature, Landlock will never log granted
> accesses by default.  In the future, we might want a permissive-like
> mode for Landlock, but this will be optional, and I would also strongly
> prefer to add new audit record types for new semantics.

Once again, this isn't consistent with how audit is typically used and
I'm not seeing a compelling reason to rework how things are done.  Please
stick with encoding the success/failure, accept/reject, etc. states in
audit record fields, not the message types themselves.

--
paul-moore.com
