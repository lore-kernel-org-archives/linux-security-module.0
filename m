Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019883;
	b=M/oXuUJlQhuSfi0u1QU7Rz07te7EOPuHBMfDL8ZJ411MayWYz1nVMAGsishVidt90RTA
	 dI81hlryQjhJL9MMRc+NJxIjBbKtjv6x6NUNQQaMtJ15s04etPISdjHhWZfNImU10YURd
	 wxtiGxUW29Nsp8+JvsJKbcQbNBkPym3WeW3ww7DtgPcjZNyzlvItxOuIliLYDz8iyu/bq
	 j01Yg3Z0E2r5k4a3ttXMKBEHPb7OUuCFZOOjLL/YDfXYvIon8Frd0IRss5uueawpe/aRm
	 Gx4AuytVlWUHpjRbGOjKTbGhMURdDKLeP2dUFOSjZHdeDpV8wvsywgeIfkXKcvQLb3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H7gsS39B++5uwRZS4nxrPcQd/QhU73pXQAkEqdg0oZk=;
	b=Kzrvqf5JDLRn9ZcjpOhUUhUKWSAQ5KZjqLxw44CitOXQeViRhMK+2laE42+woiqO89W9
	 HgTqR8YBOlZxLOdIe9UaUtSjhabsawIUiQgnvOvs3C1Bm0BJ1vUA22wx9rshAGw0NLdWy
	 oeIWWBK9e1QErWz9fd/7fdpdD1KjFL9rQltKFQBgDj9InCo5LX3SBFpbWhQmlQkYQzv4W
	 GEDqELPlx804sgKsyZghsUpY7div2wdjvThRXVDvWD6irnbyA+AvZbOheVm42OVrT8gbg
	 c8yzvRQyuq4Srxm8LCEzFLYggAggBmFc/fdM9Bz7f/iO8x7jmUn9F/ESHZeDBQN0ftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcRGAC9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B55606A31C;
	Wed, 18 Nov 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcRGAC9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1ED1F000C5;
	Wed, 18 Nov 2026 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019883;
	bh=H7gsS39B++5uwRZS4nxrPcQd/QhU73pXQAkEqdg0oZk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lcRGAC9SOPb61wZQXSLrmbBbmR+BhLgb84rJRCBUWEe5VTkf7K2JRq3rtkgyH149i
	 TTz8dE/qVuBZWo7J5Ko4UI4kTYmz+yWoPIAmKI2xBMxAZyAT8A8dE9bkLBL/4ATGC/
	 CO7SQCDUgp2XKSAgHpUH76UhalVokhgCfIWdDx7t0Z+N+0JSUtNI/sAmscv/Srmweu
	 Mwcjo0dK3p89UiBHwDj0UAKSimGEEguQMiOXkkmm+NzpFFPEx+qPuty4TXWu6Pu567
	 Py6B1yOn4PevRXHd/uPW9Tfa1WPEd/w40S4vOrSr6kX9HFvbuPNJeNyuDThhDDaYS0
	 3Xog+LI0IwMGw==
Message-ID: <sashiko-outbox-221514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] selftests/landlock: Test namespace denial
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261118163254.2554413-4-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
 <20261118163254.2554413-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:37:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The namespace trace tests cover creation and entry denials, but only
> creation exercises the quiet path.  This leaves the new ENTER request
> tag untested through quiet selection and trace dispatch when audit
> logging is suppressed.
>=20
> Add the missing quiet setns(2) case.  Together with the existing cases,
> this exercises all four combinations of CREATE and ENTER with logged and
> quieted denials, including each exact namespace_op value.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118163254.2554=
413-1-mic@digikod.net?part=3D3

