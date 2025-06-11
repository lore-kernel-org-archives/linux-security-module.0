Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080728C855
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651852; cv=none; b=lv67iamzrPEyQnfQWcqXa3dGQh+ARJLrsJrwzPqFTEZSvJynPAkaT8TQvgXV10qyo4YlqnHT+u+PsEJYl4q8djZpnZYdFcZOIX37WdKLYwPKWV0k1/n11IVo4dwtjEIioO8c4ZW9gB2H+MzYV6lN0xKKpoK9qhhh5DZFMFflSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651852; c=relaxed/simple;
	bh=+n2wxlhNO/5kmSj5JkekXPG3vsLUDhvGncEIlxfIMF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mns9RFjF7kZXht0vH1f59n6puCrkWVJt7uHFEwfQrsDdr3Lf5gQ2rQnDkLMRCNwmA5/jPs8hB32G9UHwdfHZMAVfo1SpELHvOgdyVotxt/CSeRxL79ZOl0XPy3njVmSQIBYRCEWxO2W9H86ezcoLJjSGCog19FY2w4b4rBzOHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fboq00SM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fboq00SM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad93ff9f714so1204530166b.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1749651848; x=1750256648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n2wxlhNO/5kmSj5JkekXPG3vsLUDhvGncEIlxfIMF4=;
        b=fboq00SMjpBc/dzR+nnXMmZDLpc4cY4Uk/8wUG0553GWJsGrpqT8xialuROWYUOgT/
         3Ys48/I2I6OUa8vHn18KMVkvpHqzfgzRFKuiPNkQaAgPWRzcRRjYXGrxzy/S5CQvAkxQ
         rnhfRmIr5HobqnCprThFMaaKeQG2s6sC6OREEwhCgIfEKPcnjILByz+aJKy29yOVXG/n
         31s/8/p34/yBuXNJf5ZSB/WUrEtj7ypG5E44PUuHGp85T5r9BhHloI4qjR7rLLwlUnn/
         fgCh+bk/DWCTTJS/F1FiAKF7Wy9F+VgSopHi05EfRKRWxWWJglD3tlP8vieJ33cpfMI1
         y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651848; x=1750256648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n2wxlhNO/5kmSj5JkekXPG3vsLUDhvGncEIlxfIMF4=;
        b=k36oaubzXoX6kp9gZzisk59r0F9AVc6NNNxiY0zkNU6+5FDlZrp+eNLGzNxuY3Ff1D
         ueBHLCN3D9vRvUii4rmq/K9wkqsGUKtz+bRLcDV8ldAbcM5nB6Krkk77/a02vU/q4ic2
         ppHrtqX/laF4ue2uuxv9c6WNsZZjTU0bsvRr2K0pLdZRvX7RzURGA5ksHWLQBu7WeJs6
         zSixIHe/YohtlomXIiUwkzK2y0CGehVK4xK9ldZiKAenfBR5Tr/M4FxV8B14TtbFGmr5
         XExt+thkx7s7eIlXsjNmnw7FOCWTS/Cbkai79pP+5fXTWN2RSxqLbtC5U80pL/HpHwh1
         6wCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnwezbJMsJJ8FjS63/hLnCEimiXGLvsNxPbvm22jGpO6hjIbZ7i0ndwON/22FOhppcuNBXGnWnO8eZAc62Z4wsMPxjsrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62LxjNNWojyCZMhagOXoOXVsegREJu04YglAdMqqL3EJzRpHV
	hsMoGtzqSP2BrVS/ynIHQ6NTJic1uNSGHrCs7dG7dpdzal+DVqLzKPt/JMwmK7+4EYc6LdLFcIX
	32r9ZQcyfmwxpAxvQ1Vs1v4p8nr0iPMaSU/JUrmCDHQ==
X-Gm-Gg: ASbGnctB7j8xTl17zwHN5D5iQn2/LtjagZACdbpFEKMdGG4OzSuOeL8XREyK2IxmS3c
	s8EEnTTf0CedblEXOSrnIave4sfjQ+RDvsFL6epAQwOHFH0PFsRkNwCvyfjoc7H+D5Z2RSYWFpc
	f/sYZKx7FTEAaarob/MNuSKl2c4vzdE2mmTyMTqM9AL8glWnx5eJwQjlZU87hDCn1rSQMDFDvA
X-Google-Smtp-Source: AGHT+IHi3WuXVPV9hfbd1BQHgmHc2xgdYuuZf0M1hUFi8jc87uLtSAZ8i8Pv46mcKxcv8DLSc26FN718JaJ1toUbZkI=
X-Received: by 2002:a17:907:c0c:b0:ad8:9466:3344 with SMTP id
 a640c23a62f3a-ade8c8993d1mr286839666b.43.1749651847859; Wed, 11 Jun 2025
 07:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
 <87zff6gf17.fsf@email.froward.int.ebiederm.org> <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
 <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 11 Jun 2025 16:23:56 +0200
X-Gm-Features: AX0GCFt-lvgulZZy51v1nQGdrw4LjdO7BhuMTAtxvy7UyojcjPOL_75VvfjJ_Cc
Message-ID: <CAKPOu+-S5C59X8zW=6keYAsHecketOBzMbb3XXDnLTc0X1nBhA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Richard Guy Briggs <rgb@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:19=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> Aside from a tested-by verification from Max, it looks like everyone
> is satisfied with the v2 patch, yes?

Sorry for the delay. I tested Eric's v2 patch and it solves my
problem. His patch is nearly identical to mine, it's only a bit more
intrusive by removing the weird __is_setXid functions that never made
sense. I welcome that; I wasn't confident enough to do that and tried
to make the least intrusive patch.

Eric, I'm glad you changed your mind and no longer consider my work
"pure nonsense" and "pointless".

But one problem remains: in the same email, you demanded evidence that
userspace doesn't depend on the current behavior. However, in your
patch description, you hand-waved that away by "I don't expect anyone
to care". What happened to that?

Max
