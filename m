Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B6195B16
	for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366820; cv=none; b=VJRlHkDxoQ2/HtTWC/7MIMA+GXdrIQTPmW0NLlo/bCMIAWa6BuoAT0BhD2iKDhRw0GBpaN9OXB/3Md73XS565wuQ5SddfnUA2XvaDb82Pu11l8LX923pB+2ji0QSYT7ClDg2Im2XmjRFiCNm0nei56ex7JWBdEihQkOuz+/637w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366820; c=relaxed/simple;
	bh=+/uhGibMC0VodWLnmx3poA1E1omFTZn+oa/pCFS/5tY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OBw4Z+83uGD9rsU8zkPExNf3nNmG1XquJSlN1ABAeMiCued9VnRBYHLkbnLE4RDycqSkRQGhpfYmR1edrh80VaAaIIZLS6hXLT3FZGG+0LX9BwzxxTXZIRMCTlm2wwvYSRf5lbPRTcs1Rc7cfUEPYSOpB3kC+Ppdo9+JPDR7rvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztbTGydD; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztbTGydD"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-57cad3fa0a1so1293180a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2024 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718366817; x=1718971617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GR7hffcO8SN+iR814i+ZXXfRtOjZPEskyOkMnCnkLaI=;
        b=ztbTGydDDPMEXpMQcqO04iGzDSrmo3/rkvUOV87IZjQPjqWZBn9s35gEqqE9nijTke
         1UnNz0D9QW+VzonNfA/ndRhgRn9XzxT0duocmwCsOHxDDFaDtrA/1a20sgbPuEaW/IdB
         1O+0z/lq5mlK0x551o3WGLhPv48LtgnsPGfItKG2nEwr4S6LwqxdLysJv9PVxg3ZBjjl
         0sssQGpLLAJyiVEfiBTkrhw35V7RnXLpubtYZEKjfECt2J9eKu06MN2yF39N4MuYhAgQ
         GO/R4M42im82VUje3ru0sPmgOk+v38YpvMhw1YlOkA4wPvDW35A+6257nQWeV/NDJxPq
         hpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366817; x=1718971617;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GR7hffcO8SN+iR814i+ZXXfRtOjZPEskyOkMnCnkLaI=;
        b=lb+I47vNPH44WmSLeSd3fyeBxOVkAlxC58Lh9uSWBHPZrjL+dgMUE0sHutWG90BGr4
         qsIX0HH+cWkautOpBOX1U5a+IEDN50I8wd7ySO7yhDOgXwo44yoXU+nx3IUHABSx7/qF
         zij86rbBR62CUxeB6D1QCHpyztj5qR/xNvUcnkPlwrfIv2QQlxN58sViAargMubF3TAK
         SelgEgGHGyYV9N6SS/10SnjrjwQ2VBJWapC5qo2+zZYrOp0qjhY+n6PtufBDDSTkfX5Z
         YdEPbJhvNRn5D/YP24xo878L4bPp++rIBKdkDoQ+bbnn2akygPlYCPJigEclzej0jdWV
         TIQQ==
X-Gm-Message-State: AOJu0YwgddLnPNyZT8UvO83126B3/S2hIuzGewBYoKPWFJuwUlNlBu8o
	lFdnOkPKohVXYzrCMj7Q5i0SWpVL72m+03yZJOoLpqMBEyU/XpJJGLUWXeasVvoK85zvTVzg/Se
	pkw==
X-Google-Smtp-Source: AGHT+IH0aPfN2xcmzs5hHHc3KdGfiGTggvt09QbMV9bZ0Udafhb2wsj3/5ejSvEFbmifkv/XgXprA2qn70w=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:d44d:0:b0:57c:c0ea:110 with SMTP id
 4fb4d7f45d1cf-57cc0ea02f8mr2025a12.3.1718366817062; Fri, 14 Jun 2024 05:06:57
 -0700 (PDT)
Date: Fri, 14 Jun 2024 14:06:54 +0200
In-Reply-To: <20240613.chiec1EeThe3@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZmazTKVNlsH3crwP@google.com> <20240610082115.1693267-1-gnoack@google.com>
 <20240613.chiec1EeThe3@digikod.net>
Message-ID: <ZmwyXoItby7LDd6k@google.com>
Subject: Re: [PATCH] landlock: Use bit-fields for storing handled layer access masks
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:20:38PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Great!  Looking at the generated data structures with pahole, it doesn't
> increase the whole size, and it should be fine with other (small) fields
> too.
>=20
> With this new struct, we don't need the landlock_get_* helpers anymore.
> We might want to keep the landlock_add_*() helpers as safeguards
> (because of the WARN_ON_ONCE) though.

I am unsure about removing these helper functions, due to the following rea=
sons:

 * landlock_get_fs_access_mask is the place where we transparently add the
   "refer" access right.  If we remove landlock_get_net_access_mask, it wou=
ld be
   assymetric with keeping the same function for the file system restrictio=
ns.

 * landlock_init_layer_masks() is using landlock_get_fs_access_mask and
   landlock_get_net_access_mask through a function pointer.  When these
   functions are gone, we would have to redefine them locally anyway.

   Options to refactor this function include:
    * split it in two separate functions landlock_init_fs_layer_masks and
      landlock_init_net_layer_masks.  It would end up duplicating some of t=
he
      bit manipulation code.
    * add another #if further down in the function

   Both variants seem not nice.

Do you think this is worth doing?

=E2=80=94G=C3=BCnther
