Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7D3537D7
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163480; cv=none; b=p1wH6EO55zOrBgPVaArcHtiWdIo4U8wzO1vW2VbxtUbil0wEE0aRPGVHEG1kVP6v2wMXagpf3Q+RCMjO5z8b7FPxR2i2mXE3rWR0r2kZEIoOMaHInftLtpITjzEqgqYptSbAU+Sj2WCfpN1JeHFw6V3hqYP7LAtbfyb+OVANqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163480; c=relaxed/simple;
	bh=rbcgZH5s1WpmosZP5dWR0FOVmYRsVKPxgzxpSx2FiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM/Cg0njXrc5K0GYYEokiUraDfNybwpFC6yRPTI4aD0Vgyre2oqBGc0k0wCbTetwvVS62xmA18xmGMFqdjpRGncv5R1iA91VvDWcZRSejLcaeu0sQ1stat00BNc6zv0EP5UxHI+6yMbjuwYvxPvybOiUkWz9QQ+7rnRnNgMQElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5UM6vTK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5UM6vTK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso18080345e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775163478; x=1775768278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sz3/0PjmuEsSFkQLA7iWP5iqrM2isDRIIZiuOt/75h8=;
        b=m5UM6vTKmxNFZVZyYdtsazKg4rs1DAu+/BZ0vnEfD7sS9q00K4C24qsPXBoZx+3IGF
         sRc7cud+F367oChEj2DMlCLCrITsjNEGD065ItPLkkJplwa/ciqqYEwUwK+JCvtZ2ONH
         bENNw5d8+BlV/rwYqKC497jsi05KiGQG0A0oSadw1mod/cf5GZlwnNN4iBlmWiiohSBL
         oMjmqn65+x1NbsNtXcZ2ylNiuU3Zwu1BkWOal2YPXp9ogRcdWWvREm/faDlaF3/L+UDD
         tTgr9OEhnIgGl/DH/zSOmOb9zYHFqkC9f+RFm5lYpHZKrPpCmTLp/e8QUKNoLYTkceSU
         Hyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163478; x=1775768278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sz3/0PjmuEsSFkQLA7iWP5iqrM2isDRIIZiuOt/75h8=;
        b=DTWYkppCpo/cTf9eGP9eooEa/ZdehWY35trXfuWGzLe8RsO5K4UfsqAoXG0pZ43PtM
         Jq8/men8aahNq/ANRXh0M4hyvroTEAxq7/Kkgj9GrgZL8lrbEL7W1DCq8iH7Xyarp0s6
         F61YKyuClh1extocZOsMjGMtWytP/a/Cysqr9awZzbTjfd+EZ6AOgQGmPiJ5EmSb2M+n
         YcUmyw1CFzxQ3kFS64M/otxbXaAtX4SioAW1GlNTqvCcwfMdKLekLObBqG4iltE+0Wdu
         UXqdJD/0bOTpMYJkA0Ozr5orWoowD/83dClqsBF6hNTf/L1QqUip5WOdH/ZS1EYd9Guh
         XIAg==
X-Forwarded-Encrypted: i=1; AJvYcCU2AmC7qXYal2P78/c8zRpvai5z59LbGJIy8IYniW36yDqzBLq66bhvQtYaA9Lq3QIa5HK6Go7Rym3zp0moFYnHHtsRWzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEuMQ4S3XmE4xpr+xXt+UXdRFSbIIupPdBjjfb5117jx0gOdd
	ePROz1oLcoOAWI2jcQLU9U1fyyxDKgbNv8quEV7iUPfN1XNKBm8jOgGs
X-Gm-Gg: ATEYQzz4w7O4gtAFNJjcqCVut108YmDeQrriKwMZgCrYLVG5nUY+WrlklECZ117kaXG
	498+9biEymiAURdXNKdni+yMmM/LaRIwHPW8yVowOmM9QiUjZbq8sM8vtzBw3EKrLb6x//t3XBQ
	qo0nGfXOFJ78uypt2tZ0ZRg2roCZV9A21NUv90qWk1OlN38LuKMaGdI0XfQraQeLEBo99TfuI58
	G5PDxXsw+9PSio3aovbrA+uNepGOxpBuKnjgPCu9bmM6jkCWMhJTDWQUdL4O7CrcpxnXTy4qcJA
	yG+EEosEBpvxdbNksHBeblHYC8zJbeVHiCNwZmF8iEchIFBa7yY28IoaifPF+EvdepeY0aHSrk9
	hD1j9KgPC6CXM9jjh+/UlgWc4Ws5ILYSdPU1lJvJ/go6TfnYBVIKRLMO3STmAykfWx9VYdJOZic
	6gDLzh6Ci8aPUv1nSBiIgovJfbAB4Q0PdmsyCwxvENi8GRbIxn
X-Received: by 2002:a05:600c:1381:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488996a351bmr7541905e9.4.1775163477983;
        Thu, 02 Apr 2026 13:57:57 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e420efsm3552995e9.9.2026.04.02.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:57:57 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:57:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v3 0/5] Fix Landlock audit test flakiness
Message-ID: <20260402.d8ed83acd13a@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402.eb5c4e85f472@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402.eb5c4e85f472@gnoack.org>

On Thu, Apr 02, 2026 at 10:52:46PM +0200, Günther Noack wrote:
> My kernel config is this:
> 
>     make defconfig
>     make kvm_guest.config
>     KCONFIG_CONFIG="${KBUILD_OUTPUT}/.config" ./scripts/kconfig/merge_config.sh "${KBUILD_OUTPUT}/.config" tools/testing/selftests/landlock/config
>     make debug.config
>     echo "CONFIG_RANDOMIZE_BASE=n" >> "${KBUILD_OUTPUT}/.config"
>     make olddefconfig

P.S.: I should point out, everytime that I have observed these
flakiness problems with the audit tests, it was in this debug config.
I suspect that it adds delays in a way that makes it more likely.

–Günther
