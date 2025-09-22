Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBF78F51
	for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573999; cv=none; b=AOFHqf37KqAGLwuHCKKnJQYif7HtHAW7yrfFXiJtykyMxhFDL+NFcPK9CKfhPXAdoo/tHJZn126+DPV+Sfu1JfrR73q/lLcagwe6nOuAZ1SNyR1viwYOjm13l5m5Y5hxAcQDE3Uf2DZ56oCsGb6Vb6BsktYAxVtabhXs10o6Kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573999; c=relaxed/simple;
	bh=sNif52s5HMeO2NlnrMaxGGClU/Jt3ksk6/Z0pkabfhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMtIjdFmgqrMFochXJdS2OeK+OuBvHLpVt7a4+Ihd8MXNdVrBe8YBg9t3EvU5d1QQHKW2UZwV+6gYD5+TX/KPyDhyfDXHYIuJ4tQd0w+5GmTJYZ0h0IfuPaMRklxZN0ck8936XNCwhJP8EPVCFleNhE0OSO5gT8+nqWkywamD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net; spf=none smtp.mailfrom=jjmx.net; dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b=pcQZLPl+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjmx-net.20230601.gappssmtp.com header.i=@jjmx-net.20230601.gappssmtp.com header.b="pcQZLPl+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267f0fe72a1so33605675ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjmx-net.20230601.gappssmtp.com; s=20230601; t=1758573997; x=1759178797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVGiCj6E3P2w0QKnUVf/ItLsVX3vc/6pS/TsrG5gIrc=;
        b=pcQZLPl+6UWudl7enkICtHYMhr6uNZW/D4/P1CiEQ9ySbC0UVPNMECZd7wlvZh8FYn
         sTubGoviA2i+EHWcFeMTt8kAeTHTHF1UZG310YDRRwENM29pYklxP+xBGifC+6xb64NF
         SwglEQAVbTbXqSLJrAK++ODwHgnEK1Macnz+bkEGx81PBE+h+zAUiGmtRIid2lXWEhL/
         uY10WrSvTJieLXqWVGN1gRuSNhWiyoJl+p3iRWVZHscQeulnyV8egxI9Z8khPsUFTkll
         0E/C5padmmoTgkC70hORPYMCearRyudOgiU4sJN6xSY8194vN+4Mt213nrIJYCwgjfD1
         eAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573997; x=1759178797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVGiCj6E3P2w0QKnUVf/ItLsVX3vc/6pS/TsrG5gIrc=;
        b=UabbN82LLpvSV4/gUH1Ojn5Q8YNPbzctiK9DvzTRoNQ0gNj1JlZ9D1aR90VDhXHQKY
         THTl6U3JFyci0lQuBVbk99Aqbm93I/kfGbsQbS9SUqVZBAcnQzIEfKXg7YZJ+hLy7ZUO
         r6BVR/plqC+O6I2txoC/ZDwz82XTTN0iDqPzMpr3KOGKcv58uYG38zKDqM7eBakybjLz
         Aeuvuv39YR9Wdn83wiWjE7SHlkiWoheoY0ijEvVt4RbSkHA9h61PcX+aGr2PB68Y025j
         Nh9+9DxyFU6Xk6CTQhEewOr82poPjJn3RPLv4lbfPp8jSwvnx7uOrLCiV2aInNaCGPoB
         /9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9R1550Kfio/blswdJVp2G+/YI4WW/ehAwWpz5PJ3i6FWskWMQieGJyUtfVCxE8smMbdvZZ/zXImB3hJ96UJ2vFVI0o6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrObRN/bXGAoxaWlFeujYmE1pE3HFkNnQYWQ2u++/FJAK/E05
	ZQJIN6ycCTu6ERWHXWlDLyX3ClIv9vThGxdRDfPVvPKePmzNcv80tOZs1pn0hx/aPuyNa7ALAmK
	rLZR7
X-Gm-Gg: ASbGncvgCJYqugIv2akcsp7VCayDU+VTjapcA33qyYvpz3NjjW+hRDf/YhL2UzbM2gl
	2J+NTuehbFdxqcX78IyuOjQjOhliLJ+zt86JBsx/sfejYe/0Es/ChnWzx12A6SsiyvC9f2iJSDv
	dIcgXjIWXJNO5Ye/jQXsBi4QwzeV7W3Xc9e1i6iNThQ2rzYvhExzJFzX6enQ/SiNI+d4vYj7UXI
	QTNeTxXAjnY+V1xQjMnG4ChaNzayTCrOPvz1Q7jpkYbx3nT8TGth7BsEbW7IbJRguDb+Y/oJmxR
	K+rMs57f1mDt9MYVp6YlQpx87qSaT+pS1dSX1pb8cK5YhdpnyrIf34VZvTAdwwr+hquqfPXsJ30
	OnxT/dOmNIpEZwMQMbw==
X-Google-Smtp-Source: AGHT+IGBzzduIGdXk7smDwhz6jjD79u61jKRRV7zYAexJaW7VRjMNqpCoiLIhN+qiOPpju/KPP3k7w==
X-Received: by 2002:a17:903:2f82:b0:278:9051:8ea5 with SMTP id d9443c01a7336-27cc2101372mr2088225ad.21.1758573997132;
        Mon, 22 Sep 2025 13:46:37 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698035d337sm138464615ad.139.2025.09.22.13.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 13:46:36 -0700 (PDT)
Message-ID: <d3816b71-b9c5-48da-acb9-a27702c8cf8a@jjmx.net>
Date: Mon, 22 Sep 2025 13:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what's going on with aa_destroy_aafs() call in apparmor_init()?
To: Al Viro <viro@zeniv.linux.org.uk>, John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250921073655.GM39973@ZenIV>
Content-Language: en-US
From: John Johansen <john@jjmx.net>
In-Reply-To: <20250921073655.GM39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/25 00:36, Al Viro wrote:
> 	Correct me if I'm wrong, but as far as I can tell apparmor_init()
> ends up being called from security_init(), which is called before the call
> of vfs_caches_init(), not to mention fs_initcall stuff.

sigh, yes that is what is happening.

> 	If that's the case, what is this doing there?
> error:
>          aa_destroy_aafs();
> 	AA_ERROR("Error creating AppArmor securityfs\n");
> 	return error;

it shouldn't be it should have been dropped ages ago. Its a mess up on a
patch and then it just got carried forward

> aa_create_aafs() is called via fs_initcall; moreover, it will bail out
> if called before apparmor_initialized has become true, so...
>
> While we are at it, what will happen if apparmor_init() succeeds, but
> aa_create_fs() fails afterwards?

Yeah that one is ugly. I will have to poke at the best solution atm.
For current kernels, no policy will load. Backing out the LSM hooks
isn't going to happen but we will need to just run in an unconfined
state and make sure any references to the fs handle the null condition.

> If nothing else, aa_null_path will be left {NULL, NULL}, which will
> immediately oops dentry_open() in aa_inherit_files()...

indeed, I have to wonder if it was always that way or I just messed up.
I borrowed the pattern from selinux but should have also dug into what
it was doing.

regardless it needs to be fixed.
We can check that its null and set the file to null for replace fds.

Give me a bit to see about some patches.

