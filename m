Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1C2F49F4
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369261; cv=pass; b=IP1RuLnkYXSWHFZdXR0otvXulWrzY9FfKjHpFd0kAoA/nCrgwt6XdilC3XsO5tsz6J3nFfeP28i513PRkpYK9pZVEpjXx+Voh3mcRLMW+riAzcZ22fNHUcomAAMII37Purty2ljMeRQWIVoDhzFraymtEk/rW1wyJ8SZe7zVMFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369261; c=relaxed/simple;
	bh=YRUqYgGttVfHKHB5BU/365ttQY2IwUNgPejOAIiz+NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnJJfqS9HxGo+0qE6tp3UHdUYQ3t8SpdtfbqE5VS3NxetMvJbCZA77+fbRV9L1eGBbXttIYKbhIm2t6J0vPSLRsGtRPsVjpIgORAFbYZW0+XJVCgKhlXwAINKWBLY3tM9BdK9hNFqKRY8586I/q0OObqV6zEyskOzZN2KHo7ROg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSKCgcNQ; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSKCgcNQ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b1769fda0eso407556eec.3
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 11:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769369259; cv=none;
        d=google.com; s=arc-20240605;
        b=OfhO6iDK7h/ib07bnhlTyN3osk6CmffYo10x4YP91Gjs/E5FPGUKbZRLCDq+wtcTGi
         meOAgbkoVqF5SEaq9hTwrsizXGLo+YvYAL4tYrv/sMaPm3FO3QCPb2mIGoSfhGbIgj3A
         497qNYbmjs3i3YAaSKwvnFG2QqzFgAtZ/LRkOgz3c04qRZrdZnUV/3ix4FLUe494ewJA
         2zpOioYdKaBvDai0SVny5rKvYnptAgQKUrw+4JnOoUU/DPH7sR+YECXEaiHAQlXc0ivn
         EhIEJSiYsTlHvp6aXnM0c0G+KPEpTwpEMNs6DbttQMLHL23i5z6uZdsr1Cu0fy+5pX/G
         AcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=va8g89JuZTXjoG8J36wmdQ0UU7zATe6HtF/PIIS1Cqs=;
        fh=LRVoouW5qdj/tepm+L4bVsX90UXxPmLu9sIxK9I21qQ=;
        b=lSaMriDzGDOWR6zWBLVPGKQ6ti0sYLLCBFf0sCnuk4B/xpR66d5lDG14cxc9HMnXLZ
         Qu9Y5zpkGYv3SUTIhEY6e69DT/7gjvJgZwIkSt4EsU1AEKrpHk6IzLPJbyZI1eGVgxRq
         ei2Gyhu+78J3qpnnciczNvHGnSuzF+ZDCc5OI9nUpzF3c4Hy1flQq0DoTdnwEv03UEHL
         w4GrBfgVNWQ6hnZRYi4QtSXCVKBpn6J23wRxgDwX44EG2J0PciSJQAlt2FeDlY+GGArJ
         g4cUuWF79lmrELkvLF9HcFDJIXJE5J13lJWwaIA7kS+/Iba3o/zZrla9KZbq5DHpBRIR
         Bozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769369259; x=1769974059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va8g89JuZTXjoG8J36wmdQ0UU7zATe6HtF/PIIS1Cqs=;
        b=YSKCgcNQXmd9yetcNlAx+WB361+GiAtnwf23jhxi+OeXNGcBc/CYtIz0rjrW99/Hz8
         BAeXFj1diErVvyblJQAPnWgiPap31ZghNcJQq5NWh3jWHfqdNkTR6d10CPmViDzBWWIs
         JoQKO+2zYLXwFOBd4472iRsgO8BIQ5b+T2EvQ9bRD4ZRXcMm1Qetu59zC97DNcOzL056
         1fm6Wdv5M9uRQAudcjW+C2DeBMBQ9dxux3b8w+biqRHbPHoFbSARbNZpuZmWPGilSt30
         dPgoWWEhYCk7PC8em0sT3QmGX78SIYdevqZxVhZ5bhPNIQxeWPuPaKbWN6CatXLCDNwx
         JiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769369259; x=1769974059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=va8g89JuZTXjoG8J36wmdQ0UU7zATe6HtF/PIIS1Cqs=;
        b=oLOrsO7xnrF2bo/YRPTEJMdEN1WATDRBb2/Uq/vGpSK4ZjlkqRn+gytSKPw+7ZoseK
         trsGdN6N/KdosVc/7pQMsxOlFfoqoAPVkBBXwahNPKoYuPV6wK/cTxk/jQvj1FAWLimG
         MCGFncS9JRIAyzVm4x1sKyLG5ou6vP2gKoxbugPvuDB/4/o3BxQ6ROFpOujdQOxS811h
         JV19gp5jUeQ+3flvdwM2WqnLE1xyVqkfvho34n477iJnoZtEDffvORsNua1Bne9A6DpB
         7Go1s7sNlyCMdJcooSszMxjc6NeK8tvGl6ABTUzMtyBhHj0KNoMIy8E+vg/E4vfXa4Xs
         oT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLUkMlEbQd0qhVfkZbFu31hThS00eFPwxtZHdJNcIqIgWSg5mQaC8C4VO3uVhHINnhr+EV7Kx4nQ1tSIKIkIIXNQrOfq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UwnwMv/2y061eer7UnzhRcCjquIot8VRmm2x+iv2C2dB7rRR
	vUXmQnlFJcoeloslQeRYYVhjxBtGr1tqGjJMBturETampjtNJqB6fWTtyDcmMnE96hrospyXTRd
	gQPZ8dny3ChBU7g3YX3ChiKaSvYeb9JE=
X-Gm-Gg: AZuq6aLGG4+b5y60vhHtFUU5aKPORuQCkSToldnPTIAG7DPSQ3s0tFJ0IbMHhF+/pbf
	eK4q4fgDITjA72q1KgYZ9g43VbcoqxWY31BSEY6fU8V5+x4Xx1PJhOHNA1qx3UIm4+Xxeg9/jh6
	C7+GaibEtqDLe53ED3XuW1nllb26APkRdC/E0VLx69rUvD71fMUDMo9JxDui8kQUPE3ldURtcBw
	OOrk5j2g3M4JasG4XZqjL1yu6+Acj7DbrN3SQ3dchN7QN/yZ3yPNhgKadAjA6Y/YaqdwxoA/T/O
	WPi5RFwstknDHDZkCbqLbZa09vbwSFTcAxV3d1uRJYTZu+DAKwzKur5goBjaDKMKfpYmsyBN2E4
	aWe/9ND23PyOY
X-Received: by 2002:a05:7300:ca1:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2b764515574mr562351eec.6.1769369259234; Sun, 25 Jan 2026
 11:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129135657.36144-1-atharvd440@gmail.com>
In-Reply-To: <20251129135657.36144-1-atharvd440@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Jan 2026 20:27:26 +0100
X-Gm-Features: AZwV_Qh7R3F-trvK1p_xsfUuFtGe3-r8QyHWw3LgKNheUc3kGLpPXC_8QRn8uy8
Message-ID: <CANiq72nJqFOR9vhPBfZUNrxU+M1HMV6wN9bN6i8e9rf_oOD2qw@mail.gmail.com>
Subject: Re: [PATCH] rust: security: use `pin_init::zeroed()` for LSM context initialization
To: Atharv Dubey <atharvd440@gmail.com>, Benno Lossin <lossin@kernel.org>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, linux-security-module@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 2:57=E2=80=AFPM Atharv Dubey <atharvd440@gmail.com>=
 wrote:
>
> Replace the previous `unsafe { core::mem::zeroed() }` initialization of
> `bindings::lsm_context` with `pin_init::zeroed()`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>

These were also sent by Benno, and in the issue he mentions
"re-sending", which usually means just adding your Signed-off-by below
his:

    https://lore.kernel.org/all/20250814093046.2071971-1-lossin@kernel.org/

Otherwise, if he is OK without authorship, this should most likely have:

Suggested-by: Benno Lossin <lossin@kernel.org>

Cheers,
Miguel
