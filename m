Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nMdDstZ"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58183A0
	for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:56:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so50953177b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702284987; x=1702889787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFvh0JnUT2IS+ugo/F08Vggb9r+uE9aR69m3LDFSrao=;
        b=2nMdDstZKOqp2bWUBV/eNzx4cW1L3lXF95jbPPTuQXIKZ3QtGsMa5rhRlRokHGRprE
         rMNQpX5QGyLDgvnzqiqbbNmWcTPPjW8qx3vq3FLquf6AYF1RC9dZ61Z4/N3fFjqo2GFz
         vADBya55kX0NS+ag/K3RlpbmYr7xBeBx2zZwQTfaChqEOsvO7mn8B7meS48dXsxMRAKT
         HejoEniugohMsKoc7dZH53QAc15HgpFG118thv7zubHV0K4xSdEF5qtoEkdAp4A12nBx
         tw72vdhYVQa4NwDLsxWDTKTrw5Ii2a9aTf69IkhWLY3YH6Vj86A9Z/srFtKcVuGkVhXh
         A5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284987; x=1702889787;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFvh0JnUT2IS+ugo/F08Vggb9r+uE9aR69m3LDFSrao=;
        b=lq5l4Dq0zEiM2dM40cf3CgQc0msznwfoTUkGVoBhcRm24fnX7lPBy24Ou0xazSFHnG
         pJkEwzMxTRIIBClt7ruk/AA7t4BHvQXtYs52TjfvTFiN1VZ/mSYnniIUMCFvuy++RYDo
         jwQN/PS7T2ERtrQZCAS8AGFVYpBGbcG4+6F8FAqJ1pbU+QJs6mfQAdv2zEuW7xG1gcXI
         PjPdqygKoOrYzpP7AnyxGqvq9LY6TJmfNQdvTmxYcAsUkt/05Sz0JcRA72t3x2jX/lXS
         PGBofrFNyULab/flgqs+WJbOAnpgX+ec1k+NtEPrXkigSJNibRVujP4LiH8MOyTIPVB2
         Y0zg==
X-Gm-Message-State: AOJu0Yyl0YVY0Nk0Lr7RbSYk92S+O2uRM8F7Tp/RDtVnKSBd5RfhNBxu
	HXcmxL3We+bfDU6liPqHMKOJKEaq0F0=
X-Google-Smtp-Source: AGHT+IFjDo1hWQu6AHW9LfwE0fS46hWH/RWIWIvz6jLWC8ExNKNougbI0BXGuAf8tanP0ambOS3QlbXqHA8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8dfb:6b15:9b0:522a])
 (user=gnoack job=sendgmr) by 2002:a25:9705:0:b0:db5:45eb:75b0 with SMTP id
 d5-20020a259705000000b00db545eb75b0mr26205ybo.6.1702284987551; Mon, 11 Dec
 2023 00:56:27 -0800 (PST)
Date: Mon, 11 Dec 2023 09:56:20 +0100
In-Reply-To: <20231130093616.67340-3-mic@digikod.net>
Message-Id: <ZXbOtBS958m8OCiI@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130093616.67340-1-mic@digikod.net> <20231130093616.67340-3-mic@digikod.net>
Subject: Re: [PATCH v2 2/2] selftests/landlock: Add tests to check unhandled
 rule's access rights
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, James Morris <jmorris@namei.org>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:36:16AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Add two tests to make sure that we cannot add a rule to a ruleset if the
> rule's access rights that are not handled by the ruleset:
> * fs: layout1.rule_with_unhandled_access
> * net: mini.rule_with_unhandled_access
>=20
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>=20
> Changes since v1:
> * Remove confusing comment.
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 34 +++++++++++++++++++++
>  tools/testing/selftests/landlock/net_test.c | 32 +++++++++++++++++++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 1e6c474e3d08..a1d17ab527ae 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -632,6 +632,40 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F_FORK(layout1, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_fs =3D LANDLOCK_ACCESS_FS_EXECUTE,
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
>  static void add_path_beneath(struct __test_metadata *const _metadata,
>  			     const int ruleset_fd, const __u64 allowed_access,
>  			     const char *const path)
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 83d9abc3ee55..ea5f727dd257 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1301,6 +1301,38 @@ TEST_F(mini, rule_with_unknown_access)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F(mini, rule_with_unhandled_access)
> +{
> +	struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_net =3D LANDLOCK_ACCESS_NET_BIND_TCP,
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
>  TEST_F(mini, inval)
>  {
>  	const struct landlock_ruleset_attr ruleset_attr =3D {
> --=20
> 2.42.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Looks good!

=E2=80=94G=C3=BCnther
