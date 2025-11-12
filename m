Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D62BAF4
	for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908446; cv=none; b=s+oatE2hBG7lgaN0RoVXqPuBzkRD2WwDgSdTmVZ7FVLaFBxDNffdAejlwRJGxb95PwxCDbkOXCSGfF8B/2h4RiiBVVR9ptSHU3kRYZEmX0Q1JEyycdP+quZOWoX1f17Ep7h3YFb+02RPlgzxVbbn0PRuSLJDCGKVAuiE69GmdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908446; c=relaxed/simple;
	bh=iLvULS57NLgM8eVmAKOp1ksCARhHnb96gbVXO9LaUNM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UzTsCXEa7Kd5oDXUteM3uIe0Gtn99eOVK7OhQu6qMqKfz8Zw0dVWwpUYoWYsUQfJTiSZxmX56SFXzV8Xi/JdF4rC6BgexbEJu0Pv0UeymWI4N98Am88Qb0Pq+e+ps9rIf947dY7HxeQIk4oZxHdFAqBga+6Awtu9wTaTH6DqiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ra/64PTl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ra/64PTl"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88056cab4eeso1953116d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762908444; x=1763513244; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqSkWlqwkh0AdYudIk5TWzMK7MRj4h13Ekp2jfGvU6E=;
        b=Ra/64PTl0zqBMaAaH9AdgqxwMKD2a3yqucPVt/jeaghGKhtaSAAo6GLZ+kalMxzBqY
         rWGMWSEpncx/MxpL8SvHx8bHXOGEJdjUdngHAKuaqn1E8gXQ+PkKB5DFphPyXdnzieK1
         eqnq3CA99j94o68A5H/Qz/lZ1OMrZfaoIkMEX0vTguZv9hwtlH9rXbvvicdtujM7COJH
         8b5iAHM83uGVE5OOycqRq/J3gaYpVcI1iCjTl/DUW7z5kWFxazUZI1u1sZUddYuAsa8D
         R3ZmSjofPS3ksPjwi8+t6s+vEWwjt6Jjibj9C3Jh/pjmTN9DY7YIQTQdbthbEcCT9YmT
         y8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762908444; x=1763513244;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqSkWlqwkh0AdYudIk5TWzMK7MRj4h13Ekp2jfGvU6E=;
        b=mMnh/G46fiumU38n3XlzVGdjisjcwbT7A0h1jzRlN7iNC8pyzzNhRO6kRZnmLolTVN
         4ukvvSfueH37LiEbQQbY0xbVqS68ipAjkcy+TVgjasl+jWkQ+HvxBZUhhI9LyisFA5DQ
         sP14jLbdVkY+E9RhnFppJ6vTmnPz1ME8zP6+MZZuCuiTCFy388KuzdtUSIFaWlXwljkl
         jwnL2Yu+wWfwgkdoxWT2a+Up+1CpY1kIowmgsmefAKpa5Wej5V/706xyBeg9TfmOqIII
         8ZzI2g06U0tGuARFxiqiJNWrdsXRguqm01W59jdbmulpLiy3S433XMorX+6XyOS5/Gf1
         50Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXoIlCKc5G6cHeBu39XlPQcw6C+FqfByRtN6cWaNIjturHUB0TeAHhJPyLix0ZQb97aa5yEXl4W7YQMvTz724tLiQvpFEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmSbLYwYu7X9wsXjSNiBTXsBhraga6SukXzkntnxN61X/NT57
	lqpqM8qSKHX2nnxE/2risYwx1z2M1w9U4UuACduLfuI0nY/fBLLJBIepIlR3KXubFA==
X-Gm-Gg: ASbGncsl30Dpm/Jc8S4C1UJVWlBi/GFbJAnquzJFmAPlqQYAZv98zgcKYmi2bADT+RN
	3nhJRDx9Tlh9AkodOndKoiUV0cAGjYINAyohHkQhAjM6HNHPmsPXgG6q7fClxFo1Izvs84xvsUZ
	yVgprc65bKi4VZJ6/P++nhX1ks0yyCNwop1lBJkBAYcp7Lo7cCdZw5uKSerJ1XnV0hpCX/JfE2i
	1/T7ScAvNa7N2qdWRwMEUoncurwJb3ylMXegmh/hOWdD0+urZANO0KEJfHy4p1dNPz2ON8hDbdU
	GHy66MuOus/uTZ/euMTDKZJZeOz7Q85yHxJ8KBMUVz+2N6nzzqSSHvarBukokC2XgK6zHlB83dM
	bc5d0BpQhCbVta+re4/eB2JdmaLeNIKEeLV/yszZqnwwEQRzbmjPhE10qfj/SrhjAzUb7+vGTA8
	yjVQWzJeBcmYn5xIgbpdDO9i4uLHCBowcKeOHjGB96DqePkQ==
X-Google-Smtp-Source: AGHT+IHF/PZ23l/xxiHoSeZZOtkJgamDuq/rxrjwGQfnK4SCJtFUaCpU0O+jIq/yckwppaM+qeH7Ww==
X-Received: by 2002:a05:6214:2524:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-88271915d0amr17580886d6.26.1762908443800;
        Tue, 11 Nov 2025 16:47:23 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda5956968sm76906581cf.6.2025.11.11.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:47:22 -0800 (PST)
Date: Tue, 11 Nov 2025 19:47:22 -0500
Message-ID: <fefdd59acae4d7430992b390b6f9bdfc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251111_1943/pstg-lib:20251111_1938/pstg-pwork:20251111_1943
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, David Laight <david.laight.linux@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] device_cgroup: Refactor devcgroup_seq_show to use  seq_put* helpers
References: <20251031213915.211046-1-thorsten.blum@linux.dev>
In-Reply-To: <20251031213915.211046-1-thorsten.blum@linux.dev>

On Oct 31, 2025 Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> Replace set_access(), set_majmin(), and type_to_char() with new helpers
> seq_putaccess(), seq_puttype(), and seq_putversion() that write directly
> to 'seq_file'.
> 
> Simplify devcgroup_seq_show() by hard-coding "a *:* rwm", and use the
> new seq_put* helper functions to list the exceptions otherwise.
> 
> This allows us to remove the intermediate string buffers while
> maintaining the same functionality, including wildcard handling.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changes in v2:
> - Add setq_put* helpers to modify seq_file directly (David)
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251031110647.102728-2-thorsten.blum@linux.dev/
> ---
>  security/device_cgroup.c | 56 ++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)

Looks good to me, merged into lsm/dev, thanks!

--
paul-moore.com
