Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC603CFF61
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226063; cv=none; b=Xv2RW+xPCDfLNCsoblXhZP6G5yA/j/BRzAtj9wwUlIOzAuyfg+3GYyJm4GpoDj/vLe306uxTN4KGJkBMzGgEQswvvEgFoRd6USIE99Qy8X7QqCwRpj4PV0VKhtA57FieEe9LFjAq710kmQTcDCzjTidjiDOw4oCiA44QjSLRhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226063; c=relaxed/simple;
	bh=zRCIOZXGAulewyBbqGE0TlQlTPqeFeIDTbPGyy24MV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9H/POrfkEjTm2qkiX+bSktGcUZzpfugSivwWkLkONMy4O2ovw4T+rcSIRDys7OFw2mEtzDTH/ly82iZdmkudTFjHHZDxYZXca/cpVV0/e/Xu9Rikk2kcYaKMk64R/D5F77QgXVO56hXruiskFOEd74asrlt/8GtRIIOs+OfYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+NfnaGG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+NfnaGG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9529135e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226059; x=1773830859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=l+NfnaGGhGE/Qag8NAZKtowOcVY2wLQCbEgf8MnpvieTQKfxTgLXG7gVpu41GQE3Cp
         lhcuSJ3ojhuoA+XvMW4ZK8DqWwguSBIQJdzHM+m0gGn1i58Im+PG8aw4GSSmMwNkHayu
         W9J2Et5BO3MOuAYEpSQbP4o8f9J9gsDj/OANzpqDRda1qkC6GXeo6tLR1/FbLVhhy7Cf
         MUxhHc5jx0lvSaHnxQ6WahuluHX1XzGqARVN8PyVe1PrQbU+agAKtUfEmOiyxhtTA+gY
         BR6kn5ugraDiB91Rov4L/mant481Z758KVbs1s66hkgz+KSI4U1uv3Da1yI4gGWMgZ4d
         Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226059; x=1773830859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=eQzgyETfi35xujBqSbE3DjNesBiuk+ZM3H17wjX8znaK2nv63zWmkLO8Xo8m4iqrVM
         QN7vKrkvqcsYn4nPRvyDBwVJ9XMtqoaDtOvNsblW9+2w1Ud+G1tDmHIpdBniuk9bUlq2
         Oa+Xp3ptpmrFgny9ckffvyawFcgIv80tgTySx883ZRwMSoQlnBHHpolB2j6MjUYv7rJ4
         QlYRpdn5qR0n6UTlBH8Y/fHu+7VqanUnu3nafjN5I7UGL6gPSVDmm71PLBh/vILDqPgX
         VaDABZ/r5N7UwqjDYkZ8FpxXXK2S3sI7uErImnSUgjhJZIbcz61gRv5XOv3ZqNwbJvFV
         saFw==
X-Forwarded-Encrypted: i=1; AJvYcCUJu0zBPH85oJxo8ArCkBqtmRQClYsN6fa9EodSi+ekTbgFjxOUNZiWjb1pKW+mHeRoULXCPvy99dJ5oADIWuKjBFeRfuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwspbVYll5p86GkJbS2snQc/kMufQgG7ujmOoiQukZE+aFCmWwk
	0uhNduzZ5CHLLFUOR1xp34rfDg/7Tde+s/wA/7caVRv2cfnOZm+LUaQq
X-Gm-Gg: ATEYQzx9OAfIQQPCAmvUcFCIf+wKtnyIfVrmepcArFzq70f5WzM6+iDzryCun17pfCf
	FUof0SBqYoRc7EAWMB3poRj1nK3UCuuKmJPpPqWg4Ho/laBH3h1Xu8bXsxA/OxLi5PNxbQntkMh
	M90yq0xV0FDG0BcT1ExBFJa2+OfiPGpm0hIKhvb4Id5a48gpNDJWOY+uwTCxyjRyIBGnSZukrZ2
	nAmq2otxfXmoA3CLVbJQkGZoAZeVCgI1yV6ko2WPlKtQrpS8EHVWF4cb2xb02ZPJhOs2aL4aQ6j
	SpOXBnsoh8xvahaXQZ51vc/d2Ao5wvNF2lF68ccN/ldIjEn4AXpwX/F2cS+EpD4UBpgVKif9bzR
	Y7rw3N2GV6i6ZoTYLVGW14rv0VRicM4cXWFMvPW5sFwSN9Spg1qO3+HwMtkv3k0C1Jh1yMNjFXZ
	dsGc/gFeIn8LGIymLcB9cdsRrijzbdSABzhRSJr/xgPVvOZ095dCCHxmEvvrvzgqczjyp9L6fxK
	UE=
X-Received: by 2002:a05:600c:5298:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4854b291dc2mr30148705e9.15.1773226058755;
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm5725154f8f.30.2026.03.11.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:47:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfs@lists.linux.dev, io-uring@vger.kernel.org, audit@vger.kernel.org,
 rcu@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kthread: remove kthread_exit()
Message-ID: <20260311104736.51b53405@pumpkin>
In-Reply-To: <20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
References: <20260310-work-kernel-exit-v2-0-30711759d87b@kernel.org>
	<20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 15:56:09 +0100
Christian Brauner <brauner@kernel.org> wrote:

> In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
> we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
> We left kthread_exit() around as an alias to do_exit(). Remove it
> completely.
...
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> +#define module_put_and_kthread_exit(code) do_exit(code)

I'm intrigued...
How does that actually know to do the module_put()?
(I know it does one - otherwise my driver wouldn't unload.)

The corresponding try_module_get(THIS_MODULE) is done before the
kthread_run() (and has to be 'put' if that fails).
So there is an explicit 'get' but an implicit 'put'.

While a loadable module that creates a kthread usually needs to give
the kthread a reference to its module and then have that reference
released as the kthread exits, I can imagine cases where that isn't true.
(Or broken code that just hopes the module won't be unloaded just
as the kthread exits.)

It actually makes me think that module_put_and_exit() ought to have
a 'module' parameter.
Or, perhaps, kthread_create() should have the module parameter and
hold a reference to that module until it exits.

	David
