Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653118B46D
	for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962016; cv=none; b=eJZ75/67kfz8KndgOUWFUM4aHvZ/6Zrlns0yNiT4zhRECysOZeO2sdCcaKxrXWilrSlJatxotuMpqiwKJvZ/sLDdinWNsM/+JP57oWJeQkbXHY0bEfWpGQb402g3RjhQ5Qva08Nwsab/M4JprV3ZHcdTtKOIslKXokLBFflFucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962016; c=relaxed/simple;
	bh=bUjKo2hKjo47ALYGkcpnrzn7VI8TDc7sUV14SFfR5BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JdTxeNkMq9lvp6vo8vg1zhFg5aw02FLR3zGlWR2mBwlvHmvYZfnPIU6/LArx4HrX3IqDqkdslDTAv+g+h2Dzwk/VzL2NxM2NlQj07f1cgRqixa9WDtVeFd8XPolQUv1OAfxAnOkEN+QfcMYRn9g048J4qRPxain+suOSoi+nOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLkWhyqZ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLkWhyqZ"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a868b6d6882so585590166b.1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725962012; x=1726566812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLwzZqGyb/MrVPN3DxT7ybP0Dg2vrqdUnFlphaKFoAA=;
        b=fLkWhyqZPrUn2RTPMIxVuvgazuhVpKBuHBjy+UKi1CMZ75bnyjKMOhznOTsf04RFCO
         xWpAdutKoMQDwJfwZHSl98o+T9vZm7TKMt9VVPkao++EmLebUaZcZ+1ZmeYgZovNNLmT
         2Knm+DtCGLmc2uMwMq1aWqTrmPSzd4jTGArnkLGV2S1A3oX6+u2BLlrZgjnXXQ1hPKwP
         SPUlRbTeWaHzXuL5E6KU/1Tn+RCPgd2ccyjpxZtWhy4WzRCRkmK8P0e3mLAmyIADnrX2
         2FpLF3lwrQNvkavEewEwRDtmihK6HWshWW+2FhbJGfw769A3i3G1mY3LTQoeHcOg2wLu
         rkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962012; x=1726566812;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QLwzZqGyb/MrVPN3DxT7ybP0Dg2vrqdUnFlphaKFoAA=;
        b=qkWYxHnlUTKp84btwF6T6xrTC20VI30OFG0+9f5kA2zQN0CQRCMfo8QSo0jT/r3enr
         G8FvCEvowE+wIkviI1lNm+ZSrSno4snqNDzv1UTQcbii2/G5WxLEh4mO2DJ+JHZdxy/V
         E5tAUbVFiO/VHfH6w1x134rQ4mC4nodM5wEUADulw+8ziBVjmh8ZppOde7ZBwyUfuJXV
         iyV8Objeo+lJkej5l92VRDw+jjNUnE2ICBGsFDftZCiwBg2Z84GBa+fOcFbk7U+5qs22
         lfN1PqeMLo5JK7iTy4okB+r6yzgFTYka4DibMSWFi4PSpThIvaUdpeCoQmOpgwep++lv
         OQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdUaONrdgzumjPO54ekUwhsrVlxD8MSuDmB+VR7v+i9JEDt/C77gDlSOOWFiAncVy8+5SkXMi+lv5M1lem7M8AgwH39JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9KCpvHwhEEdztHYXNUMIktdawxvxJ+6YP74UJ/dKdVdi6rlD
	LDvk3Yn+ThkgWvUJ8tgP0d86aLt5HPGv7NAmZ0ZreRE02X3vHLFSptQkveCV05/d5XpUn5nVZrl
	QIQ==
X-Google-Smtp-Source: AGHT+IEKRkuwKZ+CzVsiEkxduxS73xjFyBD2cngHBnHjRzLoQtzVHwrcWcBID3PvyDTBlYs+V00WXsliOxM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:3798:b0:a8a:802a:bfcc with SMTP id
 a640c23a62f3a-a8ffaec4543mr8266b.7.1725962011800; Tue, 10 Sep 2024 02:53:31
 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:53:29 +0200
In-Reply-To: <20240904104824.1844082-5-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-5-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZuAXGVBbld3UfKH0@google.com>
Subject: Re: [RFC PATCH v3 04/19] selftests/landlock: Test adding a rule with
 each supported access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:09PM +0800, Mikhail Ivanov wrote:
> Add test that checks the possibility of adding rule of
> `LANDLOCK_RULE_SOCKET` type with all possible access rights.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Replaces EXPECT_EQ with ASSERT_EQ for close().
> * Refactors commit message and title.
>=20
> Changes since v1:
> * Formats code with clang-format.
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 63bb269c9d07..cb23efd3ccc9 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -16,6 +16,9 @@
> =20
>  #include "common.h"
> =20
> +#define ACCESS_LAST LANDLOCK_ACCESS_SOCKET_CREATE
> +#define ACCESS_ALL LANDLOCK_ACCESS_SOCKET_CREATE
> +
>  struct protocol_variant {
>  	int family;
>  	int type;
> @@ -294,4 +297,32 @@ TEST_F(protocol, create)
>  	EXPECT_EQ(EACCES, test_socket_variant(&self->prot));
>  }
> =20
> +TEST_F(protocol, socket_access_rights)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D ACCESS_ALL,
> +	};
> +	struct landlock_socket_attr protocol =3D {
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +	int ruleset_fd;
> +	__u64 access;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	for (access =3D 1; access <=3D ACCESS_LAST; access <<=3D 1) {
> +		protocol.allowed_access =3D access;
> +		EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					       &protocol, 0))
> +		{
> +			TH_LOG("Failed to add rule with access 0x%llx: %s",
> +			       access, strerror(errno));
> +		}
> +	}
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
