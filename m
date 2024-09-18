Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5A188CC5
	for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663352; cv=none; b=awmyFsXAFe6NMks4K5pHuns41juYPNusxqqlqeJxK0oupUTI8crjEND7r5tOB/XQhEuHUmyWZ8XJFT7neiTXun7Dmk8FvGoLlXwR63EbLGBfI+VYDlv++yyMRgvAcRhnpECjuqP5nUo9Mlyz1GPZgjrJV5rHm1BFDszz7ZcZo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663352; c=relaxed/simple;
	bh=YuyzMJS60HutvgbpoJTpxl2qOeZhR7R3VcbTf7ngxec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iAN02FQsHD8vWJ/BCSJ9RWq/ahR1xAKh6FhhY2bVYycZ2ddNyObr/6EocLeEf/Hl/5wUQr+I29EoFbUsNBDZM5dj+iUhYvEK6C7MnDaUd0H0+EG5uVXvwh8aZCPD6Zym8ivRoPzY0ep1EIbUzYgJAqChtp+A8jHdznXwKh8mYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wh0F0EHV; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wh0F0EHV"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a8a8e19833cso574380566b.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726663349; x=1727268149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGJ0f/kEihxaf9XHRtf990oQq84zNlc7esDTrAZ7XRI=;
        b=Wh0F0EHVMsj0xvEW/WZabcJD1nS8lgOiBSg+g2FzSMLgy8D3AifZ64SfpL3ikMFGG7
         1585UitnRs6mUZJDApD6zLiqweOAQe9D42XKZfcr6QMIAjo8UZ2Osh+i+Qrxu2LmzNzE
         KDF8fPEI4LzZfUVp52MA4gd4VGDBjEIaM+18muVj8pF5CGr488b4R+ONHi8aG0mbxPlT
         FIJp5gLRdk8HKWKghBco0accHqUuB6JdWCIXr5B6lBfUe9e1hH58mZO5TKjrHzMQoGTH
         SI9/vW2ARiGYKw7g348EfsS/ejyCsZUD2y6N56AB3wgdanovhT8AlNeE2nGQg8ydHRM6
         qYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663349; x=1727268149;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGJ0f/kEihxaf9XHRtf990oQq84zNlc7esDTrAZ7XRI=;
        b=mnqNrQDom5Ob7Edo21VjKV86caflSHRlL3GOf8bzgHtpisB4BkQVPCX/YS1CKACedx
         7WgazI0SD4eOUNJf9NoHSWWDFrFuu/EjAQeNr9jF1rNc2tei0ILcNNYNQUIcbpi1IUu9
         qSakPqSuv5vPmWm/qVA4fiw+Dj5NTgwmUtrVXgOhPNmbwwPJh2bA+A6RL+oJBm2HZ6xa
         0vG9p4dip+bw/9N9WAKiH9DkAUbMsf6q6WnjxJgpcYAdKU6rfFHroSJ7/Xe6AUtZStJu
         t/MaZxZikN2tXYlnP/ZJBxWkQA+ZksmdDJ2dFdU/gaLBsXL3272OEZCin9xb1gc5tKA/
         K86g==
X-Forwarded-Encrypted: i=1; AJvYcCU22D+Lj0NKf04NkQ5CCFWuL+ojvKxaEQCRPDOFIKQNlzhvfJr9UNr/JCmk1tHaRUhj0R6VUtcuHLyAbJ2GseVH7TR3S6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjdznR9O6gTVS4oHGOxuPajtDUJoRnX1NUE0gTXDdVlFiPIJW
	Rbt3yNizPc5WCEDhVMKo0itH3POXblIGNf4UH+fKo16Mw/V6MTM1Lxgb2S4/8CLxrIQmjvzGSX8
	Meg==
X-Google-Smtp-Source: AGHT+IFl21qxhmyOXUg8lNc9sb+HkGJIE4koHAaq0dLwgaVvB8XbDGHG9iih5tbFXBeKdxYrwTeThjtybT4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:dd4:b0:a86:6d4e:57c0 with SMTP id
 a640c23a62f3a-a90295ceaa8mr1026666b.10.1726663348975; Wed, 18 Sep 2024
 05:42:28 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:42:26 +0200
In-Reply-To: <20240904104824.1844082-8-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-8-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurKsk0LHrIxCoV9@google.com>
Subject: Re: [RFC PATCH v3 07/19] selftests/landlock: Test adding a rule for
 empty access
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:12PM +0800, Mikhail Ivanov wrote:
> Add test that validates behaviour of Landlock after rule with
> empty access is added.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
> Changes since v2:
> * Renames protocol.inval into protocol.rule_with_empty_access.
> * Replaces ASSERT_EQ with EXPECT_EQ for landlock_add_rule().
> * Closes ruleset_fd.
> * Refactors commit message and title.
> * Minor fixes.
>=20
> Changes since v1:
> * Refactors commit message.
> ---
>  .../testing/selftests/landlock/socket_test.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index d2fedfca7193..d323f649a183 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -384,4 +384,37 @@ TEST_F(protocol, rule_with_unhandled_access)
>  	ASSERT_EQ(0, close(ruleset_fd));
>  }
> =20
> +TEST_F(protocol, rule_with_empty_access)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE
> +	};
> +	struct landlock_socket_attr protocol_allowed =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +	struct landlock_socket_attr protocol_denied =3D {
> +		.allowed_access =3D 0,
> +		.family =3D self->prot.family,
> +		.type =3D self->prot.type,
> +	};
> +	int ruleset_fd;
> +
> +	ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Checks zero access value. */
> +	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +					&protocol_denied, 0));
> +	EXPECT_EQ(ENOMSG, errno);
> +
> +	/* Adds with legitimate value. */
> +	EXPECT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &protocol_allowed, 0));

In my mind, the check with the legitimate rule is probably already done in =
other
places and does not strictly need to be duplicated here.

But up to you, it's fine either way. :)

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> --=20
> 2.34.1
>=20
