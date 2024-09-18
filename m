Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5915B10C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663384; cv=none; b=QaZMf8QRnFZpiFJVzRL8d66SPYX2NvEdRXZ77cEo23hApGN4ieIGBWCd5OxRSUY8R6YSWk+zj/1CqlqQ9fLwdubvaZSqlJ98grB3n3I2wueTHBdQqLH5h++vL5oENq4P/1aeDaanbIA84Ox1QdWvPjSLVodR4jIF/vjmQWVGBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663384; c=relaxed/simple;
	bh=eyDOxjytA+nN0IhDPMsttJqJSY1F1WZxlvJDWMsLRMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kr5/5IHULuf4cDJaqh8tuOQ5vXYoEcHb/g4w75eO8IISu8z/ui3TjMQpexCLi93TLtxm3I3HO9PTeFDOSZurPGSYKoDuOvDGKKkD24DnABDWlOC5m62CmXAKlc3n0FYe1g1Jg8XjVjrIXMaTfrY6O1tWrxyQ+0wvO2qBe8NTsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmBt01Nq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmBt01Nq"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5c40e867910so1941983a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726663381; x=1727268181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNBhWqZq17wyEKC+rFCVheefZZ0e85NnLYR5aCMNKYw=;
        b=qmBt01Nq5ZWuUS6wxK5HbPbjOW3qTN1wrTQwOsrqjAQ/l/BKJZQG+Hfde/y4aaJxFn
         oU125YUZoq+FaCGfSxz0ENy2ZH+NLcfMDYmc7kOVqIz6+Wh9lNJ/avXg2zg4HPUy8W8B
         /+jFx8kFpVTCEHVRw5jLanlOdTYn1qufF4Dxn2VSHZV32hWUCDLgfDQnLB9TgUTBE6y8
         AjkqcLBZ4iT0xQJu9TbiXSrUIEufMI3RSIdQU9+ZoZKh0hzinpEZ/o9/3zu+Tmvif8Nb
         vV0H1IpLiIkbsZ2CK/aI/WG0Gcg7AQ1opdjdsNULaCjPc3Lmc9CrHpxXjDqU3AWKXfBe
         CHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663381; x=1727268181;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNBhWqZq17wyEKC+rFCVheefZZ0e85NnLYR5aCMNKYw=;
        b=GoY5TBJxXbDKD4IRtDyNesMEBjPNNAy5nKUBy/qvC02Ayv9erp8fa1zvO3TOmZIU2X
         GKl4+WqIjVu6PoWGEBYGiCNhdzWkMNtXVe21Iuk13Mhqi3mC1OwLAWsO/sjmxjJQwUOY
         8WVg9v9B7g9Lra54a50LiufEnD9SmKMGP9/IxPzleFZjg/5FkRzgjDcTxGAVrT0b5GTq
         1EuzhQC2rG5InI5KVUXolldWH6Njz/L9J3ShWTZyjTRP5kY3OxMYFg05a/BM3CC1SMEl
         Fsjq0ANgN2urxsCjDsdtAa6tydaUbIS77t1hefQsF45mta6luYtzdFptt0c8voFtRxoy
         btjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuIkjbVHRX3mZrguCn/BFFz7Tn8ZgwRJOBfWePHADbJsO2cHkYx+57XavcpKO41RGvLQB81fVG5KBf24M2GvPKIKJqSdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqI5HHxcDJIk/+L3stWfEWAszF9Lfwqd3yFyep6YFvN4p2GcS
	nF2SSLf6q/1h+6+qeRUqelivA//k9TZUc9Qtq3Rh0H5dyBbLY2FYsTJwBWBz9cifg5UyZqjarVz
	02Q==
X-Google-Smtp-Source: AGHT+IEg1V1E+QUuLes0+C0mA72hdz5q6cepKXRGSq2AF8Z/VRlkKRu9UYtoNKhHgkM5gOQxleEFqoUxkDI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:2405:b0:5c4:14db:4a6f with SMTP id
 4fb4d7f45d1cf-5c41e1b1d6cmr12955a12.4.1726663381243; Wed, 18 Sep 2024
 05:43:01 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:42:58 +0200
In-Reply-To: <20240904104824.1844082-9-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-9-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurK0lPLYVhyhgj4@google.com>
Subject: Re: [RFC PATCH v3 08/19] selftests/landlock: Test overlapped restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:13PM +0800, Mikhail Ivanov wrote:
> Add test that validates Landlock behaviour with overlapped socket
> restriction.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Removes `tcp_layers` fixture and replaces it with `protocol` fixture
>   for this test. protocol.ruleset_overlap tests every layers depth
>   in a single run.
> * Adds add_ruleset_layer() helper that enforces ruleset and allows access
>   if such is given.
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit message and title.
>=20
> Changes since v1:
> * Replaces test_socket_create() with test_socket().
> * Formats code with clang-format.
> * Refactors commit message.
> * Minor fixes.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index d323f649a183..e7b4165a85cd 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -417,4 +417,50 @@ TEST_F(protocol, rule_with_empty_access)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +static void add_ruleset_layer(struct __test_metadata *const _metadata,
> +			      const struct landlock_socket_attr *socket_attr)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	int ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	if (socket_attr) {
> +		ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       socket_attr, 0));
> +	}
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +TEST_F(protocol, ruleset_overlap)
> +{
> +	const struct landlock_socket_attr create_socket_attr =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +
> +	/* socket(2) is allowed if there are no restrictions. */
> +	ASSERT_EQ(0, test_socket_variant(&self->prot));
> +
> +	/* Creates ruleset with socket(2) allowed. */
> +	add_ruleset_layer(_metadata, &create_socket_attr);
> +	EXPECT_EQ(0, test_socket_variant(&self->prot));
> +
> +	/* Adds ruleset layer with socket(2) restricted. */
> +	add_ruleset_layer(_metadata, NULL);
> +	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
> +
> +	/*
> +	 * Adds ruleset layer with socket(2) allowed. socket(2) is restricted
> +	 * by second layer of the ruleset.
> +	 */
> +	add_ruleset_layer(_metadata, &create_socket_attr);
> +	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
