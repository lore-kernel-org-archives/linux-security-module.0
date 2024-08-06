Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800B170A1F
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977974; cv=none; b=jo+fMQHCKUioXvpWDNNCyIdB/rlLjraPslyMxAX0ptTxL6pr6LsRTkmIQQPsKnO4yBlaWdMKSwPDtQG9Vv/GW5YS+UTEhlZvUn5X4fkH2lS2tSPPvhQ/DiEc+TIsNYjg8bv8tfJxMYelAtFnQHuZrsQRJZk6qAknnVPT+ZudOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977974; c=relaxed/simple;
	bh=qyUz9Qqv5k5SudOvCxQPX4RBki5RQXyIqfhgrvWKdyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjSUaT/CRBqs1986reTQIKiJs7ukoVRmnNAvCl6skQ3PLNFllXX+lj+thvHjYzTUuOgTqK7s1+u9/uJvKPefdUdRGCL89uK2dp2wpr8aD/ljpttaQ8Vk4Gctuu6D/AyGNOWLV/fPPNql61U71yEXGc/v9xFzKKsvzosl3lGozJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eb3sUuf/; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eb3sUuf/"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0bf677e0feso1007169276.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977971; x=1723582771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=Eb3sUuf/v0kca+XnoKJZRiENpb45DUPlfGi6IMf13qoSoLYimi3mbIv6qhH8hOEh8A
         mtVov7Lo2+nWdrAHGka9zLYVA1Sjmjb3AcjWwDADP1msPFly37oB04+MJAo54CujViTu
         a1vCj3WAE+S3ZIjyJgFSjCbqF+44/OIo599KJgBo80TX+cbW1YJaofC74vUrXxBHwvc3
         sFE1L/cMDbIe99kU4N5IUeNp9/6xTDjzSbnrqVs0378SkaDdfLa0lvtM6stQdlKdcDlN
         DrmYuETjc7TuhIltjqm90BxNzaWLUuccUumCJk4/JR+ilZrg3hf3VdnUc5ty8V2xUoWk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977971; x=1723582771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=vCw4CpkUHV17Qn3Y9qX3HApJq2M65TRw6CRemagbDnQrTnluBr5PHRK+3GTKjf5PAu
         vqwG/2O2RRvZBVR3smBnAOJQCuxcKbSb9IZiciq6citQwjxdvj4l3GwX2/XQvmQ4ZXot
         5TeIVqyJUgyEX7Sq3FxD0q3H6VKeB6XoCwrnVA2+dL14jvJWZQ+e25LqwfbFtcyMawCK
         Ci5M+1vVjc5MvCN0iLA/PiWcMew5y0h+bt1I6Su0d46136AXzgEz5gnzTCWS2DwfddJl
         Xilyo5ID6MY4knVa7w79y77G5z+bGEpQOl8rDyYD/cXaigU5a8RYnOB8h8Uj347uQeAc
         reoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqbvEQkbvQsXOmwhKUTwQPNB/PpW9VclohNqiVD6+6/tfOre5gxMxC1RS5S1gA6tApG0sF7p7TQXlgnJ2DX4ux9xKvMIn0cISSmYU8+pxdKaAIQsnS
X-Gm-Message-State: AOJu0YxYS5Gv6w8+GvQKYoI1MTEDrFY4lgQcKDzPozz+3f8idTWWDLlW
	h59neMCLgMuT6CjhbEKhm5B3ft4Zfsjlj2SaCI0WVZmozDLG0AWNC9sVOgizoaFOYNBscW1ugs/
	u/onLB0pNL731SaW5WDkcJWU6AmBgqvk2r14w
X-Google-Smtp-Source: AGHT+IG+g9ZPIj3c+gMV8h9nbV6S0gFWlT866BH5MDCEFMia55H31Vc+W1m/exuwqdaE7fTnf6/iUgbwZyFG5W1FJkM=
X-Received: by 2002:a05:6902:15c5:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e0be2edba28mr17255194276.9.1722977971481; Tue, 06 Aug 2024
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:59:20 -0400
Message-ID: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> IPE is a Linux Security Module that takes a complementary approach to
> access control. Unlike traditional access control mechanisms that rely on
> labels and paths for decision-making, IPE focuses on the immutable securi=
ty
> properties inherent to system components. These properties are fundamenta=
l
> attributes or features of a system component that cannot be altered,
> ensuring a consistent and reliable basis for security decisions.
>
> ...

There was some minor merge fuzz, a handful of overly long lines in the
comments, and some subject lines that needed some minor tweaking but
overall I think this looks good.  I only see one thing holding me back
from merging this into the LSM tree: an updated ACK from the
device-mapper folks; if we can get that within the next week or two
that would be great.

--=20
paul-moore.com
