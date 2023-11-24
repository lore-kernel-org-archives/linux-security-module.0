Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fH5hb05R"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B369810CB
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:07:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca26c07848so32189347b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700845634; x=1701450434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDbAHL1WzbpxpVmmBQ1q4f+lIFqPoK269H6Oa6NY9+M=;
        b=fH5hb05RhUcK/VZfGxorsC3u4fZ11k+gVOXYj9rVTWMk6DFntuUOrv0sY7oyp2GIrl
         bzUfLgzbz1a4BxEueo7qAOOsmrtVXuwH0KUhgFI8wT3CuCIU2i/KYbcOdiYF23Xqsvwm
         cBw4uckdPnAp1I5xcAVNzCtK5FnpMdsiemKRdYlvPSXBYRZQ66UvOR0Aq9JETIyWiAVI
         k72ON/G/qLueajTN/tw3ypnEgCqFygd0C1/nYeO3msoa7F2OPsH7OTw8jvuN+OQM0/WD
         KZUIHlYckF2wsRR3xcmWMAdD841ZmXV6UCzPnR2R0uNE6GOiGhyceQagxpQWs45XBsdJ
         zQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845634; x=1701450434;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDbAHL1WzbpxpVmmBQ1q4f+lIFqPoK269H6Oa6NY9+M=;
        b=M5mqrE6rSPcLe4F7CcdOVD4HAc6/L4qk2zxuLuK1nKuOgJSsUKU19ZoSTGOcbwYwKh
         a1AA+IjN01HVwRfTInjPcsSRnAUjfCywA6WMuELafxhIzOwmeYn8tnFTgXUm7gd2P1/B
         gFVKd71Rh6eh6zqte7qStPOFBju+oMTWY7Dby1NVoWZcp6lZPqkFHg4RNJrgR/qD7ylU
         AdKDI5mJ6wMRpakLGM0dJi0hm9jmrJwnyErhchy+8M2XGn94Uz0hUJjRLWwOwnBYcvm1
         TLcjJFlYLh0kzVpVetRjOYjDC7bGVtPrYwG9lrxmpxFQy7c3ZmdRQPRTIacIlxOlint+
         lxNA==
X-Gm-Message-State: AOJu0Yxoucb0ixOm3eeequFV0D7Xq0idEGw7/CoyKdPIydqJrl9xSfMC
	MVJPKAq+hGJu1v220WzL+6WE9Ve8BLM=
X-Google-Smtp-Source: AGHT+IEi6smLAoM5LsFSTHDUVsdt9l8qmt2YzLQlOJC8syM9mvuhR5uuah8uEnw1ZFKpiILQQz5kcq1gPEY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:690c:2f0d:b0:5cb:e3c9:ca22 with SMTP id
 ev13-20020a05690c2f0d00b005cbe3c9ca22mr98129ywb.7.1700845634005; Fri, 24 Nov
 2023 09:07:14 -0800 (PST)
Date: Fri, 24 Nov 2023 18:07:05 +0100
In-Reply-To: <20231120193914.441117-2-mic@digikod.net>
Message-Id: <ZWDYOThtJcTx_Z7U@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231120193914.441117-1-mic@digikod.net> <20231120193914.441117-2-mic@digikod.net>
Subject: Re: [PATCH v1 1/2] selftests/landlock: Add tests to check undefined
 rule's access rights
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, James Morris <jmorris@namei.org>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:39:13PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Extend two tests to make sure that we cannot add a rule with access
> rights that are undefined:
> * fs: layout1.file_and_dir_access_rights
> * net: mini.network_access_rights
>=20
> The checks test all 64 bits access right values until it overflows.
>=20
> Replace one ASSERT with EXPECT in layout1.file_and_dir_access_rights .
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c  | 17 ++++++++++++-----
>  tools/testing/selftests/landlock/net_test.c | 17 ++++++++++-------
>  2 files changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 18e1f86a6234..d77155d75de5 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -548,7 +548,6 @@ TEST_F_FORK(layout1, inval)
>  TEST_F_FORK(layout1, file_and_dir_access_rights)
>  {
>  	__u64 access;
> -	int err;
>  	struct landlock_path_beneath_attr path_beneath_file =3D {},
>  					  path_beneath_dir =3D {};
>  	struct landlock_ruleset_attr ruleset_attr =3D {
> @@ -568,11 +567,19 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
>  		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
>  	ASSERT_LE(0, path_beneath_dir.parent_fd);
> =20
> -	for (access =3D 1; access <=3D ACCESS_LAST; access <<=3D 1) {
> +	for (access =3D 1; access > 0; access <<=3D 1) {
> +		int err;
> +
>  		path_beneath_dir.allowed_access =3D access;
> -		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
> -					       LANDLOCK_RULE_PATH_BENEATH,
> -					       &path_beneath_dir, 0));
> +		err =3D landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath_dir, 0);
> +		if (access <=3D ACCESS_LAST) {
> +			EXPECT_EQ(0, err);
> +		} else {
> +			EXPECT_EQ(-1, err);
> +			EXPECT_EQ(EINVAL, errno);
> +			continue;
> +		}

Style question: why not have two loops next to each other?  You could keep =
the
old loop from 1 to ACCESS_LAST and then have a separate one from ACCESS_LAS=
T+1
onwards.  Then you would not need to put logic inside the loop; it might re=
duce
nesting a bit, and each loop individually might be slightly easier to grasp=
.

I was initially a bit confused why the other landlock_add_rule() call for t=
he
directory doesn't need the same change. That is clear to me after looking a=
t the
code a few seconds longer, but it might be slightly simpler with two separa=
te
loops.

But this is a minor nit.

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Thanks!
=E2=80=94G=C3=BCnther
