Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB68E5FBB7
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199478; cv=none; b=KWu2Bh+gSl6a4+Q59Ma4fjnV/ymX7ZbEbCmSI509U0PHnRgkWq9hx8vsVS9mvplQtTXOhWvB4c/KAIu7k3g8cT+OwTOrnmbKbogJaYVX+96L7qCiUyTPSUFeXgZThz5dBPwL0+eRKxs2UpAX1riDxKJ+ILiX2Q5AJlVoES5uDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199478; c=relaxed/simple;
	bh=uFoZhI+y8PqW89rv42XL15MiRKjZkSfGtLddBoynQSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz2xMGqFA6i2FtUBGYVLzqzUAMfoO1yMpPrybW8pCiUAXcCsJCz3DaVJGsVdWtO/HQXhdq6O4ANiYePCmWE8HtAUEDondpfOxQEfGK+wJ9x5c28D5DEfj6OfXMrtqqYroduwAiLCSiILCqaZOh76li6pIIaBe1aGKs3jtac1QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KADqoiAg; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KADqoiAg"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0360f890a1so2403986276.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jul 2024 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720199475; x=1720804275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84qVFb2nDbAUCwkzyJJKS1FbfelcLQzwoo/l877IkBU=;
        b=KADqoiAg4JLLNSHgthscqMRHcYvIF/m8qiySEaTO419mtjkzQXlO3+8oJA8JIYSCj7
         Rg6VJXYPc4NeqE+x2VmOjELBXiKUtXIeR/49UD2D37zd2lNlZOlcJlX+mm+VwdYUoJBt
         QAIYwGFzaS4NIz2QOn2NusdWxflNjJEsu+Yf5de16k4j8yc3aSVsBmmSh7fjn/ZrJzCl
         LkmC9jvGAeAMXPJub0/BjX2CUsMcC4zyAv0rKpVm6mB5VBRBjLhEu+IwGUdF93dcAAgs
         1S3EvE2xqXxtCllq3QKR6W0yVNPAfuzUaprMDuPwftMEsyfjuCyVZPcBT/vM82KTsd6a
         0isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199475; x=1720804275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84qVFb2nDbAUCwkzyJJKS1FbfelcLQzwoo/l877IkBU=;
        b=MXsJbLtEIeBYxIcFUBkhwwnZ2KY0Pr6porWzFYkFOIG/lc7AwgoJbTzgW81x5E2rTX
         CfczvLZQjaWb2NvMZaNcqcqXPKAHMRi/f0AlWUwI0EL7I66EhpHojdxhq/2/7XR9Y2oC
         /JdHHQu+sgZb+O+nygBLmiTWP2jX1Kz5dTBQz8GgYjG1iwS7h600Q/nSxZ1rsZiuhy9o
         E1lhDlbeR7zCd6Qqi6H9SP5oqovPr1+fvL6LwF/8qX7DwHkCwwxLm8ePBIuzG2nL2qA1
         eMG1HZFjZcNXfEqtmG38hvvE5bZezgZoYdMrqSaiPrjx6jjEz8Fj8dex13TgqJRmkGzV
         /LQg==
X-Gm-Message-State: AOJu0YyizhtIDFCIe/wJbuoQWNLpnrrOYSrOQAbMmMXsUeboPRpBLDdG
	vfG9GCShfIbcJP2UlEND2rodlYcYYLiGTN7oo9f5UmPCYkNwqKowRX0FMYs9wif2+FNgQjggTRF
	I2WEEDPWQgW3LDdqMVs1Z95oLZnVAartkyp/4
X-Google-Smtp-Source: AGHT+IEUehfLkP/b0qCwvoZnMsa8LDPHzos4+YAaeUMFI2pMvO/QgLHw9mWVUzg3TySRzEnKB7mNaQ+fUn5DhyQgIc8=
X-Received: by 2002:a81:430c:0:b0:618:90cc:bc4a with SMTP id
 00721157ae682-652f8184b19mr27843367b3.26.1720199474812; Fri, 05 Jul 2024
 10:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703211134.349950-2-paul@paul-moore.com> <9335721c-db66-43a4-8fc1-078d94550a0a@schaufler-ca.com>
In-Reply-To: <9335721c-db66-43a4-8fc1-078d94550a0a@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jul 2024 13:11:04 -0400
Message-ID: <CAHC9VhR6Xdo9tMnbDpJ=1F8YraPGvnrUjw9okYbxo88gbByOwg@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/3/2024 2:11 PM, Paul Moore wrote:
> > Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> > moved the responsibility of doing the inode xattr capability checking
> > out of the individual LSMs and into the LSM framework itself.
> > Unfortunately, while the original commit added the capability checks
> > to both the setxattr and removexattr code in the LSM framework, it
> > only removed the setxattr capability checks from the individual LSMs,
> > leaving duplicated removexattr capability checks in both the SELinux
> > and Smack code.
> >
> > This patch removes the duplicated code from SELinux and Smack.
> >
> > Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.  As this is a pretty minor fix, I'm going to go ahead
and merge it into lsm/dev so it will go up to Linus during the next
merge window; if anyone has any objections to that please let me know
soon.

--=20
paul-moore.com
