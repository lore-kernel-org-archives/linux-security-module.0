Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D015221D87;
	Fri, 23 May 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748000318; cv=none; b=X8AgxuNtFtyF2OlH0KV8sE0cGtgc8yf6D7EfYrB7EfCG54gBFlPniPvMhZ24zcfmzHfwXm0DwZeDzqNSaY7bpwDD3S7/V2Hf4I3KmfwVY6GANlXa8xPpZZDPlkt+Qv780/Fiu5lPiwqEm6Geufcbz6SNpHOGea4YyI0ptxHJfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748000318; c=relaxed/simple;
	bh=C8l6K1eDGx1IOwbMAVrLHUZ6g+1rGq8hIcwKEz+RO24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cTky9oAYj3P6DmO/Y6wGrg6S+mPoj61vbQb/wrGIKtgJJgysaCSwXkKh6yCScK/smtTxovnxbEma5qh7v+u9FK7HzDEDDDlWrF09gJ/9k7T1Nz1afHXIcPmAKTVjBSQAYWkvZH6y+0z+BODSLIGHnsuyYssg4e8MX6SSUSFZO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okuq+63N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okuq+63N"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so4839751f8f.0;
        Fri, 23 May 2025 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748000314; x=1748605114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nV44RYFzgQCSPTYPIbcTRtzMraX+Xrj0AC4YMAinlic=;
        b=Okuq+63No6WnIwAyL2N9sRYPac1l0Pr3rNK3obDozHIJJdP12IePPtXPJAPYuMAr5x
         Co6Acx9Qz//yK+TUbvd15B/aKPCWFw2KTds8eV1KMACVx5BWGxT4A8n++Rwa+Iz7k5r+
         yqUNJKNlEZOKbrnwYH44wbc1fZjKxsBWbzONYAORtJlCyJ6IWN7m10duE1P9lDLKaKRz
         DLfwgtvcMOugGrlxVsZdPdb+06UA7Ns8rg2iPzOnYuEK1X7/vbAUxxBGPJ4Cc9pHrSIW
         nADLEMWGnUoAwyiN3oPsnIpVALua7dxa9rVt5j6vOJxA7tiPrJ5/Z/KNBjG5X5NDNOuH
         BsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748000314; x=1748605114;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV44RYFzgQCSPTYPIbcTRtzMraX+Xrj0AC4YMAinlic=;
        b=fdrW5wDzPXTH3jduaM9aSWngNX7FWiqTTzsIlCq7QLRLyCOb+dEtU14Ac8pu9T+VRZ
         0ktF5r59lwUD/I1PZHcOosWVrdXzgR/N2aksKEpoof+q67KnmaAALXQtWuzaMXyl56ro
         9T7LSqCwmfX2Xb9f8X4ETaBF/TPw1+AF2+yJl7igCIp2G+BNijdK7xHlYNmp5tBeFlpg
         0P4MrCasJavpeG8yiKrQGODD9wFoI8OKjiX+ZEFw23RCI7TSgl+CDTkLyuZT8z0sThmT
         aBdZCsw6FrJlNzik88Cd3Ji3JxJJmpUBDv/xI5edrK0K87xZzCjH6MA477BeNu8N45Pj
         Oy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYSe9mBMdDYP9V3sxRgE5IKV8hoSp7XpweXCtGyrrdPToJQdgHBwybaysrU9Ce5mHgeSNMAdjVfUuXkOQyxuHJxtOB7Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr1Bi4JQWKIK1s+hV1JlZItbhM27E0QEu1SbC1VUah2frTBwv
	6bJnSb7sfjFYwzKsPE6C53hicyz9XzIIHNXflsnInkVkHQJadmPYHwKJd7WXTA==
X-Gm-Gg: ASbGnctfSGX9zbsv6QksoIzaF9FHjZXvuX2QW1TAETTGjTgQHJw0lcTKPsnu4Dlfn4D
	TBaTiF8i2gzU4GUUWsrr2BjB231v47BozVAw7DW9z/oU0D4qiHn7m8VwnTdE/jgw3SUZViy3ULV
	C+y3mhpJcHuKhd1zKMSCeigdfVrIClDWVIZBeoRRM6pPDh5dOzzMqo2U6WS2e1aCEj2gm7gAK/C
	ShQUm62w1GiVmDQfchegcn/RzCzU3GTw6MMtaX9ncj5ctpxpvCp9s01g6vZAbJs2eimnKheY7rH
	6E3Ekq44TmOYXMsEKtLpxu0lxOcF0UQpZ7Ppp9iQEMNSGdfrNOiIlccd9MxrYwOUnIpvN9mOWBW
	OegrrKkOkLWjsZbJfRdE9mdwOZQfR29AveDKKZIDmGw==
X-Google-Smtp-Source: AGHT+IGSymWAI4/j9vDmQlzt/sPc9Dh/0VDwaExNYUv64bsna5U4XuMSwwnbvHdZIplpAKkpEPMSXw==
X-Received: by 2002:a05:6000:400f:b0:39f:175b:a68d with SMTP id ffacd0b85a97d-3a35c808b3dmr26578121f8f.11.1748000314259;
        Fri, 23 May 2025 04:38:34 -0700 (PDT)
Received: from [192.168.1.31] (86-44-211-146-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c002e937sm3816448f8f.29.2025.05.23.04.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 04:38:33 -0700 (PDT)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <c0a1f475-b973-40a8-a7cc-6947791af38a@draigBrady.com>
Date: Fri, 23 May 2025 12:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: bug#77597: listxattr() should return ENOTSUP for sysfs / tmpfs
 entries, not 0
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org
Cc: 77597@debbugs.gnu.org, Paul Eggert <eggert@CS.UCLA.EDU>,
 Rahul Sandhu <nvraxn@gmail.com>
References: <D8Z6FP3UZG2G.I8H42ZV6DM08@gmail.com>
 <41067aa3-0e72-456f-b3f2-7bd713242457@cs.ucla.edu>
 <c7d16a13-79c9-4e81-996a-0f32bcff79cc@draigBrady.com>
 <2e24f40d-b475-4199-b53b-e4c266d0d314@cs.ucla.edu>
 <60b2252d-9295-4d03-921e-a596444da960@draigBrady.com>
 <64b14829-381d-4295-8878-f6b06906ef3c@draigBrady.com>
Content-Language: en-US
In-Reply-To: <64b14829-381d-4295-8878-f6b06906ef3c@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2025 13:22, Pádraig Brady wrote:
> Older coreutils was less efficient and always called getxattr("security.selinux"),
> and thus shows the SELinux context as expected:
> 
>     $ coreutils-9.3/src/ls -lZd /run/initramfs
>     drwxr-xr-x. 3 root root system_u:object_r:tmpfs_t:s0 60 Apr 19 14:52 /run/initramfs
>     $ coreutils-9.3/src/ls -lZd /sys/block
>     drwxr-xr-x. 2 root root system_u:object_r:sysfs_t:s0 0 Apr 23 12:54 /sys/block
> 
> However newer coreutils is more efficient, and does not call getxattr()
> if listxattr() returns 0 indicating that there are no xattrs.
> 
>     $ coreutils-9.7/src/ls -lZd /run/initramfs
>     drwxr-xr-x 3 root root ? 60 Apr 19 14:52 /run/initramfs
>     $ coreutils-9.7/src/ls -lZd /sys/block
>     drwxr-xr-x 2 root root ? 0 Apr 23 12:54 /sys/block
> 
> I also noticed the same issue with the exa utility for example.
> For coreutils to maintain efficient processing and to fix the issue centrally,
> it would be more correct for listxattr() to return ENOTSUP,
> in which case ls will try the getxattr() call and operate as expected.
> Otherwise I can't see a way for coreutils to be both efficient and always correct.
> 
> I'm currently testing on kernel 6.14.2-300.fc42.x86_64

FYI this should be addressed with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b0ba61d

cheers,
Pádraig
