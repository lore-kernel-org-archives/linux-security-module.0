Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0simpED"
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD61718
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:13:02 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-548a12a78d4so1618796a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700845981; x=1701450781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e1+jKHDtlt8jdUKdu546q2eV+Bv2V3yCJqwCBVY6RM=;
        b=j0simpEDd5RPSLXaylGmQVhMgujmv3z0GcElS3iKI/NK8qFftPWMPRLCMursS7Swhr
         1+Fb+gf8AwEcPecUrc7SU5v3jtaFRFxMo/QVUMSDNF4ZR05QD17lX2ZEUxS5a3lCpc8N
         /Ghw11RNQVQjEtNUGeOOW8jR/0POq+B/cIaGWR2/4uv/LHL8e7YIZ+aBIJog6RmrJYxK
         RhDPmSLNruQ4pEqUs3xMd2EaPT32lXrVrfUIfn2bZ09oQG+kGDcaNxts9dQVufwg5sDY
         jL6z6gApUX8WTUs7529ukSObIedUGSj3okygcFP07cSQ6YyYruaJj3Qyi6WwIArUV5P+
         D7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845981; x=1701450781;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4e1+jKHDtlt8jdUKdu546q2eV+Bv2V3yCJqwCBVY6RM=;
        b=o1kJJgtjaI/eFhiE+Bz/WpVqSDJ1PVsFucIkFqgurw2XiatpAF7cosvntuxec53UuO
         Di7I0WxlCL2MbpbjOnkmP/YD/9uvvu8lCOTHqwQMMXYz87aWIsZby8e0fGSko2hu/sEH
         OX1aZgGJWtShCjlCjpgB0e1dzxJDrmXoX6wbzV4dotpZ/RJpmdVNjMpNmxXTR31QG0Ir
         fvNjhasiJgChzf0psme2XKymBjJylJJgUONIOMTO/5rQEAOOZwjSALaTkSB8Rn7v+Qmv
         atvRbTlFkn3StK0ZsJ8Gu6og3V0SQIm7fw0Z2aw3mFmoaw8sWWVz8BCdR+/Z3uydxxu2
         isrA==
X-Gm-Message-State: AOJu0YyxuwSKlsYunC3HIh+TU2eGzFtJUWgpjqTILEMZzuDzfXAcTGSE
	+KY5S5Pg0kyligNUgHOXtl0GAl/MhYk=
X-Google-Smtp-Source: AGHT+IGPQoccpFtHh6ZN3TDzhmxuu0F2Pb3C3uWQdN3ZVLxcnVtaEyAUVROMy4fqr1heK0mLFuuXHLJc84M=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:6402:290a:b0:54a:c656:b30d with SMTP id
 ee10-20020a056402290a00b0054ac656b30dmr39018edb.1.1700845980455; Fri, 24 Nov
 2023 09:13:00 -0800 (PST)
Date: Fri, 24 Nov 2023 18:12:52 +0100
In-Reply-To: <20231120193914.441117-3-mic@digikod.net>
Message-Id: <ZWDZlGhDmzeUjBvK@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231120193914.441117-1-mic@digikod.net> <20231120193914.441117-3-mic@digikod.net>
Subject: Re: [PATCH v1 2/2] selftests/landlock: Add tests to check unhandled
 rule's access rights
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, James Morris <jmorris@namei.org>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:39:14PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Add two tests to make sure that we cannot add a rule to a ruleset if the
> rule's access rights that are not handled by the ruleset:
> * fs: layout1.rule_with_unhandled_access
> * net: mini.rule_with_unhandled_access
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 35 +++++++++++++++++++++
>  tools/testing/selftests/landlock/net_test.c | 33 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index d77155d75de5..8cabcbe3554e 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -596,6 +596,41 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F_FORK(layout1, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr =3D {
> +		/* First bit */
> +		.handled_access_fs =3D LANDLOCK_ACCESS_FS_EXECUTE,

Optional nit: If you want to spell out that this is 1, you could as well ad=
d an
assertion for that.  Doesn't even need to be a static_assert, it's just a t=
est
after all.  Or maybe even put a literal 1 here instead. :)

> +	};
> +	struct landlock_path_beneath_attr path_beneath =3D {};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	path_beneath.parent_fd =3D open(file1_s1d2, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +
> +	for (access =3D 1; access > 0; access <<=3D 1) {
> +		int err;
> +
> +		path_beneath.allowed_access =3D access;
> +		err =3D landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath, 0);
> +		if (access =3D=3D ruleset_attr.handled_access_fs) {
> +			EXPECT_EQ(0, err);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EINVAL, errno);
> +		}
> +	}
> +
> +	EXPECT_EQ(0, close(path_beneath.parent_fd));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_F_FORK(layout0, unknown_access_rights)
>  {
>  	__u64 access_mask;
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 9356f5800e31..aec01917abd5 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1262,6 +1262,39 @@ TEST_F(mini, network_access_rights)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F(mini, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr =3D {
> +		/* First bit */
> +		.handled_access_net =3D LANDLOCK_ACCESS_NET_BIND_TCP,

Ditto.

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
> +	for (access =3D 1; access > 0; access <<=3D 1) {
> +		int err;
> +
> +		net_port.allowed_access =3D access;
> +		err =3D landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +					&net_port, 0);
> +		if (access =3D=3D ruleset_attr.handled_access_net) {
> +			EXPECT_EQ(0, err);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EINVAL, errno);
> +		}
> +	}
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  /* Checks invalid attribute, out of landlock network access range. */
>  TEST_F(mini, unknown_access_rights)
>  {
> --=20
> 2.42.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Thanks for the tests!
=E2=80=94G=C3=BCnther
