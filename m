Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1911E522;
	Wed, 23 Apr 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410980; cv=none; b=LE3PC9FTHpzY1HXsLklPGL24/lxlflaYwETY/xOBZYJNWgIjJg9Y8maNPpVRQ0x923WpzXJtWqSpI6hNQKlwpful0QSRazsVpkXgNyxoF8Jii+c7D3lW8xcPeUh5I7vlKNBlByA8zjFZHxMHKd4yPAOKM00A9fxdbdAGojGrPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410980; c=relaxed/simple;
	bh=HnPu7j6sgJzVwudx0LKxUL7+884C8qH1FQULmojI5+w=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:To:
	 In-Reply-To:Content-Type; b=aDg2yb+gPnr99LLPgoT35SkcX1NJEuS3m6LD0+Mng8R3HJONDsQ/RCozUx7TL2U9O/wWv6IxoPis10J9/mJtD4jhmv5vvZ/aI7EQ0eJpinlaloAK4xJRrg6aTuDx4KHhXXbNBwbFKS9gbvXNR7mMbZxBeST8cFtSPuciPTm0Ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv/TOtqT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv/TOtqT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c30d9085aso4811838f8f.1;
        Wed, 23 Apr 2025 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410976; x=1746015776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:to:content-language
         :references:cc:from:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=21cooLsZt7+Ib4zLsXhitekoycP4WyhBP1wFPyAZigo=;
        b=Nv/TOtqT9rEpph3j1U7ixJTqA2Vvpl2KfyFXPMX33d72Amsl6hl3E7sUqOZH8uhQP7
         pVc43IovBNVw36yr/9cPhI3dshmQN4qNNf9OgPoSJyy6eZyS3PbJrMrZXpkAYKU+Zq5I
         xlPsHiFVdSS5yg0h75N3UhkAUEIk35l6lPgcfw72Q7Dy8fQEYy64ipkhvWma/o15Dm1A
         8JOd/eL05HuPN6clOPgVHg7B0Nym/IXDiwkT0BAqKO5AyX4gK1z7a2B4ljouGD2Vclk8
         ieK+WLGvxaLlVs9iJs+SDkoxp0iv+/XgZbohfBIVWWV31aFr98hExynlUFvX+bXLK9EZ
         QPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410976; x=1746015776;
        h=content-transfer-encoding:in-reply-to:to:content-language
         :references:cc:from:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21cooLsZt7+Ib4zLsXhitekoycP4WyhBP1wFPyAZigo=;
        b=kVd5NRvZk23NfqnSloJe0keIXpfjPoAUY0Z525F6mdWtvDhHhA3Pls99/hhz36ZNIb
         vR4M0xqCoXdteKVN0Ot8D5FoUJJWF1gtccOYCRO1HyI6PBrRk+sRPC54gu3uQcfzGebP
         VhNIgcp4r8uizoYa2I8iEbUQ9yTJxGrZdzF2cc9cn2gsg/PhBPYha8X6tppfvluhatet
         HpxHHbrS01zP9wByAjrvoVFRntbsqtK6sTh7KoNcSWiFFvvIdzMHunBqLmzv1XVyRLyw
         cPvIwIVz21eT3UsjqbCi3K865i4TxRQm5hrui+y33ZsjEXFsRiJ6y2CkBz1GnqrbVBI8
         VOJA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwD8uo4RIdDgyJqhiLMmkLmMZGHn/4FznAJrIVrB6uUC/ASKywExjB2HUB3W9pnFMXJPfIAQGxqCIYg94OeZNL8ZVNC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyntHVNxBHArc/NYQHOuYLa2deK8hkuCq5eR8rMkm4dgUeRHo
	EW6gElATD3o+uibs6KoPOCDmp8dVl2m2mbsO12AONC+BKZPvYc32P09LTg==
X-Gm-Gg: ASbGncvrRIGcfvHAoIA0zrhlRMeumNJFnaqf92ndkujlkjTzGcfzMykqR/4CPh7nIPJ
	mM4fy/3LQFWO/G3DZH/Mge4/4RvpC23HUVAEpthmWYOIBdRaC1Ydd6TFyk8DNN+A+wbJtJaLj7N
	Ab2345hRFFWv5CE6t397BTV1SzJajHUEhgw9p8yMF4cg6NtcKJd6oJh3dVzNe2BMxVYW9OYi6AG
	/JOslu7nVfqFW+O39lXYZ6VVOCi+qGhZ50V51OOf22QDyMSAbseFjTKZtxScJoXDxkkaVh27STA
	jpAMkPDyIMvPrkUlSDK5GgpZwOUv7/Zv7tnpYFI=
X-Google-Smtp-Source: AGHT+IEKDYteCQcfk3Z30r2wb4x3W8b0O6ydDFY1mIHMwY49tgkK/xu0y/LqgMayC8ZP49NK1BkaOg==
X-Received: by 2002:a5d:64cb:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39efbb05ea0mr14029009f8f.49.1745410975909;
        Wed, 23 Apr 2025 05:22:55 -0700 (PDT)
Received: from [192.168.1.31] ([86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa4330d8sm19081582f8f.33.2025.04.23.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 05:22:55 -0700 (PDT)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <64b14829-381d-4295-8878-f6b06906ef3c@draigBrady.com>
Date: Wed, 23 Apr 2025 13:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: listxattr() should return ENOTSUP for sysfs / tmpfs entries, not 0
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Cc: 77597@debbugs.gnu.org, Rahul Sandhu <nvraxn@gmail.com>,
 Paul Eggert <eggert@CS.UCLA.EDU>
References: <D8Z6FP3UZG2G.I8H42ZV6DM08@gmail.com>
 <41067aa3-0e72-456f-b3f2-7bd713242457@cs.ucla.edu>
 <c7d16a13-79c9-4e81-996a-0f32bcff79cc@draigBrady.com>
 <2e24f40d-b475-4199-b53b-e4c266d0d314@cs.ucla.edu>
 <60b2252d-9295-4d03-921e-a596444da960@draigBrady.com>
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org
In-Reply-To: <60b2252d-9295-4d03-921e-a596444da960@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Older coreutils was less efficient and always called getxattr("security.selinux"),
and thus shows the SELinux context as expected:

   $ coreutils-9.3/src/ls -lZd /run/initramfs
   drwxr-xr-x. 3 root root system_u:object_r:tmpfs_t:s0 60 Apr 19 14:52 /run/initramfs
   $ coreutils-9.3/src/ls -lZd /sys/block
   drwxr-xr-x. 2 root root system_u:object_r:sysfs_t:s0 0 Apr 23 12:54 /sys/block

However newer coreutils is more efficient, and does not call getxattr()
if listxattr() returns 0 indicating that there are no xattrs.

   $ coreutils-9.7/src/ls -lZd /run/initramfs
   drwxr-xr-x 3 root root ? 60 Apr 19 14:52 /run/initramfs
   $ coreutils-9.7/src/ls -lZd /sys/block
   drwxr-xr-x 2 root root ? 0 Apr 23 12:54 /sys/block

I also noticed the same issue with the exa utility for example.
For coreutils to maintain efficient processing and to fix the issue centrally,
it would be more correct for listxattr() to return ENOTSUP,
in which case ls will try the getxattr() call and operate as expected.
Otherwise I can't see a way for coreutils to be both efficient and always correct.

I'm currently testing on kernel 6.14.2-300.fc42.x86_64

thanks,
Padraig
