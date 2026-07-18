Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3430170F
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784406930; cv=pass; b=FRdhgBjXKbxxj6rKd4shPYs9yuYGJN8RI4PmDSqHPGtqHoqCBNXNwKWkv2u4TvxUXqjcL0GAChwckSyw6siUd41xnga8fjGbN/M+Qrx3HkDcoXtALAs8YNHZCUjEZGkx2WhyTK6cfpxlQKt42u2MQm9vmbvsdzbcvq9vL5uzrFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784406930; c=relaxed/simple;
	bh=L4R3GSXsdF+KHdVEA142jPzPE6lMiiTCY9x+aQGKhtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNHbQqE+4E2JMFWUasOK4kskXZsGmarIUjQjEtOjpb3eMZIkEqrUu3PoarViOg3YLyZwVVFT5rQ/cMZyA5nX1solIsg8VX2VFZKCtOJjQA+skCXI018O9jHWl0kKWuOiuFYqz12UtXZQcnHQrvOzfjheEBSggO85XtlfHuvCPqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbXWwlwX; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbXWwlwX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d530fcfdso12693288d50.2
        for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 13:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784406928; cv=none;
        d=google.com; s=arc-20260327;
        b=SvuoagPtZFxYQhkPUYvhn5CqbeNTd8n/hw/72lz21ogadVkPfh90jmxO+3X+Dri65p
         j8g0r6lnuj2SgABfkm2/qxqSINQlUA0oBGFGHZpzIQmvsTCmKHIS+dkC5vAPqKFc86NE
         btOJdGaGaR0AgO6s0fU3TRxxQp9z+UQZLEXNbcTUSCwed2wsfZuT6jB+ELweICPYZZv9
         PbrW6c4uvkLZBCFPiM922pl5x7VRuAFpkLBivCXwrcytEfGw5Su2dnVpEirWxEESrWPq
         FwmTlyZ3x2kxkq9HoRffACvVaN4z8DkN0kGeqLHlWd0Vn5Bxm4rzvkzxJ55OpTImMuK+
         LZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        fh=tODD92D26cSmP4fy4yxKuPmOQGAPybu1IgEad9i4Mic=;
        b=WDMxIl4al13fZK/qeCLg4S+h0QGNOijkKOlNPBBi6vGeukOF0ItI8PQKNR+bdHoUxB
         aixqVf08Tjc/Kh2RQaJ5TuHch8AfbjtA1+BEKbngKIpqOj0ZyXy4mLyiCfy97zVWktYo
         X+yH9kAyK9A/y8zTnZeodg07+aOwPB0+PKAlNsnPm2X3r16KvOQveaYJFOT2LKoReIww
         C0pNagn2UNpny3+5PeZzxbS9mlBzXHaMK5Pp4Dpf7AuKl1KuvljzGEWUztjwDm5UjoVN
         61w95Lf/YGBVuqPTjfcpRVDusemebNaxYEimRVcg+SZHw8Vs7G9q0lat+q8Aw4rFfSW8
         Q/4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784406928; x=1785011728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        b=qbXWwlwXkFBO+XQKdl06XjSeJHinrg2BLUgkGYd0u253dljCMdJuk0j6S7p8faqHSo
         8SHaAB5EenfyNrt2kl3I0z7az9dAM5kPvimX9mHH8FovlytRgC8B5fO8BTL1GFDXyA/u
         yxkJuD1iZECUVumBHtjCGmKeutcG5yOxpxviPWYQ0fvg6zPgCN2++QX6Bhm/i0o+o/L3
         e1NwfxgifUPR1H87sWTKo0hCvNgjCB1sieSibKE3zId7lc8Q4jxhyd3DLOLHQP1Wk7u6
         gNPKIOzqeQWZxSmqNDVk+z9GBD7vf8gg4ormDSMkg1HDu91HSDNEMpvMKNrQ3evBsmG3
         Psyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784406928; x=1785011728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANaq4uxSilcneb8rgahEYkQ/Kfssn+e8OiW7uLYST90=;
        b=JnvbmWg3kwcsYaSwax/qktz993Z6nuX3sm9r2z7RFnL9hkmJwCUJ7dZ7dlok6SjlAJ
         ITRQgwvhIBUgps1eDsG6vt/MJofW+R0j3bImuSwdU2isFfV0BFyRldSLco/4hztr7tsk
         /81F8ez6VeLK9Ya8lxVaMR8goW3R0ippv6bSqeIfmqilpldnnWQgoualSaATcsVOFM6r
         dbU60TcnhmwSe+WlqAHsz8IPTsH/IyX819K4Tia67rwnmE+CEagS/wxbXyzMTiZpD9zq
         Gq63HStYfmvw4A+r/ssqKivnwABkjTMLp1d6Ap6F1WbCzFbVz6mrij3NCZb36k21kxze
         6Vtw==
X-Forwarded-Encrypted: i=1; AHgh+RrggEj0P9/IR34Y9HDpCHW0WRcOPYV9fe8c1mp3D/npKklEEZODPwsdzfs6H7l8A/tQmqmtOi+QbDB5bmwvIAbaZgI39CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKyhk9U8SNVOEOEg2GKleaFQxqHLsH5gWpuhI3ZkhukF12LKz
	LJJ3KVhH/yDzzjW2hdBMmp1pB1yXOCpxsUiH+wZeUi7vqfgNK4nTsqjmKK9FXna2QkS1ha9AfO/
	1M9xwu87xmeBDpIZj8kshei5d/6UpA8s=
X-Gm-Gg: AfdE7cmsehmPKMLJMPDavJbwjOcoSgaUs9U0/wPso5FituFo5ZFhKlvaQsirbPuflrQ
	H5gVtsDOFqCzHAKDSeHjKYTbQ0SjYiVvB/8l+5F7+7bht6X8WarGIlKwx7illhK3HMJyiE56e8u
	Qv9/KtXo8mGBfwR7c5ij8IVi31ro5U06cpQaI1NGKhO/GA5zfiIuUj64Wkpfz5D8Y9p429R5KVv
	tFkoZD4cKNV4VlIjLQzgBrqUurKwUJsG84kebgUf4nT4ZX21c8XDvfpn4zAii33rbb4l+8DIifx
	PGXigsBW4jTmn/s=
X-Received: by 2002:a05:690e:43cf:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-6683bcc5c09mr1712064d50.56.1784406928154; Sat, 18 Jul 2026
 13:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
 <20260714115451.3773164-4-michael.bommarito@gmail.com> <alvIBm3Po_1gX6g_@kernel.org>
 <alvKED66fSFFcl1Z@kernel.org>
In-Reply-To: <alvKED66fSFFcl1Z@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Jul 2026 16:35:17 -0400
X-Gm-Features: AUfX_myY7jKb26VYe4sNdbzD9c138J4SlvnBQsoBTRGFhUo80gRTiHM4mVVVlu4
Message-ID: <CAJJ9bXyHopjhwusu=yK5HzrF31N5QX0uU-WTRN0g=aSMc9HJmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] assoc_array: trim the final shortcut word using
 the current chunk end
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 2:46=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> Were you able to reproduce this with basic command-line tools? The
> patches are verifiable by reading the code but asking this just in
> case if you had a snippet at hand (not interested on complex
> reproducers).

No, it's a little tricky to hit, definitely not just a few keyctl
commands.  I can send offlist if you'd like but it requires at least
~50 or so lines of C/python

PS - I'll send v3 with the nit fixed and carry your tags today/tomorrow

Thanks,
Mike
