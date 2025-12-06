Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4933B8D74
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765055052; cv=none; b=p8CjZsVHGeNVY3CLzNvZjmsV/yM8h3qo0rXYrTjS5GtxDTFjwTyDgQQRu5IG7n+ofNa2vACmLw2Hi1sKTwXkjoDj3lFr7GMYOdAS3pWwso7jLJFWCYgiU+6bypj9s2ct9SZbDcPvRK/tDHWZ4kR38fyErmjPgOLbxC/OLXfz0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765055052; c=relaxed/simple;
	bh=65VTVob7bPHN4AEz7ESbcTaMj5t7GF5JO+TjLqPCNI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luSqvXOXvY814Di4z433CuQw2Rg81W19qRAxJ1DjBFZTIlESh4TTN0i1MeNGNP8lmlat8WDK3MKQYOHE4GSmbLYBNwaCI60OCi+AoodbDIOAFf5CWt9GEPDxnv0tayd6mqIZfWG7UiWOGIb5HejCON3RVT39oFlVFsBRdxRbq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7ZJPg6T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7ZJPg6T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so36578465e9.3
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765055049; x=1765659849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+R0SCGzq/u4KwTitXErbXr7iBc4ZD/VrlTfrwpim4U=;
        b=L7ZJPg6Tumkf+tmGj7IVu/XKOdR6uRJYc3zjrxxFdf30R//955ltk1XNyDcJIUV4BG
         9FrHc/e20kJqVSXrc7wjXnRaYNtQLNpvBfSn1tB59GRHqZegInKaHWxX/1edV7Nd1b0M
         Tr9Pv6YWCv3k/EE+nJIyzFJzkbZhVwhVyqCsvlEuLZ1lMP/yvEMh1uWa/zAPG5d+J5j6
         wucWKSoIO2gIgi8uoLmgMRCrhw5FyM6M42Ii5n2OSRywZekMEe7unOfTaPAzmw+9iKBe
         6bh7mReYuIOAzF7LXAvh53Ar7Wb+5Agy9eKbOTokR+TAGc55ZXIGV7kxHvyGmL/nzwjK
         DTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765055049; x=1765659849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+R0SCGzq/u4KwTitXErbXr7iBc4ZD/VrlTfrwpim4U=;
        b=WmQFg9MW98IOzDhCX18Iu+tjEPR78PS4fkd0fEo/mxN/In5EkMzCEEBF9cb42+J1R4
         S8WLKBxqj2qlN91TqrixAOf0d/+cs/NqfEyruXdXARxXkDMkrV0lSkvB3FEUHQ8F5q7o
         VoH/npNmTfksEDX0QXSL3J33yuAlwPe6Rb6OBoso4n4yISHTM10OwgbzUETmmzVcMH20
         MWlfgTkc+VFCivK0Igpij86YdT471Zn2nYg4fIS/n3Nz2+Q6fRje2qNx+cPfbWyYngUH
         vQLhxuDGjQUGrfzth5gXS30jzdw99padSKFEmWK22y1gXAQt3gkfmr2Tq2KXxcOB2NNz
         qonw==
X-Forwarded-Encrypted: i=1; AJvYcCVQH6pjfsGKKOOKhUAfqkeuHJs6ZgIGG4J7RqBq7I2Zc/+qcdaHsJF+FUZyz1sYrrIV7pi/lFIYqrNC/amvEgcsIpux/rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdm7imJPthjNRZkCuyYsNBr8ENOssOR7gEJSSkde+uVWBqO4NT
	XJRYd83GyLRD1puCFn+Dzq1v4FPzyyBOGgxniFOqRws0YMO5RQ4W7025
X-Gm-Gg: ASbGncuxdWwSHUnt/Gz4p97HfqrPPob2/7iJkWDpJ8Z2q9kvEY9GZ4nnVh811oLuMTH
	U7c32WCJWhDQHNTgoHu+BNbjoLA8NFxt0RI/wsjjYwTyA6bOJrwMiGgP7gCwCfMeHYoCz0HkCNR
	4rR76m1RsCC5H4ga2eeeKJ+GruFhrbBSaIQNfN1Rrwf1n/2/prJpJHftWHpFTpsqbFhPfuPTzZl
	RNTj5hQHXKI14JctL/X/eyijixoRucIVv3JwwjF4vVqMYLDcgS/6G5eiazK/b7FUuItCcEsb36F
	f25RX8dL4XGLXZ5diw7sf30lmz21gt7OWbYC0qwPJtmHEk6pCgUePcm2oFSLsBzgqyZZtBYWZWq
	xdfBR/gUpm6S5LwmucPdoFeQr8MQmt1xcAM6Y1yW+mZERoox0BBlZB0lcOHvX4ifkc1o9heW+qx
	iWiRzj5M1fQ+Y/H4ts
X-Google-Smtp-Source: AGHT+IGY90HRYud37zhfaVkcTOoavhZ9fJ9fd1f+w8+vh+XVqQ6dNfOiRg9JQrPM/eFXEkmpN5KshQ==
X-Received: by 2002:a05:600c:8b4b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47939e4ff40mr33087245e9.33.1765055048424;
        Sat, 06 Dec 2025 13:04:08 -0800 (PST)
Received: from [10.247.237.184] ([129.234.0.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930c7473bsm247108195e9.10.2025.12.06.13.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 13:04:08 -0800 (PST)
Message-ID: <3748b276-6503-4c50-a394-e5b75c1eb7bf@gmail.com>
Date: Sat, 6 Dec 2025 21:04:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipe: remove headers that are included but not used
To: Fan Wu <wufan@kernel.org>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251203193718.504344-1-yiconghui@gmail.com>
 <CAKtyLkEyD9UVxqbmODVOAymE32aE7X4Xdbqj6H3BMGyhn_PQqw@mail.gmail.com>
Content-Language: en-US
From: Yicong Hui <yiconghui@gmail.com>
In-Reply-To: <CAKtyLkEyD9UVxqbmODVOAymE32aE7X4Xdbqj6H3BMGyhn_PQqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 10:25 PM, Fan Wu wrote:
> On Wed, Dec 3, 2025 at 11:37 AM Yicong Hui <yiconghui@gmail.com> wrote:
> 
> Hi Yicong,
> 
> Thanks for the patch. This kind of cleanup is appreciated.
> 
> Commit message typo: "audit. c, audit.c, policy. c" - audit. c is listed
> twice.

Hi! Thank you for the reply! Yes! My bad, this typo will be fixed in v2.

> I was trying to verify whether ipe.h is really not needed and found
> that these files are missing explicit dependencies. policy.c and
> policy_fs.c use rcu, mutex, and slab functions but rely on transitive
> includes.  After removing ipe.h, they still compile because eval.h
> also happens to provide these dependencies indirectly.
> 
> I'm happy to merge a patch removing unused headers like ipe.h, but
> would like to see the implicit dependencies resolved as well. Would
> you mind tracing the complete dependencies and adding the explicit
> includes in v2?

I have manually read through the functions/macros/filetypes in policy.c, 
policy_fs.c and audit.c and found a few dependencies that are used but 
not explicitly included, like minmax.h, sha2.h, lockdep.h, string.h, 
capability.h, kstrtox.h, sprintf.h, array_size.h and err.h.

This might be a stupid question, but how explicit should I be in my v2 
patch with the dependencies? There's headers like 
"asm-generic/int-ll64.h" "uidgid.h", "gfp_types.h", "rwonce.h", 
"compiler_types.h" or "errno-base.h" but I'm not sure to what extent I 
need to import them, because I shouldn't be including them all, right?

Thank you!
- Yicong
