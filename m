Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DE3A63F6
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564090; cv=pass; b=TahJAxbBonGJCSlDKSKc7/LUGHtrfpe0AillBXe9vyAmVR+tLs+XUrgZc9B4biYFHWQqcbIhrUugs+NNADeUdpUFzB9MmxEgCCFNrVosvhDkV9YcV81Rxv1CzoCdRqas4rmbqbLXoYk+H28nCA0GdbPBbv2vRRBt2FFoAKGEpW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564090; c=relaxed/simple;
	bh=DYtH3ovqeZiNqkreX7Nz4nkPWobgUXsJ5dwCB2BpWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh/9rPVw3IDOM6n6Lku37lQXGzyjsM5Tzl6anSZ4KMVE5EnfV53tWkhhMTUUKthwoL4YQlS5N8KoXdMD4hRos902GN9L0n7sSLtfFusvIeRNijrA22oI1hyrH/4MLiUT4qLT2RvUy6sSTCyPJtlPVesT4CeCBNiTczQeCo1CRz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVZPYGFy; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVZPYGFy"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so3209941a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 05:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775564088; cv=none;
        d=google.com; s=arc-20240605;
        b=B5Og5Yp6lezwTaZe9uSkZFi3wZsGNqddnCGCpgjZJ084e/ujvj2wvpgwrdHmTr47rI
         O3D40jnYVTjTeGXN3fHKefzryKWKvfh0HijKBv0B3ZZMyru6lrPrHhYq7zW4tBsaghWr
         v4isTPzlbJA/nDugIMno5p022ky0bIcAnDmGemdzNP14+AFZZDYQF1YJ2UyIE/GVjmmm
         hqRhol4dDrt1CsUCsEgakRLM6eVu2mS6lTmW69l5vsksU4/ngc/WZ6Z/RzyxTiR8SFM9
         9T5hLSgsXp8iomoxVD/OgkV0p18zcl8tTKV6ZsDkVRP+3XQoQq325gBA1NTKd4MBbo7j
         0DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        fh=kEr/IbOL7svhdlfg0VmFqAmfagol6bF69wyh4u3DgQk=;
        b=GQqs1KKvPHbA07zHuDdFFlmh1R93MNSiKtM+DMPZSUTiiXmvWg3keGPBvuKfgC7C3K
         fz406B3enyjHQXf4hw7Mg+W1rm2h8hqpW/XL538xOWYDcA8v8Hdkt4Pbm3jwWfxU2CNt
         O0N9e35/zyHsVbzz/TnekHe+xRrhdfJyocJ3iXunD1TYpkoNVN3qiLRFm8sztj1GgES3
         JRyp1Sp4Bd+U24a0TZYvHhrUEikjqJ3sNdSoh2eEJFyG509SRZjeyUo1bCuP4aKiycZk
         x6L/2ekWEpJH4x6V/fxO7Rmj/AWx8nGiEFieAWEntjGSbmaosNrD6rLjGiu8wj9ExLVH
         rFog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775564088; x=1776168888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=mVZPYGFyBgGtpWk4sX37nuVl392e96R4bjfs0ORNcxHmm4repjBBJl6wER9s05QPRx
         u9yMmyrIxhKtFPIgahhJkUem9XXnOt0Y4udHqUe5ZV5JLiunPgHbLwuF5YVLX9xOMwfS
         SHajj6jRYt56S5BkSVItPD2zTTs+S886TqgSWf6wGsfmVf48l/adO1vgGfcBxFHMUdKk
         98zAae8oxZWozMTxhB3oIy7PG5AaxmT0a1YdtlKIlVFcGbOdculw91xtDE6pfiAGsJ+L
         dEx4POQKFfhhxVSIboL7SSA5JB8IVPNytMGFiSoathMYqf1+sLX8Za9GGxj7OoZpqzGF
         gAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564088; x=1776168888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=r/sH9M7OW8IuNoXrHsqo6mZyinsqdtyjGr76WSNRIBtfLlfw55sd1bNAKOsDcln3hE
         HucfsJmoQ/xUIUIw3rW0yl5ytjdOuRUmPwhYMAuYUlc89z+usfdewhVvQgE9BfRplD3r
         1wjyI5nPiNQ93doRTLzz9uLXpoZCl7ZGbxuEjQeBJRvEZhFvB2A6+tX7T/ybE/KmwbWZ
         QL82C6K6ZsGAW8tIUfvje9QBurrosO1dRqIsdDPQFzEoV0Lt81OVwxx3txIe/JWIVmg7
         XXQGdsS8+nphvI9wSXrDCZNjt/kfyE2orns264w82BOcUgsQ0JYIaejtqzQsU6bNjLae
         x8cg==
X-Gm-Message-State: AOJu0YxP3aGMh0bBeRXW03La0cI9TLui7XpU+183d4+GqiZQQw3r8I3I
	+kYl3qXMgtmzgd3VlhfyuZahyN5sDi5nfOpT+GOpv5QVpqQClmQ8JqCHzBbYDxzN7prcl7V+pZj
	Si3Ejr485qzgBPfZRtTOwiwC/vkDQCFM=
X-Gm-Gg: AeBDiet0Aw5tecg/Vy5a4QdJjggtema3aH/Y7ktLEuk2AZYAYU7djRB/9C2o2CEgEFd
	wjoZU4fMqoOhzASps9SIl0bRZuMxRoMgUKT12vCrxQ+iToEGcBUz83ha/Z64TjSTKMUhkSlMJLo
	lQbyChpZaM94HOGjJGvkUOgZYP+IA2CCNqO1JQ7ZtcVU+7PWdVMPqEzE6x7Z7S0o+b9S+8nQ9st
	55hW28TP9YKMGMuA9P2ZUJAAw81lhfOPD+UuCiAxDMSC9gnG8dVAzh//cN7lxuHfFAkgZLq0j5g
	9p2cSBE=
X-Received: by 2002:a17:90b:3d4d:b0:35c:d37:6024 with SMTP id
 98e67ed59e1d1-35de67ea9d5mr15645164a91.11.1775564088070; Tue, 07 Apr 2026
 05:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 08:14:36 -0400
X-Gm-Features: AQROBzAHeiE5r-KOh8TmARe6SlYgAd0n8yvhwUwHmTAae_PdDX5ZmAScFcPTcfU
Message-ID: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Do you have tests for these changes showing the before and after (i.e.
failing without your patches, passing with them)? I tried running an
earlier set from Ondrej but they failed.
