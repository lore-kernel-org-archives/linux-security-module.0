Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DD335094
	for <linux-security-module@vger.kernel.org>; Tue, 16 Dec 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925866; cv=none; b=RK/Vv4vQu8Rsj/ONGjlmwPWMfmhNXSGG1Sjg2LZJoygMNpak+E/SAKpN0uB1OSieQs917GRjdldh6uwW0qFqriMm50pGIiaA8bUe3UKhpsTgTAM1O2n3q1QJVVpQm2JjoIC+oXjwudUz8zG6w8mQPqiy9Z8DZiuw+Q9v3uVcdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925866; c=relaxed/simple;
	bh=BWxuoXqjfI0xUgzQh+4H7fFdkUYv7IYAkvpnO8v1Ejg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCXtZwq6+hHLMLYHLnlfKqZDkvHUGkirWmR7nqonKkc3pwAdu27rPkICq8CJUTpkuD9I1BzA8PQ70gpBaE3Hp4Lx/2E3/oCKgSACRc/r2zv6QfqqfGvXzPNpzgsUnv+OTJVWv4AarY8xQQaPtp9/nOqvVgYAarnjza3MgdlKNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vjt9z6/s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vjt9z6/s"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ade456b6abso4058342b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Dec 2025 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765925864; x=1766530664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH0LzqhUZuOfaWHwOwXK+iLd36Cjg5eO2z3Ta0zxZlY=;
        b=Vjt9z6/siV/y0olr1NAJjdfs4Ll5VaDvZKKfIJkc2jebcmNCgOFRl2i9vIi03Xwsqx
         bMfKPAv/95CBO3pwLs45WdokjrAnjTR54mX5OviZVEdqu8zYDFIdkfmoWAfWqoLqb9q4
         wHpYuCJ5jNIpz69C1TIFU0guFGsXXFnne4k4vIVCgIbnTdFENMRXjzmkTwPrpHBNWiNP
         D6QWSf3xYeQhSm339xEhliEQN3Lw6sOGILD71whbxeuUPhu1QHY8r0ZJQH3BHBp8Ymy4
         zBJyEzgRX+RoI666k5JzMQybhlrFRt/u1mCcmgGTSJUvVvzIVo5Eo/PlA4+h1VApcr/j
         Gecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925864; x=1766530664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DH0LzqhUZuOfaWHwOwXK+iLd36Cjg5eO2z3Ta0zxZlY=;
        b=O8hDObu/FGzm4OyK6fTkV1REpfiD7pq579kiqcMMpcGOrbft7U18L1ksQ0K0aL8NjO
         RZPTigt+mZNcvcueSDcfsGxiK/NrL8ODnBUK0yBxr4toT0EMWBi0nx2Edjtswjf+uP79
         hG/k26dSPVsA1GxLTcBGWR19rZY+4CBrL0+Wy3JH2Uddm7JGQndgZeuWyz7bqyz0Lz2j
         TdlRPUnv7xUS6yZRKT2g+YsPKXlC+Y/SpNCnaPtLLpoOWUy8b04s8QcgoLl2nC0/Iekr
         pfdsxb4KQLCFJTzSoXGTFgDBGfoEKBF9FavaWMTvMMADrCb89AHWEtfxY2qPX5BQGbBC
         rM3w==
X-Gm-Message-State: AOJu0Yw9Bo554m8pyPa23MpUuSsyP3a/yFWvrW6GNq7DHVtRK5zXhTSp
	lFSph84+oPzuxtQNNKDGgLt2mn6etFXz6dQtrq1NhE1ajhZKAHHqnPU7IZslCXesgHA6hcvqeHp
	pBylFQsW84qbDxOLqOMCDPeHW/temMl8/U8mO3e8h
X-Gm-Gg: AY/fxX7HTUWXdsNGL9s+kqEMgKSZTME9n+0uMjmq0+mZmimpbwqoBb2ehA03fOxnrMJ
	ur/LGZH/50Xm9SAX9DzHtXmY//UnH/h0K6u0dPk54sW0K+OS4ZrnDVUgCMAhNQmhx8pNoqggIBH
	l/o1E7FuYK0WW/BNOV4okbqsFMRwEsPL3rY7S9TF6C3wpdqU1p1My5xAx6jBbSxytftu37+3pNR
	S+F3TWm0kKOCxx6qWkLkL54KE0MbrB9WghD9xwiSFVIWQmfvftQs+bNaW8qTOzsvEGwpR0=
X-Google-Smtp-Source: AGHT+IEZaa50wLYoB/qjIN1BisNwwg9uxmvHQeXzhrlvMr4QrfDHDM+v3u1TcO5epACzmqZ1HLL6MI1PGaf4+YOOMkw=
X-Received: by 2002:a05:6a21:99a2:b0:35e:e604:f787 with SMTP id
 adf61e73a8af0-369af338521mr15932062637.39.1765925864177; Tue, 16 Dec 2025
 14:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSXICxT6u0Rx1FhW@mail.hallyn.com> <20251204215610.148342-1-foster.ryan.r@gmail.com>
In-Reply-To: <20251204215610.148342-1-foster.ryan.r@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 17:57:32 -0500
X-Gm-Features: AQt7F2qvN-WKK5OZOWNPKl_sIuKytbQJbuFqGud3WiWD4EtFjaLpCsWvcmVtMNc
Message-ID: <CAHC9VhQ0MZamekAi-2kXgVv9qhSw16jpTyJ1CrfvQ+7Tp9GW6w@mail.gmail.com>
Subject: Re: [PATCH] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
To: Ryan Foster <foster.ryan.r@gmail.com>, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:56=E2=80=AFPM Ryan Foster <foster.ryan.r@gmail.com=
> wrote:
>
> Add comprehensive KUnit tests for the namespace-related capability
> functions that Serge Hallyn refactored in commit 9891d2f79a9f
> ("Clarify the rootid_owns_currentns").
>
> The tests verify:
> - Basic functionality: UID 0 in init namespace, invalid vfsuid, non-zero =
UIDs
> - Actual namespace traversal: Creating user namespaces with different UID
>   mappings where uid 0 maps to different kuids (e.g., 1000, 2000, 3000)
> - Hierarchy traversal: Testing multiple nested namespaces to verify
>   correct namespace hierarchy traversal
>
> This addresses the feedback to "test the actual functionality" by creatin=
g
> real user namespaces with different values for the namespace's uid 0, rat=
her
> than just basic input validation.
>
> The test file is included at the end of commoncap.c when
> CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, following the standard
> kernel pattern (e.g., scsi_lib.c, ext4/mballoc.c). This allows tests to
> access static functions in the same compilation unit without modifying
> production code based on test configuration.
>
> All 7 tests pass:
> - test_vfsuid_root_in_currentns_init_ns
> - test_vfsuid_root_in_currentns_invalid
> - test_vfsuid_root_in_currentns_nonzero
> - test_kuid_root_in_ns_init_ns_uid0
> - test_kuid_root_in_ns_init_ns_nonzero
> - test_kuid_root_in_ns_with_mapping
> - test_kuid_root_in_ns_with_different_mappings
> ---
>  security/Kconfig          |  17 +++
>  security/commoncap.c      |   4 +
>  security/commoncap_test.c | 290 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 security/commoncap_test.c

You'll need to sort this out with Serge, but I would suggest adding
security/commoncap_test.c to the CAPABILITIES entry in the MAINTAINERS
file so it has a proper home.

--=20
paul-moore.com
