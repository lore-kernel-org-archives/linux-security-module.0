Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758CD4A0C
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591629; cv=none; b=Yyqm1THPPAZ70mEIFv2z5Ema1Si/ZZiYiOV7+lNfY13X/K8mIiW2O4DEPfOUwaNOCOYQwzfQdEWIa8nwk22dYL2i4gq1DNEKF7QIT/Q5JWW+YDB0TabbzUNH2hFVtJwbKboK+eMw46Q2CinSOroXKFi6Z4pT6VBE0BDYe3i8B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591629; c=relaxed/simple;
	bh=vXCTGBNTu1ZhVw/3Q0kYcVmj5r+C9dLc8FPhH6o66uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxxBaanXWZae0LYMPabsB/k0lKwcIO6XfY4CyrXQm/eapO2nNtuYe+VLx0CYiiAa9qIACCo0CaMn7VRTZZqMkh9E56ElTEpDnHFfT1bOohsGrPp2Toa6LjmwA7eUQhOBCU7+fwoRpMajhEjLF5zzl+onVVncmYnDXpgOPVFkkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CVoMtSX8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CVoMtSX8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e573136107bso2364665276.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742591626; x=1743196426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i2ew2LYxgleBNPrPHWYUPReaCgmTl0BEjHG0XlfsxM=;
        b=CVoMtSX8aeCGHEIpipOw2bN3TUYw2kx91HSCAUn9jLQz3hfMF2Fy1gwK6/amNZ5Ozx
         eOc5pSMN39mbNge0B26/WZ225Z80rbeIcxbwjVjG3MQsyHKNUK+k0S5t+JlooCPbLZgI
         qpIHi72Q4uf2RX9aeAmMNAoFKVKdgEMiTifPxb59WsNjfQmviDYVftK5sV3fpMVExced
         6n6cHSzj70C8MsPteIVtomOSDXYuJwOiIiPNh+tC/rr1ESUmPR1OVhC+DF2FZwa07Ccs
         vjUEjS0gdAwP5lVScSpTaTEd/jGGWiKxX2gwvRkusFfVr76Ft2wdEdot3/XZgsDmSaAU
         MxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591626; x=1743196426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i2ew2LYxgleBNPrPHWYUPReaCgmTl0BEjHG0XlfsxM=;
        b=lhLxHTPDNXWOw20wlz8PP/XhwpZdLdNRO/fLzrly5EVieX7YAjsTTkIxjK8fGCw3JO
         MSVtX+uyparb2z4lj6hWIwo5fYyCmY3CNjj/QfkB14rWa8XylCEkJJ0KN3zoP/MotWwt
         wjCfj6jIPUM1qqaZQSna0E2cS+OISGV/S8uJCfin4NzIlDVynaHIcg+zoRhjS8bIEg1t
         ZJfRaGHn7VKufBErNaxwNPfzd7+QOffioVCzRH7i2yOomAnpEnl/HUXtrQ7e5d0AnqUr
         HG0jDKaUwlXNFtAvzCJCbmhp1RxhjhLvSqX4Verl9rbLFThE65syQT4Fo/dTL+EPoo1t
         +9gA==
X-Gm-Message-State: AOJu0YwJ+djnBWSwvBD3FG72SiOD7zVcxFydPP83A6+Sb7VJRqK+j6+D
	Z64or6utfJTGVnClZlANVTX4A9fWsIthb81XYNvyih2Aycf6XGBlNHivFJKhyjDTipvAmkhtsYK
	5cd1mcfPCuie/OGOhqt3Sg4Odkd8xryQbevGFM0igbeaVXoopfw==
X-Gm-Gg: ASbGncstoCkmwfFBbcp0gdM7BVAmZPIEo/gP6LlGcCVK9mJB11idBiSNksCXg3lvC6A
	XMwes9kUozvpBNiBbyozR3F954MbBlvraqF6M50G6btoHRJEPir9h4qnydxPgvI/w8r982j1aM5
	w0AB5pZQDw1Ka5FB9qLfKV8gNg/7jKm8f2ioj6
X-Google-Smtp-Source: AGHT+IEJdg9bvrmazKSaObyLFJyvWysTY9GZ1IrakNKlyqsc9PcsudY5cVnjW0AMjOxr//q3y/G2oTHH1ULQgsL6BR0=
X-Received: by 2002:a05:690c:6e0e:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-700baccc7famr70059317b3.26.1742591626216; Fri, 21 Mar 2025
 14:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321102422.640271-1-nik.borisov@suse.com>
In-Reply-To: <20250321102422.640271-1-nik.borisov@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 17:13:35 -0400
X-Gm-Features: AQ5f1Jp901Ps5YHdQiwmT3LZ4ohZiC6256GsYwktLVbiz-fabRCF7SyN3qruNTw
Message-ID: <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, serge@hallyn.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:24=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
>
> This simple change allows usecases where someone might want to  lock only=
 specific
> feature at a finer granularity than integrity/confidentiality levels allo=
ws.
> The first likely user of this is the CoCo subsystem where certain feature=
s will be
> disabled.
>
> Nikolay Borisov (2):
>   lockdown: Switch implementation to using bitmap
>   lockdown/kunit: Introduce kunit tests

Hi Nikolay,

Thanks for the patches!  With the merge window opening in a few days,
it is too late to consider this for the upcoming merge window so
realistically this patchset is two weeks out and I'm hopeful we'll
have a dedicated Lockdown maintainer by then so I'm going to defer the
ultimate decision on acceptance to them.

--=20
paul-moore.com
