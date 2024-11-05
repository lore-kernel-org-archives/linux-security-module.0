Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BB53365
	for <linux-security-module@vger.kernel.org>; Tue,  5 Nov 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844289; cv=none; b=eoNkXhM4PzUdIIoA8zlEq4+bt/cncDbwXQLfKNwIK6fo/AU0b1GxypFSVHWiG85dzwqYH1IS3LdrXH5/zmYUQb+Mdmz4L8GYqC7JDwIRsyoif/ODVck56fWeahiYZOgiBhr02BtZZQczwyf1/yMEnebCIA/VINvemehvOxbf/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844289; c=relaxed/simple;
	bh=h5E8tbdwQuAnz02qdegFAV9AhNHWAdTqFa3nNKp4Bf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouGmAAvJEoeiasRbE4x0nAKjtYCzqP9orZ8TZxga3ID8wWrZnBg3rJW/LEFT//2jM80dos9wHDRCO8nZim0BYuR1lepQLVlsX+/QeEdMPQQ4MqBQLKAsL5zkkfHKZu3LzuDbNyQRhgpLIkYjiQ4OASMYTPEPCn1ROMqyW3WNc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DJJVBoz/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DJJVBoz/"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea0b25695dso50552947b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2024 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730844286; x=1731449086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5E8tbdwQuAnz02qdegFAV9AhNHWAdTqFa3nNKp4Bf0=;
        b=DJJVBoz/DQBvK5SrSeqv0h2qtgsyvx6aEyD7rtK4hHmV9zo8BOAlyLZrUizXuqRXsT
         U/Aja4Z4Mvs7UAGDdMftxqAVG4PjDGk0hP7R7fNfhFliZrIuhZ60Gu4oOGlsJwGBnzRi
         yZxXpggKWC1XNE/iPf2yNBOJxDnjhjsL8XsOcmkURwbhyMz3CA26OETSwfokYOCkrX0d
         muR8Upulc2aw199BRoSwIr0UjHSytStvgTlyamfT7WnIz3mMUxa8SwDaa58GHvzJkOvW
         ZYnRCzBFOLcXlaOl3yyK9yfJqIF9a4Lm1II1X7T1Y6Nm0OPzvhKnUVZT3PMasB6qetWI
         nHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844286; x=1731449086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5E8tbdwQuAnz02qdegFAV9AhNHWAdTqFa3nNKp4Bf0=;
        b=w4YNIS9eefSxJcmdnnORZ8csgqELdl/NFaWziD6x4Tt+6oKwm47bH/Nt7FBddJP9JP
         A1BmsIgNTeIjCz0AtLR/x6enqMGaDz+oB7Xys9mFATqEClIfDDO/VOh/6GH/QINAG1I1
         UMtmdEEjKMBJ3Znhe8Uv185J7OlXlcDTIWDyNFFOiEBEz6v4uCUqoSRMjwHAxRb8ReKP
         fRUcA5DLCVFFraSvhv3ufdH2F/GF+UrlTmd49Kwf1zuYmFJ28ezedp30359iuyNoKy9Y
         ZDxNsRwivx0ZPGTdDQTUlDdGYmXnAHCL5hYc74rxWLYBz2c2eaQ8PFOYcM0f1bt1VkT+
         KNIg==
X-Gm-Message-State: AOJu0Ywj0TlidHJBiPyK0DVG8zjiwpB4pvWYBCU+Dk7+NakEBQYDo956
	xbN+f3ayV6qHPB/mnV5pu8bi6NvJipvCRQKemFbUYBbbzRWh9bVWAVqNz677wDNORMqm5o0/iPE
	77HP8lVEQRZoaQY5IkChgF/UJjt2zl+unV1uReV6K5GqyZuY=
X-Google-Smtp-Source: AGHT+IHAM4B30rqEBtA1bea0X//vOICjJEWRc9PdZhUy6efSS/4i3F8gDU0IOFw9nnzACNyefVemKP0yxSEw3VKkZXw=
X-Received: by 2002:a05:690c:fd0:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6ea8d6fb48amr104945807b3.0.1730844286519; Tue, 05 Nov 2024
 14:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101165243.159021-2-paul@paul-moore.com> <19daad51-99dc-4f1c-a142-3a19553dea82@schaufler-ca.com>
In-Reply-To: <19daad51-99dc-4f1c-a142-3a19553dea82@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 17:04:35 -0500
Message-ID: <CAHC9VhQBz8dCqkt9z13h1njZRLR6OsF4FY7fNb0ftWZHaFeNOg@mail.gmail.com>
Subject: Re: [PATCH] smack: fix the smack_lsmprop_to_secctx() kdoc
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 11/1/2024 9:52 AM, Paul Moore wrote:
> > Trivial kdoc fix to correct a fixup omission when converting to the
> > lsm_context struct in the LSM and Smack.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202411011723.I59qZ7Ke-lkp=
@intel.com/
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Casey Schauflercasey@schaufler-ca.com>

Merged into lsm/dev-staging.

--=20
paul-moore.com
