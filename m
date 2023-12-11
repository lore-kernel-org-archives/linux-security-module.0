Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lr9bdvR5"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522FAB6
	for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:54:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5deda822167so23969817b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702284884; x=1702889684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2S/XXWOIPLH+GvLpVZ+6rEz/5XKM4opvQE6Xud/RzY=;
        b=Lr9bdvR52TeDKPQ6FGnm4oxlfCgEhz27j/haLzmLD9ajnCPY5THQCQc9j5qfz3Hz5I
         Ehbg+PazY1NLZXUbc3tmClNLOmpgdjAe76OfRMzuekLknSC9JiAP58wbmkBRsRVWGKkt
         VDbJS5697Yo8bkmnLryGTO+b2M7/BkTE4wLuOINZEjeMkIlSz7MZcIxCVrIHiX2gd4pY
         8pndfGv47eUc6Lp0QJYuFH5VVC4WZi2MVmU5i1AbPwNsCyDyT73BNm7YBoUszcoef1bg
         PDqqtjQrb+ZSGRrIeXOOz6pwRPksVubeA3fc6MjuzOJ71rEziww03lRT2FuWZ0FLKZ3M
         Eqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284884; x=1702889684;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v2S/XXWOIPLH+GvLpVZ+6rEz/5XKM4opvQE6Xud/RzY=;
        b=doEfWBqn1+7Hdn0JI4Ha/Kg6sxH4tSIdO88J0B1HqqsaP2vjzyg+ztJXVlNZQiya3m
         nuZoZiy0ow/qtD8oEfnrMVK6/K6bM6W+g043O3PoR4F0TYbbf5ngJV8Y+cfcFMxBXW9Q
         Q4nGGiy16jqCSf8TAcqLPiDPzpxw8Qc4nfz+iOHynGdgiGkyR9bfW7OoTADW7hv3baHc
         MEOcqVVLoYRhmbehJahpsezxg1mHV3Wr+/6HZckqeWdjAXuhfUDnNQQpEVtLVDliZjtq
         aqb53WiAUz5kgCXyKwWm2o1zieOF17TvTPeVqyounmaY5rVENxXTDgsX3LjoP5jQ1Knr
         Yr3A==
X-Gm-Message-State: AOJu0YxE7BOYxHXoqo3w+Lc/tCS7h5LwwbXrAkl4dlSZyGZygjKHRHCa
	BcSv15Ui4Q46tT86PpQWKfIwhDVdHSQ=
X-Google-Smtp-Source: AGHT+IGwT+U4BpxbZ8xinInHlqkTHHXicCFh9NaTTcDeIh1O5f5CEX0ax3w3zC5utoGP9P6oaxJRBYesecE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8dfb:6b15:9b0:522a])
 (user=gnoack job=sendgmr) by 2002:a05:6902:150:b0:da0:3da9:ce08 with SMTP id
 p16-20020a056902015000b00da03da9ce08mr34296ybh.10.1702284884569; Mon, 11 Dec
 2023 00:54:44 -0800 (PST)
Date: Mon, 11 Dec 2023 09:54:36 +0100
In-Reply-To: <20231130093616.67340-2-mic@digikod.net>
Message-Id: <ZXbOTE5FehZ3WIE-@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130093616.67340-1-mic@digikod.net> <20231130093616.67340-2-mic@digikod.net>
Subject: Re: [PATCH v2 1/2] selftests/landlock: Add tests to check unknown
 rule's access rights
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, James Morris <jmorris@namei.org>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:36:15AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Add two tests to make sure that we cannot add a rule with access
> rights that are unknown:
> * fs: layout0.rule_with_unknown_access
> * net: mini.rule_with_unknown_access
>=20
> Rename unknown_access_rights tests to ruleset_with_unknown_access .
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>=20
> Changes since v1:
> * Move checks into their own test/loop as suggested by G=C3=BCnther Noack=
.
> * Don't change layout1.file_and_dir_access_rights
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 29 ++++++++++++++++++++-
>  tools/testing/selftests/landlock/net_test.c | 27 ++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 18e1f86a6234..1e6c474e3d08 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -589,7 +589,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> -TEST_F_FORK(layout0, unknown_access_rights)
> +TEST_F_FORK(layout0, ruleset_with_unknown_access)
>  {
>  	__u64 access_mask;
> =20
> @@ -605,6 +605,33 @@ TEST_F_FORK(layout0, unknown_access_rights)
>  	}
>  }
> =20
> +TEST_F_FORK(layout0, rule_with_unknown_access)
> +{
> +	__u64 access;
> +	struct landlock_path_beneath_attr path_beneath =3D {};
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_fs =3D ACCESS_ALL,
> +	};
> +	const int ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	path_beneath.parent_fd =3D
> +		open(TMP_DIR, O_PATH | O_DIRECTORY | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +
> +	for (access =3D 1ULL << 63; access !=3D ACCESS_LAST; access >>=3D 1) {
> +		path_beneath.allowed_access =3D access;
> +		EXPECT_EQ(-1, landlock_add_rule(ruleset_fd,
> +						LANDLOCK_RULE_PATH_BENEATH,
> +						&path_beneath, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	ASSERT_EQ(0, close(path_beneath.parent_fd));
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  static void add_path_beneath(struct __test_metadata *const _metadata,
>  			     const int ruleset_fd, const __u64 allowed_access,
>  			     const char *const path)
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 929e21c4db05..83d9abc3ee55 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1260,7 +1260,7 @@ TEST_F(mini, network_access_rights)
>  }
> =20
>  /* Checks invalid attribute, out of landlock network access range. */
> -TEST_F(mini, unknown_access_rights)
> +TEST_F(mini, ruleset_with_unknown_access)
>  {
>  	__u64 access_mask;
> =20
> @@ -1276,6 +1276,31 @@ TEST_F(mini, unknown_access_rights)
>  	}
>  }
> =20
> +TEST_F(mini, rule_with_unknown_access)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_net =3D ACCESS_ALL,
> +	};
> +	struct landlock_net_port_attr net_port =3D {
> +		.port =3D sock_port_start,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access =3D 1ULL << 63; access !=3D ACCESS_LAST; access >>=3D 1) {
> +		net_port.allowed_access =3D access;
> +		EXPECT_EQ(-1,
> +			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					    &net_port, 0));
> +		EXPECT_EQ(EINVAL, errno);
> +	}
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_F(mini, inval)
>  {
>  	const struct landlock_ruleset_attr ruleset_attr =3D {
> --=20
> 2.42.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Thank you, looks good to me!
Good idea to split it up into two separate tests.

=E2=80=94G=C3=BCnther
